var dt = require( 'datatables.net' )();
$('#rules-index').ready(function () {

  $('#rules-list').DataTable({
    aoColumns: [
      { bVisible: false }, //0: hidden rule # for sorting
      { iDataSort: 0 }, //1: rule
      null, //2: description
      { iDataSort: 4 }, //3: cases stat
      { bVisible: false }, //4: hidden cases stat for sorting
      { bSortable: false } //5: cases barchart
    ],
    info: false,
    order: [[ 1, 'asc']],
    paging: false,
    searching: false
  });

  $('.toggle-special-comment').on('click touchstart', function(){
    var verb = $(this).find('.verb').text();
    $(this).find('.verb').text(verb === 'Show' ? 'Hide' : 'Show');
    $(this).parent().children('.special-comment-div').slideToggle();
    return false;
  });
});