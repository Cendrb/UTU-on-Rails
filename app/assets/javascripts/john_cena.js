$(function () {
    var maximum_index = 3;
    var pattern = [107, 97, 110, 97];
    var current_index = 0;
    $(document).keypress(function (e) {
        if (e.which == pattern[current_index]) {
            current_index = current_index + 1;
            if (current_index > maximum_index) {
                wwe();
                reset();
            }
        }
        else
            reset();
    });

    function reset() {
        current_index = 0;
    }

    function wwe() {
        var audio = new Audio('http://adis.g6.cz/johncena/john-cena.mp3');
        audio.play();
        setTimeout(function(){
          $(".john_cena").show();
        }, 800);
    }
    
    if($("#material_container").data("experimental"))
      $("a").click(function () 
      {
        var kej = new Audio("http://adis.g6.cz/johncena/aclick.mp3");
        kej.play();
      });
});