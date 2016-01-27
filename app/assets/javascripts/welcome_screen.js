var mode = "dick"

$(function () {
    $("#sclass_select").change(function () {
        document.cookie = "sclass_id=" + $(this).val();
        $("#welcome_screen_class_saved_section").show();

        if (mode == "register")
            $("#welcome_screen_form_placeholder").html("<p>Načítání...</p>");
        $.ajax({
            type: "POST",
            url: "/sclasses/change_current",
            data: {sclass_id: $(this).val()},
            dataType: 'script',
            format: 'js',
            success: function () {
                if (mode == "register")
                    fetchRegisterForm();
            }
        });
    });
    $(".welcome_screen_register_button").click(function () {
        mode = "register";
        $("#welcome_screen_form_heading").html("Registrace");
        $("#welcome_screen_form_container").show();
        fetchRegisterForm();
    });
    $(".welcome_screen_login_button").click(function () {
        $("#welcome_screen_form_heading").html("Přihlášení");
        $("#welcome_screen_form_container").show();
        mode = "login";
        fetchLoginForm();
    });
});

function fetchRegisterForm() {
    $("#welcome_screen_form_placeholder").html("<p>Načítání...</p>");
    $.ajax({
        type: "GET",
        url: "/users/new",
        data: {target: "#welcome_screen_form_placeholder"},
        dataType: 'script',
        format: 'js'
    });
}

function fetchLoginForm() {
    $("#welcome_screen_form_placeholder").html("<p>Načítání...</p>");
    $.ajax({
        type: "GET",
        url: "/login",
        data: {target: "#welcome_screen_form_placeholder"},
        dataType: 'script',
        format: 'js'
    });
}
