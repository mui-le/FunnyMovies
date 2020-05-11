class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.text :url
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :movies, [:user_id, :created_at]
  end
end
