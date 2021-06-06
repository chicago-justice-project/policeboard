$('#home').ready(function () {

  $('#case-outcomes').DataTable({
    aaSorting: [[2, "desc"]], //disable initial sort
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

  $('.inlinesparkline').sparkline('html', {
      fillColor: "rgba(0, 0, 0, 0.1)",
      height: "38px",
      lineColor: "#666",
      lineWidth: 2,
      spotRadius: 0,
      width: "140px"
  });
});
