class GoogleCustomSearchService
  BASE_URL = 'https://www.googleapis.com/customsearch/v1'

  def initialize(query)
    
    @query = query
    @api_key = ENV["GOOGLE_CUSTOM_SEARCH_API_KEY"]
    @cx      = ENV["GOOGLE_CUSTOM_SEARCH_CX_KEY"]

    puts "#keys: " + @api_key + ", " + @cx 
    @conn    = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.response :json, parser_options: { symbolize_names: true } # auto parse JSON
      faraday.adapter Faraday.default_adapter
    end
  end

  def search
    response = @conn.get do |req|
      req.params['key'] = @api_key
      req.params['cx']  = @cx
      req.params['q']   = @query
      req.params['num'] = 5
    end

    if response.success?
      response.body[:items] || []
    else
      Rails.logger.error("Google CSE Error: #{response.status} #{response.body}")
      []
    end
  end
end

