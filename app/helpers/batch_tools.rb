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
		account_of_user = Account.by_user_id(pre_object.delete(:user_id))
		if account_of_user.class == Account
			account_id = account_of_user.id
		else
			account_id = nil
		end
		pre_object.merge!(account_id: account_id)
		pre_object.delete(:row_id)
		pre_object.delete(:error_messages)
		pre_object
	end

	def add_to_batch(pre_manipulation)
		session[:batch_id] = session[:batch_id] || Batch.create().id 
		pre_manipulation.merge!(batch_id: session[:batch_id])
	end

	def close_batch_if_empty(post_manipulations)
	 close_current_batch if post_manipulations.empty?
	end

	def close_current_batch
		session.delete(:batch_id)
	end

	def group_by_year_flattened(pluckdata)
		grouped_by_year = pluckdata.group_by { |user| user[1] }
		years = grouped_by_year.keys

		years.each do |year|
			grouped_by_year[year].map! { |x| x[0] }
			grouped_by_year[year] = grouped_by_year[year].flatten
		end
		grouped_by_year
	end



end



helpers BatchTools
