class AddPasswordDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string
  end
end


# def up
#   change_column :products, :price, :float
# end

# def down
#   change_column :products, :price, :integer
# end