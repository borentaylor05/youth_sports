class Parent < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates(:firstName, presence: true, length: { maximum: 30 })
	validates(:lastName, presence: true, length: { maximum: 30 })
	validates(:phone, presence: true)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, presence: true, uniqueness: { case_sensitive: false }, 
				format: { with: VALID_EMAIL_REGEX })
	validates(:password, length: { minimum: 6 })
	has_many :children
	has_secure_password
end
