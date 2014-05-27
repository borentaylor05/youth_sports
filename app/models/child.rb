class Child < ActiveRecord::Base
	belongs_to :parent, foreign_key: "parent_id"
	validates(:firstName, presence: true, length: { maximum: 30 })
	validates(:lastName, presence: true, length: { maximum: 30 })
	validates(:birthday, presence: true)
	validates(:username, presence: true, length: { maximum: 30  }, on: [:update])
	validates(:password, presence: true, length: { minimum: 6 }, on: [:update])
	validates_associated :teams
	has_and_belongs_to_many :sports
	has_and_belongs_to_many :teams
	has_many :child_comments
	has_many :messages, as: :sender
	validates(:password, length: { minimum: 6 })
	has_secure_password

	# http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
	def age_now
	  now = Time.now.utc.to_date
	  now.year - self.birthday.year - ((now.month > dob.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
	end

	def age_on(date)
		now = date.to_time.utc.to_date
	  	now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
	end

	def eligible?(sport, team)
		if team.nil?
			self.age_on(sport.season_start) <= sport.max_age and self.age_on(sport.season_start) >= sport.min_age
		else
			self.age_on(sport.season_start) <= team.max_age and self.age_on(sport.season_start) >= team.min_age
		end
		# need to verify gender
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

	def assigned?(sport)
		Rails.logger()
		!self.teams.find_by(sport_id: sport.id).nil?
	end

	def assigned_and_current?(sport)
		self.assigned?(sport) and Date.today >= 2.months.ago(sport.season_start) and Date.today <= sport.season_end
	end

	def current_team
		sports = Sport.all
		sports.each do |sport|
			if assigned_and_current?(sport)
				return self.teams.find_by(sport_id: sport.id)
			end
		end
	end

	def current_team_for(sport)
		if assigned_and_current?(sport)
			return self.teams.find_by(sport_id: sport.id)
		end
	end

	def has_no_account?
		self.username.nil?
	end

	def Child.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Child.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = Child.digest(Child.new_remember_token)
		end

end
