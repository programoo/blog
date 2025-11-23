class UserLikesController < ApplicationController
  before_action :set_user_like, only: %i[ show edit update destroy ]

  # GET /user_likes or /user_likes.json
  def index
    @user_likes = UserLike.all
  end

  # GET /user_likes/1 or /user_likes/1.json
  def show
  end

  # GET /user_likes/new
  def new
    @user_like = UserLike.new
  end

  # GET /user_likes/1/edit
  def edit
  end

  # POST /user_likes or /user_likes.json
  def create
    @movie = Movie.find(params.dig(:movie_id))
    @user_liked = UserLike.find_by(user_id: params.dig(:user_id), movie_id: params.dig(:movie_id))
    
    if @user_liked.present?
      @user_liked.movie.movie_metric.decrement!(:likes_count)
      @user_liked.destroy
      
      respond_to do |format|
        format.turbo_stream
      end
    else
      @user_like = UserLike.new(user_like_params)
      respond_to do |format|
        if @user_like.save
          @user_like.movie.movie_metric.increment!(:likes_count)
          format.turbo_stream
        else
          format.turbo_stream
        end
      end
    end
  end

  # PATCH/PUT /user_likes/1 or /user_likes/1.json
  def update
    respond_to do |format|
      if @user_like.update(user_like_params)
        format.html { redirect_to @user_like, notice: "User like was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_likes/1 or /user_likes/1.json
  def destroy
    @user_like.destroy!

    respond_to do |format|
      format.html { redirect_to user_likes_path, notice: "User like was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_like
      @user_like = UserLike.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_like_params
      params.permit(:user_id, :movie_id)
    end
end
