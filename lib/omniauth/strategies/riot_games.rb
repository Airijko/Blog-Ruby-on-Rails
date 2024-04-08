# lib/omniauth/strategies/riot_games.rb
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class RiotGames < OmniAuth::Strategies::OAuth2
      def request_phase
        Rails.logger.debug "Authorize URL: #{client.auth_code.authorize_url({ :redirect_uri => callback_url }.merge(authorize_params))}"
        super
      end

      option :name, "riot_games"

      option :client_options, {
        site: "https://auth.riotgames.com",
        authorize_url: "https://auth.riotgames.com/authorize",
        token_url: "https://auth.riotgames.com/token",
        scope: "openid",
      }

      uid { raw_info["id"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"],
        }
      end
    end
  end
end
