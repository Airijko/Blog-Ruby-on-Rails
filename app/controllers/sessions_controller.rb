class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
        auth = request.env['omniauth.auth']
        logger.debug "Omniauth auth hash: #{auth.inspect}"

        # binding.pry
        # render json: auth
    end
end