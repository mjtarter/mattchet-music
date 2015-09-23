class SongsController < ApplicationController

	def index
		@songs = Song.all
	end

	def create
		# Instantiate a new object using form parameters
		@artist = Artist.find_by_artist(params[:artist][:artist]) unless params[:artist][:artist].nil?
		# If artist from form parameters does not exist in db, create new artist
		if @artist == nil
			@artist = Artist.create(artist_params)
		end

		@song = Song.new(song_params)
		@song.artist_id = @artist.id 

		if @song.save
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Track added to library!'
			redirect_to(:action => 'index')
		else
			render('new')
		end
	end

	def edit
		# Instantiate new objects using url parameters
		@song = Song.find(params[:song_id])
		@artist = Artist.find(params[:artist_id])
		@artist_to_be_updated = Artist.find(params[:artist_id])
		# Render index action 
		@songs = Song.all
		render('index')
	end

	def update
		@artist_to_be_updated = (params[:artist_to_be_updated])
		@song = Song.find(params[:song_id])
		@artist = Artist.find_by_artist(params[:artist][:artist]) unless params[:artist][:artist].nil?
		# If artist from form parameters does not exist in db, create new artist
		if @artist == nil
			@artist = Artist.create(artist_params)
		end			

		@song.update_attributes(song_params)
		@song.artist_id = @artist.id

		if @song.save
			# If the old artist_id is no longer being used by any songs, then delete that row from the artist table
			if Song.find_by_artist_id(@artist_to_be_updated).nil?
				Artist.find(@artist_to_be_updated).destroy
			end
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Track updated!'
			redirect_to(:action => 'index')
		else
			@songs = Song.all
			render('index')
		end
	end

	def delete
		@song = Song.find(params[:song_id])
		@artist = Artist.find(params[:artist_id])
		# Render index action 
		@songs = Song.all
		render('index')
	end

	def destroy
		@song = Song.find(params[:song_id]).artist_id
		Song.find(params[:song_id]).destroy
		
		# If the old artist_id is no longer being used by any songs, then delete that row from the artist table
		if Song.find_by_artist_id(@song).nil?
			Artist.find(@song).destroy
		end
		flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Track Deleted!'
		redirect_to(:action => 'index')
	end

	def create_join
		@playlist_id = (params[:id])
		@song_ids = (params[:song][:song_id])

		flash[:notice] = @playlist_id + @song_ids.inspect + '<span class="glyphicon glyphicon-music"></span> Track Deleted!'
		redirect_to(:action => 'index')
	end

	private
		
		def artist_params
			params.require(:artist).permit(:artist)
		end

		def song_params
			params.require(:song).permit(:title)
		end

end