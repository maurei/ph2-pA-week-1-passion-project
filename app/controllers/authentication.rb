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