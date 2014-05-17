class ParentComment < ActiveRecord::Base
	validates :parent_id, presence: true
	validates :body, presence: true, length: { maximum: 300 }
	belongs_to :parent

	#### ORDER IN MODEL
	default_scope -> { order('created_at DESC') }
end
