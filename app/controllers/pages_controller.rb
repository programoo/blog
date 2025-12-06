class PagesController < ApplicationController
  layout "welcome"
  
  def home
    @movies = Movie.first(3)
    @comments = Comment.order(created_at: :desc).first(6)
  end
end
