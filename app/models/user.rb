require 'bcrypt'

class User < ActiveRecord::Base


  has_many :accounts  #multiple type of accounts available in future, e.g. prom, holiday and general account


include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end

