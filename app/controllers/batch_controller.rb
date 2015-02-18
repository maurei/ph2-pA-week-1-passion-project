require 'json'

## all admin routes

# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")
# [
# 	["16/12/14", Nick Wensvoort, "withdraw", 40, "opladen pas"],
# 	["16/12/14", Tom Brackel, "withdraw", 350, "flugel (10)"],
# 	["16/12/14", Koningswijk, "withdraw", 78, "afbo slotfeest"],
# ]

get "/batch/upload" do
  erb :'batches/upload'
end 

post "/batch/upload" do 



  user_data = Hash[User.pluck(:id, :handle)]
  response = {manipulations: parse_bill, user_data: user_data}.to_json

  session[:batch_id] = Batch.create(bill_data: response).id

 	redirect '/batch/new'

end



get '/batch/new' do
	erb :'batches/edit_batch'
end

get '/api/batch/new' do

		content_type :json
		 	Batch.find( session[:batch_id] ).bill_data
end

post '/api/batch' do

	post_manipulations = JSON.parse(params[:content])

	post_manipulations.reject! do |post_manipulation|
		manipulation = construct_object(post_manipulation)
		if manipulation.save
			reject = true
		else
			post_manipulation.merge!(error_messages: manipulation.errors.messages)
			reject = false
		end
	reject

	end

	content_type :json
	post_manipulations.to_json

end



