var dt = require( 'datatables.net' )();
$('body').ready(function () {

  $('.voting-history').DataTable({
    aaSorting: [[0, "asc"]], //disable initial sort
    aoColumns: [
      { bVisible: false }, //0: hidden board member name for sorting
      null, //1: photo
      { iDataSort: 0 }, //2: board member
      null, //3: agreed
      null, //4: disagreed
      null, //5: did not vote
      { bSortable: false } //6: voting chart
    ],
    info: false,
    paging: false,
    searching: false
  });
  
});
