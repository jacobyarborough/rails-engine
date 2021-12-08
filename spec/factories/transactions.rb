FactoryBot.define do
  factory :item do
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { nil }
    invoice_id { nil }
  end
end