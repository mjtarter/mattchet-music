class ArtistsController < ApplicationController

	def index
		@songs = Song.all
	end
end
