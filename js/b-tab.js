// Checking whether document is ready
$(document).ready(function () {

    // Handle click on link
    $(".b-tab__link").on('click', function (event) {
        var linkUrl = $(this).children('a').attr('href');

        // Show/Hide tabs
        // .siblings() - находит соседей элемента и скрывает их
        $(".b-tab " + linkUrl).show().siblings().hide();

        // Change current tab to active
        $(this).addClass('b-tab__link_active').siblings().removeClass('b-tab__link_active');

        event.preventDefault();
    })
});