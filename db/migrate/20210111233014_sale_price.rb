class SalePrice < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :sale_price, :float
  end
end