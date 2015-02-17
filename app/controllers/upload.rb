## all admin routes

get "/upload" do
  erb :upload
end 

post "/upload" do 
	# return "Not a csv" unless is_a_csv?(params[:type])
	bill_source = APP_ROOT.to_path+'/public/uploads/'+params[:bill][:name]
  File.open('public/uploads/'+params[:bill][:name], "w") do |f|
    f.write(params[:bill][:tempfile].read)
  end
  bill_data = read_csv(bill_source)

  bill_data.map! do |row|
  	reformat_csv_row(row)
  end

  user_data = Hash[User.pluck(:id, :handle)]
  response = {manipulations: bill_data, user_data: user_data}.to_json

  session[:batch_id] = Batch.create(bill_data: response).id

 	redirect '/mass-edit'

end

