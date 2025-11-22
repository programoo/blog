class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  def index
    if params[:query].present?
      @searched_movies = Movie.where("title ILIKE ?", "%#{params[:query]}%").order(updated_at: :desc)
    else
      @searched_movies = Movie.order(updated_at: :desc)
    end

    @pagy, @movies = pagy(@searched_movies, limit: 10)


    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @movie.movie_metric.increment!(:views_count)
    @movie.touch
  end

  def new

    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        MovieMetric.find_or_create_by(movie_id: @movie.id)
        format.html { redirect_to admin_movies_path, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # Delete selected images
    if params[:remove_images]
      params[:remove_images].each do |image_id|
        image = @movie.images.find(image_id)
        image.purge
      end
    end
    
    movie_params_without_image = movie_params.except(:images)
    # Only attach if user actually uploaded something
    if params[:movie][:images].present?
      @movie.images.attach(params[:movie][:images])
    end
    
    respond_to do |format|
      if @movie.update(movie_params_without_image)
        format.html { redirect_to admin_movies_path, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to admin_movies_path, notice: "Movie was successfully deleted not admin." }
      format.json { head :no_content }
    end
  end

  private
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    def movie_params
      params.expect(movie: [:content, :video_id, :title, :description, images: [] ])
    end
end
