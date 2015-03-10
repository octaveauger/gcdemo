// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('#merchant_logo, #merchant_product_image').bind('change', function() {
  size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert('Maximum file size is 5MB. Please choose a smaller file.');
  }
});