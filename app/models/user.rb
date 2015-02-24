class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :password, on: create
	validates_presence_of :username, on: create
end
