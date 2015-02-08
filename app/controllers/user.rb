before 'users/*' do 
	redirect '/login' unless session[:user_id]
end

get '/users' do
	@user = User.find(session[:user_id])
	erb :users
end

get '/accounts/:id/manipulations' do
	@user = User.find(session[:user_id])
	@manipulations =  @user.accounts.first.manipulations
	erb :users_transactions
end


#accounts/<%= account.id %>/manipulations  accounts/:id/manipulations

# href="/categories/<%= @category.id%>/articles