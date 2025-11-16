class MovieMetricsController < ApplicationController
  before_action :set_movie_metric, only: %i[ show edit update destroy ]

  # GET /movie_metrics or /movie_metrics.json
  def index
    @movie_metrics = MovieMetric.all
  end

  # GET /movie_metrics/1 or /movie_metrics/1.json
  def show
  end

  # GET /movie_metrics/new
  def new
    @movie_metric = MovieMetric.new
  end

  # GET /movie_metrics/1/edit
  def edit
  end

  # POST /movie_metrics or /movie_metrics.json
  def create
    @movie_metric = MovieMetric.new(movie_metric_params)

    respond_to do |format|
      if @movie_metric.save
        format.html { redirect_to @movie_metric, notice: "Movie metric was successfully created." }
        format.json { render :show, status: :created, location: @movie_metric }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_metrics/1 or /movie_metrics/1.json
  def update
    respond_to do |format|
      if @movie_metric.update(movie_metric_params)
        format.html { redirect_to @movie_metric, notice: "Movie metric was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @movie_metric }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_metrics/1 or /movie_metrics/1.json
  def destroy
    @movie_metric.destroy!

    respond_to do |format|
      format.html { redirect_to movie_metrics_path, notice: "Movie metric was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_metric
      @movie_metric = MovieMetric.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_metric_params
      params.expect(movie_metric: [ :movie_id, :views_count, :likes_count, :comments_count, :shares_count ])
    end
end
