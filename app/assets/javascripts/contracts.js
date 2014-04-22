$(function() {
    var strahobj = new autoobj($("input#contract_strahovatel_attributes_firstname"),
            $("input#contract_strahovatel_attributes_lastname"),this);

    function autoobj(firstname, lastname) {
        //this.fname = firstname;
        //this.lname = lastname;
        this.currentfield = null;
        

        firstname.add(lastname).autocomplete({
            source: function(request, response) {
                strahobj.currentfield=this.element[0];
                $.ajax({
                    url: "/search",
                    dataType: "json",
                    data: {
                        firstname: firstname.val(),
                        lastname:  lastname.val()
                    },
                    success: function(data) {
                        response($.map(data, function(item) {
                            this.currentfield;
                            this;
                            strahobj.currentfield;
                            return {
                                label: item.lastname + " " + item.firstname,
                                value: (strahobj.currentfield === firstname[0]) ? item.firstname : item.lastname,
                                lastname: item.lastname,
                                firstname: item.firstname,
                                id: item.id
                            }
                        }));
                    }
                });
            },
            minLength: 2,
            select: function(event, ui) {
                if (strahobj.currentfield === firstname[0]) {
                    lastname.val(ui.item.lastname);
                } else {
                    firstname.val(ui.item.firstname);
                }
            }
        });
    }

});

