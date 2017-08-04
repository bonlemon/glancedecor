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
		modal.toggleClass("b-modal--closed");
		modalOverlay.toggleClass("b-modal__overlay--closed");
		$('body').addClass('overflowhide');
	});

	$(".b-tab__calculation").on("click", function(event) {
		var imgBlock = $(this).parent().parent().find(".b-tab__img");
		var imgBlockPongs = $(this).parent().parent().find(".b-tab__img-pongs");

		if ( imgBlock.hasClass('b-tab__img--hidden') ){
			imgBlock.removeClass('b-tab__img--hidden');
			imgBlockPongs.removeClass('b-tab__img-pongs--hidden');
		} else {
			imgBlock.addClass('b-tab__img--hidden');
			imgBlockPongs.addClass('b-tab__img-pongs--hidden');
		}
	});

	$("#confirm").on('change', function(){
		if ( $("#confirm").prop("checked") ){
			$('.b-mail__submit').prop('disabled',false);
		}else{
			$('.b-mail__submit').prop('disabled',true);
		}	
	})
});