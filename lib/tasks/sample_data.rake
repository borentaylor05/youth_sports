
namespace :db do
	desc "Fille database with sample data"
	task populate: :environment do

		### PARENTS
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

		### CHILDREN
		Child.create!(
			firstName: "Mason",
			lastName: "Boren",
			birthday: Date.new(2013, 11, 20),
			physicalComplete: false,
			parent_id: 1	
		)
		99.times do |i|
			name = Faker::Name.name
			name = name.split(" ")
			firstName = name[0]
			lastName = name[1]
			r = Random.new
			year = r.rand(1995..2013)
			month = r.rand(1..12)
			day = r.rand(1..30)
			birthday = Date.new(year, month, day)
			physicalComplete = r.rand(0..1)
			parent_id = r.rand(1..Parent.count)
			Child.create!(
				firstName: firstName,
				lastName: lastName,
				birthday: birthday,
				physicalComplete: physicalComplete,
				parent_id: parent_id
			)
		end

		### COMMENTS
		parents = Parent.limit(6)
		20.times do
			body = Faker::Lorem.sentence(5)
			parents.each { |parent| parent.parent_comments.create!(body: body) }
		end

		### Sports
		makeSports
	end
end

def makeSports
	Sport.create!(
		name: "Football",
		season_start: Date.new(2014, 8, 31),
		season_end: Date.new(2014, 11, 24),
		open_to: "boys",
		coed: false,
		min_age: 8,
		max_age: 14
	)
end