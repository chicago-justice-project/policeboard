$('#extranet-case-detail').ready(function () {

  console.log("Extranet case detail starting which I just modified just now.  What happens?")

  $('.remove-link').click(function(link) {
	$(link).previous('input[type=hidden]').value = "1";
	$(link).up('.fields').hide();
    return false;
  });

});
