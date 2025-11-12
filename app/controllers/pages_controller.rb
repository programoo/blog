class PagesController < ApplicationController
  def home
    @movies = Movie.all
    @comments = Comment.order(created_at: :desc).first(6)
  end
end
