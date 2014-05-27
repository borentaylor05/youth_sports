class Message < ActiveRecord::Base
	belongs_to :sender, polymorphic: true
	validates :sender_id, presence: true
	validates :sender_type, presence: true
	default_scope -> { order("created_at DESC") }
end
