class UpdateUserColumnEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique:true
  end
change_column :users, :email, :string, index: {unique:true}
end
