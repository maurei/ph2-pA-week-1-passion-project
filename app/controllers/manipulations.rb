## member routes

get '/manipulations' do 
	@user = User.find(session[:user_id])
	@account = @user.account

	unless @account.manipulations.empty?
		@manipulations = @account.manipulations
		erb :'manipulations/manipulations_show'
	else
		p "no manipulations show"
	end
end


## admin routes

get '/treasurer/manipulations/new' do
  @users = User.where(access_level: "member")
  erb :'manipulations/manipulations_new'
end


post '/treasurer/manipulations' do
	manipulation = hashify(params[:new_manipulation])
	account = Account.by_user_id(manipulation.delete(:user_id))
	
	account.manipulate(manipulation)
	redirect '/login'
end



post '/treasurer/manipulations/edit' do 
	@user = User.find(params[:user_id])
	@manipulations =  @user.account.manipulations
	@admin = User.find(session[:user_id])
	erb :'manipulations/manipulations_show'

end

delete '/treasurer/manipulations/:id' do |id|
	Manipulation.find(id).destroy  #callback in model also reverses change in balance of corresponding account
	redirect '/login'
end

