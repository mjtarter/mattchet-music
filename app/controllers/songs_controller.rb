class SongsController < ApplicationController

	def index
		@songs = Song.all
	end

	def create

		# if artist does not currently exist in DB: Add new artist to ArtistTbl & Add new title and new artist_id to SongTbl
		# else: Add new title, and existing artist_id to Song Table

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
			@songs = Song.all
			render('index')
		end

	end

	def update
	end

	def destroy
	end

end