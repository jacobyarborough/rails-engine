FactoryBot.define do
  factory :item do
    name { Faker::Hipster.sentence(word_count: 2) }
    description { Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 4) }
    unit_price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    merchant_id { nil }
  end
end

