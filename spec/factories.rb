FactoryBot.define do
  factory :user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "alibaba" }
  end
end

FactoryBot.define do
  factory :booking, class: Booking do
    user { create(:user) }
  end
end

FactoryBot.define do
  factory :room, class: Room do
    name { Faker::Company.name }
    price { Faker::Commerce.price }
    image { Faker::LoremFlickr.image + "?random=" + rand(1000).to_s }
    status { :available }
  end
end

