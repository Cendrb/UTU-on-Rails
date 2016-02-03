$(function () {
    // john cena when "kana"
    var john_cena = new Audio('http://adis.g6.cz/johncena/john-cena.mp3');
    var maximum_index = 3;
    var pattern = [107, 97, 110, 97];
    var current_index = 0;
    var john_cena_string = "<img src=\"http://adis.g6.cz/johncena/john-cena.jpg\" width=\"1920\" height=\"1080\" class=\"john_cena\">";
    var john_cena_summoned = false;
    $(document).keypress(function (e) {
        if (e.which == pattern[current_index]) {
            current_index = current_index + 1;
            if (current_index > maximum_index) {
                john_cena.cloneNode(true).play();
                if (!john_cena_summoned) {
                    $("body").append(john_cena_string);
                    john_cena_summoned = true;
                }
                setTimeout(function () {
                    $(".john_cena").show();
                    $("#material_container").hide();
                }, 800);
            }
        }
        else
            current_index = 0;
    });

    // kej sound when "a" clicked - experimental must be enabled
    if ($("#material_container").data("experimental")) {
        var kej = new Audio("http://adis.g6.cz/johncena/aclick.mp3");
        $("a").click(function () {
            kej.play();
        });
    }

    // summon flying_cena on 10 clicks on material_header
    var header_clicked = 0;
    var header_target_clicks = 10;
    $("#material_header").click(function () {
        header_clicked = header_clicked + 1;
        if (header_clicked >= header_target_clicks) {

        }
    });
});