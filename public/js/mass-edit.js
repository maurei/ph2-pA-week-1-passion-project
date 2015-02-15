$(document).ready(function() {
// "use strict";




  function manipulationsView(){
    this.$container = $('.mass-edit-container');
    this.$submit = $('button');


    this.render = function(model){
      this.$container.html('');
      var i, manipulations;
      manipulations = model.getManipulations();
      user_data = model.getAllUsers()
      for(i = 0; i < manipulations.length; i++){
        this.$container.append('<div class="list-group-item" row_id="' + manipulations[i].row_id + '"><form class="form-inline"><div class="form-group"><label for="user_id">Name</label>'+populateSelect(user_data, manipulations[i]).prop("outerHTML")+'</div><div class="form-group"><label for="date">Date</label><input type="email" class="form-control" id="issue_date" placeholder="2014/01/30" value="' + manipulations[i].issue_date + '"></div><div class="form-group"><label for="description">Description</label><input type="text" class="form-control" id="description" placeholder="Description..." value="' + manipulations[i].description + '" size = 50></div><div class="form-group"><label for="amount">Amount</label><input type="text" class="form-control" id="amount" placeholder="$$$" value="' + manipulations[i].amount + '"></div></form></div>');
      }
    };
    this.getSelectorTypes = function(){
    	return 'select, input'
    };
  }


  function manipulationsModel(){
    var manipulations = [];
    var all_users = {}

    this.load = function(renderViewCallback){
     	$.ajax({
        url: '/api/mass-edit',
        type: 'GET',
        success: function(data){
          all_users = data.user_data
          manipulations = data.manipulations
        	$.each(manipulations, function(index, element){
          element.row_id = index
        //   _frontData = {row_id: index, validated: null, error_messages: null }
      	//   element._frontData = _frontData
        //   remove :handle out this data, no longer used in

          });
        	renderViewCallback();
        },
        error: function(){
        	console.log('Error while fetching manipulations from imported bill')
        }
      });
   	}

    this.submitManipulations = function(event){
      aj = $.ajax({
        url: '/api/mass-edit',
        type: 'post',
        data: {content: JSON.stringify( manipulations ) },
        success: function(data){
          manipulations = data
          event.data.callback()
        },
        error: function(){console.log('Validation error')}
      });
    };
    this.getAllUsers = function(){
      return all_users;
    }
    this.getManipulations = function(){
      return manipulations;
    }
  }


  function massEditController(model,view){
    var generate = function(){
      view.render(model);
    };
    model.load(generate);

    var rowIsChanged = function(){
    	var $thisRow = $(this).closest('.list-group-item');
    	var rowId = $thisRow.attr('row_id');
			var manipulations = model.getManipulations()
      var newValue = $(this).val()
    	var field = $(this).attr('id');

			$.each(manipulations, function(index, element){
				if ( element.row_id == rowId ){ 
					element[field] = newValue
				console.log(manipulations[index])
				};
			})
    };

    view.$container.on('change', view.getSelectorTypes(), rowIsChanged)
    view.$submit.on('click', {callback: generate}, model.submitManipulations)
  };

  var massEditor = new massEditController(new manipulationsModel(), new manipulationsView());
})



/*

to do for mass edit:

* loading button: (post mvp but fun)
	- initially display = hidden for mass-edit-container.
	- as soon as line 30 renderViewCallback has finished, 
		- remove loading button
		- change display hidden to block


* submit button that AJAX post's everything to sinatra,
	- sinatra does validation 
	- consider changing flow of how manipulations are add (start on manipulation end vs the way it happens now)
	- return data should be failed-to-validate objects including error messages, which get displayed nicely
	- if no errors, trigger sinatra redirect



*/


