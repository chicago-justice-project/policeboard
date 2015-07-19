$().ready(function () {
  /* Search */
  $('#search-toggle').on('click touchstart', function(){
    $('#nav .search').toggle();
    return false;
  });
});