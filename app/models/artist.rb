class Artist < ActiveRecord::Base
	
	has_many :songs

	validates_presence_of :artist
	validates_uniqueness_of :artist

end
