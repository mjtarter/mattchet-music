class ArtistsController < ApplicationController

	layout false

	def index
		@songs = Song.all
	end
end
