$(document).ready(function() {
// "use strict";


function BatchEditView(templates){
  this.$undoButtons = $('li#undo_button')
  this.$tabMenu = $('#tabMenu')

  var $manipulationsMenu = $('#manipulations_menu')
  this.getManipulationsMenu = function(){
    return $manipulationsMenu;
  };

  this.toggleTabMenu = function(target, manipulationsModel){
    var tabChoice = $(target).attr('id')
    $(target).siblings('li').removeClass('active')
    $(target).addClass('active')

    if (tabChoice === "users"){
      $manipulationsMenu.html( templates.userOverview( manipulationsModel ).prop('outerHTML') )
    }
    else if (tabChoice === "batches"){
      $manipulationsMenu.html( templates.batchOverview( manipulationsModel ).prop('outerHTML') )
    }
  }

  this.appendCorrespondingManipulations = function($rowClicked, manipulations){
    if ( $rowClicked.attr('revealed') === 'false'){
      $rowClicked.attr('revealed', 'true')
      $manipulationPanels = templates.manipulationPanels(manipulations) 
      $rowClicked.append($manipulationPanels)
      $manipulationPanels.slideDown('slow')
    }
    else {
      $rowClicked.attr('revealed', 'false')
      $rowClicked.find('#manipulationPanelWrap').slideUp('slow', function(){ $(this).remove() })
    }

  }
}



function ManipulationsModel(manipulation_data, batches_data, userModel){

  this.users = userModel.getUsers()
  this.usersByYear = userModel.getUsersByYear()

  var manipulations = manipulation_data
  this.getManipulations = function(){
    return manipulations
  }
  this.setManipulations = function(manipulation_data){
    manipulations = manipulation_data
  }

  var batches = batches_data
  this.getBatches = function(){
    return batches
  };
  this.setBatches = function(batches_data){
    batches = batches_data
  };


  this.getUsers = function(){
    return userModel.getUsers()
  }
  this.getUsersByYear = function(){
    return userModel.getUsersByYear()
  }



  this.perBatch = function(){
    var manipulationsPerBatch = groupByBatch(batches, manipulations)
    return manipulationsPerBatch
  };

  var groupByBatch = function(batches, manipulations){
    var manipulationsPerBatch = {};

    $.each(batches, function(index, batch){
      manipulationsPerBatch[batch.id] = [];
      $.each(manipulations, function(index, manipulation){
        if (batch.id === manipulation.batch_id ){
        manipulationsPerBatch[batch.id].push(manipulation)
        }
      })
    })

    return manipulationsPerBatch
  }



  this.perUser = function(){
    var manipulationsPerUser = groupByUser( userModel.getUsers(), manipulations )
    return manipulationsPerUser
  }; 
  var groupByUser = function(users, manipulations){
    var manipulationsPerUser = {};
    for (user_id in users){
      manipulationsPerUser[user_id] = [];
      $.each(manipulations, function(index, manipulation){
        if (user_id == manipulation.user_id ){
        manipulationsPerUser[user_id].push(manipulation)
        }
      })
    }
    return manipulationsPerUser
  } 


}

function UserModel(users, usersByYear){
  this.getUsers = function(){
    return users
  };
  this.getUsersByYear = function(){
    return usersByYear
  };    
}





function BatchEditController(manipulationsModel, view){

  var toggleTabMenu = function(){
    view.toggleTabMenu(this, manipulationsModel)
  };
  view.$tabMenu.on('click', '#users, #batches', toggleTabMenu )

  var undoBatch = function(){
    var $batchClicked = $(this).closest('.list-group-item')
    var batch_id = $batchClicked.attr('batch_id')
    console.log("batch id to delete:"+batch_id)
    $batchClicked.fadeOut('slow') // move this to view
    deleteBatchFromModel( batch_id )
    deleteBatchFromDB( batch_id )
  }
  view.getManipulationsMenu().on('click', 'li#undo_batch_button', undoBatch )

  var undoManipulation = function(){
    var $manipulationClicked= $(this)
    var manipulation_id = $manipulationClicked.attr('manipulation_id')
    console.log("manipulation id to delete:"+manipulation_id)
    $manipulationClicked.closest('.panel-default').fadeOut('slow') // move this to view
    deleteManipulationFromModel( manipulation_id )
    deleteManipulationFromDB( manipulation_id )
  }
  view.getManipulationsMenu().on('click', 'li#undo_manipulation_button', undoManipulation )


  var toggleRevealBatch = function(){
    if ($(event.target).hasClass('list-group-item')){
      var $batchClicked = $(this)
      var batch_id = $batchClicked.attr('batch_id')
      var manipulations = manipulationsModel.perBatch()[batch_id]
      view.appendCorrespondingManipulations($batchClicked, manipulations)
    }
  }
  view.getManipulationsMenu().on('click', '#batch-row', toggleRevealBatch )

  var toggleRevealUser = function(){
    if ($(event.target).hasClass('list-group-item')){
      var $userClicked = $(this)
      var user_id = $userClicked.attr('user_id')
      var manipulations = manipulationsModel.perUser()[user_id]
      view.appendCorrespondingManipulations($userClicked, manipulations)
    }
  }
  view.getManipulationsMenu().on('click', '#user-row', toggleRevealUser )

  var deleteManipulationFromModel = function(id){
    var manipulations = manipulationsModel.getManipulations()
    manipulations = jQuery.grep(manipulations, function(manipulation) {
      return manipulation.id == id;
    }, true);
    manipulationsModel.setManipulations(manipulations)
  }

  var deleteBatchFromModel = function(id){
    var batches = manipulationsModel.getBatches()
    batches = jQuery.grep(batches, function(batch) {
      return batch.id == id;
    }, true);

    manipulationsOfBatch = manipulationsModel.perBatch()[id]
    manipulationsModel.setBatches(batches)

    $.each(manipulationsOfBatch, function(index, manipulation){
      deleteManipulationFromModel(manipulation.id)
    })
  }



  var deleteManipulationFromDB = function(id){
    $.ajax({
      url: '/manipulations/'+id,
      type: 'DELETE',
      success: function(){
        console.log('Deleting done!')
      },
      error: function(){
        console.log('Unable to delete manipulation. Sorry man.')
      }
    });
  };

  var deleteBatchFromDB = function(id){
    $.ajax({
      url: '/batch/'+id,
      type: 'DELETE',
      success: function(){
        console.log('Deleting done!')
      },
      error: function(){
        console.log('Unable to delete manipulation. Sorry man.')
      }
    });
  };


};


var BatchEditControl = new BatchEditController( new ManipulationsModel(manipulations, batches, new UserModel(users, usersByYear) ), new BatchEditView( new EditManipulationsTemplates() ) );
})




