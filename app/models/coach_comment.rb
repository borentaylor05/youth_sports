class CoachComment < ActiveRecord::Base
	validates :coach_id, presence: true
	validates :body, presence: true
	belongs_to :coach
end
