module AdminTools

	def add(member)
		member.merge!(access_level: "member") {|key, oldval, newval| oldval }
		p member
		User.create(member).accounts << Account.create(balance: 0.0, account_type: "PD")
	end

	def update_member(member)
		user = User.find member.delete(:id)
		user.update_attributes(member)
	end

	def delete(member)
		user = User.find(member)
		user.accounts.each{ |acc|
			acc.manipulations.each(&:destroy)
			acc.destroy
			}
		user.destroy
	end

	def update_manipulation(manipulation)
		manipulation = Manipulation.find manipulation.delete(:id)
		manipulation.delete(:action) # to make sure that no one can change an withdrawal into deposit
		manipulation.update(manipulation)
	end

	

end

helpers AdminTools