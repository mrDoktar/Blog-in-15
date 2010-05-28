$(function() {
  var allow_load_posts = true;
  var loading_posts    = false;

  var $selectors = $(".selector");
  $selectors.click(function(){
    $selectors.removeClass("active");
    $active_selector = $(this);
    $active_selector.addClass("active");
    var extra = "";
    if($active_selector.attr("data-type") == "user") 
      extra = "&user=" + $active_selector.attr("data-id");
    else if($active_selector.attr("data-type") == "status")
      extra = "&status=" + $active_selector.attr("data-id");
    
    $("li.post").remove();
    $("#loading_post").addClass("normal_position").show();
    $("#posts").css("top", "0px");
  
    allow_load_posts = true;
    $.get("/admin/posts", "list=true" + extra, function(data) {
      $("#loading_post").hide().removeClass("normal_position");
      if(data == " ")
        allow_load_posts = false;
      else {
        $("#loading_post").before(data);
      }
    });
  });
});