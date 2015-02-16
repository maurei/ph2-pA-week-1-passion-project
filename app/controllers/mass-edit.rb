require 'json'

# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")
# [
# 	["16/12/14", Nick Wensvoort, "withdraw", 40, "opladen pas"],
# 	["16/12/14", Tom Brackel, "withdraw", 350, "flugel (10)"],
# 	["16/12/14", Koningswijk, "withdraw", 78, "afbo slotfeest"],
# ]

get '/fiscus/mass-edit' do
	erb :mass_edit
end

get '/fiscus/api/mass-edit' do
		content_type :json
		 	BatchManipulation.find( session.delete(:batch_id) ).batch_json
end

post '/fiscus/api/mass-edit' do

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



