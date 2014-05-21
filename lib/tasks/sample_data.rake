
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
			day = r.rand(1..28)
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
		r = Random.new
		20.times do
			body = Faker::Lorem.sentence(5)
			parents.each { |parent| parent.parent_comments.create!(body: body, team_id: r.rand(1..20)) }
		end

		### Sports
		makeSports
		register

		### Teams
		makeTeams
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
	Sport.create!(
		name: "Soccer",
		season_start: Date.new(2014, 4, 14),
		season_end: Date.new(2014, 6, 14),
		open_to: "both",
		coed: true,
		min_age: 5,
		max_age: 14
	)
	Sport.create!(
		name: "Baseball",
		season_start: Date.new(2014, 6, 20),
		season_end: Date.new(2014, 8, 20),
		open_to: "boys",
		coed: true,
		min_age: 8,
		max_age: 14
	)
	Sport.create!(
		name: "Basketball",
		season_start: Date.new(2014, 12, 1),
		season_end: Date.new(2015, 3, 24),
		open_to: "boys",
		coed: true,
		min_age: 8,
		max_age: 14
	)
end

def makeTeams
	r = Random.new
	images = ['http://media-cache-ec0.pinimg.com/236x/2b/99/0f/2b990fbb44840a41a8d0d75076cb5c2b.jpg', 'http://cdn.shopify.com/s/files/1/0065/0022/products/Police-KCCO_DESIGN_1024x1024.jpg?v=1373049609', 'http://media-cache-ec0.pinimg.com/236x/72/c1/df/72c1df391fb52f728f1b646379927511.jpg']
	20.times do |i|
		min = r.rand(5..11)
		Team.create(
			name: Faker::Lorem.word.capitalize,
			sport_id: r.rand(1..4),
			min_age: min,
			max_age: min + 2,
			image_url: images[r.rand(0..2)]
		)
	end
end

def register
	r = Random.new
	98.times do |i|
		child = Child.find(i+1)
		sport = Sport.find(r.rand(1..4))
		child.sports << sport
	end
end