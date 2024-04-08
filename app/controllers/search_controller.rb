require "net/http"
require "uri"

class SearchController < ApplicationController
  include PlayerDataFetcher

  def index
    region = params[:region]
    game_name = params[:gameName]
    tag_line = params[:tagLine]
    client_secret = ENV["RIOT_GAMES_CLIENT_SECRET"]

    player_data = fetch_player_data(game_name, tag_line, client_secret)

    if player_data
      logger.info "Player data fetched for game name: #{game_name}, tag line: #{tag_line}"
      redirect_to summoner_path(region: region, gameName: game_name, tagLine: tag_line)
    else
      logger.warn "Summoner not found for game name: #{game_name}, tag line: #{tag_line}"
      flash[:alert] = "Summoner not found"
      redirect_to root_path
    end
  end
end
