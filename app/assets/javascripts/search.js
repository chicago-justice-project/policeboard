$().ready(function () {
  /* Search */
  $('#search-toggle').on('click touchstart', function(){
    $('#search').toggle();
    return false;
  });
});