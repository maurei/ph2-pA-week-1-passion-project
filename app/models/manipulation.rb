class Manipulation < ActiveRecord::Base
	belongs_to :account

	def undo 
		account.method(inverse self.action).call(self.amount)
		account.save
		self.destroy
	end

	def inverse(operation)

		return :withdraw if operation == "deposit"
		return :deposit  if operation == "withdraw"

	end

end