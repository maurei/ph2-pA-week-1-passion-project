module AdminTools

	def add(member)
		member.merge!(access_level: "member", password: nil) {|key, oldval, newval| oldval unless oldval == ""  } # to prevent empty string passwords. turning them into nil. cleaner way is to delete key/value pairs from members where value = "", but dont want to spend time on that.
		new_user = User.new(member)
		if new_user.valid?
			new_user.save
			new_user.accounts << Account.create(balance: 0.0, account_type: "PD")
		else
			session[:errors] = new_user.errors.messages
			redirect back
		end
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