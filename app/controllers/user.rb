before '/users/*' do 
	redirect '/login' unless session[:user_id] 
	# redirect somewhere if params[:splat][0] != session[:user_id]
end

get '/users/new' do
	erb :users_create
end

post '/users' do
  member = Hash[params[:new_user].map do |k,v| 
  	[k.to_sym,v] 
  end]
  add member
	redirect '/login'
end

get '/users/:id' do
	@user = User.find(session[:user_id])
	if @user.access_level == "member"
		erb :users
	else
		erb :admin_panel
	end
end

get '/users/id/edit' do
	erb :users_edit
end

put '/users/id/edit' do
		erb :users_edit
end


get '/users/:id/accounts/:id/manipulations' do
	@user = User.find(session[:user_id])
	@manipulations =  @user.accounts.first.manipulations
	erb :manipulations
end

