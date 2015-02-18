# module AccessLevels
# 	extend self
# 	def member
# 		"member"
# 	end

# end

module AdminTools

	module MemberManagement

		def add_member(member)
			default = {"access_level" => "member", "password" => nil}
			prevent_empty_string_password(member)
			new_user = User.new(member)

			if new_user.valid?
				new_user.save
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
			user.account.manipulations.each(&:destroy)
			user.account.destroy
			user.destroy

		end

		def prevent_empty_string_password(new_member)
			default = {"access_level" => "member", "password" => nil}
			new_member.merge!(default) {|field, old_value, new_value| old_value unless old_value == ""  }
		end

	end

	module ManipulationManagement

		def update_manipulation(manipulation)
			manipulation = Manipulation.find manipulation.delete(:id)
			manipulation.delete(:action) # to make sure that no one can change an withdrawal into deposit
			manipulation.update(manipulation)
		end

		def hashify(manipulation_post_data)
			Hash[manipulation_post_data.map{ |k,v| [k.to_sym,v] } ]
		end


	end

	
end

helpers AdminTools::MemberManagement, AdminTools::ManipulationManagement


