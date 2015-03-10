// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	// Prepopulate holder name
	$('#customer_given_name, #customer_family_name').bind('change', function(e) {
	  $('#customer_holder_name').val($('#customer_given_name').val() + ' ' + $('#customer_family_name').val());
	});

	// Hide / show elements based on country
	$('#customer_country_code').bind('change', function(e) {
	  if($(this).val() == 'GB') toggle_bacs_footer(true);
	  else toggle_bacs_footer(false);
	  customise_local_bank_details($(this).val());
	}).change();

	// Hide / display the BACS footer
	function toggle_bacs_footer(action) {
	  if(action === true) $('#bacs-compliance').removeClass('hide');
	  else $('#bacs-compliance').addClass('hide');
	}

	// Show the right local bank details based on the country
	function customise_local_bank_details(country_code) {
		if(country_code == 'GB') {
			$('.customer_bank_accounts_account_number').removeClass('hide');
			$('.customer_bank_accounts_bank_code').addClass('hide');
			$('.customer_bank_accounts_branch_code').removeClass('hide').find('label').text('Sort code');
			$('#show-local-bank-details').click();
		}
		else {
			$('#show-international-bank-details').click();
			if(country_code == 'FR') {
				$('.customer_bank_accounts_account_number').removeClass('hide');
				$('.customer_bank_accounts_bank_code').removeClass('hide');
				$('.customer_bank_accounts_branch_code').removeClass('hide').find('label').text('Branch code');
			}
			else if(country_code == 'BE') {
				$('.customer_bank_accounts_account_number').removeClass('hide');
				$('.customer_bank_accounts_bank_code').addClass('hide');
				$('.customer_bank_accounts_branch_code').addClass('hide').find('label').text('Branch code');
			}
			else if(country_code == 'DE') {
				$('.customer_bank_accounts_account_number').removeClass('hide');
				$('.customer_bank_accounts_bank_code').removeClass('hide');
				$('.customer_bank_accounts_branch_code').addClass('hide').find('label').text('Branch code');
			}
			else if(country_code == 'ES') {
				$('.customer_bank_accounts_account_number').removeClass('hide');
				$('.customer_bank_accounts_bank_code').removeClass('hide');
				$('.customer_bank_accounts_branch_code').removeClass('hide').find('label').text('Branch code');
			}
			else if(country_code == 'IT') {
				$('.customer_bank_accounts_account_number').removeClass('hide');
				$('.customer_bank_accounts_bank_code').removeClass('hide');
				$('.customer_bank_accounts_branch_code').removeClass('hide').find('label').text('Branch code');
			}
			else if(country_code == 'NL') {
				$('.customer_bank_accounts_account_number').removeClass('hide');
				$('.customer_bank_accounts_bank_code').removeClass('hide');
				$('.customer_bank_accounts_branch_code').addClass('hide').find('label').text('Branch code');
			}
		}
	}

	// Decide whether local details or international details should be shown at page load
	if($('#customer_bank_accounts_attributes_0_iban').val() == '') {
		if($('#customer_bank_accounts_attributes_0_account_number').val() != '' || $('#customer_bank_accounts_attributes_0_bank_code').val() != '' || $('#customer_bank_accounts_attributes_0_branch_code').val() != '') {
			$('#show-local-bank-details').click();
		}
	}
});