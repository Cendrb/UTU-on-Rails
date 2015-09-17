$(function () {
    $("#planned_raking_entries_sortable").sortable(
        {
            update: function (event, ui) {
                $("#planned_raking_list_status").text("Ukládání...");
                $.ajax({
                    type: "POST",
                    url: "/planned_raking_entries/sort",
                    data: {
                        data: $("#planned_raking_entries_sortable").children().map(function (i, v) {
                            return [[i, $(this).data("entry-id")]]
                        }).toArray()
                    },
                    dataType: 'script',
                    format: 'js',
                    success: function (msg) {
                        $("#planned_raking_list_status").text("Všechny změny uloženy");
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        $("#planned_raking_list_status").text("Došlo k chybě");
                    }
                });
            }
        }
    );
});