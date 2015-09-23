class PlaylistsController < ApplicationController

	def new
		@songs = Song.all
		render('/application/index')	
	end

	def create
		if @playlist = Playlist.create(playlist_params)
			@playlist_id = @playlist.id
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Playlist created!'
			@songs = Song.all 
			render('/application/index')
		else
			@playlist_id = @playlist.id
			@songs = Song.all
			render('/application/index')
		end
	end

	private
	
		def playlist_params
			params.require(:playlist).permit(:playlist)
		end

end