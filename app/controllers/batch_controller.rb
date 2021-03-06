require 'json'

get "/batch/upload" do
  erb :'batches/upload'
end

get '/batch/edit' do 
	manipulations = Manipulation.all.map do |manipulation|
		add_user_id(manipulation)
	end
	@manipulations = manipulations.to_json
	@batches = Batch.all.to_json
	@users = Hash[User.pluck(:id, :handle)].to_json
	@user_ids_by_year = group_by_year_flattened( User.pluck(:id, :year) ).to_json
	
	erb :'batches/edit'
end

delete '/manipulations/:id' do |id|

	Manipulation.find(id).destroy #notice callback in model that reverses balance effect

end

delete '/batch/:id' do |id|

	Batch.find(id).destroy

end



post "/batch/upload" do
  bill_data = parse_bill.to_json
  session[:batch_id] = Batch.create(bill_data: bill_data).id

 	redirect '/batch/new'

end



get '/batch/new' do
	erb :'batches/new'
end

get '/api/batch/new' do
	if session[:batch_id]
		manipulations = JSON.parse( Batch.find( session[:batch_id] ).bill_data )
	end

	content_type :json
	response = {manipulations: manipulations}.to_json
end

get '/api/batch/check' do
	content_type :json
	 (!!session[:batch_id]).to_json
end

get '/api/batch/users' do

	user_data = Hash[User.pluck(:id, :handle)]
	user_ids_by_year = group_by_year_flattened( User.pluck(:id, :year) )


	content_type :json
	 {user_data: user_data, user_id_by_year: user_ids_by_year}.to_json
end

post '/api/batch' do
	post_manipulations = JSON.parse(params[:data])
	remaining_manipulations = save_or_get_errors(post_manipulations)

	content_type :json
	remaining_manipulations.to_json
end



