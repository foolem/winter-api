namespace :dev do
  desc "Inserts fake data on db"
  task fake_data: :environment do

    puts "Inserting new users"
    10.times do
      User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: 123123123,
        password_confirmation: 123123123,
        birthday: Faker::Date.birthday,
        sex: [0,1,2].sample,
        sex_preference: [0,1,2].sample,
        about: Faker::Hobbit.quote
      )
    end

    puts "Inserting new areas"
    ["Cinema", "Arte", "Esportes", "Hobbies", "Séries", "Signos"].each do |a|
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


  end

end
