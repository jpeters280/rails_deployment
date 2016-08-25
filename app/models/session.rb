class Session < ActiveRecord::Base
  has_secure_password
  # attr_accessor :password_digest, :password_confirmation, :name, :email
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, :password, :presence => true
  validates :email, :uniqueness => { false }, :format => { :with => email_regex }
  validates :password_digest, confirmation: true
end
