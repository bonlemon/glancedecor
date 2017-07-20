$(document).ready(function () {

	// Slider
	$('.b-sld').slick({
		autoplay: true,
		dots: true,
		arrows: true,
		autoplaySpeed: 2000,
	});


	// Modal
	var modal = $("#modal");
	var modalOverlay = $("#modal-overlay");

	$(".b-modal__close").on("click", function() {
		console.log('close')
		modal.toggleClass("b-modal--closed");
		modalOverlay.toggleClass("b-modal__overlay--closed");
		$('body').removeClass('overflowhide');
	});

	$(".b-modal__open").on("click", function(event) {
		console.log('open')
		// if( event.target.hasClass('mail') ) {
		// 	alert('mail.')
		// }
		modal.toggleClass("b-modal--closed");
		modalOverlay.toggleClass("b-modal__overlay--closed");
		$('body').addClass('overflowhide');
	});
	
});