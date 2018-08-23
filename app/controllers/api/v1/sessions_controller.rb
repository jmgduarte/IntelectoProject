class Api::V1::SessionsController < Devise::SessionsController
    require 'json_web_token'
    skip_before_action :verify_authenticity_token
    
    def create
      user  = User.find_for_database_authentication(email: params[:user][:email])
      if user && user.valid_password?(params[:user][:password])
        auth_token = jwt_token(user)
        render json: {auth_token: auth_token}
      else
        invalid_login
      end
    end
  
    def destroy
      #TODO crear accion de logout
    end
    
    private 
    
    def jwt_token(user)
      JsonWebToken.encode({id: user.id, email: user.email}) 
    end
    
    def invalid_login
      render json: { error: t('devise.failure.not_found_in_database') }, status: :unauthorized
    end
  end  