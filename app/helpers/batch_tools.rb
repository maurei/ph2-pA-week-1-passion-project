module BatchTools

	def save_or_get_errors(post_manipulations)

		post_manipulations.reject! do |post_manipulation|
			manipulation = construct_object(post_manipulation)
			if manipulation.save
				reject = true
			else
				post_manipulation.merge!(error_messages: manipulation.errors.messages)
				reject = false
			end
		reject
		end

		close_batch_if_empty(post_manipulations)
		return post_manipulations
	end

	def construct_object(post_manipulation)
		pre_manipulation = reformat_post_data(post_manipulation)
		add_to_batch(pre_manipulation)
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

	def add_to_batch(pre_manipulation)
		p session[:batch_id]
		pre_manipulation.merge!(batch_id: session[:batch_id])
	end	

	def close_batch_if_empty(post_manipulations)
	 session.delete(:batch_id) if post_manipulations.empty?
	end

end

helpers BatchTools