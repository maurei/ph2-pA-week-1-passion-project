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
	erb :'batches/edit_batch'
end

get '/api/batch/new' do
		manipulations = JSON.parse( Batch.find( session[:batch_id] ).bill_data )
		user_data = Hash[User.pluck(:id, :handle)]

		content_type :json
		response = {manipulations: manipulations, user_data: user_data}.to_json
end

post '/api/batch' do
	post_manipulations = JSON.parse(params[:data])
	remaining_manipulations = save_or_get_errors(post_manipulations)

	content_type :json
	remaining_manipulations.to_json
end



