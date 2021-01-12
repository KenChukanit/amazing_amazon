class User < ApplicationRecord

    scope(:search, -> (query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")})
    scope(:created_after, -> (date) { where("created_at < ?", "#{date}")})

end