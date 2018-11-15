class User < ApplicationRecord
	validates_uniqueness_of :username
	validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@#{DOMAIN}\.com\z/,
                  message: "must be a #{DOMAIN}.com account" }
	has_secure_password 
	has_secure_token :auth_token
	has_many :groups
	has_many :contacts, through: :groups


	def invalidate_token
		self.update_columns(auth_token: nil)
	end

	def self.validate_login(username, password)
		user = User.find_by(username: username)
		if user && user.authenticate(password)
			user
		end
	end
end
