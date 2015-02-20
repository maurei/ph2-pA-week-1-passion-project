$(document).ready(function() {
// "use strict";


function BatchEditView(templates){
  this.$undoButtons = $('li#undo_button')
  this.$tabMenu = $('#tabMenu')

  var $manipulationsMenu = $('#manipulations_menu')
  this.getManipulationsMenu = function(){
    return $manipulationsMenu;
  };

  this.toggleTabMenu = function(target, userModel, batchModel){
    var tabChoice = $(target).attr('id')
    $(target).siblings('li').removeClass('active')
    $(target).addClass('active')

    if (tabChoice === "users"){
      $manipulationsMenu.html( templates.userOverview( userModel ).prop('outerHTML') )
    }
    else if (tabChoice === "batches"){
      $manipulationsMenu.html( templates.batchOverview( batchModel ).prop('outerHTML') )
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
      $rowClicked.find('#manipulationPanelWrap').slideUp('slow')
    }

  }
}




function UserModel(users, manipulationsPerUser, usersByYear){
  this.getUsers = function(){
    return users
  };
  this.perUser = function(){
    return manipulationsPerUser
  };    
  this.getUsersByYear = function(){
    return usersByYear
  };  
}

function BatchModel(batches, manipulationsPerBatch){
  this.getBatches = function(){
    return users
  };
  this.perBatch = function(){
    return manipulationsPerBatch
  };
};





function BatchEditController(batchModel, userModel, view, manipulationsModel){

  var toggleTabMenu = function(){
    view.toggleTabMenu(this, userModel, batchModel)
  };
  view.$tabMenu.on('click', '#users, #batches', toggleTabMenu )

  var undoBatch = function(){
    var $batchClicked = $(this).closest('.list-group-item')
    var batch_id = $batchClicked.attr('batch_id')
    console.log("batch id to delete:"+batch_id)
    $batchClicked.fadeOut('slow')
  }
  view.getManipulationsMenu().on('click', 'li#undo_batch_button', undoBatch )

  var undoManipulation = function(){
    var $manipulationClicked= $(this)
    var manipulation_id = $manipulationClicked.attr('manipulation_id')
    console.log("manipulation id to delete:"+manipulation_id)
    $manipulationClicked.closest('.panel-default').fadeOut('slow')

  }
  view.getManipulationsMenu().on('click', 'li#undo_manipulation_button', undoManipulation )


  var toggleRevealBatch = function(){
      var $batchClicked = $(this)
      var batch_id = $batchClicked.attr('batch_id')
      var manipulations = batchModel.perBatch()[batch_id] // model of manipulations is not being updated when deleted. same for batches.
      view.appendCorrespondingManipulations($batchClicked, manipulations)
  }
  view.getManipulationsMenu().on('click', '#batch-row', toggleRevealBatch )

  var toggleRevealUser = function(){
    var $userClicked = $(this)
    var user_id = $userClicked.attr('user_id')
    var manipulations = userModel.perUser()[user_id]
    view.appendCorrespondingManipulations($userClicked, manipulations)
  }
  view.getManipulationsMenu().on('click', '#user-overview-panel', toggleRevealUser )


};

var BatchEditControl = new BatchEditController( new BatchModel(batches, manipulationsPerBatch), new UserModel(users, manipulationsPerUser, usersByYear), new BatchEditView( new EditManipulationsTemplates() ) );

})



