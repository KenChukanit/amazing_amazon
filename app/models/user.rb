class User < ApplicationRecord
    # [Exercise] Find a user by name or email
    scope(:search, -> (query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")})
    # [Exercise] After
    scope(:created_after, -> (date) { where("created_at < ?", "#{date}")})

end

# [Exercise] Not John...
# User.where("first_name  NOT LIKE ? OR last_name NOT LIKE ?", 'John', "john")
