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
				new_user.create_account(balance: 0.0)  # @TODO see before_save
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

		def construct_object(post_manipulation)
			pre_manipulation = reformat_post_data(post_manipulation)
			manipulation = Manipulation.new(pre_manipulation)
		end

		def reformat_post_data(post_manipulation)
			pre_object = hashify(post_manipulation)
			account_id = Account.by_user_id(pre_object.delete(:user_id)).id
			pre_object.merge!(account_id: account_id)
			pre_object.delete(:row_id)
			pre_object.delete(:error_messages)
			pre_object
		end

	end

	module BillConverter

		def read_csv(source)
			bill_row = []
			CSV.foreach(source) do |row|
			 bill_row << row
			end
			bill_row
		end

		def reformat_csv_row(row)
			fields = [:user_id, :issue_date, :description, :amount, :action]
			row = Hash[fields.zip(row)]
			replace_handle_by_id(row)
		end

		def replace_handle_by_id(row)
			user_id = User.find_by(handle: row[:user_id]).id
			row[:user_id] = user_id
			row
		end

	end
	

end

helpers AdminTools::MemberManagement, AdminTools::ManipulationManagement, AdminTools::BillConverter


