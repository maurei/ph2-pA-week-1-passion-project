get '/accounts' do
  @accounts = Accounts.all
  erb :'accounts/accounts_index'
end