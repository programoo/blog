class CreateUserLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :user_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end

    # Ensure a user can like a movie only once
    add_index :user_likes, [:user_id, :movie_id], unique: true
  end
end
