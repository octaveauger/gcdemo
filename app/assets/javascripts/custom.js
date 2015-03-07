$(function() {

	$('[data-role="toggle"]').click(function(e) {
		e.preventDefault();
		$(this).parents('[data-role="container"]').addClass('hide');
		$('#'+$(this).attr('data-target')).removeClass('hide');
	});

});