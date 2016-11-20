$(document).on("turbolinks:load", function () {
    var entries_div = $("#planned_raking_entries_div");
    $("#round_selector").change(function () {
        if (entries_div.data("admin") == 1)
            $.ajax({
            type: "GET",
            url: "/planned_raking_lists/admin_show/" + entries_div.data("id"),
            data: { raking_round_number: $(this).val() },
            dataType: 'script',
            format: 'js'
        });
        else
            $.ajax({
                type: "GET",
                url: "/planned_raking_lists/" + entries_div.data("id"),
                data: { raking_round_number: $(this).val() },
                dataType: 'script',
                format: 'js'
            });
    });
});