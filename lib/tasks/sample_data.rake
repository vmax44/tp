namespace :db do
  require 'bcrypt'
  desc "Fill models with sample data"
  task populate: :environment do
    policy_number=34823848
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
        address: Faker::Address.city
      )
      strah2=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address.city
      )
      zastrah1=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address.city
      )
      zastrah2=Strahovatel.create!(
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        address: Faker::Address.city
      )
      
      user.contracts.create!(
        strahovatel_id: strah1.id,
        zastrahovanniy_id: zastrah1.id,
        number: policy_number,
        date: Time.now,
        datestart: Time.now + 5.days,
        datefinish: Time.now + 4.days + 1.years ,
        cost: 190
      )
      policy_number=policy_number+1
      user.contracts.create!(
        strahovatel_id: strah2.id,
        zastrahovanniy_id: zastrah2.id,
        number: policy_number,
        date: Time.now,
        datestart: Time.now + 5.days,
        datefinish: Time.now + 4.days + 1.years ,
        cost: 190
      )
      policy_number=policy_number+1
      
    end
  end
end
