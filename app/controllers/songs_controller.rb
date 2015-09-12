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
		# Render index action 
		@songs = Song.all
		render('index')
	end

	def update
		@song = Song.find(params[:song_id])
		@artist = Artist.find_by_artist(params[:artist][:artist]) unless params[:artist][:artist].nil?
		# If artist from form parameters does not exist in db, create new artist
		if @artist == nil
			@artist = Artist.create(artist_params)
		end			

		@song.update_attributes(song_params)
		@song.artist_id = @artist.id

		if @song.save
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
		if @song = Song.find(params[:song_id]).destroy
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Track Deleted!'
			redirect_to(:action => 'index')
		else
			@songs = Song.all
			render('index')
		end
	end

	private
		
		def artist_params
			params.require(:artist).permit(:artist)
		end

		def song_params
			params.require(:song).permit(:title)
		end

end