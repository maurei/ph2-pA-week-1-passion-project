before 'users/*' do 

	redirect '/login' unless session[:user_id]

	
end

get '/users' do
	user = User.find(session[:user_id])

	if user.access_level == "superadmin"
	  return <<-HTML
	  <h1>Welcome #{user.handle}</h1>
	  <h1>Jesus christ, youre an admim!</h1>
	  HTML
	else
	<<-HTML
	  <h1>Welcome #{user.handle}</h1>
	  HTML
	end

end
