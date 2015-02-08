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
	
	def manipulate(manipulation)
		method(manipulation[:action].to_sym).call(manipulation[:amount])
		make_record_of manipulation
	end

	def make_record_of(manipulation)
		manipulation.merge!(account_id: self.id)
		Manipulation.create(manipulation)
	end

end


# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")


# class Test
# def show(x)
# 	print x + "YAAAAAAAY"
# end

# def top(x)
#  self.method(:show).call(x)
# end
# end



# {
# 	amount: 		19,23,
# 	issue_date: "2015/01/01",
# 	description: "Allemachtig wat prachtig"
# }


#     	t.float		:amount
#       t.date		:issue_date	#refers to date of event, not moment of manipulation      
#       t.string 	:action  #withdrawal or deposit
#       t.string  :description
      
# 			t.integer :account_id

# User.first.accounts[0].withdraw(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig")
# User.first.accounts[0].record_manipulation({})

# User.first.accounts[0].deposit(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")
