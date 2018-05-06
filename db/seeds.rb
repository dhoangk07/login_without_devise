# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_list = [
  [ "dhoangk08@gmail.com", "1234567" ],
  [ "dhoangk08+1@gmail.com", "1234567" ],
  [ "dhoangk08+3@gmail.com", "1234567" ],
  [ "dhoangk08+2@gmail.com", "1234567" ],
  [ "dhoangk08+4@gmail.com", "1234567" ],
  [ "dhoangk08+5@gmail.com", "1234567" ],
  [ "dhoangk08+6@gmail.com", "1234567" ],
  [ "dhoangk08+7@gmail.com", "1234567" ],
  [ "dhoangk08+8@gmail.com", "1234567" ],
  [ "dhoangk08+9@gmail.com", "1234567" ],
  [ "dhoangk08+10@gmail.com", "1234567" ],
  [ "dhoangk08+11@gmail.com", "1234567" ],
  [ "dhoangk08+12@gmail.com", "1234567" ],
  [ "dhoangk08+13@gmail.com", "1234567" ],
  [ "dhoangk08+14@gmail.com", "1234567" ],
  [ "dhoangk08+15@gmail.com", "1234567" ],
  [ "dhoangk08+16@gmail.com", "1234567" ],
  [ "dhoangk08+17@gmail.com", "1234567" ],
  [ "dhoangk08+18@gmail.com", "1234567" ],
  [ "dhoangk08+19@gmail.com", "1234567" ],
  
]

user_list.each do |email, password|
  User.create( email: email, password: password )
end
