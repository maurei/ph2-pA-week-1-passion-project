


get '/manipulations/new' do
  @users = User.where(access_level: "member")
  erb :'manipulations/manipulations_new'
end


post '/manipulations' do
	manipulation = hashify(params[:new_manipulation])
	user = User.find(manipulation.delete(:user_id))  # consider replacing these two lines w a scope @TODO
	account = user.account
	# ^^^ pre processing

	account.manipulate(manipulation)
	redirect '/login'
end


get '/manipulations' do #change
	@user = User.find(session[:user_id])
	@account = @user.account

	unless @account.manipulations.empty?
		@manipulations = @account.manipulations
		erb :'manipulations/manipulations_show'
	else
		p "no manipulations show"
	end
end

post '/manipulations/edit' do 
	@user = User.find(params[:user_id])
	@manipulations =  @user.account.manipulations
	@admin = User.find(session[:user_id])
	erb :'manipulations/manipulations_show'

end

delete '/manipulations/:id' do |id|
	manipulation = Manipulation.find(id)
	manipulation.undo
	redirect '/login'
end

