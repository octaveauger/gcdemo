$(function() {

  	// Turns on Bootstap tooltips for the application
  	$('[data-toggle="tooltip"]').tooltip();

  	// Toggles show / hide for the target element and its parent container element
	$('[data-role="toggle"]').click(function(e) {
		e.preventDefault();
		$(this).parents('[data-role="container"]').addClass('hide');
		$('#'+$(this).attr('data-target')).removeClass('hide');
	});

});