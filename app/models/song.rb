class Song < ActiveRecord::Base
	
	belongs_to :artist
	has_many :playlistings
	has_many :playlists, :through => :playlistings

	scope :sort_by_artist, lambda { joins(:artist).order('artists.artist') }
	
	validates_associated :artist
	validates_presence_of :title
	validates_presence_of :artist
	validates_uniqueness_of :title, :scope => [:artist_id]
end
