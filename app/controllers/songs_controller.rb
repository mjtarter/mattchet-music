class SongsController < ApplicationController

	def index
		@songs = Song.all
	end

	def create
		# if artist does not exist in DB: Add new artist to ArtistTbl & Add new title and new artist_id to SongTbl
		# else: Add new title, and existing artist_id to SongTbl

		new_artist = params[:artist][:artist]
		artist_exists = Artist.all.find_by_artist(new_artist)
		
		if artist_exists == nil
			@artist = Artist.new(params.require(:artist).permit(:artist))
			@artist.save

			@song = Song.new(params.require(:song).permit(:title))
			@song.artist_id = @artist.id
		
		else
			@song = Song.new(params.require(:song).permit(:title))
			@song.artist_id = artist_exists.id 
		end

		if @song.save
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Track added to library!'
			redirect_to(:action => 'index')
		else
			render('new')
		end
	end

	def edit
		@song = Song.find(params[:id])
		@artist = Artist.find(params[:artist_id])
		@songs = Song.all
		render('index')
	end


	def update
		@song = Song.find(params[:id])
		new_artist = params[:artist][:artist]
		artist_exists = Artist.all.find_by_artist(new_artist)
		
		if artist_exists == nil
			@artist = Artist.new(params.require(:artist).permit(:artist))
			@artist.save

			@song.update_attributes(params.require(:song).permit(:title))
			@song.artist_id = @artist.id
		
		else
			@song.update_attributes(params.require(:song).permit(:title))
			@song.artist_id = artist_exists.id 
		end

		if @song.save
			flash[:notice] = '<span class="glyphicon glyphicon-music"></span> Track updated!'
			redirect_to(:action => 'index')
		else
			@songs = Song.all
			render('index')
		end
	end

end