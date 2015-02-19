require 'json'

get "/batch/upload" do
  erb :'batches/upload'
end 

post "/batch/upload" do 
  #   # response = {manipulations: parse_bill, user_data: user_data}.to_json
  bill_data = parse_bill.to_json
  session[:batch_id] = Batch.create(bill_data: bill_data).id

 	redirect '/batch/new'

end



get '/batch/new' do
=begin 
expect ajax request to check if there is an open batch (which means bill has been uploaded)
if so: return true. this triggers front end ajax load command.
if not: return false. this triggers front end custom manipulation adder thing that im building right now

todo: close any existing batch when admin panel is opened by deleting session id.
=end

	erb :'batches/edit_batch'
end

get '/api/batch/new' do
	if session[:batch_id]
		manipulations = JSON.parse( Batch.find( session[:batch_id] ).bill_data )
	end	
	# user_data = Hash[User.pluck(:id, :handle)]

	content_type :json
 #	response = {manipulations: manipulations, user_data: user_data}.to_json
	response = {manipulations: manipulations}.to_json
end

get '/api/batch/check' do 
	content_type :json
	 (!!session[:batch_id]).to_json
end

get '/api/batch/users' do 
	user_data = Hash[User.pluck(:id, :handle)]

	users_by_year = User.pluck(:id, :year)
	
	# users_by_year.map! do |label, group|
	# 	group.map!(&:id)
	# end

	p user_by_year
	content_type :json
	 {user_data: user_data}.to_json
end

post '/api/batch' do
	post_manipulations = JSON.parse(params[:data])
	remaining_manipulations = save_or_get_errors(post_manipulations)

	content_type :json
	remaining_manipulations.to_json
end



