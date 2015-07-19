$('#case-detail').ready(function () {
  $(".toggle-files").on('click touchstart', function(){
    $(".files").slideToggle();
    return false;
  });
  
  $("[class^='toggle-case-rule-counts']").on('click touchstart', function(){
    var target = $(this).attr('class').split('toggle-')[1];
    $("[class^='" + target + "']").slideToggle();
    return false;
  });
});
