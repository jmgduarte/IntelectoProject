class Api::V1::BaseController < ApplicationController
    #skip_before_action :verify_authenticity_token
    before_action :authenticate!
  
    def authenticate!
      auth_header = request.headers['Authorization']
      token = auth_header.split(' ').last
      return true if JsonWebToken.decode(token)
    rescue
      render json: {error: "Error en la autenticación, Token Errado"}
    end
  
    def invalid_authentication
      render json: {error: t('devise.failure.unathenthication')}, status: unathorized
    end
  end