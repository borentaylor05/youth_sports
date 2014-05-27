class ChildComment < ActiveRecord::Base
	belongs_to :child
	validates :child_id, presence: true
	validates :body, presence: true, length: { maximum: 300 }
	belongs_to :parent
	belongs_to :team
	#### ORDER IN MODEL
	default_scope -> { order('created_at DESC') }
end
