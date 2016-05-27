$('#extranet-board-member-detail').ready(function(){
 
  $(document).on('change', '#board_member_remove_image', function (){
     if(this.checked){
        console.log('remove image is checked');
        var $img = $(this).closest('.form-row').find('img');
        $img.hide();
        $this.hide(); 
     }
  });

}(jQuery);
