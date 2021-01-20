class NewsArticle < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true

    validate :published_at_after_created_at?

    def published_at_after_created_at?  
      if published_at < created_at
        errors.add :published_at, "must be after created_date"
      end
    end
    # def published
    #     @news_article.update(published_at: Date.now)
    # end
end
