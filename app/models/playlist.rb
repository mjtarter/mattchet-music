class Playlist < ActiveRecord::Base
	has_many :playlistings
	has_many :songs, :through => :playlistings
end
