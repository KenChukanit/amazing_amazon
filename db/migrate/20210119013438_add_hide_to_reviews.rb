class AddHideToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column  :reviews, :hide, :boolean, default: false
  end
end
