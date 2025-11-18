# app/services/majorcineplex_scraper.rb
class MajorScraper
  require 'nokogiri'
  require 'faraday'

  BASE_URL = 'https://www.majorcineplex.com' # adjust if needed

  def initialize
    @url = BASE_URL
  end

  def fetch_movies
    conn = Faraday.new(url: @url) do |faraday|
        faraday.response :follow_redirects  # This tells Faraday to follow 301/308 automatically
        faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/movie")

    puts response.env.url
    doc = Nokogiri::HTML(response.body)

    movies = []
    # binding.pry
    doc.css('.ml-box').each do |movie_box|
      # Image from style attribute
      cover_style = movie_box.at_css('.mlb-cover')&.[]('style')
      image_url = cover_style&.match(/url\((.*?)\)/)&.captures&.first

      # Movie page URL
      movie_url = movie_box.at_css('.mlb-name a')&.[]('href')
      movie_url = BASE_URL + movie_url if movie_url&.start_with?('/')

      # Title
      title = movie_box.at_css('.mlb-name a')&.text&.strip

      # Genres (from mlb-genres)
      genres = movie_box.css('.mlb-genres .genres_span').map(&:text).map(&:strip)
      duration = genres.pop # last span is duration
      genres = genres.map { |g| g.split('/').map(&:strip) }.flatten # split genres if "/"

      # Release date
      release_date = movie_box.at_css('.mlb-date')&.text&.strip

      movies << {
        title: title,
        url: movie_url,
        image_url: image_url,
        genres: genres,
        duration: duration,
        release_date: release_date
      }
    end

    movies
  end
end
