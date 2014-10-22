var ready;
ready = function() {

  function trace() {for(var i = 0, count = arguments.length; i < count; i++){console.log(arguments[i]);}};
  
  if ($(".notice.notification").html().match(/[\w]+/) != null) {
    $("p.notice.notification").addClass('active').css('display', 'block');
    setTimeout(function(){
      $("p.notice.notification").animate({
        opacity: 0
      },1000,function(){
        $("p.notice.notification").css('display','none');
      });
    },4000);
  } 
  else if($(".alert.notification").html().match(/[\w]+/) != null) {
    $("p.alert.notification").addClass('active').css('display', 'block');
    setTimeout(function(){
      $("p.alert.notification").animate({
        opacity: 0
      }, 1000, function(){
        $("p.alert.notification").css('display','none');
      });
    },4000);
  }
  else {
    $("p.notice.notification").removeClass('active') ;
  }


  /*
  //this is for the sliding menu up and down
  var type = $('li a').each(function(){
    if((this).getAttribute('data-type') == "unit")
      $(this).click(function(){
        var checkElement = $(this).next();
          if(checkElement.is(':visible')) checkElement.slideUp(250);
          else checkElement.slideDown(250);
      });
  })


  */
};

$(document).ready(ready);
$(document).on('page:load', ready);