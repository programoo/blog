class Admin::MoviesController < Admin::ApplicationController
  def index
    # @pagy, @movies = pagy(Movie.order(created_at: :desc), items: 5)
    @pagy, @movies = pagy(:offset, Movie.order(created_at: :desc), limit: 10)


  end

  def show
  end
end
