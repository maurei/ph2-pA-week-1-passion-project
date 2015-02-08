get '/login' do
  redirect '/users' if session[:user_id]
  erb :login
end

post '/login' do

  user = User.find_by(handle: params[:handle])

  redirect '/login' unless user

  if user.password == params[:password]
    session[:user_id] = user.id
    session[:handle] = user.handle
    redirect "/users"
  else
    redirect '/login'
  end
end

get '/logout' do
  session.delete :user_id
  redirect '/login'
end