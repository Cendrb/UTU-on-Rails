KeyboardPhraseDetector = (function () {
    function KeyboardPhraseDetector() {
        $(document).keydown(function (e) {
            var i, len, phraseActionPair, ref, results;
            ref = KeyboardPhraseDetector.phrasesActionsArray;
            results = [];
            console.log(e.which);
            for (i = 0, len = ref.length; i < len; i++) {
                phraseActionPair = ref[i];
                console.log(phraseActionPair.keycodes);
                console.log(e.which == phraseActionPair.keycodes[phraseActionPair.current_index]);
                if (e.which == phraseActionPair.keycodes[phraseActionPair.current_index]) {
                    phraseActionPair.current_index += 1;
                } else {
                    phraseActionPair.current_index = 0;
                }
                if (phraseActionPair.current_index > (phraseActionPair.keycodes.length - 1)) {
                    results.push(phraseActionPair.action());
                } else {
                    results.push(void 0);
                }
            }
            return results;
        });
    }

    KeyboardPhraseDetector.phrasesActionsArray = [];

    KeyboardPhraseDetector.current_index = 0;

    KeyboardPhraseDetector.characters = {
        a: 65,
        b: 66,
        c: 67,
        d: 68,
        e: 69,
        f: 70,
        g: 71,
        h: 72,
        i: 73,
        j: 74,
        k: 75,
        l: 76,
        m: 77,
        n: 78,
        o: 79,
        p: 80,
        q: 81,
        r: 82,
        s: 83,
        t: 84,
        u: 85,
        v: 86,
        w: 87,
        x: 88,
        y: 89,
        z: 90
    };

    KeyboardPhraseDetector.prototype.addListener = function (charactersArray, action) {
        var character, i, index_sucks, keycodes_array, len;
        keycodes_array = [];
        for (index_sucks = i = 0, len = charactersArray.length; i < len; index_sucks = ++i) {
            character = charactersArray[index_sucks];
            if (KeyboardPhraseDetector.characters[character] != undefined) {
                keycodes_array[index_sucks] = KeyboardPhraseDetector.characters[character];
            } else {
                keycodes_array[index_sucks] = character;
            }
        }
        KeyboardPhraseDetector.phrasesActionsArray[KeyboardPhraseDetector.current_index] = {
            keycodes: keycodes_array,
            action: action,
            current_index: 0
        };
        return KeyboardPhraseDetector.current_index += 1;
    };

    return KeyboardPhraseDetector;

})();

setPersistentCookie = function (name, value) {
    var expiration_date = new Date();
    var cookie_string = '';
    expiration_date.setFullYear(expiration_date.getFullYear() + 1);
    cookie_string = name + "=" + value + "; path=/; expires=" + expiration_date.toGMTString();
    document.cookie = cookie_string;
};

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
    }
    return "";
}

var zrsa_audio = new Audio('http://adis.g6.cz/johncena/zrsa.mp3');
var hehou_audio = new Audio('http://adis.g6.cz/johncena/hehou.mp3');
var john_cena_audio = new Audio('http://adis.g6.cz/johncena/john-cena.mp3');
var john_cena_string = "<img src=\"http://adis.g6.cz/johncena/john-cena.jpg\" width=\"1920\" height=\"1080\" class=\"john_cena\">";
var traitor_audio = new Audio('http://adis.g6.cz/johncena/traitor.mp3');
var material_container = $("#material_container");
var john_cena_summoned = false;

function playZrsa(e) {
    zrsa_copy = zrsa_audio.cloneNode(true);
    zrsa_copy.volume = 0.6;
    zrsa_copy.play();
}

function playHehou(e) {
    hehou_copy = hehou_audio.cloneNode(true);
    hehou_copy.volume = 0.8;
    hehou_copy.play();
}

function setZrsaListener() {
    $(document).keydown(playZrsa);
    $(document).click(playHehou);
}

function setTraitorListener() {
    $("a").click(function () {
        traitor_audio.cloneNode(true).play();
        $(".traitor").show();
        material_container.hide();
        setTimeout(function () {
            $(".traitor").hide();
        }, 200);
    });
}

var keyboardPhraseDetector;
keyboardPhraseDetector = new KeyboardPhraseDetector();
keyboardPhraseDetector.addListener(['k', 'a', 'n', 'a'], function () {
    john_cena_audio.cloneNode(true).play();
    if (!john_cena_summoned) {
        $("body").append(john_cena_string);
        john_cena_summoned = true;
    }
    setTimeout(function () {
        $(".john_cena").show();
        material_container.hide();
    }, 750);
});
keyboardPhraseDetector.addListener([20, 20, 20, 'z', 'r', 's', 'a', 20, 20, 20], function () {
    if (getCookie('zrsa') == 'true') {
        setPersistentCookie('zrsa', false);
        alert('ZRSA DISABLED');
    }
    else {
        setPersistentCookie('zrsa', true);
        setZrsaListener();
        alert('ZRSA ENABLED');
    }
});
keyboardPhraseDetector.addListener(['t', 'r', 'a', 'i', 't', 'o', 'r'], function () {
    if (getCookie('traitor') == 'true') {
        setPersistentCookie('traitor', false);
        alert('TRAITOR DISABLED');
    }
    else {
        setPersistentCookie('traitor', true);
        setTraitorListener();
        alert('TRAITOR ENABLED');
    }
});

if (getCookie('zrsa') == 'true')
    setZrsaListener();

$(document).ready(function () {
    if (getCookie('traitor') == 'true')
        setTraitorListener();

    var base_height = window.innerHeight;
    var base_width = window.innerWidth;

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
    var cena_travel_time = 5;
    var playing = false;
    flying_cena.click(function () {
        current_angle = current_angle + 420;
        flying_cena.css('transform', 'rotate(' + current_angle + 'deg)');

        var topcena = (Math.random()) * window.innerHeight - 75;
        var leftcena = (Math.random()) * window.innerWidth - 75;
        console.log("top: " + topcena + " left: " + leftcena);
        console.log("window.innerHeight: " + window.innerHeight + " window.innerWidth: " + window.innerWidth);

        flying_cena.css('top', topcena);
        flying_cena.css('left', leftcena);
        score_achieved = score_achieved + 1;
        cena_score_div.html('SCORE ' + score_achieved);
        milis_remaining = milis_remaining + (2000 - 100 * Math.log(milis_passed));

        if (!playing) {
            playing = true;
            milis_remaining = 5000;
            cena_time_div.show();
            cena_score_div.show();
            cena_travel_time = 5 - Math.log10(milis_passed / 10);
            flying_cena.css('transition', "all 0." + cena_travel_time + "s ease-in-out")
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