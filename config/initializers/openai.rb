# config/initializers/openai.rb

OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(:openai, :api_key)
end

puts "############################### INITIALISER WORK WITH " + Rails.application.credentials.dig(:openai, :api_key)