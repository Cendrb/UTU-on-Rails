$(function () {
    $(".additional_infos_subject_select").change(function () {
        $("#additional_infos_index_placeholder").html("Načítání...");
        $.ajax({
            type: "GET",
            url: "/additional_infos",
            data: {target: "#additional_infos_index_placeholder", subject_id: $(this).val()},
            dataType: 'script',
            format: 'js',
            error: function () {
                $("#additional_infos_index_placeholder").html("Došlo k chybě");
            }
        });
    });
});