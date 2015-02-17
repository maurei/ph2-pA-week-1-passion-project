

## member routes

get '/users/:user_id' do |id|
	if @access == "member" 
		@user = User.find(id)
		erb :'users/users_show'
	else
		@users = User.where(access_level: "member")
		erb :'users/users_admin_show'
	end
end


## admin routes

get 'treasurer/users' do
	@users = User.where(access_level: "member")
	erb :'users/users_index'
end

get 'treasurer/users/new' do
	@errors = session.delete(:errors)
	erb :'users/users_new'
end

post 'treasurer/users' do
  add_member params[:new_user]
	redirect '/login'
end


get 'treasurer/users/:user_id/edit' do |id|
		@user = User.find(id)
		erb :'users/users_edit'
end

put 'treasurer/users/:user_id' do
	update_member params[:edit_user].merge!(id: params[:user_id])
	p params[:edit_user]
	redirect "/users/#{session[:user_id]}"
end

delete 'treasurer/users/:user_id' do |id|
	delete(id)
	redirect "/users/#{session[:user_id]}"
end


