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
  end

end
