$(function() {
    var strahobj = new autoobj($("input#contract_strahovatel_attributes_firstname"),
            $("input#contract_strahovatel_attributes_lastname"));
    strahobj.set();
    var zastrobj = new autoobj($("input#contract_zastrahovanniy_attributes_firstname"),
            $("input#contract_zastrahovanniy_attributes_lastname"));
    zastrobj.set();

    // object for autocomplete firstname and lastname fields
    function autoobj(firstname, lastname) {
        var currentfield;

        this.set = function() {
            firstname.add(lastname).autocomplete({
                source: function(request, response) {
                    currentfield = this.element[0];
                    $.ajax({
                        url: "/people/search",
                        dataType: "json",
                        data: {
                            firstname: firstname.val(),
                            lastname: lastname.val()
                        },
                        success: function(data) {
                            response($.map(data, function(item) {
                                return {
                                    label: item.lastname + " " + item.firstname,
                                    value: (currentfield === firstname[0]) ? item.firstname : item.lastname,
                                    lastname: item.lastname,
                                    firstname: item.firstname,
                                    id: item.id
                                };
                            }));
                        }
                    });
                },
                minLength: 2,
                select: function(event, ui) {
                    if (currentfield === firstname[0]) {
                        lastname.val(ui.item.lastname);
                    } else {
                        firstname.val(ui.item.firstname);
                    }
                }
            });
        return this;
        };
    };

});

