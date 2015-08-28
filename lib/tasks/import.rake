require 'csv'

namespace :import  do
	
	desc "Import songs from CSV"
	task songs: :environment do
		counter = 0

		CSV.foreach("db/csv/songs.csv") do |row|
			title = row[0]
			song = Song.create(title: title)
			puts "#{title} - #{song.errors.full_messages.join(",")}" if song.errors.any?
			counter += 1 if song.persisted?
		end

		puts "Imported #{counter} songs"
	end


	desc "Import artists from CSV"
	task artists: :environment do
		counter = 0

		CSV.foreach("db/csv/artists.csv") do |row|
			artist = row[0]
			artist = Artist.create(artist: artist)
			puts "#{artist} - #{artist.errors.full_messages.join(",")}" if artist.errors.any?
			counter += 1 if artist.persisted?
		end

		puts "Imported #{counter} artists"
	end


	desc "Import playlists from CSV"
	task playlists: :environment do
		counter = 0

		CSV.foreach("db/csv/playlists.csv") do |row|
			playlist = row[0]
			playlist = Playlist.create(playlist: playlist)
			puts "#{playlist} - #{playlist.errors.full_messages.join(",")}" if playlist.errors.any?
			counter += 1 if playlist.persisted?
		end

		puts "Imported #{counter} playlists"
	end
end