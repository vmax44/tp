$(function() {
    function setup_autocomplete() {
        autoobj($("div#strahovatel_fields input#person_firstname"),
                $("div#strahovatel_fields input#person_lastname"),
                $("input#contract_strahovatel_id"));
        autoobj($("div#zastrahovanniy_fields input#person_firstname"),
                $("div#zastrahovanniy_fields input#person_lastname"),
                $("input#contract_zastrahovanniy_id"));
    }

    var strah_id = $("input#contract_strahovatel_id");
    get_people_form(strah_id,$("div#strahovatel_fields"),false);
    
    var zastr_id = $("input#contract_zastrahovanniy_id");
    get_people_form(zastr_id,$("div#zastrahovanniy_fields"),true);

    function get_people_form(id,container,need_setup_autocomplete) {
        $.ajax({
            url: id.val() > 0 ? "/people/" + id.val() + "/edit" : "/people/new",
            dataType: "html",
            success: function(data) {
                //alert( "Прибыли данные: " + data );
                var div = container.html(data);
                if(need_setup_autocomplete) setup_autocomplete();
            }
        });
    }

    function autoobj(firstname, lastname, id) {
        var currentfield;
        id;
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
                if (id.length === 0) {
                    var part = "contract_strahovatel" //firstname[0].id.substring(0,firstname[0].id.lastIndexOf('_'));
                    var str = '<input id="';
                    str = str + part + '_id" name="';
                    part = "contract[strahovatel_id]"; //firstname[0].name.substring(0,firstname[0].name.lastIndexOf('['));
                    str = str + part + '" type="hidden" />';

                    id = $(str).insertAfter(firstname);
                }
                id.val(ui.item.id);
            }
        });
    }
});

