class ChaptersController < ApplicationController
  before_action :set_chapter, only: %i[ show edit update destroy ]

  def index
    @chapters = Chapter.all
  end

  def show
  end

  def new
    @chapter = Chapter.new
    @chapter.position = Movie.find(params[:movie_id]).chapters.try(:size) + 1
  end

  def edit
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.movie_id = params[:movie_id]
    
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to movie_chapters_path(params[:movie_id]), notice: "Chapter was successfully created." }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: "Chapter was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1 or /chapters/1.json
  def destroy
    @chapter.destroy!

    respond_to do |format|
      format.html { redirect_to chapters_path, notice: "Chapter was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def chapter_params
      params.expect(chapter: [ :title, :description, :content, :position, :movie_id ])
    end
end
