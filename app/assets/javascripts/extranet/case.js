$('#extranet-case-detail').ready(function () {
	//console.log("dom is ready");
	
	//initially hide the rule drop downs
	//$('select[name=rule_select]').hide();
	
	
	
	$('.remove_fields').on('click', function() {
	//console.log('Remove link called ' + $(this).attr('class'));
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
	
	//event for selecting a case rule to add
	$('select[name=rule_select]').on('change', function(){
		var $rule = $(this).find('option:selected');
		//console.log("rule_select changed to " + $rule.val() + "" + $rule.data('description'));
		
		//update the case rule code
		$rule.parent().closest('li').find('.rule_code').html($rule.val());
		//update the case rule description
		$rule.parent().closest('li').find('.rule_description').html($rule.data('description'));
		
		//update the case rule id hidden field
		$rule.parent().closest('li').find('input.rule_id').val($rule.val())
		
	});
	
	function add_fields(link, association, content) {  
	    var new_id = new Date().getTime();  
	    var regexp = new RegExp("new_" + association, "g");  
	    $(link).parent().before(content.replace(regexp, new_id));  
	};
	
	
	
});
