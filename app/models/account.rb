#require 'bcrypt'
class Account < ActiveRecord::Base
	has_secure_password
	has_many :project, dependent: :destroy
	has_one :person, dependent: :destroy
	has_one :api_token, dependent: :destroy

	validates_uniqueness_of :username
	validates_presence_of :username
	validates_presence_of :password
	validates_format_of :username,
	:with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
end
