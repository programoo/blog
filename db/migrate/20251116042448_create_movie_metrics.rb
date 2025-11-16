class CreateMovieMetrics < ActiveRecord::Migration[8.0]
  def change
    create_table :movie_metrics do |t|
      t.integer :movie_id
      t.integer :views_count
      t.integer :likes_count
      t.integer :comments_count
      t.integer :shares_count

      t.timestamps
    end
  end
end
