before '/users/*' do 
	redirect '/login' unless session[:user_id] # redirect_unless_logged_in @TODO
end

get '/users' do
	@users = User.where(access_level: "member")
	erb :'users/users_index'
end

get '/users/new' do
	@errors = session.delete(:errors)
	# p @errors
	erb :'users/users_new'
end

post '/users' do
	# member = Hash[params[:new_user].map{ |k,v| [k.to_sym,v] } ]
  add_member params[:new_user]
	redirect '/login'
end

get '/users/:id' do
	@user = User.find(session[:user_id])
	if @user.access_level == "member"  # @TODO @user.is_member calls an instance method with the same logic
		erb :'users/users_show'
	else
		@users = User.where(access_level: "member")
		erb :'users/users_admin_show'
	end
end

get '/users/:user_id/edit' do |id|
		@user = User.find(id)
		erb :'users/users_edit'
end

put '/users/:user_id' do
	update_member params[:edit_user].merge!(id: params[:user_id])
	p params[:edit_user]
	redirect "/users/#{session[:user_id]}"
end

delete '/users/:user_id' do |id|
	delete(id)
	redirect "/users/#{session[:user_id]}"
end


