var populateSelect = function(all_users, manipulation){
	var option = '';
	// console.log(manipulation)
	// console.log(all_users)
	var $selectList = $('<select class="form-control" id="user_id"></select>')
	for (user_id in all_users){
		if (user_id == manipulation.user_id){
			option += '<option value="' + user_id + '" selected="selected">' + all_users[user_id] + '</option>';}
		else {option += '<option value="' + user_id + '">' + all_users[user_id] + '</option>';}
	}
	return $selectList.append(option);
}

var generateRow = function(manipulations, i){
  return $('<div class="list-group-item" row_id="' + manipulations[i].row_id + '"><form class="form-inline"><div class="form-group"><label for="user_id">Name</label>'+populateSelect(user_data, manipulations[i]).prop("outerHTML")+'</div><div class="form-group"><label for="date">Date</label><input type="email" class="form-control" id="issue_date" placeholder="2014/01/30" value="' + manipulations[i].issue_date + '"></div><div class="form-group"><label for="description">Description</label><input type="text" class="form-control" id="description" placeholder="Description..." value="' + manipulations[i].description + '" size = 50></div><div class="form-group"><label for="amount">Amount</label><input type="text" class="form-control" id="amount" placeholder="$$$" value="' + manipulations[i].amount + '"></div></form></div>')
};

var generateErrors = function(errors){
	var $errorDiv = $('<div class="alert alert-danger" role="alert"></div>');
	var error_messages = '';
  for (var field in errors){
    error_messages += '<p>'+field+':&ensp;'+errors[field].join(', ')+'</p>'
  }
  return $errorDiv.append(error_messages)  
};

var generateSuccessMessage = function(){
	return $('<div class="alert alert-success" role="alert">All manipulations have been successfully processed</div>');
};




/*
<div class="list-group-item" user-id="' + manipulations[i].user_id + '">
		<form class="form-inline">
		  <div class="form-group">
		    <label for="handle">Name</label>
		    '+populateSelect(manipulations, manipulations[i]).prop("outerHTML")+'
		  </div>
		  <div class="form-group">
		    <label for="date">Date</label>
		    <input type="email" class="form-control" id="date" placeholder="2014/01/30" value="' + manipulations[i].issue_date + '">
		  </div>
		  <div class="form-group">
		    <label for="description">Description</label>
		    <input type="text" class="form-control" id="description" placeholder="Description..." value="' + manipulations[i].description + '">
		  </div>		  
		  <div class="form-group">
		    <label for="amount">Amount</label>
		    <input type="text" class="form-control" id="amount" placeholder="$$$" value="' + manipulations[i].amount + '">
		  </div>
		</form>
</div>*/