class ChildrenTeams < ActiveRecord::Base
	belongs_to :team
	belongs_to :child
	validates_uniqueness_of :child_id, scope: :team_id
end
