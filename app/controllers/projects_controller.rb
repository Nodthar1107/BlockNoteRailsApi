class ProjectsController < ApplicationController

    before_action :jwt_token_parse

    def get_all_projects_info
        user_id = jwt_decode(params["token"])

        projects = Project.where(user_id: user_id)
        projects_headers = []
        
        if projects
            projects.each do |project|
                projects_headers << { 
                    name: project.name,
                    id: project.id 
                }
            end
        end

        render json:{
            status: "succesful",
            projects: projects_headers,
            token: params["token"]
        }
    end

    def create_new_project
        user_id = jwt_decode(params["token"])

        project = Project.create(name: params["project_name"], user_id: user_id)

        render json: {
            status: "succesful",
            token: params["token"]
        }
    end

    def delete_project
        Project.destroy_by(id: params["id"])

        render json:{
            status: "succesful",
            token: params["token"]
        }
    end

    def get_project_struct
        p project = Project.find_by_id(params[:id])
        p blocks = Block.where(project_id: project.id)
        blocks_headers = []

        if blocks
            blocks.each do |block|
                blocks_headers << { 
                    block_name: block.name,
                    id: block.id,
                    struct_number: block.struct_number,
                    active: false
                }
            end
        end

        render json:{
            status: "succesful",
            token: params["token"],
            project_name: project.name,
            project_id: project.id,
            blocks_headers: blocks_headers
        }
    end

    def create_new_block
        struct_number = Block.where(project_id: params["project_id"]).count + 1

        block = Block.create(name: "Новый блок", project_id: params["project_id"], struct_number: struct_number)
        block_headers = {
            id: block.id,
            block_name: block.name,
            struct_number: block.struct_number,
            active: false
        }

        render json:{
            status: "succesful",
            token: params["token"],
            block_headers: block_headers,
        }
    end

    def update_project_name
        project = Project.find_by_id(params["project_id"])
        project.update(name: params["project_name"])

        render json:{
            status: "succesful",
            token: params["token"]
        }
    end

    def update_block_name
        block = Block.find_by_id(params["block_id"])
        block.update(name: params["block_name"])

        render json:{
            status: "succesful",
            token: params["token"]
        }
    end

    def get_block_content
        p params["block_id"]
        block = Block.find_by_id(params["block_id"])
        p block.content
        p block
        block.content.blank? ? content = "Это новый блок" : content = block.content

        render json:{
            status: "succesful",
            token: params["token"],
            content: content
        }
    end

    def save_block_content
        block = Block.find_by_id(params["block_id"])
        block.update(content: params["content"])

        render json: {
            status: "succesful",
            token: params["token"]
        }
    end

    def get_text_file
        params["project_id"]
        blocks = Block.where(project_id: params["project_id"]).sort_by{ |block| block.struct_number }
        project = Project.find_by_id(params["project_id"])
        name = "lib/tasks/files/" + project.name + ".txt"


        File.open(name, "w") do |file|
            blocks.each do |block|
                file.write(block.name.upcase + "\n\n")
                file.write(block.content + "\n\n")
            end
        end

        File.open(name, "r") do |file|
            render json:{
                status: "succesful",
                token: params["token"],
                file_name: File.basename(file),
                content: file.read
            }
        end

        File.delete(name)
    end

    def delete_block
        block = Block.find_by_id(params["block_id"])
        blocks = Block.find_by_sql("
            SELECT * FROM blocks
            where (project_id = #{ block.project_id })
            and (struct_number > #{ block.struct_number });
            ")
        block.destroy

        unless blocks.blank?
            blocks.map! do |block|
                block.update(struct_number: block.struct_number - 1)
            end
        end

        render json: {
            status: "succesful",
            token: params["token"]
        }
    end

end
