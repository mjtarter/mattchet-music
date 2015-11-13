class Playlist < ActiveRecord::Base
	has_many :playlistings
	has_many :songs, :through => :playlistings

	scope :sort_by_artist, lambda { joins(:artist).order('artists.artist') }

	validates_presence_of :playlist
	validates_uniqueness_of :playlist
end
