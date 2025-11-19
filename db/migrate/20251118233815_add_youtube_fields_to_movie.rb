class AddYoutubeFieldsToMovie < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :youtube_thumbnail, :text
    add_column :movies, :youtube_title, :string
    add_column :movies, :video_id, :string
  end
end
