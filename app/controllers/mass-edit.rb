require 'json'

# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")
# [
# 	["16/12/14", Nick Wensvoort, "withdraw", 40, "opladen pas"],
# 	["16/12/14", Tom Brackel, "withdraw", 350, "flugel (10)"],
# 	["16/12/14", Koningswijk, "withdraw", 78, "afbo slotfeest"],
# ]

get '/mass-edit' do
	erb :mass_edit
end

get '/api/mass-edit' do

		fake_import_data = 
		[{:user_id=>1, :amount=>27, :issue_date=>"2015/01/01", :description=>"We can do this", :action=>"withdraw"}, {:user_id=>2, :amount=>27, :issue_date=>"2015/01/01", :description=>"wazzap", :action=>"withdraw"}, {:user_id=>3, :amount=>27, :issue_date=>"2015/01/01", :description=>"eeeey", :action=>"withdraw"}, {:user_id=>4, :amount=>27, :issue_date=>"2015/01/01", :description=>"I'll quantify the virtual JSON pixel, that should firewall the GB system!", :action=>"withdraw"}, {:user_id=>2, :amount=>27, :issue_date=>"2015/01/01", :description=>"ik ben pro", :action=>"withdraw"}, {:user_id=>4, :amount=>27, :issue_date=>"2015/01/01", :description=>"Ik ben skeer", :action=>"withdraw"}]

		user_data = Hash[User.pluck(:id, :handle)]
		response = {manipulations: fake_import_data, user_data: user_data}
		content_type :json
			response.to_json
end

get '/mass-edit' do
	erb :mass_edit
end

post '/api/mass-edit' do
	post_manipulations = JSON.parse(params[:content]).reject! do |post_manipulation|
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



__END__





[{"user_id"=>1, "handle"=>"Mees Koningswijk", "amount"=>27, "issue_date"=>"2015/01/01", "description"=>"", "action"=>"withdraw", "row_id"=>0, :validated=>false, :error_messages=>{:description=>["can't be blank"]}},

 {"user_id"=>2, "handle"=>"Nick Wensvoort", "amount"=>27, "issue_date"=>"2015/01/01", "description"=>"sdf", "action"=>"withdraw", "row_id"=>1, :validated=>true}, 

 {"user_id"=>3, "handle"=>"Tom Brackel", "amount"=>27, "issue_date"=>"2015/01/01", "description"=>"eeeey", "action"=>"withdraw", "row_id"=>2, :validated=>true}, {"user_id"=>4, "handle"=>"Mees Koningswijk", "amount"=>27, "issue_date"=>"2015/01/01", "description"=>"I'll quantify the virtual JSON pixel, that should firewall the GB system!", "action"=>"withdraw", "row_id"=>3, :validated=>true}, {"user_id"=>2, "handle"=>"Maurits", "amount"=>27, "issue_date"=>"2015/01/01", "description"=>"ik ben pro", "action"=>"withdraw", "row_id"=>4, :validated=>true}, {"user_id"=>4, "handle"=>"Arendo", "amount"=>27, "issue_date"=>"2015/01/01", "description"=>"", "action"=>"withdraw", "row_id"=>5, :validated=>false, :error_messages=>{:description=>["can't be blank"]}}]
