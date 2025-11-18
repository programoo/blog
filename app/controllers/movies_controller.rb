class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  def index
    if params[:query].present?
      @searched_movies = Movie.where("title ILIKE ?", "%#{params[:query]}%").order(created_at: :desc)
    else
      @searched_movies = Movie.order(created_at: :desc)
    end

    @pagy, @movies = pagy(@searched_movies, limit: 10)


    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @movie.movie_metric.increment!(:views_count)
    puts "SHOW WAS CALLED DURING THIS PERIOD " + @movie.title
  end

  def new
    client = OpenAI::Client.new
    response = client.chat(
        parameters: {
        model: "gpt-4o", # Required.
        messages: [{ role: "user", content: "Hello!"}], # Required.
        temperature: 0.7
      }
    )
    puts response.dig("choices", 0, "message", "content")
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
      params.expect(movie: [ :title, :description, images: [] ])
    end
end
