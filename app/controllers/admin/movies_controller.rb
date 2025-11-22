class Admin::MoviesController < Admin::ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  def index
    if params[:query].present?
      @searched_movies = Movie.where("title ILIKE ?", "%#{params[:query]}%").order(updated_at: :desc)
    else
      @searched_movies = Movie.order(updated_at: :desc)
    end

    @pagy, @movies = pagy(:offset, @searched_movies, limit: 10)
  end

  def fetch
    puts "#### Calling fetch in admin"

    MajorScraper.new.fetch_movie
    @movies = Movie.order(updated_at: :desc)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def show
  end
    # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    client = OpenAI::Client.new
    chat_params =  {
          model: "gpt-4.1",
          messages: [
            { role: "system", content: "You are a helpful assistant that responds only in JSON and translate to thai language." },
            { role: "system", content: "locked structured: {
  'title': '',
  'year': ,
  'genre': [
    ''
  ],
  'director': '',
  'writers': [
    ''
  ],
  'cast': [
    ''
  ],
  'plot': '',
  'runtime': '',
  'language': '',
  'country': '',
  'imdb_rating': 0,
  'images': [
    ''
  ],
  'trailer_youtube': '',
  'test_field': ''
}'"},
            { role: "user", content: "give me movie detail of the movie named including images and trailers youtube: " + @movie.title}
          ], # Required.
          temperature: 0
      }
    # response = client.chat(parameters: chat_params)
    puts JSON.pretty_generate(response)
    # puts response.dig("choices", 0, "message", "content")
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
    movie_params_without_image = movie_params.except(:images)
    binding.pry
    # Only attach if user actually uploaded something
    if params[:movie][:images].present?
      @movie.images.first.attach(params[:movie][:images])
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
      params.expect(movie: [ :content, :title, :description, images: [] ])
    end
end
