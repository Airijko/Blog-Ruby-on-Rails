require 'omniauth/strategies/riot_games'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :riot_games, ENV['RIOT_GAMES_CLIENT_ID'], ENV['RIOT_GAMES_CLIENT_SECRET']
end