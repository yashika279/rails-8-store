class AddShippingAddressToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :shipping_name, :string
    add_column :orders, :shipping_phone, :string
    add_column :orders, :shipping_address_line_1, :string
    add_column :orders, :shipping_address_line_2, :string
    add_column :orders, :shipping_city, :string
    add_column :orders, :shipping_state, :string
    add_column :orders, :shipping_postal_code, :string
  end
end
