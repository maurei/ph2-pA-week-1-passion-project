class Account < ActiveRecord::Base
	belongs_to :user
	has_many :manipulations #, dependent: :destroy ...see active record callbacks
	
	def withdraw(amount)
		self.balance -= amount
		save
	end

	def deposit(amount)
		self.balance += amount
		save
	end

	def manipulate(transaction)
		method(transaction[:action].to_sym).call(transaction[:amount].to_f)  #key of gets turned into symbol to trigger either method withdraw or deposit, with as argument .call(argument)
		make_record_of transaction
	end

	def make_record_of(transaction)
		transaction.merge!(account_id: self.id) # id gets added to make association work
		Manipulation.create(transaction)
	end

end

# this format works for making a manipulate:
# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")

