/**
 * Inialize block foto default value
 */
$(".b-example-block__foto").ready(function () {
  $.each($(".b-example-block__foto"), function () {
    $imgUrl = $(this).find(':first-child').attr('href');
    $(this).css('background-image', 'url(' + $imgUrl + ')');
  })
});

/**
 * Handle mouseover and mouseout event.
 * mouseover - change background depending on the href
 * mouseout - reset to first child href
 */
$(".b-example-block__foto-cell")
  .mouseover(function () {
    $imgUrl = $(this).attr('href');
    $(this).parent().css('background-image', 'url(' + $imgUrl + ')');
  })
  .mouseout(function () {
    $imgUrl = $(this).parent().children().attr('href');
    $(this).parent().css('background-image', 'url(' + $imgUrl + ')');
  });