$(function () {
    setupClassSelectorHandler();
});

function setupClassSelectorHandler() {
    $("#main_sclass_selector").change(function () {
        $.ajax({
            type: "POST",
            url: "/sclasses/change_current",
            data: {sclass_id: $(this).val()},
            dataType: 'script',
            format: 'js'
        });
    });
}