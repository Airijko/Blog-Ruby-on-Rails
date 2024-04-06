class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token, only: :riotgames
    protect_from_forgery except: :riotgames
end
