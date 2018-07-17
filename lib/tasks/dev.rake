namespace :dev do
  desc "Inserts fake data on db"
  task fake_data: :environment do

    puts "Inserting new locations"

    Location.create(city: "Curitiba", state: "PR", country: "Brazil")
    Location.create(city: "São Paulo", state: "SP", country: "Brazil")

    puts "Inserting new areas"
    ["Cinema", "Arte", "Esportes", "Hobbies", "Séries"].each do |a|
      Area.create(
        name: a
      )
    end

    SubArea.create(name: "Artista", area: Area.find(2))
    SubArea.create(name: "Pintores", area: Area.find(2), sub_area: SubArea.first)
    Preference.create(content: "Van Gogh", sub_area: SubArea.last)
    Preference.create(content: "Picasso", sub_area: SubArea.last)
    SubArea.create(name: "Diretores", area: Area.find(1))
    Preference.create(content: "Quentin Tarantino", sub_area: SubArea.last)
    Preference.create(content: "Peter Jackson", sub_area: SubArea.last)

    puts "Inserting new users"
    100.times do
      u = User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: 123123123,
        password_confirmation: 123123123,
        birthday: Faker::Date.birthday,
        sex: [0,1,2].sample,
        sex_preference: [0,1,2].sample,
        about: Faker::Hobbit.quote,
        location_id: [1,2].sample
      )
      [0,1,2,3].sample.times do
        preference = [1,2,3,4].sample
        u.preferences << Preference.find(preference)
      end
    end

    u = User.create(
      name: 'Filipe',
      email: 'foolemdev@gmail.com',
      password: 123123123,
      password_confirmation: 123123123,
      birthday: Faker::Date.birthday,
      sex: 0,
      sex_preference: 2,
      about: Faker::Hobbit.quote,
      location_id: 1
    )

    u.preferences << Preference.all

  end

end
