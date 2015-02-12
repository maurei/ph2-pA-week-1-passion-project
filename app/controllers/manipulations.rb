


get '/manipulations/new' do
  @accounts = Account.all
  @users = User.where(access_level: "member")
  erb :'manipulations/manipulations_new'
end


post '/manipulations' do
	manipulation = hashify(params[:new_manipulation])
	user = User.find(manipulation.delete(:user_id))  # consider replacing these two lines w a scope @TODO
	manipulation.delete(:account_type)
	account = user.accounts[0]
	# ^^^ pre processing

	account.manipulate(manipulation)
	redirect '/login'
end


get '/users/:id/accounts/:id/manipulations' do
	@user = User.find(session[:user_id])
	@account = @user.accounts.first

	unless @account.manipulations.empty?
		@manipulations = @account.manipulations
		erb :'manipulations/manipulations_show'
	else
		p "no manipulations show"
	end
end

post '/manipulations/edit' do 
	@user = User.find(params[:user_id])
	@manipulations =  @user.accounts.first.manipulations
	@admin = User.find(session[:user_id])
	erb :'manipulations/manipulations_show'

end

delete '/manipulations/:id' do |id|
	manipulation = Manipulation.find(id)
	manipulation.undo
	redirect '/login'
end

# {"user_id"=>"1", "account_type"=>"PD", "action"=>"withdraw", "amount"=>"", "issue_date"=>"", "description"=>""}
# # {"user_id"=>"1", "account_type"=>"PD", "action"=>"withdraw", "amount"=>"sdf", "issue_date"=>"sdf", "description"=>"sdf"}

# # member = Hash[params[:new_user].map{ |k,v| [k.to_sym,v] } ]