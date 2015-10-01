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
		#If multiple songs added to playlist:
		if (params[:id]).nil? == false
			@playlist_id = (params[:id])
			@song_ids = (params[:song][:song_id])

			if 	@song_ids.each do |song_id|
					Playlisting.create(:song_id => song_id, :playlist_id => @playlist_id)
				end
				flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Songs added to playlist!'
				redirect_to(:action => 'show', :playlist_id => @playlist_id)
			else
				@songs = Song.all
				render('index')
			end
		#If 1 individual song is added to playlist:
		else
			@playlist_id = (params[:playlist][:id])
			@song_id = (params[:song_id])
			@playlist = Playlisting.new(:song_id => @song_id, :playlist_id => @playlist_id)

			if 	@playlist.save
				flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Songs added to playlist!'
				redirect_to(:action => 'show', :playlist_id => @playlist_id)
			else
				@songs = Song.all
				render('index')
			end
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

		@playlist.update_attributes(playlist_params)

		if @playlist.save
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Playlist name updated!'
			@song_ids = Playlisting.where(playlist_id: @playlist_id).pluck(:song_id)
			@songs = Song.where(id: @song_ids)
			render('index')
		else
			@song_ids = Playlisting.where(playlist_id: @playlist_id).pluck(:song_id)
			@songs = Song.where(id: @song_ids)			
			render('index')
		end 
	end

	def delete
		@playlist_id = Playlist.find(params[:playlist_id])
		@playlist = Playlist.find(@playlist_id)
		# Render index action 
		@song_ids = Playlisting.where(playlist_id: @playlist_id).pluck(:song_id)
		@songs = Song.where(id: @song_ids)
		render('/application/index')
	end

	def destroy
		Playlisting.destroy_all(:playlist_id => (params[:playlist_id]))
		Playlist.find(params[:playlist_id]).destroy

		flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Playlist Deleted!'
		@songs = Song.all
		redirect_to(:controller => 'songs', :action => 'index')
	end

	#Called if user exits modal without filling out form
	def redirect_index
		@songs = Song.all
		redirect_to(:controller => 'songs', :action => 'index')
	end

	private
	
		def playlist_params
			params.require(:playlist).permit(:playlist)
		end

end