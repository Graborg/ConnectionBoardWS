#require 'bcrypt'
class Account < ActiveRecord::Base
	#before_create { generate_token(:auth_token) }
	has_secure_password
	has_many :project, dependent: :destroy
	has_one :person, dependent: :destroy
	has_one :api_token, dependent: :destroy

	validates_uniqueness_of :username
	validates_presence_of :username, :on => :create
	validates_presence_of :password, :on => :create
	validates_format_of :username,
	:with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i


	def send_password_reset
		generate_reset_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		Mailer.password_reset(self).deliver
	end

	def generate_reset_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while Account.exists?(column => self[column])
	end
end
