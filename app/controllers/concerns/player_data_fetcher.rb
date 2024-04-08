module PlayerDataFetcher
  extend ActiveSupport::Concern

  def fetch_player_data(game_name, tag_line, client_secret)
    encoded_game_name = URI.encode_www_form_component(game_name)
    encoded_tag_line = URI.encode_www_form_component(tag_line)

    Rails.cache.fetch("player_data_#{encoded_game_name}_#{encoded_tag_line}", expires_in: 12.hours) do
      uri = URI("https://americas.api.riotgames.com/riot/account/v1/accounts/by-riot-id/#{encoded_game_name}/#{encoded_tag_line}?api_key=#{client_secret}")
      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        nil
      end
    end
  end
end
