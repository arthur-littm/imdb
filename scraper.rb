TOP_MOVIES = "https://www.imdb.com/chart/top"
BASE_URL = "https://www.imdb.com"
require 'nokogiri'
require 'open-uri'

# IMDB Reminder
# open(url, "Accept-Language" => "en")

# return an array of the top 5 movie urls
def fetch_movie_urls
  # open the url
  big_string = open(TOP_MOVIES).read
  # use nokogiri to turn the content into searcheable doc
  doc = Nokogiri::HTML(big_string)
  # inspect the website to find out where the class are
  # titleColumn
  # use search method with the right class
  movie_array = []
  doc.search('.titleColumn a').first(5).each do |element|
   movie_array << BASE_URL + element.attr("href")
  end

  # return an array
  return movie_array
end

def scrape_movie(url)
  info = {}
  #   title: Shawshank Redemption,
  #   year: 1994,

  # open the url
  big_string = open(url).read
  # use nokogiri to turn the content into searcheable doc
  doc = Nokogiri::HTML(big_string)
  # inspect the website to find out where the class are
  # h1
  # use search method to find a relevant information for find a title
  title = doc.search("h1").text.strip
  year = doc.search("#titleYear a").text.strip
  description = doc.search(".summary_text").text.strip
  director = doc.search(".credit_summary_item a").first.text.strip
  cast = []
  doc.search(".credit_summary_item").last.search("span a").each do |element|
    cast << element.text.strip
  end
  # store the information into the hash
  info[:title] = title
  info[:year] = year
  info[:description] = description
  info[:director] = director
  info[:cast] = cast
  # return the hash
  return info

end

