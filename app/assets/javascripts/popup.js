popup = function (text, type) {
    var $body_element = $("#material_body_popup");
    var popup_class = "alert alert-" + type;
    var $popup_div = $("<div>", {class: popup_class});
    $popup_div.css("position", "absolute");
    $popup_div.css("top", 0);
    $popup_div.css("right", 0);
    $popup_div.append("<a href='#' class='close' data-dismiss='alert'>&times;</a>");
    var $text_span = $("<span>");
    $text_span.text(text);
    $text_span.css("padding-right", 8);
    $popup_div.append($text_span);
    $body_element.html($popup_div);
};