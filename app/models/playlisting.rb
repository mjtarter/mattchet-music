class Playlisting < ActiveRecord::Base
	belongs_to :playlist
	belongs_to :song

	validates_uniqueness_of :song_id, :scope => [:song_id, :playlist_id]
end
