$(function () {
    $("#planned_raking_entry_planned_raking_list_id").change(function () {
        $("#planned_raking_entry_raking_round_id").replaceWith("<div id=\"planned_raking_entry_raking_round_id\">Probíhá získávání kol pro tento seznam...</div>");
        $.ajax({
            type: "POST",
            url: "raking_rounds/for_planned_raking_list.js",
            data: {planned_raking_list_id: $(this).val()},
            dataType: 'script',
            format: 'js'
        });
    });
});