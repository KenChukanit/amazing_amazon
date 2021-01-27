class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, uniqueness: {
    scope: :review_id, 
    message: "has already been voted on"
  }

  validates :result, inclusion: {
    in: [true, false]
  }

  def self.up 
    where(result: true)
  end 

  def self.down 
    where(result: false)
  end 


end
