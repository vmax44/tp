page_ready= function(){

    function people_obj(container,fname,lname,elemforid) {
      this.container = container;
      this.firstname = fname;
      this.lastname = lname;
      this.id = elemforid;
    };
    
    var strah=new people_obj($("div#strahovatel_fields"),
                              $("div#strahovatel_fields input#person_firstname"),
                              $("div#strahovatel_fields input#person_lastname"),
                              $("input#contract_strahovatel_id"));
    var zastr=new people_obj($("div#zastrahovanniy_fields"),
                              $("div#zastrahovanniy_fields input#person_firstname"),
                              $("div#zastrahovanniy_fields input#person_lastname"),
                              $("input#contract_zastrahovanniy_id"));

    get_people_form(strah);
    get_people_form(zastr);

    function get_people_form(o) {
        $.ajax({
            url: o.id.val() > 0 ? "/people/" + o.id.val() + "/edit" : "/people/new",
            dataType: "html",
            success: function(data) {
                //alert( "Прибыли данные: " + data );
                var div = o.container.html(data);
                autoobj(o);
            }
        });
    }

    function autoobj(o) {
        var currentfield;
        o.firstname.add(o.lastname).autocomplete({
            source: function(request, response) {
                currentfield = this.element[0];
                $.ajax({
                    url: "/people/search",
                    dataType: "json",
                    data: {
                        firstname: o.firstname.val(),
                        lastname: o.lastname.val()
                    },
                    success: function(data) {
                        response($.map(data, function(item) {
                            return {
                                label: item.lastname + " " + item.firstname,
                                value: (currentfield === o.firstname[0]) ? item.firstname : item.lastname,
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
                if (currentfield === o.firstname[0]) {
                    o.lastname.val(ui.item.lastname);
                } else {
                    o.firstname.val(ui.item.firstname);
                }
                o.id.val(ui.item.id);
                var tmp=o.firstname.closest('form').children(':input').not(':hidden').not('.btn');
                tmp.attr({
                    'readonly': 'true'
                });
            }
        });
    }
};

$(document).ready(page_ready);
$(document).on('page:load', page_ready);
