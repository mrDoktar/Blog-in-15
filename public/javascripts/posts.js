$(function() {
  var $buttons = $("#all, #martin, #mikael, #patrik");
  $buttons.click(function(){
    $buttons.removeClass("active");
    $(this).addClass("active");
    if(this.id == "all") {
      $("li.post").slideDown("slow");
    }
    else {
      $("li." + this.id).slideDown("slow");
      $("li:not(." + this.id + ")").slideUp("slow");
    }
  });
  
  $('#posts').jScrollPane();  

});