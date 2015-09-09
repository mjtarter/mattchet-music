class Song < ActiveRecord::Base
	
	belongs_to :artist
	
	validates_associated :artist
	validates_presence_of :title

end
