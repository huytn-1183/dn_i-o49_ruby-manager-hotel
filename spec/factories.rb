FactoryBot.define do
  factory :room, class: Room do
    name { Faker::Company.name }
    price { Faker::Commerce.price }
    image { Faker::LoremFlickr.image + "?random=" + rand(1000).to_s }
    status { :available }
  end
end

