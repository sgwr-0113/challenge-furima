$(function(){
  $('#new-address-btn').click(function(){
      $('.shipping-address-form').attr('style', 'display:block');
      $(this).attr('style', 'display:none')
      $('#registered-address').remove();
  });
});