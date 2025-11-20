# app/services/youtube_search_service.rb
require "faraday"
require "json"

class YoutubeSearchService
  BASE_URL = "https://www.googleapis.com/youtube/v3/search"

  def initialize(movie_title)
    @movie_title = movie_title
    @api_key = ENV["GOOGLE_YOUTUBE_DATA_API_V3_KEY"]
  end

  def call
    return nil if @api_key.blank?

    query = "#{@movie_title} trailer"

    response = connection.get("", {
      part: "snippet",
      type: "video",
      q: query,
      key: @api_key
    })

    return nil unless response.success?

    data = JSON.parse(response.body)
    extract_item(data)
  rescue => e
    Rails.logger.error("YouTube API error: #{e.message}")
    nil
  end

  private

  def connection
    Faraday.new(url: BASE_URL) do |f|
      f.request :url_encoded
      f.response :raise_error # raise exceptions for non-2xx
      f.adapter Faraday.default_adapter
    end
  end

  def extract_item(data)
    item = data["items"]&.first
    return nil unless item

    {
      video_id: item["id"]["videoId"],
      title: item["snippet"]["title"],
      thumbnail: item["snippet"]["thumbnails"]["high"]["url"]
    }
  end
end
