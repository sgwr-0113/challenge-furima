FactoryBot.define do
  factory :item do
    name { Faker::Lorem.sentence }
    price { 1000 }
    info { Faker::Lorem.sentence }
    scheduled_delivery_id { 1 }
    shipping_fee_status_id { 1 }
    prefecture_id { 1 }
    sales_status_id { 1 }
    category_id { 1 }
    association :user
  end
end
