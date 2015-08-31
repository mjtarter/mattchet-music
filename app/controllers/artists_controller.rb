class ArtistsController < ApplicationController

	def index
		@songs = Song.all
	end

	def add_song
		@song = Song.new(params.require(:song).permit(:title))
		@song.save
		redirect_to(:action => 'index')
	end
end
