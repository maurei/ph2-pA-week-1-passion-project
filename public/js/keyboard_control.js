$(document).ready(function() {

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
    };

    this.focusFirstField = function(){
      this.allFields().eq(0).focus()
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
    
    // setTimeout(function() {
    //   console.log("tried to set focus")
    //   view.focusFirstField()
    // }, 1500);
   // view.focusFirstField()
   // trigger view.focusFirstField() once in either checkKey or row generator

    view.$container.on('keydown', view.getSelectorTypes(), checkKey)
  };


  var keyBoardControl = new keyBoardController(new keyBoardViewer())



})



