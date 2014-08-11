#require 'bcrypt'
class Account < ActiveRecord::Base
	has_secure_password
	has_many :projects, dependent: :destroy
	has_one :person, dependent: :destroy
	has_one :api_token, dependent: :destroy

end
