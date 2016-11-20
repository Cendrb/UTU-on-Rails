$(document).on("turbolinks:load", function () {
    var menuitems = $(".main_menu_item");
    menuitems.bind("mouseenter", function () {
        $(this).children().css("borderBottom", "1px solid white")
        $(this).children().animate({}, 1000);
    });
    menuitems.bind("mouseleave", function () {
        $(this).children().css("borderWidth", "0px")
        $(this).children().animate({}, 1000);
    });
});