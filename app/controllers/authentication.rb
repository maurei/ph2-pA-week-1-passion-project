# error 301 do
  
# end


before '/*' do 
  authorize_or_redirect unless request.path_info == '/login' or request.path_info == '/logout'
end

get '/' do
 redirect "/login"
 erb :'users/users_show'
end

get '/login' do
  redirect "/users/#{session[:user_id]}" if session[:user_id] # redirect_unless_logged_in @TODO
  erb :login
end

post '/login' do

  user = User.find_by(handle: params[:handle])

  redirect '/login' unless user

  if user.password == params[:password]
    session[:user_id] = user.id
    session[:handle] = user.handle
    redirect "/users/#{session[:user_id]}"
  else
    redirect '/login'
  end
end

get '/logout' do
  session.delete :user_id
  redirect '/login'
end



# <!-- <div class = "container">
#   <h1>Welcome <%= @user.handle %></h1>
#   <br>
#   <br>
#   <h1> Your accounts: </h1>
#   <p> you only have one, dumbass.. </p>
#   <a href="/manipulations"> Show your manipulations </a>
#   <br> Balance: <%= @user.account.balance %>
#   <form action='/logout' method='get'>
#     <input type='submit' value='logout'>
#   </form>
# </div>

#  -->