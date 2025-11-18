class AddFieldsToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :source_image, :text
    add_column :movies, :source_url, :string
    add_column :movies, :release_date, :string
    add_column :movies, :duration, :string
    add_column :movies, :category, :string
    add_column :movies, :pending_review, :boolean, default: false, null: false
  end
end
