require 'csv'

namespace :import  do
	
	desc "Import songs from CSV"
	task songs: :environment do
		counter = 0

		CSV.foreach("db/songs.csv") do |row|
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

		CSV.foreach("db/artists.csv") do |row|
			artist = row[0]
			artist = Artist.create(artist: artist)
			puts "#{artist} - #{artist.errors.full_messages.join(",")}" if artist.errors.any?
			counter += 1 if artist.persisted?
		end

		puts "Imported #{counter} artists"
	end
end