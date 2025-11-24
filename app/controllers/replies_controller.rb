class RepliesController < ApplicationController
  before_action :set_reply, only: %i[ show edit update destroy ]

  # GET /replies or /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1 or /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies or /replies.json
  def create
    @reply = Reply.new(reply_params)
    @reply.comment_id = params[:comment_id]
    @reply.user_id = params[:user_id]
    respond_to do |format|
      if @reply.save
        @reply.comment.movie.movie_metric.increment!(:comments_count)
        create_notification_for(@reply.comment)

        format.turbo_stream
        format.html { redirect_to @reply, notice: "Reply was successfully created." }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1 or /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: "Reply was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1 or /replies/1.json
  def destroy
    @reply.destroy!

    respond_to do |format|
      format.html { redirect_to replies_path, notice: "Reply was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.expect(reply: [:content ])
    end

    def create_notification_for(comment)
      Notification.create!(
        user: comment.user,   # owner of the post receives notification
        notifiable: comment,
        message: "#{comment.user.first_name} commented on your post"
      )
    end
end
