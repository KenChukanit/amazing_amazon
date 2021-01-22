
  
FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Movies::StarWars.character + " #{n}"}
    description { Faker::Hacker.say_something_smart }
    published_at {Time.zone.now }
    view_count {rand(0..100)}
    association(:user, factory: :user)
  end
end
