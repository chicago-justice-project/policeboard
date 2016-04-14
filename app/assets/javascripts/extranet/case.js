$('#extranet-case-detail').ready(function () {
  console.log("dom is ready");
  
  $('.remove_fields').on('click', function() {
	console.log('Remove link called ' + $(this).attr('class'));
	$(this).prev('input[type=hidden]').val("true");
	$(this).closest('.fields').hide();
    return false;
  });

  
  
  $('.add_fields').on('click', function(){
  	time = new Date().getTime()
  	regexp = new RegExp($(this).data('id'), 'g')
  	$(this).before($(this).data('fields').replace(regexp, time))
  	return false;
  });
  
  
	function add_fields(link, association, content) {  
	    var new_id = new Date().getTime();  
	    var regexp = new RegExp("new_" + association, "g");  
	    $(link).parent().before(content.replace(regexp, new_id));  
	}
	
	
});
