var populateSelect = function(all_users, manipulation){
var $selectList;
	var option = '';
	// console.log(manipulation)
	// console.log(all_users)
	for (user_id in all_users){
		if (user_id == manipulation.user_id){
			option += '<option value="' + user_id + '" selected="selected">' + all_users[user_id] + '</option>';}
		else {option += '<option value="' + user_id + '">' + all_users[user_id] + '</option>';}
	}
	return $('<select class="form-control" id="user_id"></select>').append(option);
}






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