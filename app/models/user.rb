require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :accounts  #multiple type of accounts available in future, e.g. prom, holiday and general account


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end

