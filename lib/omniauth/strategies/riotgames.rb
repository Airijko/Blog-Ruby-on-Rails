# lib/omniauth/strategies/riotgames.rb
require 'omniauth-oauth2'

module OmniAuth
 module Strategies
    class Riotgames < OmniAuth::Strategies::OAuth2
      option :name, 'riotgames'
      option :client_options, {
        site: 'https://auth.riotgames.com',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }
      option :provider_ignores_state, false

      # Define the scope and redirect_uri options here
      option :scope, 'account openid' # Adjust the scope as needed
      option :redirect_uri, 'https://example.com/users/auth/riotgames/callback' # Adjust the redirect_uri as needed

      uid { raw_info['id'] }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email']
        }
      end
    end
 end
end
