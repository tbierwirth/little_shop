class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :body
      t.references :item, foreign_key: true
    end
  end
end
