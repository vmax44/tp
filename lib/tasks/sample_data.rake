namespace :db do
  require 'bcrypt'
  desc "Fill models with sample data"
  task populate: :environment do
    polis_number=34823848
    User.create!(login: "vmax444",
                 email: "vmax44@tut.byt",
                 password: "11111111",
                 admin: true)
    20.times do |n|
      firstname  = Faker::Name.first_name
      lastname = Faker::Name.last_name
      login = "#{lastname}#{n}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "11111111"
      ikp = "4400#{n+1}-14"
      user=User.create!(firstname: firstname,
                   lastname: lastname,
                   login: login,
                   email: email,
                   password: password,
                   ikp: ikp
      )

      strah1=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address
      )
      strah2=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address
      )
      zastrah1=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address
      )
      zastrah2=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address
      )
      
      user.polis.create!(
        strahovatel_id: strah1.id
      )
      
    end
  end
end
