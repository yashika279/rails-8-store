class AddColumnsToProducts < ActiveRecord::Migration[8.1]
  def change
    rename_column :products, :name, :title

    add_reference :products, :category, foreign_key: true

    add_column :products, :sku, :string
    add_column :products, :brand, :string
    add_column :products, :price, :decimal, precision: 10, scale: 2
    add_column :products, :discount_percentage, :decimal, precision: 5, scale: 2
    add_column :products, :weight, :decimal
    add_column :products, :thumbnail, :string
    add_column :products, :availability_status, :string
  end
end