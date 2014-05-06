class Team < ActiveRecord::Base
	belongs_to :sport
	has_and_belongs_to_many :coaches
	has_and_belongs_to_many :children
end
