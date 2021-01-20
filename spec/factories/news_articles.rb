RANDOM_HUNDRED_CHARS="hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello worldhello world"

FactoryBot.define do
  factory :news_article do
    sequence(:title){ |n| Faker::Job.title + "#{n}"}
    description{ Faker::Job.field + "#{RANDOM_HUNDRED_CHARS}"}
    published_at{Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)}
    view_count{rand(0..100)}
    
  end
  

end
