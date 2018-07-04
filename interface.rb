require_relative "scraper"
require "yaml"

puts "----------------------------"
puts "Welcome to your IMDB scraper"
puts "----------------------------"

urls = fetch_movie_urls
movies = []

urls.each do |url|
  movies << scrape_movie(url)
end

File.open("movies.yml", "wb") do |file|
  file.write(movies.to_yaml)
end
