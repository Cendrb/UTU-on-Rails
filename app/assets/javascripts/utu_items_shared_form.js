$(function() {
    $(".new_additional_info").submit(function() {
        $(".new_additional_info").find("input[type=text], input[type=url], textarea").val("");
    });
});