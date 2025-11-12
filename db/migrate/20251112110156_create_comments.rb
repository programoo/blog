class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :movie, null: false, foreign_key: true
      t.text :content
      t.string :user

      t.timestamps
    end
  end
end
