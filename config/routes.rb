Rails.application.routes.draw do
  scope "/user" do
    post "/create-user" => "user_manager#create_user"
    post "/get-user-data" => "user_manager#get_user_data"
    post "/login" => "user_manager#login"
    get "/destroy-session" => "user_manager#destroy_session"
  end
  scope "/projects" do
    post "/get-all-projects-info" => "projects#get_all_projects_info"
    post "/create-new-project" => "projects#create_new_project"
    post "/delete-project" => "projects#delete_project"
    post "/get-project-struct" => "projects#get_project_struct"
    post "/create-new-block" => "projects#create_new_block"
    post "/update-project-name" => "projects#update_project_name"
    post "/update-block-name" => "projects#update_block_name"
    post "/get-block-content" => "projects#get_block_content"
    post "/save-block-content" => "projects#save_block_content"
    post "/get-text-file" => "projects#get_text_file"
    post "/delete-block" => "projects#delete_block"
  end

end
