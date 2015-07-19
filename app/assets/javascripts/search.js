$().ready(function () {
  /* Search */
  $('#search-toggle').on('click touchstart', function(){
    $('#search-form').toggle();
    return false;
  });
});