# # helpers do 
# # 	def allow(*access_levels)
# # 		@user = User.find(session[:user_id])

# # 		if access_levels.include?(@user.access_level)
# # 		elsif 
# # 			puts "niet erin"
# # 		end

# # 	end
# # end


# module Authorization

# 	def authorize_or_redirect
# 		redirect '/login', 401 unless session[:user_id]
# 		if params[:user_id]
# 			redirect_to_home unless session[:user_id] == params[:user_id]
# 		else
# 			@access = User.find(session[:user_id]).access_level
# 			redirect to('/') unless authorized?(@access)
# 		end

# 	end

# 	def redirect_to_home
# 		redirect "/users/#{session[:user_id]}"
# 	end

# 	def authorized?(access_level)
# 		if access_level == "member"
# 			routes = [/\/users\/(\d+)\z/, /manipulations/]
# 			routes.each do |route|
# 				return true if request.path_info =~ route
# 			end
# 		else
# 			routes = [/\/users\/(\d+)\z/]
# 			routes.each do |route|
# 				return false if request.path_info =~ route
# 			end
# 		end
# 	end
# end

#  helpers Authorization


# =begin
	

# user logs in: 
# 	- id is stored in session X
# 	- access level is read	X
# 			- user is redirected to members homepage if level == member X
# 			- user is redirected to admin homepage if level == superadmin X
# user hits "member" route X
# 	- session id is compared with id in url X
# 			- if error: redirect back with status code 401 (unauthorized). session not being present is also part of this X
# 			- if OK:
# 					get access_level corresponding to ID from DB, compare with route's requirements
# 						- if OK: go on
# 						- if not: redirect to users landing page with code 401



# =end