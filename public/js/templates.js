var populateSelect = function(all_users, manipulation){
	var option = '<option selected hidden value=""></option>';
	var $selectList = $('<select class="form-control" id="user_id"></select>')
	for (user_id in all_users){
		if (user_id == manipulation.user_id){
			option += '<option value="' + user_id + '" selected="selected">' + all_users[user_id] + '</option>';}
		else {option += '<option value="' + user_id + '">' + all_users[user_id] + '</option>';}
	}
	return $selectList.append(option);
}

var generateRow = function(manipulation){
  return $('<div class="list-group-item" row_id="' + manipulation.row_id + '"><form class="form-inline"><div class="form-group"><label for="user_id">Name</label>'+populateSelect(user_data, manipulation).prop("outerHTML")+'</div><div class="form-group"><label for="date">Date</label><input type="email" class="form-control" id="issue_date" placeholder="2014/01/30" value="' + manipulation.issue_date + '"></div><div class="form-group"><label for="description">Description</label><input type="text" class="form-control" id="description" placeholder="Description..." value="' + manipulation.description + '" size = 50></div><div class="form-group"><label for="amount">Amount</label><input type="text" class="form-control" id="amount" placeholder="$$$" value="' + manipulation.amount + '"></div></form></div>')
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

var generatePanelContent = function(){
	return $('<ul class="nav nav-tabs"><li role="presentation" id="smart-all-users"><a href="#">All users</a></li><li role="presentation" id="smart-per-year"><a href="#">Users selected by year</a></li></ul><div class="panel-body">Choose an option</div>')
};	

var allUsersTab = function(){

	return $('<p>Prefill options:</p><form class="form-inline" id="prefill"><div class="form-group"><label for="date">Date</label><input type="email" class="form-control" id="issue_date" placeholder="2014/01/30"></div><div class="form-group"><label for="description">Description</label><input type="text" class="form-control" id="description" placeholder="Description..."size = 50></div><div class="form-group"><label for="amount">Amount</label><input type="text" class="form-control" id="amount" placeholder="$$$"></div></form><br><br><button type="button" class="btn btn-default" id="all-users-deploy"> Deploy! </button>')
};

var perYearTab = function(years){
	return $('<p>Prefill options:</p><form class="form-inline" id="prefill"><div class="form-group"><label for="date">Date</label><input type="email" class="form-control" id="issue_date" placeholder="2014/01/30"></div><div class="form-group"><label for="description">Description</label><input type="text" class="form-control" id="description" placeholder="Description..."size = 50></div><div class="form-group"><label for="amount">Amount</label><input type="text" class="form-control" id="amount" placeholder="$$$"></div></form>'+generateCheckBoxes(years).prop('outerHTML')+'<button type="button" class="btn btn-default" id="per-year-deploy"> Deploy! </button>')

};

var generateCheckBoxes = function(years){
	var $checkBoxDiv = $('<div class="checkbox"></div>');
	var option = '';
	for (year in years){
		option += '<label><input type="checkbox" year="'+year+'">'+year+'</label>'
	}
	return $checkBoxDiv.append(option)
}

// Need to wrap above functions in container as well. Not a priority for now.





var EditManipulationsTemplates = function(){



	this.userOverview = function(userModel){
		var users = userModel.getUsers()
		var usersByYear = userModel.getUsersByYear()
		var $overview = $('<div class="list-group">'+this.generateUserOverviewPanels()+'</div>')
		return $overview
	};
	this.generateUserOverviewPanels = function(){
		var	overviewPanels = '';
		for (year in usersByYear){
			overviewPanels += '<a href="#" class="list-group-item active"> Year: '+year+'</a>'
			$.each(usersByYear[year], function(index, user_id){
				overviewPanels += '<a href="#" class="list-group-item" id="user-overview-panel" user_id="'+user_id+'">'+users[user_id]+'</a>'
			})
		}
		return overviewPanels
	};

	this.manipulationPanels = function(manipulations){
		var $wrapper = $( '<div id="manipulationPanelWrap" style="display:none"></div>' )
		var panels = '';
		var generateManipulationPanel = this.generateManipulationPanel
		$.each(manipulations, function(index, manipulation){
			panels += '<div class="panel panel-default"><div class="panel-body">'+generateManipulationPanel( manipulation )+'<div class="btn-group"><button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Undo <span class="caret"></span></button><ul class="dropdown-menu" role="menu"><li id="undo_manipulation_button" manipulation_id = "'+manipulation.id+'"><a href="#">Confirm</a></li></ul></div></div></div>'
		})
		return $wrapper.html(panels)
	};
	this.generateManipulationPanel = function(manipulation){
		return 'Nice Manipulation layout comes here<br>'+manipulation.description
	}

	this.batchOverview = function(batchModel){
		var batches = batchModel.getBatches()
		var manipulationsPerBatch = batchModel.perBatch()
		var $overview = $('<ul class="list-group">'+this.generateBatchOverviewPanels()+'</ul>')
		return $overview
	};
	this.generateBatchOverviewPanels = function(){
		var overviewPanels = '';
		$.each(batches, function(index, element){
			overviewPanels += '<li class="list-group-item" id="batch-row" batch_id = "'+element.id+'" revealed="false"><span class="badge">'+manipulationsPerBatch[element.id].length+'</span>Batch name:'+element.batch_name+'<div class="btn-group"><button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Undo <span class="caret"></span></button><ul class="dropdown-menu" role="menu"><li id="undo_batch_button"><a href="#">Confirm. Undoing a whole batch is irreversible!</a></li></ul></div></li>'
		})
		return overviewPanels
	};



};




