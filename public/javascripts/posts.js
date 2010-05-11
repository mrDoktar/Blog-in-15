$(function() {
  var $buttons = $("#all, #blogs");
  $buttons.click(function(){
    $buttons.removeClass("active");
    $(this).addClass("active");
    switch(this.id) {
      case "blogs":
        $("li.blog").slideDown("slow");
        $("li:not(.blog)").slideUp("slow");
      break;
      default:
        $("li.item").slideDown("slow");
      break;
    }
  });

});