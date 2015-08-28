require 'csv'

namespace :import  do
	
	desc "Import songs from CSV"
	task songs: :environment do
		counter = 0
		print "This will delete all of the current songs and replace them. Continue? (Y, N) "
		continue = STDIN.gets.chomp.downcase
		
		if continue == "y"
			table = Song.all
			table.destroy_all
			CSV.foreach("db/csv/songs.csv") do |row|
				title = row[0]
				song = Song.create(title: title)
				puts "#{title} - #{song.errors.full_messages.join(",")}" if song.errors.any?
				counter += 1 if song.persisted?
			end

			puts "Deleted old songs and imported #{counter} new songs"

		else
			puts "Ok. Nothing was changed."
		end
	end


	desc "Import artists from CSV"
	task artists: :environment do
		counter = 0
		id = 1
		print "This will delete all of the current artists and replace them. Continue? (Y, N) "
		continue = STDIN.gets.chomp.downcase

		if continue == "y"
			table = Artist.all
			table.destroy_all
			CSV.foreach("db/csv/artists.csv") do |row|
				artist = row[0]
				artist = Artist.create(id: id, artist: artist)
				puts "#{artist} - #{artist.errors.full_messages.join(",")}" if artist.errors.any?
				counter += 1 if artist.persisted?
				id += 1 if artist.persisted?
			end

			puts "Deleted old artists and imported #{counter} new artists"

		else
			puts "Ok. Nothing was changed."
		end
	end


	desc "Import playlists from CSV"
	task playlists: :environment do
		counter = 0
		print "This will delete all of the current playlists and replace them. Continue? (Y, N) "
		continue = STDIN.gets.chomp.downcase

		if continue == "y"
			table = Playlist.all
			table.destroy_all
			CSV.foreach("db/csv/playlists.csv") do |row|
				playlist = row[0]
				playlist = Playlist.create(playlist: playlist)
				puts "#{playlist} - #{playlist.errors.full_messages.join(",")}" if playlist.errors.any?
				counter += 1 if playlist.persisted?
			end

			puts "Deleted old playlists and imported #{counter} new playlists"
		
		else
			puts "Ok. Nothing was changed."
		end
	end

end