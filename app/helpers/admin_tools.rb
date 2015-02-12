# module AccessLevels
# 	extend self
# 	def member
# 		"member"
# 	end

# end

module AdminTools

	module MemberManagement

		def add_member(member)
			default = {access_level: "member", password: nil}

			member.merge!(default) {|key, oldval, newval| oldval unless oldval.empty?  } # to prevent empty string passwords. turning them into nil. cleaner way is to delete key/value pairs from members where value = "", but dont want to spend time on that.
			new_user = User.new(member)
			if new_user.valid?
				new_user.save
				new_user.accounts << Account.create(balance: 0.0, account_type: "PD")  # @TODO see before_save
			else
				session[:errors] = new_user.errors.messages
				redirect back
			end
		end

		def update_member(member)
			user = User.find member.delete(:id)
			user.update_attributes(member)
		end

		def delete_member(member)
			user = User.find(member)
			user.accounts.each do |acc|
				acc.manipulations.each(&:destroy)  # @TODO see dependent: :destroy
				acc.destroy
			end
			user.destroy
		end
	end

	module ManipulationManagement

		def update_manipulation(manipulation)
			manipulation = Manipulation.find manipulation.delete(:id)
			manipulation.delete(:action) # to make sure that no one can change an withdrawal into deposit
			manipulation.update(manipulation)
		end

		def hashify(manipulation_post_data)
			Hash[manipulation_post_data.map{ |k,v| [k.to_sym,v] } ] # 
		end

	end
	

end

helpers AdminTools::MemberManagement, AdminTools::ManipulationManagement