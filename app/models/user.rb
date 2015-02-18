require 'bcrypt'
require_relative '../../lib/automailer.rb' # why doesnt requiring this in environment do the trick??

class User < ActiveRecord::Base
 include AutoMailer


  has_one :account #multiple type of accounts available in future, e.g. prom, holiday and general account

  validates :handle, presence: true, uniqueness: true
  validates :password_hash, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\w+@\w+.[a-zA-Z]{2,}/}
  validates :year, presence: true, numericality: { only_integer: true }
  validates :access_level, presence: true

  after_create :create_corresponding_account
  # scope :by_access_level, ->(level){ where(access_level: level) }
  # User.by_access_level("member")  @TODO

  include BCrypt


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password) unless new_password == nil
    self.password_hash = @password
  end

  def create_corresponding_account
    self.create_account(balance: 0.0)
  end


  # def send_email(subject, text)
  #     RestClient.post "https://api:key-bd73d72bf3ad7a809db3316b37fcfc53"\
  #     "@api.mailgun.net/v2/sandbox69718c6add8d47f0be16d79679aec711.mailgun.org/messages",
  #     :from => "Mailgun Sandbox <postmaster@sandbox69718c6add8d47f0be16d79679aec711.mailgun.org>",
  #     :to => self.email,
  #     :subject => subject,
  #     :text => text
  # end

end
