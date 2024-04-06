class SummonersController < ApplicationController
  require 'net/http'
  require 'uri'

  def show
    client_secret = ENV['RIOT_GAMES_CLIENT_SECRET']
    @player_data = session[:player]
    encryptedPUUID = @player_data['puuid']
    region = session[:region]

    uri = URI("https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/#{encryptedPUUID}?api_key=#{client_secret}")
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
        @summoner_data = JSON.parse(response.body)
        @profile_icon_id = "https://ddragon.leagueoflegends.com/cdn/14.7.1/img/profileicon/#{@summoner_data['profileIconId']}.png"
        logger.info "Summoner name: #{@summoner_data['name']}"
    else
        @summoner_data = nil
        logger.warn "No summoner found"
    end
  end
end