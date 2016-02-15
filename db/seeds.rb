# creates users
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: "helloworld"
  )
end
users = User.all

# creates wikis
20.times do
  Wiki.create!(
    title: Faker::Hipster.sentence(3),
    body: Faker::Hipster.paragraph(4, true, 2),
    private: false,
    user_id: rand(User.count)
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
