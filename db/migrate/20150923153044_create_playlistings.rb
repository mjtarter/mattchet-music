class CreatePlaylistings < ActiveRecord::Migration
  def change
    create_table :playlistings do |t|
      t.integer :playlist_id
      t.integer :song_id

      t.timestamps null: false
    end
  end
end
