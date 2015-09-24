class Playlist < ActiveRecord::Base
	has_many :playlistings
	has_many :songs, :through => :playlistings

	validates_presence_of :playlist
	validates_uniqueness_of :playlist
end
