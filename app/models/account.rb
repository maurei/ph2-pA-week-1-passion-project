class Account < ActiveRecord::Base
	belongs_to :user
	has_many :manipulations
	
	def withdraw(amount)
		self.balance -= amount
		save
	end

	def deposit(amount)
		self.balance += amount
		save
	end

	def manipulate(transaction)
		p transaction
		method(transaction[:action].to_sym).call(transaction[:amount].to_f)
		p "****************************************"
		make_record_of transaction
	end

	def make_record_of(transaction)
		transaction.merge!(account_id: self.id)
		Manipulation.create(transaction)
	end

end


# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")

