class Team < ActiveRecord::Base
	default_scope { order('min_age DESC') } 
	validates :name, presence: true, length: { maximum: 60 }
	validates :min_age, presence: true, numericality: {only_integer: true}
	validates :max_age, presence: true, numericality: {only_integer: true}
	validates :sport_id, numericality: {only_integer: true}
	belongs_to :sport
	belongs_to :parent
	has_and_belongs_to_many :children
	has_many :parent_comments
	has_many :child_comments
end
