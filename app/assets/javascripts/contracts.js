$(function() {
    $("input#contract_strahovatel_attributes_firstname").autocomplete({
        source: function(request, response) {
            $.ajax({
                url: "/search",
                dataType: "json",
                data: {
                    firstname: request.term
                },
                success: function(data) {
                    response($.map(data, function(item) {
                        return {
                            label: item.lastname+" "+item.firstname,
                            value: item.firstname,
                            lastname: item.lastname,
                            id:item.id
                        }
                    }));
                }
            });
        },
        minLength: 2,
        select: function(event, ui) {
            $("input#contract_strahovatel_attributes_lastname").val(ui.item.lastname);
        }
    });
});