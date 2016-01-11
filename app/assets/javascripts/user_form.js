$(function() {
    $(".user_form_class_select").change(function() {
        $.ajax({
            type: "POST",
            url: "/users/class_select_changed",
            data: { sclass_id: $(this).val() },
            dataType: 'script',
            format: 'js'
        });
    });
});

