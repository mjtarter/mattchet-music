class PlaylistsController < ApplicationController

	def new
		@songs = Song.all
		render('/application/index')	
	end

	def create_name
		@playlist = Playlist.new(playlist_params)
		if @playlist.save 
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

	def create_songs
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

	def show
		@playlist_id = (params[:playlist_id]) 
		@playlist = Playlist.find(@playlist_id)
		@song_ids = Playlisting.where(playlist_id: @playlist_id).pluck(:song_id)
		@songs = Song.where(id: @song_ids)
		render('/application/index')
	end

	def edit
		@playlist_id = (params[:playlist_id]) 
		@playlist = Playlist.find(params[:playlist_id])
		@song_ids = Playlisting.where(playlist_id: @playlist_id).pluck(:song_id)
		@songs = Song.where(id: @song_ids)
		render('index')
	end

	def update
		@playlist_id = params[:playlist_id]
		@playlist = Playlist.find(params[:playlist_id])
		@new_name = Playlist.find_by_playlist(params[:playlist][:playlist]) unless params[:playlist][:playlist].nil?
		# If artist from form parameters does not exist in db, create new artist
		if @new_name == nil
			@playlist.update_attributes(playlist_params)
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Playlist name updated!'
			redirect_to(:action => 'show', :playlist_id => @playlist_id)
		else
			redirect_to(:action => 'edit', :playlist_id => @playlist_id, :error => 'yes')
		end
	end

	private
	
		def playlist_params
			params.require(:playlist).permit(:playlist)
		end

end