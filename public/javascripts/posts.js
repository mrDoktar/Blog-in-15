$(function() {
  var allow_load_posts = true;
  var loading_posts    = false;


  loadPosts = function() {
    if(loading_posts || allow_load_posts == false) {
      loading_posts = false;
      return;
    }
    else {
      $("#loading_post").show();
      loading_posts = true;
    }

    var currently_loaded_posts = $("li.post").size()
    $selector = $(".selector.active");
    var extra = "";
    if($selector.attr("data-type") == "user") 
      extra = "&user=" + $selector.attr("data-id");
    else if($selector.attr("data-type") == "tag")
      extra = "&tag=" + $selector.attr("data-id");
      
    $.get("/posts", "list=true&offset=" + currently_loaded_posts + extra, function(data) {
      $("#loading_post").hide();
      if(data == " ")
        allow_load_posts = false;
      else {
        $("#loading_post").before(data);
        $("#posts").jScrollPane({reload: true, callbackOnBottom: loadPosts});
      }
      loading_posts = false;
    }); 
  }


  var $selectors = $(".selector");
  $selectors.click(function(){
    $selectors.removeClass("active");
    $active_selector = $(this);
    $active_selector.addClass("active");
    var extra = "";
    if($active_selector.attr("data-type") == "user") 
      extra = "&user=" + $active_selector.attr("data-id");
    else if($active_selector.attr("data-type") == "tag")
      extra = "&tag=" + $active_selector.attr("data-id");
      
    $("li.post").remove();
    $("#loading_post").addClass("normal_position").show();
    $(".jScrollPaneDrag").css("top", "0px");
    $("#posts").css("top", "0px");
    
    allow_load_posts = true;
    $.get("/posts", "list=true" + extra, function(data) {
      if(data == " ")
        allow_load_posts = false;
      else {
        $("#loading_post").before(data);
        $("#loading_post").hide().removeClass("normal_position");
        if($("li.post").size() < 7) {
          $("#posts").css("height", "auto");
          $(".jScrollPaneContainer").height($("#posts").height());
        }
        else 
          $("#posts, .jScrollPaneContainer").css("height", "48.58em");
        $("#posts").jScrollPane({reload: true, callbackOnBottom: loadPosts, maintainPosition: false});
      }
    });
  });
  

  $('#posts').jScrollPane({callbackOnBottom: loadPosts});  

});