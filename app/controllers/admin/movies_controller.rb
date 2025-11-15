class Admin::MoviesController < Admin::ApplicationController
  def index
    if params[:query].present?
      @searched_movies = Movie.where("title ILIKE ?", "%#{params[:query]}%").order(created_at: :desc)
    else
      @searched_movies = Movie.order(created_at: :desc)
    end

    @pagy, @movies = pagy(:offset, @searched_movies, limit: 10)
  end

  def show
  end
end
