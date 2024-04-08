class SummonersController < ApplicationController
  include PlayerDataFetcher
  require "net/http"
  require "uri"

  def show
    client_secret = ENV["RIOT_GAMES_CLIENT_SECRET"]
    game_name = params[:gameName]
    tag_line = params[:tagLine]
    region = params[:region]
    encoded_game_name = URI.encode_www_form_component(game_name)
    encoded_tag_line = URI.encode_www_form_component(tag_line)

    @player_data = fetch_player_data(game_name, tag_line, client_secret)
    @reviews = Review.where(summoner_name: @player_data["gameName"], summoner_tag: @player_data["tagLine"]).order(created_at: :desc)

    if @player_data
      encryptedPUUID = @player_data["puuid"]
      @summoner_data = fetch_summoner_data(encryptedPUUID, region, client_secret)
      # logger.info "Summoner data: #{@summoner_data}"

      if @summoner_data
        @profile_icon_id = "https://ddragon.leagueoflegends.com/cdn/14.7.1/img/profileicon/#{@summoner_data["profileIconId"]}.png"
        logger.info "Summoner name: #{@summoner_data["name"]}"
        @matches = Rails.cache.fetch("matches_#{encryptedPUUID}", expires_in: 12.hours) do
          fetch_matches(@player_data["puuid"], client_secret) if @player_data["puuid"]
        end
      end
    else
      logger.warn "No player data found in session"
      redirect_to root_path
    end
  end

  private

  def fetch_summoner_data(puuid, region, client_secret)
    Rails.cache.fetch("summoner_data_#{puuid}", expires_in: 12.hours) do
      uri = URI("https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/#{puuid}?api_key=#{client_secret}")
      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        logger.warn "API request failed with status: #{response.code}"
        nil
      end
    end
  end

  def fetch_matches(puuid, client_secret)
    uri = URI("https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/#{puuid}/ids?start=0&count=5&api_key=#{client_secret}")
    response = Net::HTTP.get(uri)
    match_ids = JSON.parse(response)

    match_ids.map do |match_id|
      uri2 = URI("https://americas.api.riotgames.com/lol/match/v5/matches/#{match_id}?api_key=#{client_secret}")
      match_response = Net::HTTP.get(uri2)
      JSON.parse(match_response)
    end
  end
end
