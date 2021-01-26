class User < ApplicationRecord

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, uniqueness: true

    has_secure_password

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :nullify
    has_many :likes
    has_many :liked_review, through: :likes, source: :review
    # [Exercise] Find a user by name or email
    scope(:search, -> (query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")})
    # [Exercise] After
    scope(:created_after, -> (date) { where("created_at < ?", "#{date}")})

    def full_name
        "#{first_name.capitalize} #{last_name.capitalize}"
    end
end

# [Exercise] Not John...
# User.where("first_name  NOT LIKE ? OR last_name NOT LIKE ?", 'John', "john")
