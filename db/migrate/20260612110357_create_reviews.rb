class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :product, null: false, foreign_key: true
      t.string :reviewer_name
      t.string :reviewer_email
      t.integer :rating
      t.text :comment
      t.datetime :reviewed_at

      t.timestamps
    end
  end
end
