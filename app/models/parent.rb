class Parent < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates(:firstName, presence: true, length: { maximum: 30 })
	validates(:lastName, presence: true, length: { maximum: 30 })
	validates(:phone, presence: true)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, presence: true, uniqueness: { case_sensitive: false }, 
				format: { with: VALID_EMAIL_REGEX })
	validates(:password, length: { minimum: 6 })
	has_many :children
	has_secure_password

	def Parent.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Parent.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = Parent.digest(Parent.new_remember_token)
		end

end
