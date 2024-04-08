class AddSummonerTagToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :summoner_tag, :string
  end
end
