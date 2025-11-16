# lib/tasks/movie_metrics.rake
namespace :movies do
  desc "Create MovieMetric for movies that don't have one yet"
  task create_metrics: :environment do
    Movie.find_each do |movie|
        if(movie.movie_metric.blank?)
          MovieMetric.find_or_create_by(movie_id: movie.id)
          puts "created: for " + movie.title
        else
          puts "Found: for " + movie.title
        end
        
        
    end

    puts "Done!"
  end
end
