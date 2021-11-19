# ROOM
20.times do |n|
  image = Faker::LoremFlickr.image + "?random=" + rand(1000).to_s
  price = Faker::Commerce.price
  level = rand(4)
  status = rand(2)
  description = Faker::Lorem.paragraphs(number: 2)
  name = Faker::Company.name
  Room.create!(
    image: image,
    price: price,
    level: level,
    status: status,
    description: description,
    name: name,
  )
end if Room.count < 20

# USER
User.create!(
    name: "Đàm Vĩnh Biệt",
    email: "dam@gmail.com",
    phone: "0332813079",
    password:              "12345678",
    password_confirmation: "12345678",
    role: 2
)
User.create!(
    name: "Nguyễn Huỳnh Thanh Đạt",
    email: "dat@gmail.com",
    phone: "0332813078",
    password:              "12345678",
    password_confirmation: "12345678",
    role: 1
)
User.create!(
    name: "Trần Ngọc Huy",
    email: "truongduchuy910@gmail.com",
    phone: "0332813077",
    password:              "truongduc910",
    password_confirmation: "truongduc910",
    role: 0
)

3.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.phone_number
  password = "password"
  User.create!(
    name: name,
    email: email,
    phone: phone,
    password:              password,
    password_confirmation: password
  )
end if User.count < 3



# ROOM ATTRIBUTE
10.times do |n|
  furniture = Faker::House.unique.furniture
  RoomAttribute.create(name: furniture)
end if RoomAttribute.count < 10

# ROOM ATTRIBUTE GROUP
rooms = Room.all
rooms.each do |room| 
  attributes = RoomAttribute.order(Arel.sql("RANDOM()")).first rand(5)
  attributes.each do |attribute|
    RoomAttributeGroup.create!(room_id:room.id, room_attribute_id:attribute.id)
  end
end

# BOOKING
20.times do |n|
  status = rand(4)
  user = User.order(Arel.sql("RANDOM()")).first
  booking = Booking.create!(
    status: status,
    user_id: user.id,
  )
  rand(5).times do 
    room = Room.order(Arel.sql("RANDOM()")).first
    date_in = rand(10.day).seconds.ago
    date_out = date_in + rand(8.hours)
    booking.booking_details.create!(
      room_id: room.id,
      date_in: date_in, 
      date_out: date_out,
    )
  end
end if Booking.count < 20
