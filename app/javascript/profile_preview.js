$(function(){
  $('#profile-image').change(function(){
      var file = $(this).prop('files')[0];
      var fileReader = new FileReader();
      fileReader.onloadend = function() {
          $('#preview').html('<img id="prof-photo" src="' + fileReader.result + '"/>');
          $('#prof-photo').addClass('resize-image');
      }
      fileReader.readAsDataURL(file);
  });
});