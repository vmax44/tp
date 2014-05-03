function people_obj(container, fname, lname, elemforid) {
    this.container_sel = container;
    this.container = null;
    this.firstname_sel = container + ' ' + fname;
    this.firstname = null;
    this.lastname_sel = container + ' ' + lname;
    this.lastname = null;
    this.id_sel = elemforid;
    this.id = null;
    this.form = null;
    this.onPressEdit = function(param) {
        param.preventDefault();
        var o = param.data.obj;
        o.canmodify();
    };
    this.onPressClear = function(param) {
        param.preventDefault();
        var o = param.data.obj;
        o.id.val("");
        o.get_form();
    };
    this.onPressSave = function(param) {
        //param.preventDefault();
        var o = param.data.obj;
        o.form.trigger('submit.rails');
        //o.firstname.focus();
    };
    this.init = function() {
        var o=this;
        this.firstname = $(this.firstname_sel);
        this.lastname = $(this.lastname_sel);
        this.btnSave = this.container.find("a#btnSave");
        this.btnEdit = this.container.find("a#btnEdit");
        this.btnClear = this.container.find("a#btnClear");
        this.btnClear.click({obj: this}, this.onPressClear);
        this.btnSave.click({obj: this}, this.onPressSave);
        this.btnEdit.click({obj: this}, this.onPressEdit);
        if (this.id.val() > 0) {
            this.readonly();
        } else {
            this.canmodify();
        }
        this.autoobj();
        this.form = this.firstname.closest('form');
        this.form.validate(validation_people);
        this.form.on('ajax:success', function(event, data, status, xhr) {
            o.container.html(data);
            o.init();
        });
    };

    this.readonly = function() {
        this.firstname.closest('form')
                .children(':input')
                .not(':hidden')
                .not('.btn')
                .attr('readonly', true);
        this.btnSave.hide();
        this.btnClear.show();
        this.btnEdit.show();
    };
    this.canmodify = function() {
        this.firstname.closest('form')
                .children(':input')
                .not(':hidden')
                .not('.btn')
                .removeAttr('readonly');
        this.btnSave.show();
        this.btnClear.show();
        this.btnEdit.hide();
    };
    this.autoobj = function() {
        var currentfield;
        var o = this;
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
                o.readonly();
            }
        });
    };
    this.get_form = function() {
        var o = this;
        o.container = $(o.container_sel);
        o.id = $(o.id_sel);
        if (o.id.length > 0) {
            $.ajax({
                url: o.id.val() > 0 ? "/people/" + o.id.val() + "/edit" : "/people/new",
                dataType: "html",
                success: function(data) {
                    //alert( "Прибыли данные: " + data );
                    o.container.html(data);
                    o.init();
                }
            });
        }
    };
}

var validate_url = '/people/validate';
var validation_people = {
    debug: false,
    rules: {
        'person[firstname]': {
            required: true,
            remote: {
                url: validate_url,
                type: 'get'
            }
        },
        'person[lastname]': {
            required: true,
            remote: {
                url: validate_url,
                type: 'get'
            }
        },
        'person[passport]': {
            required: true,
            remote: {
                url: validate_url,
                type: 'get'
            }
        },
        'person[address]': {
            required: true,
            remote: {
                url: validate_url,
                type: 'get'
            }
        }
    }
};


var strah = new people_obj("div#strahovatel_fields",
        "input#person_firstname",
        "input#person_lastname",
        "input#contract_strahovatel_id");
var zastr = new people_obj("div#zastrahovanniy_fields",
        "input#person_firstname",
        "input#person_lastname",
        "input#contract_zastrahovanniy_id");


    /*if(data.e.length===0) {
     o.id.val(data.p.id);
     o.container.find('div#messages').html('');
     o.readonly();
     } else {
     o.container.find('div#messages').html(data.e.);
     } */


page_ready = function() {
    strah.get_form();
    zastr.get_form();
    $('div#policy_fields').find('form').on('form:submit', contract_submit);
};

contract_submit = function() {

};

$(document).ready(page_ready);
$(document).on('page:load', page_ready);
