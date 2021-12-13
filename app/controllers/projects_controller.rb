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
        p blocks = Block.find_by(project_id: project.id)
        blocks_headers = []

        if blocks
            blocks.each do |block|
                blocks_headers << { 
                    block_name: block.name,
                    id: block.id
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

end
