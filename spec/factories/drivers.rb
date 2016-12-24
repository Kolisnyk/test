FactoryGirl.define do
  factory :driver do
    phone { '0' + Faker::Number.number(9) }
    password { Faker::Internet.password(8) }
    active true
  end
end
