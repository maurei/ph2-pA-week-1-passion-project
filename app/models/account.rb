class Account < ActiveRecord::Base
	belongs_to :user
	has_many :manipulations #, dependent: :destroy ...see active record callbacks
	
 	scope :by_user_id,  ->(user_id){ find_by(user_id: user_id) }
  #Account.by_user_id(params[:user_id])

	def withdraw(amount)
		self.balance -= amount
		save
	end

	def deposit(amount)
		self.balance += amount
		save
	end							


end


  # scope :by_access_level, ->(level){ where(access_level: level) }
  # User.by_access_level("member")  @TODO

# this format works for making a manipulate:
# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")
# ajax response will be with handle, not username. Look username up by handle and manipulate corresponding account