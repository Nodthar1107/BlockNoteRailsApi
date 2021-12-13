class UserManagerController < ApplicationController

    before_action :jwt_token_parse, except: [:create_user, :login, :make_jwt, :destroy_session]

    def create_user
        if User.find_by_login(params["login"])
            render json: {
                status: "unsuccesful",
                message: "Пользователь с Логином #{ params["login"] } уже существует"
            }
            return
        end
        
        user = User.create(login: params["login"], password: params["password"], phone_number: params["telephone"], mail: params["mail"])
        jwt_token = make_jwt(user.id)

        render json:{
            token: jwt_token,
            status: "succesful"
        }
    end

    def login
        user = User.find_by(login: params["login"])
        unless user
            render json: {
                status: "unsuccesful",
                message: "Пользователь с таким именем не существует"
            }
            return
        end

        if user.password != params["password"]
            render json: {
                status: "unsuccesful",
                message: "Введен некорректный пароль"
            }
            return
        end

        token = make_jwt(user.id)
        
        render json: {
            status: "succesful",
            token: token
        }
    end

    def get_user_data
        user_id = jwt_decode(params["token"])
        user = User.find_by_id(user_id)

        render json: {
            status: "succesful",
            login: user.login,
            token: params["token"]
        }
    end

    def destroy_session
        render json:{
            status: "destroy connection",
            message: "user token incorrec"
        }
    end

    protected

    def make_jwt(id)
        data = {
            id: id
        }

        token = JWT.encode(data, JWT_CONST, 'HS256')
    end

end
