class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer "artist_id"
      t.string "title"
      t.timestamps null: false
    end
  end
end
