$('#case-detail').ready(function () {
  $("[class^='toggle-case-rule-counts']").on('click touchstart', function(){
    var target = $(this).attr('class').split('toggle-')[1];
    $("[class^='" + target + "']").slideToggle();
    return false;
  });
});
