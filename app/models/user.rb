class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_likes, dependent: :destroy
  has_many :liked_movies, through: :user_likes, source: :movie
  has_one_attached :avatar
  has_many :ratings, dependent: :destroy

  def get_display_name
    temp_display_name = "#{first_name} #{last_name}"
    if temp_display_name.blank?
      return email
    else
      return temp_display_name
    end
  end
end
