$(document).ready(function() {
// "use strict";


  function manipulationsView(){
    this.$container = $('.mass-edit-container');
    this.$submit = $('button');

    this.render = function(model){
      this.$container.html('');
      var i, manipulations;
      manipulations = model.getManipulations();
      user_data = model.getAllUsers();
      for(i = 0; i < manipulations.length; i++){
        var errors = manipulations[i].error_messages
        $row = generateRow(manipulations, i)
        this.$container.append( $row );
        // console.log(errors)
        if (  errors !== undefined ){
          $errorMessages = generateErrors(errors)
          this.$container.find('div.list-group-item').last().after($errorMessages)
        };
      }
    };

    this.successMessage = function(){
    this.$container.html('')
    this.$container.append(generateSuccessMessage())
     return  $('button').html('Go back').wrap('<form action="/login" method="get"></div>')
    };
    this.getSelectorTypes = function(){
    	return 'select, input'
    };

  }

  function userModel(users){
    

  }


  function manipulationsModel(){

    var blank_manipulation = {action: null, withdraw: null, amount: null, description: null, issue_date: null, user_id: null}

    var manipulations = [];
    var all_users = {}


    this.load = function(renderViewCallback){
     	$.ajax({
        url: '/api/batch/new',
        type: 'GET',
        success: function(data){
          all_users = data.user_data // extract this out in user model
          if (data.manipulations === null){
            manipulations.push(blank_manipulation)
          }
          else{
            manipulations = data.manipulations
            console.log(manipulations)
          }
          
          addRowIdToManipulations()
        	renderViewCallback();
        },
        error: function(){
        	console.log('Error while fetching manipulations from imported bill')
        }
      });
   	}

    var addRowIdToManipulations = function(){
      $.each(manipulations, function(index, element){
      element.row_id = index
      });
    }

    this.submitManipulations = function(event){
      $.ajax({
        url: '/api/batch',
        type: 'post',
        data: {data: JSON.stringify( manipulations ) },
        success: function(data){
          manipulations = []
          if (data.length === 0){
            event.data.done();
          }
          else{
            manipulations = data;
            event.data.response();
          }
        },
        error: function(){console.log('Something went wrong on in the backend while fetching failed manipulations')}
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

    var checkForBatch = function(){
      $.ajax({
        url: '/api/batch/check',
        type: 'GET',
        success: function(data){
          if (data === true){model.load(generate)}
          else {
            console.log("there is no bill, going to give you custom manipulation shizzle")
            model.load(generate)
          };
        },
        error: function(){console.log('For some reason, I can not check if there is a batch')}
      });
    };

    var rowIsChanged = function(){
    	var $thisRow = $(this).closest('.list-group-item');
    	var rowId = $thisRow.attr('row_id');
			var manipulations = model.getManipulations()
      var newValue = $(this).val()
    	var field = $(this).attr('id');

			$.each(manipulations, function(index, element){
				if ( element.row_id == rowId ){ 
					element[field] = newValue
				// console.log(manipulations[index])
				};
			})
    };


    checkForBatch()


    view.$container.on('change', view.getSelectorTypes(), rowIsChanged)
    view.$submit.on('click', {response: generate, done: view.successMessage.bind(view) }, model.submitManipulations)
  };


  var massEditor = new massEditController(new manipulationsModel(), new manipulationsView() );

})



