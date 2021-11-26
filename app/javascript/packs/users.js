var dt = require( 'datatables.net' )();
$('#admin-users-index').ready(function () {
	$('#users-list').DataTable({
    aoColumns: [
      { iDataSort: 0 }, //1: email
      null, //2: last sign in
	  null, //3: delete
    ],
    info: false,
    order: [[ 0, 'asc']],
    paging: false,
    searching: true
  });
});