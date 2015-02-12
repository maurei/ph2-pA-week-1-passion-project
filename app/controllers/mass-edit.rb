require 'json'

# User.first.accounts[0].manipulate(amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit")
# [
# 	["16/12/14", Nick Wensvoort, "withdraw", 40, "opladen pas"],
# 	["16/12/14", Tom Brackel, "withdraw", 350, "flugel (10)"],
# 	["16/12/14", Koningswijk, "withdraw", 78, "afbo slotfeest"],
# ]


get '/get-imported-data' do
 

# ready_to_confirm = some huge object with all nicely formatted data
# ready_to_confirm.to_json

one_row = {user_id: 1, amount: 40.00, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit"}

content_type :json
# json = one_row.to_json
# p json
# # back = JSON.parse(json)
# # p back
# # p hashify(back)
	one_row.to_json

end

post '/json-manipulation-row' do
 

# ready_to_confirm = some huge object with all nicely formatted data
# ready_to_confirm.to_json




end



__END__

hit manipulations post route with something like User.first.accounts[0].manipulate(

every row before converting to json:
{amount: 19.23, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit"}


{amount: 40.00, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit"}
{amount: 350.00, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit"}
{amount: 78.00, issue_date: "2015/01/01", description: "allemachtig wat prachtig", action: "deposit"}


["16/12/14", Nick Wensvoort, "withdraw", 40, "opladen pas"],
# 	["16/12/14", Tom Brackel, "withdraw", 350, "flugel (10)"],
# 	["16/12/14", Koningswijk, "withdraw", 78, "afbo slotfeest"],


every row after converting back from json


