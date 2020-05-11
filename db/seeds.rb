# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(email: "lemui@gmail.com", password: "password")

99.times do |n|
  email = "remitano#{n+1}example@remitano.com"
  password = "password"
  User.create!(email: email, password: password)
end

users = User.order(:created_at).take(6)

url_example = [
  'https://www.youtube.com/watch?v=OFndFA1ipiw',
  'https://www.youtube.com/watch?v=S2mEBYDDKaI',
  'https://www.youtube.com/watch?v=FkOOTqA5jA4',
  'https://www.youtube.com/watch?v=8zMCzHYOk4U',
  'https://www.youtube.com/watch?v=6JcBCoezCGk',
]
50.times do |n|
  users.each { |user| user.movies.create!(url: url_example.sample, title: "title_#{n}", description: "description-#{n} " * 100) }
end