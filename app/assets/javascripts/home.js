$('#home').ready(function () {

  $('#case-outcomes').DataTable({
    aaSorting: [2], //disable initial sort
    aoColumns: [
      { bVisible: false }, //0: hidden cases total for sorting
      null, //1: recommendation -> decision
      { iDataSort: 0 }, //2: cases
      { bSortable: false }, //3: annual trend sparkline
      { bSortable: false } //4: annual trend barchart
    ],
    info: false,
    paging: false,
    searching: false
  });

});
