class PlaylistsController < ApplicationController

	def new
		@songs = Song.all
		render('/application/index')	
	end

	def create_name
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

	def add_songs
		@playlist_id = (params[:id])
		@song_ids = (params[:song][:song_id])

		if 	@song_ids.each do |song_id|
				Playlisting.create(:song_id => song_id, :playlist_id => @playlist_id)
			end
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Songs added to playlist!'
			redirect_to(:controller => 'songs', :action => 'index')
		else
			@songs = Song.all
			render('index')
		end
	end

	private
	
		def playlist_params
			params.require(:playlist).permit(:playlist)
		end

end