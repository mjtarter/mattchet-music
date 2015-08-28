class AddIndexToArtists < ActiveRecord::Migration
  def change
  	add_index(:artists, :artist, unique: true)
  end
end