require "omniauth/strategies/riot_games"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
           {
             scope: "email,profile",
             access_type: "offline",
             prompt: "select_account",
           }
  #   provider :riot_games, ENV["RIOT_GAMES_CLIENT_ID"], ENV["RIOT_GAMES_CLIENT_SECRET"]
end

OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.silence_get_warning = true
