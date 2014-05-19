class Team < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 60 }
	validates :min_age, presence: true, numericality: {only_integer: true}
	validates :max_age, presence: true, numericality: {only_integer: true}
	validates :sport_id, numericality: {only_integer: true}
	belongs_to :sport
	has_and_belongs_to_many :coaches
	has_and_belongs_to_many :children
end
