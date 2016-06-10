$('#extranet-case-detail').ready(function () {
	
	$(document).on('click', '.remove_fields', function() {
		//console.log('Remove link called ' + $(this).attr('class'));
		//console.log($(this).closest('.fields').find('input[type=hidden][id$="_destroy"]'));
		$(this).closest('.fields').find('input[type=hidden][id$="_destroy"]').val("true");
		$(this).closest('.fields').hide();
		return false;
	});
	
	$(document).on('click', '.add_fields', function(){
		var association = $(this).data('association');
		var new_id = new Date().getTime();  
	    var regexp = new RegExp("new_" + association, "g");  
		$(this).parent().before($(this).data('fields').replace(regexp, new_id));
	
		//($(this)) is the add_fields link and the form to be added is it's previous sibling
		// will append this form to the correct form group
		
		var $form = $(this).prev('.fields');
	
		//if adding a new case rule, there's more work to be done to the fields
		if (association == "case_rule_counts"){
			console.log("calling init case rules form " + new_id);  
			$form.appendTo('.violated-rules');
			initCaseRuleForm(new_id);
		}
	
		//if this is adding a new board
		if (association == "board_member_votes"){
			//console.log("calling init boardmember vote form " + new_id);  
			//$form.appendTo('.board-member-votes');
			initBoardMemberVoteForm(new_id);
		}
		return false;
	});
	
	
	//case rules
	var initCaseRuleForm = function(new_id)
	{
		var id = 'case_case_rules_attributes_' + new_id + '_rule_id';
		var $newItem = $('.violated-rules input[id=' + id + ']').parent('.case-rule-fields');
		if ($newItem){
			$newItem.find('.rule_selection').show();
		}
		return false;
	};
	
	//event for selecting a case rule to add
	$('.violated-rules').on('change', '.case-rule-fields select[name=rule_select]', function(){
		var $rule = $(this).find('option:selected');
		
		//update the case rule code
		$rule.parent().closest('.case-rule-fields').find('.rule_code').html($rule.val());
		//update the case rule description
		$rule.parent().closest('.case-rule-fields').find('.rule_description').html($rule.data('description'));
		
		//update the case rule id hidden field
		$rule.parent().closest('.case-rule-fields').find('input.rule_id').val($rule.val())
		
	});
	
	//board member voting
	//show dissent reason text box when dissent is selected;
	$(document).on('change', 'input[type="radio"][name$="[vote_id]"]', function(){
		toggleDissent($(this));
	});
	
	var toggleDissent = function($element){
		var $tbDissent = $($element.closest('.board-member-votes-fields').find('.dissent-detail'));
		if ($tbDissent)
		{
			var vote = $('label[for='+ $element.attr('id')+']').text();
			var showOrHide = vote === "Dissent";
			$tbDissent.toggle(showOrHide);
		}
	};
	
	
	
	//$('.board-member-votes .dissent-description').first().closest('.board-members-vote-fields').find('.board-member-votes-options')
	//hide all dissent description boxes
	$('.dissent-description').each(function(index, value){
		//get the radio button for the vote
		var $rbVote = $(this).closest('.board-member-votes-fields').find('input:radio:checked');
		if ($rbVote){
			toggleDissent($($rbVote));
		}
	});	
	
	//board member add
	$('.board-member-votes').on('change', '.board-member-votes-fields select[name=board_select]', function(){
		//this is the select element
		//board is the selected option
		var $selectedBoard = $(this).find('option:selected');
		var boardName = $selectedBoard.text();
		var boardId = $selectedBoard.val();
                alert(boardId);		
		//update the board name
		$selectedBoard
			.closest('.board-member-votes-fields')
			.find('.board-member-votes-name')
			.html(boardName);
		
		//updated the hidden board member id
		$selectedBoard
			.closest('.board-member-votes-fields')
			.find('input[type=hidden][id^=case_board_member_votes]')
			.val(boardId);
		
	});
	
	var initBoardMemberVoteForm = function(new_id)
	{
		//initial display of the add board form, show drop down to select a board and hide the dissent descriptio
		
		var id = 'case_board_member_votes_attributes_' + new_id + '_board_member_id';

		var $newItem = $('.board-member-votes select[id=' + id + ']');
		if ($newItem){
		  $newItem.closest('.board-selection').show();
		}
		return false;
	};
});
