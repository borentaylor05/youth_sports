class Coach < ActiveRecord::Base
	has_and_belongs_to_many :teams
	has_many :coach_comments
end
