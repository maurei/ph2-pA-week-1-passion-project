

get '/manipulations/new' do
  @accounts = Account.all
  @users = User.all
  erb :'manipulations/manipulations_new'
end


post '/manipulations' do
	manipulation = Hash[params[:new_manipulation].map{ |k,v| [k.to_sym,v] } ]
	user = User.find(manipulation.delete(:user_id))
	manipulation.delete(:account_type)
	account = user.accounts[0]
	account.manipulate(manipulation)
	
end


get '/users/:id/accounts/:id/manipulations' do
	@user = User.find(session[:user_id])
	@manipulations =  @user.accounts.first.manipulations
	erb :'manipulations/manipulations_show'
end

# {"user_id"=>"1", "account_type"=>"PD", "action"=>"withdraw", "amount"=>"", "issue_date"=>"", "description"=>""}
# # {"user_id"=>"1", "account_type"=>"PD", "action"=>"withdraw", "amount"=>"sdf", "issue_date"=>"sdf", "description"=>"sdf"}

# # member = Hash[params[:new_user].map{ |k,v| [k.to_sym,v] } ]