$('#board-index').ready(function () {

  $('#current-board-list').DataTable({
    aaSorting: [], //disable initial sort
    aoColumns: [
      { bVisible: false }, //0: hidden board member name for sorting
      { iDataSort: 0 }, //1: board member
      null, //2: agreed
      null, //3: disagreed
      null, //4: did not vote
      { bSortable: false } //5: voting chart
    ],
    info: false,
    paging: false,
    searching: false
  });

  $('#past-board-list').DataTable({
    aaSorting: [], //disable initial sort
    aoColumns: [
      { bVisible: false }, //0: hidden board member name for sorting
      { iDataSort: 0 }, //1: board member
      null, //2: agreed
      null, //3: disagreed
      null, //4: did not vote
      { bSortable: false } //5: voting chart
    ],
    info: false,
    paging: false,
    searching: false
  });
});