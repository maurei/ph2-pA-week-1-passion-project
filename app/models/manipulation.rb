class Manipulation < ActiveRecord::Base
	belongs_to :account
	belongs_to :batch

	after_create :change_balance
	before_destroy :undo

	validates :amount, presence: true
  validates :issue_date, presence: true
  validates :action, presence: true
  validates :description, presence: true
  validates :account, presence: true

	def change_balance
		self.account.method(self.action).call(self.amount)
		self.account.save
	end

	def undo
		self.account.method(inverse self.action).call(self.amount)
		self.account.save
	end

	def inverse(operation)

		return :withdraw if operation == "deposit"
		return :deposit  if operation == "withdraw"

	end

end


