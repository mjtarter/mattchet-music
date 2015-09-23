class Song < ActiveRecord::Base
	
	belongs_to :artist
	has_many :playlistings
	has_many :playlists, :through => :playlistings
	
	validates_associated :artist
	validates_presence_of :title

end
