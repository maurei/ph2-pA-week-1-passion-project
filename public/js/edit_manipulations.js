$(document).ready(function() {
// "use strict";


function BatchEditView(templates){

  this.$tabMenu = $('#tabMenu')

  var $manipulationsMenu = $('#manipulations_menu')
  var getManipulationsMenu = function(){
    return $manipulationsMenu;
  };

  this.toggleTabMenu = function(){
    var tabChoice = $(this).attr('id')
    $(this).siblings('li').removeClass('active')
    $(this).addClass('active')

    if (tabChoice === "users"){
      $manipulationsMenu.html( templates.userOverview() )

    }
    else if (tabChoice === "batches"){
      $manipulationsMenu.html( templates.batchOverview() )
    }

  }

  // this.render = function(model, userModel){
  // };

}

function UserModel(){
}

function BatchModel(){
}


function BatchEditController(batchModel, userModel, view){
  var generate = function(){
    view.render(batchModel, userModel);
  };


  view.$tabMenu.on('click', '#users, #batches', view.toggleTabMenu )

};

var BatchEditControl = new BatchEditController( new BatchModel(), new UserModel(), new BatchEditView(new EditManipulationsTemplates) );

})



