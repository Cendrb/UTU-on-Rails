$(function(){
    $("#planned_raking_entries_sortable").sortable(
        {
            update: function(event, ui)
            {
                alert("tohle zatím nic nedělá");
            }
        }
    );
});