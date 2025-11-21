class CreateReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :replies do |t|
      t.integer :comment_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
