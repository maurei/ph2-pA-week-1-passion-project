get '/login' do
  redirect '/users' if session[:user_id]

  <<-HTML
  <h3>Login</h3>
  <form action='/login' method='post'>
    <input type='text' name='handle'>
    <input type='password' name='password'>
    <input type='submit' value='submit'>
  </form>
  HTML
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