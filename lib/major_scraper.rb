# app/services/majorcineplex_scraper.rb
class MajorScraper
  require 'nokogiri'
  require 'faraday'

  BASE_URL = 'https://www.majorcineplex.com' # adjust if needed

  def initialize
    @url = BASE_URL
  end

  def fetch_movie
    conn = Faraday.new(url: @url) do |faraday|
        faraday.response :follow_redirects  # This tells Faraday to follow 301/308 automatically
        faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/movie")

    puts response.env.url
    doc = Nokogiri::HTML(response.body)

    movies = []
    # binding.pry
    doc.css('.ml-box').each do |box|
        cover_style = box.at_css('.mlb-cover')['style']
        image_url = cover_style[/url\((.*?)\)/, 1]  # extract from background:url(...)

        title = box.at_css('.mlbc-name')&.text&.strip.squish
        title_alt = box.at_css('.mlb-name a')&.text&.strip.squish   # fallback title

        genres = box.css('.mlb-genres .genres_span')
                    .map { |g| g.text.strip.squish }
                    .reject(&:empty?)

        duration = box.at_css('.mlbc-time')&.text&.strip.squish

        category = box.at_css('.mlbc-cate')&.text&.strip.squish

        if category.include?("เพลง")
          next
        end

        sound = box.at_css('.mlbc-sound')&.text&.strip.squish

        date = box.at_css('.mlb-date')&.text&.strip.squish

        detail_url = box.at_css('.mlbc-btn a.mlbc-btn-mi')['href'] rescue nil
        buy_url    = box.at_css('.mlbc-btn a.buynow_button')['href'] rescue nil

        movies << {
            image: image_url,
            title: title || title_alt,
            category: category,
            duration: duration,
            sound: sound,
            date: date,
            genres: genres,
            detail_url: detail_url,
            buy_url: buy_url
        }
    end
    # binding.pry
    movies.each do |m|
        movie = Movie.find_or_initialize_by(title:m.dig(:title))
        if !movie.new_record?
          puts "# old: " + movie.title
          next
        end

        puts "### fetching...: " + movie.title

        youtube_data = YoutubeSearchService.new(movie.title).call
        youtube_data = nil
        movie.assign_attributes(
            description: m.dig(:description),
            category:    m.dig(:category),
            source_image:m.dig(:image),
            duration:    m.dig(:duration),
            release_date:m.dig(:date),
            source_url:  m.dig(:detail_url)
        )
        if youtube_data.present?
          movie.youtube_thumbnail = youtube_data.dig(:thumbnail)
          movie.youtube_title = youtube_data.dig(:title)
          movie.video_id = youtube_data.dig(:video_id)
        end

        movie.save!

        MovieMetric.find_or_create_by(movie_id: movie.id)

        break
    end
  end
end
