class User < ApplicationRecord
	attr_accessor :remember_token
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false} 
	validates :password, length: {minimum: 6}, presence: true
	has_secure_password
	has_many :posts

	before_save :downcase_email
	before_create :create_remember_token

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	private

		def create_remember_token
			self.remember_token = User.new_token
			self.remember_digest = User.digest(remember_token)
		end

		def downcase_email
			self.email.downcase!
		end

end
