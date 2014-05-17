class Child < ActiveRecord::Base
	belongs_to :parent, foreign_key: "parent_id"
	validates(:firstName, presence: true, length: { maximum: 30 })
	validates(:lastName, presence: true, length: { maximum: 30 })
	validates(:birthday, presence: true)
#	has_and_belongs_to_many :teams
end
