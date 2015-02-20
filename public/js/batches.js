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
    this.slideSmartPanel = function(event){
      if($smartAddPanel.css('display') === 'none'){
        $panelContent = generatePanelContent()

        $smartAddPanel.html( $panelContent )
        $smartAddPanel.slideDown( "slow" )

        $panelContent.on('click', '#smart-all-users, #smart-per-year', {years: event.data.years}, this.toggleSmartPanel )
      }
      else{
        $smartAddPanel.slideUp("slow")
      };
    };

    this.toggleSmartPanel = function(event){

      $(this).siblings('li').removeClass('active')
      $(this).addClass('active')
      $panelContent = $smartAddPanel.find('.panel-body')

      var tabChoice = $(this).attr('id')
      if (tabChoice === "smart-all-users"){
        $panelContent.html( allUsersTab() )
      }
      else if (tabChoice === "smart-per-year"){
        $panelContent.html( perYearTab(event.data.years) )
      }
      massEditor.listenDeployButton(tabChoice)
    }

    this.getPreFills = function(){
      $fields = $('#prefill').find('input')
      var preFillData = {};
      $.each($fields, function(index, element){
        preFillData[ $(element).attr('id') ] = $(element).val() })
      return preFillData
    }

    this.getCheckedBoxes = function(){
      $checkedBoxes = $('input:checkbox:checked')
      var selectedYears = []
      $.each($checkedBoxes, function(index, element){
       selectedYears.push( $(element).attr('year') )
      })
      return selectedYears
    }

  }


  function userModel(){
    var all_users = [];
    var users_per_year = {};

    this.load = function(){
      $.ajax({
        url: '/api/batch/users',
        type: 'GET',
        success: function(data){
          all_users = data.user_data
          users_per_year = data.user_id_by_year
        },
        error: function(){
          console.log('Can not fetch the users from the API')
        }
      });

    };
    this.getAllUsers = function(){
      return all_users
    };
    this.getUsersPerYear = function(){
      return users_per_year
    };
  }


  function manipulationsModel(){

    var blankManipulation = function(amount, user_id, issue_date, description){
      this.action = "withdraw"
      this.amount = amount || ""
      this.user_id = user_id || ""
      this.issue_date = issue_date || ""
      this.description = description || ""
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

    this.addNewRow = function(event, amount, user_id, issue_date, description){
      manipulations.push( new blankManipulation(amount, user_id, issue_date, description) )
      addRowIdToManipulations()
      event.data.render()
    };

    this.addSmartRows = function(event){
      var preFillData = event.data.getPreFills()
      var type = event.data.option
      var users = event.data.users
      var users_per_year = event.data.users_per_year
      var model = this
      if( type === 'smart-all-users' ){
        for (var user_id in users){
        model.addNewRow(event, preFillData.amount, user_id, preFillData.issue_date, preFillData.description)
        }
      }
      else if (type === 'smart-per-year'){
        var selectedYears = event.data.getCheckedBoxes()
        $.each(selectedYears, function(index, year){
          $.each(users_per_year[year], function(index, user_id){
            model.addNewRow(event, preFillData.amount, user_id, preFillData.issue_date, preFillData.description)
          })    
        })
      }

    }

    this.submitManipulations = function(event){
      console.log(manipulations)
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
    this.foo = "foo!!"
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
              listenSmartPanelButton()
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

   var listenSmartPanelButton = function(){
    view.$smartAdd.on( 'click', {years: userModel.getUsersPerYear() }, view.slideSmartPanel.bind(view) )
   }



   this.listenDeployButton = function(tabChoice){
     $('div#smart-panel').find('button').on('click', {getPreFills: view.getPreFills, render: generate, option: tabChoice, users: userModel.getAllUsers(), users_per_year: userModel.getUsersPerYear(), getCheckedBoxes: view.getCheckedBoxes }, model.addSmartRows.bind(model))
     $('div#smart-panel').find('button').on('click', view.slideSmartPanel.bind(view))
   }



   checkForBatch()


   view.$container.on( 'change', view.getSelectorTypes(), rowIsChanged)
   view.$submit.on( 'click', {response: generate, done: view.successMessage.bind(view) }, model.submitManipulations )
   view.$addRow.on( 'click', {render: generate }, model.addNewRow )
   
 };


 var massEditor = new massEditController(new manipulationsModel(), new userModel(), new manipulationsView() );

})



