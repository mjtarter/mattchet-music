require 'csv'

namespace :import  do
	
	desc "Import songs from CSV"
	task songs: :environment do
		counter = 0

		CSV.foreach("songs.csv") do |row|
			title = row[0]
			song = Song.create(title: title)
			puts "#{title} - #{song.errors.full_messages.join(",")}" if song.errors.any?
			counter += 1 if song.persisted?
		end

		puts "Imported #{counter} users"
	end
end