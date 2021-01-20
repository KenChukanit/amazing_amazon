require 'rails_helper'
# rails g rspec:model JobPost

RANDOM_HUNDRED_CHARS="hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello worldhello world"

RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    describe "title" do

    it "requires a title" do
      #given
      news_article= FactoryBot.build(:news_article, title:nil, published_at: DateTime.now.in_time_zone("Asia/Kolkata"),  
      created_at: DateTime.now.in_time_zone("Asia/Kolkata"))
      #when 
      news_article.valid?

      #then
      expect(news_article.errors.messages).to(have_key(:title))
      end
    end
    
  describe "title" do
    it 'title is unique' do
      persisted_news_article= FactoryBot.create(:news_article)
      news_article= FactoryBot.build(:news_article, title: persisted_news_article.title, published_at: DateTime.now.in_time_zone("Asia/Kolkata"),  
      created_at: DateTime.now.in_time_zone("Asia/Kolkata"))
      news_article.valid?

      expect(news_article.errors.messages).to(have_key(:title))
    end
  end
  describe 'description' do  
    it 'requires a description' do
      news_article = FactoryBot.build(:news_article, description: nil, published_at: DateTime.now.in_time_zone("Asia/Kolkata"),
        created_at: DateTime.now.in_time_zone("Asia/Kolkata"))
      news_article.valid?
      expect(news_article.errors.messages).to(have_key(:description))
    end
  end
  describe 'published_at' do
    it 'published_at must be greater than created_at' do 
      news_article = FactoryBot.build(:news_article,  published_at: DateTime.now.in_time_zone("Asia/Kolkata"),  created_at: DateTime.now.in_time_zone("Asia/Kolkata"))
      news_article.valid?
      expect(news_article.errors.add :published_at, "must be after created_date")
    end
  end


  end

end