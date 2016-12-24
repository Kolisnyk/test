FactoryGirl.define do
  factory :order do
    baggage { Faker::Boolean.boolean }
    end_point { Faker::Address.street_address }
    comment { Faker::Lorem.paragraph }
    passengers { Faker::Number.between(1, 8) }
    phone { '0' + Faker::Number.number(9) }
    start_point { Faker::Address.street_address }
  end
end
