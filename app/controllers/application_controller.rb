class ApplicationController < ActionController::API

    JWT_CONST = "test".freeze

    def jwt_token_parse
        token = params["token"]
        begin
            data = JWT.decode(token, JWT_CONST, true, { algorithm: 'HS256' })
        rescue
            redirect_to "/destroy-session"
        end
    end

    def jwt_decode(token)
        JWT.decode(token, JWT_CONST, true, { algorithm: 'HS256' })[0]["id"]
    end

end
