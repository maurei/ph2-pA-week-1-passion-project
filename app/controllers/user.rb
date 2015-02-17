

## member routes



## admin routes

get '/users' do
	@users = User.where(access_level: "member")
	erb :'users/users_index'
end

get '/users/new' do
	@errors = session.delete(:errors)
	erb :'users/users_new'
end

get '/users/:user_id' do |id|
	@user = User.find(id)
	if @user.access_level == "member" 
		
		erb :'users/users_show'
	else
		@users = User.where(access_level: "member")
		erb :'users/users_admin_show'
	end
end


post '/users' do
  add_member params[:new_user]
	redirect '/login'
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


