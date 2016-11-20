$(document).on("turbolinks:load", function () {
    var data_element = $(".generic_utu_partial_data");
    var item_id = data_element.data("item_id");
    var item_type = data_element.data("item_type");
    $(".generic_utu_partial_subject_select").change(function () {
        $(".generic_utu_partial_additional_infos_list").html("Načítání...");
        $.ajax({
            type: "GET",
            url: "/additional_infos",
            data: {
                target: ".generic_utu_partial_additional_infos_list",
                subject_id: $(this).val(),
                source: "form",
                item_id: item_id,
                item_type: item_type
            },
            dataType: 'script',
            format: 'js',
            error: function () {
                $(".generic_utu_partial_additional_infos_list").html("Došlo k chybě");
            }
        });
    });
});