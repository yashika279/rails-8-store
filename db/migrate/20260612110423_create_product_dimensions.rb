class CreateProductDimensions < ActiveRecord::Migration[8.1]
  def change
    create_table :product_dimensions do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :width
      t.decimal :height
      t.decimal :depth

      t.timestamps
    end
  end
end
