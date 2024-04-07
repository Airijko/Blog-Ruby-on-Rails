require 'net/http'
require 'uri'

class SearchController < ApplicationController
  def index
    region = params[:region]
    session[:region] = params[:region]
    game_name = params[:gameName]
    tag_line = params[:tagLine]
    client_secret = ENV['RIOT_GAMES_CLIENT_SECRET']
    

    uri = URI("https://americas.api.riotgames.com/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}?api_key=#{client_secret}")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      session[:player] = JSON.parse(response.body)
      logger.info "Player name: #{session[:player]['gameName']}"
    else
      session[:player] = nil
      logger.warn "No player found for: #{game_name} and tag line: #{tag_line}"
    end

    redirect_to summoner_path(region: region, game_name: game_name, tag: tag_line)  
  end
end