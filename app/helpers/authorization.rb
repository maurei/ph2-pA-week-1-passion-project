module Authorization

	def authorize_or_redirect
		redirect '/login' unless session[:user_id]
		permissions = User.find(session[:user_id]).access_level
		if permissions == "superadmin"
		 	if user_id_from_params.is_a? Integer
				redirect "/users/#{session[:user_id]}" unless user_id_from_params == session[:user_id]
			end
		else
			check_member_permissions
		end
	end

	def user_id_from_params
		id = /users\/(\d+)\z/.match(params["splat"].join)
		if id
		 id[1].to_i
		end
	end

	def check_member_permissions
		allowed = ['/manipulations', "/users/#{session[:user_id]}"]
		return if allowed.include?(request.path_info)
		redirect '/login'
	end

end


helpers Authorization

