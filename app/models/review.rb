class Review < ApplicationRecord
  validates :content, :summoner_name, :summoner_tag, presence: true
  validate :summoner_exists_in_riot_games

  def summoner_exists_in_riot_games
    client_secret = ENV["RIOT_GAMES_CLIENT_SECRET"]
    summoner_name = self.summoner_name
    summoner_tag = self.summoner_tag
    encoded_game_name = URI.encode_www_form_component(summoner_name)
    encoded_tag_line = URI.encode_www_form_component(summoner_tag)

    uri = URI("https://americas.api.riotgames.com/riot/account/v1/accounts/by-riot-id/#{encoded_game_name}/#{encoded_tag_line}?api_key=#{client_secret}")
    response = Net::HTTP.get_response(uri)

    errors.add(:summoner_name, "does not exist in Riot Games") unless response.is_a?(Net::HTTPSuccess)
  end
end
