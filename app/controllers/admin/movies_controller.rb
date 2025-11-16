class Admin::MoviesController < Admin::ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

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
    # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      MovieMetric.find_or_create_by(movie_id: @movie.id)
      if @movie.save
        format.html { redirect_to admin_movies_path, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to admin_movies_path, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to admin_movies_path, notice: "Movie was successfully deleted by admin." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :description, images: [] ])
    end
end
