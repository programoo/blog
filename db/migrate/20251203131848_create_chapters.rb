class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.string :description
      t.text :content
      t.integer :position
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
