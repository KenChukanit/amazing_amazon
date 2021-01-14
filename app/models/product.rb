class Product < ApplicationRecord

    before_validation :set_default_price, :set_default_sale_price,:capitalize_title

    # [Exercise] Notifying admin
    before_destroy :log_delete_details

    # Exercise Reserved Name 
    # Excercise validates :title, presence: true, uniqueness: true in one line
    validates :title, 
    presence: true, 
    uniqueness: true,
    exclusion: {
        in: ['apple', 'microsoft', 'sony'],
        message: "%{value} is reserved. Please use a different title." 
        }
    
    # [Exercise] Validate
    validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000 }
    validates :description, presence: true, length: { minimum: 10 }
    validate :sale_price_less_than_price

    has_many :reviews, -> { order('updated_at DESC') }, dependent: :destroy

    # [Exercise] Product model custom methods
    scope(:search, -> (query) { where("title ILIKE? OR description ILIKE?", "%#{query}%") })

    # A constant is a value that should never change. We use these often to replace hard coded values. That way you can use this constant in multiple areas and if you ever need to change it you'd only need to change it at one place.
    DEFAULT_PRICE = 1 # a ruby convention is to place constants at the top of the file and name them using SCREAMING_SNAKE_CASE
    # rubocop has good guidelines on best practices https://github.com/rubocop-hq/ruby-style-guide
    
    def self.search_but_using_class_method(query)
        where("title ILIKE?", "%#{query}%")
    end

    # [Exercise] Increment hit count
    def increment_hit_count
        new_hit_count = self.hit_count += 1
        update({hit_count: new_hit_count})
    end

    private 

    def set_default_price
        self.price ||= DEFAULT_PRICE
    end

    def capitalize_title
        self.title.capitalize!
    end
    # [Exercise] Setting sale price
    def set_default_sale_price
        self.sale_price ||= self.price
    end
  # [Exercise] Setting sale price
    def sale_price_less_than_price
        if self.sale_price > self.price
            errors.add(:sale_price, " #{self.sale_price} must be lower than price: #{self.price}")
        end
    end

    # [Exercise] Notifying admin
    def log_delete_details
        puts "Product #{self.id} is about to be deleted"
    end

end