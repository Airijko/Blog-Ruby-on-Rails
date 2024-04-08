class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :name
      t.text :content
      t.text :summoner_name
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end
end
