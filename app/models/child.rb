class Child < ActiveRecord::Base
	belongs_to :parent, foreign_key: "parent_id"
	validates(:firstName, presence: true, length: { maximum: 30 })
	validates(:lastName, presence: true, length: { maximum: 30 })
	validates(:birthday, presence: true)
	has_and_belongs_to_many :sports

	# http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
	def age_now
	  now = Time.now.utc.to_date
	  now.year - self.birthday.year - ((now.month > dob.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
	end

	def age_on(date)
		now = date.to_time.utc.to_date
	  	now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
	end

	def eligible?(sport)
		self.age_on(sport.season_start) <= sport.max_age and self.age_on(sport.season_start) >= sport.min_age
		# need to verify sex
	end

	# sees if the child is registered for a sport
	# cur = value to check against
	def registered?(sport)
		self.sports.include? sport
	end

	def status(sport)
		if Date.today >= sport.season_start and Date.today <= sport.season_end
			"playing"
		else
			"registered for"
		end
	end

end
