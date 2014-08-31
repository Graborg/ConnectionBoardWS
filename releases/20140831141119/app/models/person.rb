class Person < ActiveRecord::Base
	belongs_to :account

	validates_presence_of :account_id
	validates_presence_of :show_profile
	validates_presence_of :image
end
