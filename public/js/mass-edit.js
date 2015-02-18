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
        console.log(errors)
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


  function manipulationsModel(){
    var manipulations = [];
    var all_users = {}

    this.load = function(renderViewCallback){
     	$.ajax({
        url: '/api/batch/new',
        type: 'GET',
        success: function(data){
          all_users = data.user_data
          manipulations = data.manipulations
        	$.each(manipulations, function(index, element){
          element.row_id = index
          });
        	renderViewCallback();
        },
        error: function(){
        	console.log('Error while fetching manipulations from imported bill')
        }
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
    generate = function(){
      view.render(model);
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

    model.load(generate);
    view.$container.on('change', view.getSelectorTypes(), rowIsChanged)
    view.$submit.on('click', {response: generate, done: view.successMessage.bind(view) }, model.submitManipulations)
  };


  var massEditor = new massEditController(new manipulationsModel(), new manipulationsView() );





 // keyboard stuff below here, mass edit stuff above this line.
  function keyBoardViewer(){
    this.allFields = function(){
      return $('div > select, input')
    };
    this.labelCurrentFocus = function(){
      $(document.activeElement).attr('active','true')
    };
    this.getSelectorTypes = function(){
      return 'select, input'
    };
    this.$container = $('.mass-edit-container')

    this.changeFocus = function(newField){
      newField.focus()
    }

  };
  

  function keyBoardController(view){
    var keyMapper = {37: 1, 38: 4, 39: -1, 40: -4}

    var checkKey = function(event){
      if (keyMapper.hasOwnProperty(event.which)){
        changeField(event.which)
      }
    }

    var changeField = function(key){
      event.preventDefault()
      $fields = view.allFields()
      var activeIndex = findActiveIndex($fields)
      $newField = $fields.eq( activeIndex - displacement(key) )
      view.changeFocus($newField)
    };

    var findActiveIndex = function(fields){
      view.labelCurrentFocus()
      var indexMatch;
      $.map(fields, function(element, index){
        if ($(element).attr('active') == 'true' ){
          $(element).removeAttr('active')
          indexMatch = index
        };
      })
      return indexMatch
    }

    var displacement = function(key){
      return keyMapper[key]
    }
    

    view.$container.on('keydown', view.getSelectorTypes(), checkKey)
  };


  var keyBoardControl = new keyBoardController(new keyBoardViewer())
})

// left    37
// up      38
// right   39 
// down    40



