$(function () {
    var material_container = $("#material_container");

    var base_height = window.innerHeight;
    var base_width = window.innerWidth;

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
    if (material_container.data("experimental")) {
        var kej = new Audio("http://adis.g6.cz/johncena/aclick.mp3");
        $("a").click(function () {
            kej.play();
        });
    }

    // summon flying_cena on 10 clicks on material_header
    var header_clicked = 0;
    var header_target_clicks = 10;
    var flying_cena = $(".flying_cena");
    $("#material_header").click(function () {
        header_clicked = header_clicked + 1;
        if (header_clicked >= header_target_clicks) {
            flying_cena.show();
            header_clicked = 0;
        }
    });
    var current_angle = 0;
    var cena_score_div = $("#cena_score");
    var cena_time_div = $("#cena_time");
    var milis_remaining = 0;
    var milis_passed = 0;
    var score_achieved = 0;
    var playing = false;
    flying_cena.click(function () {
        current_angle = current_angle + 420;
        flying_cena.css('transform', 'rotate(' + current_angle + 'deg)');

        var topcena = Math.random() * window.innerHeight;
        var leftcena = Math.random() * window.innerWidth;
        flying_cena.css('top', topcena);
        flying_cena.css('left', leftcena);
        score_achieved = score_achieved + 1;
        cena_score_div.html('SCORE ' + score_achieved);
        milis_remaining = milis_remaining + (5000 / Math.log10(milis_passed));

        if (!playing) {
            playing = true;
            milis_remaining = 5000;
            cena_time_div.show();
            cena_score_div.show();
            var timer = window.setInterval(function () {
                milis_remaining = milis_remaining - 10;
                milis_passed = milis_passed + 10;
                cena_time_div.html(milis_remaining);

                if (milis_remaining <= 0) {
                    cena_score_div.hide();
                    cena_time_div.hide();
                    flying_cena.hide();
                    score_achieved = 0;
                    milis_passed = 0;
                    playing = false;
                    window.clearInterval(timer);
                }
            }, 10);
        }
    });
});