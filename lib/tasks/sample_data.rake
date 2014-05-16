
namespace :db do
	desc "Fille database with sample data"
	task populate: :environment do
		Parent.create!(
			firstName: "Taylor",
			lastName: "Boren",
			email: "example@railstutorial.org",
			phone: 8062759559,
			password: "password",
			password_confirmation: "password",
			admin: true	
		)
		99.times do |i|
			name = Faker::Name.name
			name = name.split(" ")
			firstName = name[0]
			lastName = name[1]
			password = "password"
			email = "example-#{i+1}@example.com"
			phone = Faker::Number.number(10)
			Parent.create!(
				firstName: firstName,
				lastName: lastName,
				email: email,
				phone: phone,
				password: password,
				password_confirmation: password
			)
		end
	end
end