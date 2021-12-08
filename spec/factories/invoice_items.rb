FactoryBot.define do
  factory :invoice_item do
    invoice_id { nil }
    quantity { Faker::Number.within(range: 1..10) }
    unit_price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    item_id { nil }
  end
end