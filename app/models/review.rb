class Review < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :product
    
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
    
    has_many :votes, dependent: :destroy 
    has_many :voters, through: :votes, source: :user

    def vote_total 
        votes.up.count - votes.down.count 
    end 
    
    validates :rating, presence: {message: "must give rating"},numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
