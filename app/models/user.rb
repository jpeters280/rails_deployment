class User < ActiveRecord::Base
	has_many :secrets
  	has_many :likes, dependent: :destroy
  	has_many :secrets_liked, through: :likes, source: :secret
  	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  	validates :name, :presence => true
  	validates :email, :presence => true, :uniqueness => { case_sensitive: false }, :format => { :with => email_regex }
  	has_secure_password
  	validates :password_confirmation, :presence => true, on: [:create]
  	validates :password, confirmation: true
end
