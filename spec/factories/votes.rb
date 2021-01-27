FactoryBot.define do
  factory :vote do
    result { false }
    user { nil }
    review { nil }
  end
end
