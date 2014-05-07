class Child < ActiveRecord::Base
	belongs_to :parent, foreign_key: "parent_id", dependent: :destroy
	has_and_belongs_to_many :teams
end
