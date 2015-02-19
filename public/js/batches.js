$(document).ready(function() {
// "use strict";


function manipulationsView(){
  this.$container = $('.mass-edit-container');
  this.$submit = $('#submit');
  this.$addRow = $('#add');
  this.$smartAdd = $('#smart-add')
  var $smartAddPanel = $('#smart-panel')

  this.render = function(model, userModel){
    this.$container.html('');
    var i, manipulations;
    manipulations = model.getManipulations();
  
    user_data = userModel.getAllUsers();
    for(i = 0; i < manipulations.length; i++){
      var errors = manipulations[i].error_messages

      $row = generateRow(manipulations[i])
      this.$container.append( $row );
        if (  errors !== undefined ){
          $errorMessages = generateErrors(errors)
          this.$container.find('div.list-group-item').last().after($errorMessages)
        };
      }
    };

    this.successMessage = function(){
      this.$container.html('')
      this.$container.append(generateSuccessMessage())
      return  $('#submit').html('Go back').wrap('<form action="/login" method="get"></div>')
    };
    this.getSelectorTypes = function(){
    	return 'select, input'
    };
    this.slideSmartPanel = function(){
      if($smartAddPanel.css('display') === 'none'){
        $panelContent = generatePanelContent()

        $smartAddPanel.html( $panelContent )
        $smartAddPanel.slideDown( "slow" )

        $panelContent.on('click', '#smart-all-users, #smart-per-year', this.toggleSmartPanel )
      }
      else{
        $smartAddPanel.slideUp("slow")
      };
    };

    this.toggleSmartPanel = function(){
      $(this).siblings('li').removeClass('active')
      $(this).addClass('active')
      $panelContent = $smartAddPanel.find('.panel-body')

      var tabChoice = $(this).attr('id')
      if (tabChoice === "smart-all-users"){
        $panelContent.html( allUsersTab() )
      }
      else if (tabChoice === "smart-per-year"){
        $panelContent.html( perYearTab() )
      }

      

    


    }


  }





  function userModel(){
    var all_users = {};

    this.load = function(){

      $.ajax({
        url: '/api/batch/users',
        type: 'GET',
        success: function(data){
          all_users = data.user_data
        },
        error: function(){
          console.log('Can not fetch the users from the API')
        }
      });

    };

    this.getAllUsers = function(){
      return all_users
    };

  }


  function manipulationsModel(){

    var blankManipulation = function(){
      this.action = "withdraw"
      this.amount = ""
      this.user_id = ""
      this.issue_date = ""
      this.description = ""
    }

    var manipulations = [];


    this.load = function(renderViewCallback){
      $.ajax({
        url: '/api/batch/new',
        type: 'GET',
        success: function(data){
          if (data.manipulations !== null){
            manipulations = data.manipulations
            addRowIdToManipulations()
            renderViewCallback();
          }
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

    this.addNewRow = function(event){
      manipulations.push( new blankManipulation() )
      addRowIdToManipulations()
      event.data.render()
    };

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

    this.getManipulations = function(){
      return manipulations;
    }


  }


  function massEditController(model,userModel,view){

    userModel.load()

    var generate = function(){
      view.render(model, userModel);
    };


    var checkForBatch = function(){
      $.ajax({
        url: '/api/batch/check',
        type: 'GET',
        success: function(data){
          if (data === true){model.load(generate)}
            else {
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
      };
    })
   };



   checkForBatch()


   view.$container.on( 'change', view.getSelectorTypes(), rowIsChanged)

   view.$submit.on( 'click', {response: generate, done: view.successMessage.bind(view) }, model.submitManipulations )

   view.$addRow.on( 'click', {render: generate }, model.addNewRow )
   view.$smartAdd.on( 'click', view.slideSmartPanel.bind(view) )
 };


 var massEditor = new massEditController(new manipulationsModel(), new userModel(), new manipulationsView() );

})



