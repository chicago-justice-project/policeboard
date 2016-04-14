$('#extranet-case-detail').ready(function () {
  console.log("dom is ready");
  
  $('.remove_fields').on('click', function() {
	console.log('Remove link called ' + $(this).attr('class'));
	$(this).prev('input[type=hidden]').val("true");
	$(this).closest('.fields').hide();
    return false;
  });

});
