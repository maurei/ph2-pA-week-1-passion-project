require 'bcrypt'

class User < ActiveRecord::Base
  has_many :accounts  #multiple type of accounts available in future, e.g. prom, holiday and general account

  validates :handle, presence: true, uniqueness: true
  validates :password_hash, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\w+@\w+.[a-zA-Z]{2,}/}
  validates :year, presence: true, numericality: { only_integer: true }
  validates :access_level, presence: true

include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password) unless new_password == nil
    self.password_hash = @password
  end

end
