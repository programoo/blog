class RatingsController < ApplicationController
  before_action :set_movie

  def create
    @rating = Rating.find_or_initialize_by(movie_id: params[:movie_id], user_id: current_user.id)
    @rating.value = params[:value]
    if @rating.new_record?
        if @rating.save
            respond_to do |format|
                format.turbo_stream
            end
        else
            head :unprocessable_entity
        end
    else
        if @rating.save
            respond_to do |format|
                format.turbo_stream
            end
        else
            head :unprocessable_entity
        end
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
