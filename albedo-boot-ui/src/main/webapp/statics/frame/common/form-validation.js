var FormValidation = function () {

    var $form = $('.form-validation'), validator;
    var handleValidateConfig = function (config, form) {
        if (!config)
            config = {};
        var error = $('.alert-danger', form);
        var success = $('.alert-success', form);
        config = $.extend(true, {
            errorElement: 'span', // default input error message container
            errorClass: 'help-block help-block-error', // default input error
                                                       // message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {},
//			{
//				name: {
//                    minlength: 2,
//                    required: true
//                },
//                email: {
//                    required: true,
//                    email: true
//                },
//			},
            messages: {},
            // { // custom messages for radio buttons and checkboxes
            // membership: {
            // required: "Please select a Membership type"
            // },
            // service: {
            // required: "Please select at least 2 types of Service",
            // minlength: jQuery.validator.format("Please select at least {0}
            // types of Service")
            // }
            // },

            errorPlacement: function (error, element) {

                if (element.parent(".input-group").size() > 0) {
                    error.insertAfter(element.parent(".input-group"));
                } else if (element.attr("data-error-container")) {
                    error.appendTo(element.attr("data-error-container"));
                } else if (element.parents('.radio-list').size() > 0) {
                    element.parents('.radio-list').append(error);
                } else if (element.parents('.radio-inline').size() > 0) {
                    element.parents('.radio-inline').append(error);
                } else if (element.parents('.radiobox-list').size() > 0) {
                    element.parents('.radiobox-list').append(error);
                } else if (element.parents('.checkbox-list').size() > 0) {
                    element.parents('.checkbox-list').append(error);
                } else if (element.parents('.checkbox-inline').size() > 0) {
                    element.parents('.checkbox-inline').append(error);
                } else {
                    error.insertAfter(element);
                }
            },

            invalidHandler: function (event, validator) {
                success.hide();
                error.show();
                App.scrollTo(error, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // hightlight error inputs
            },

            unhighlight: function (element) { // revert the change done by
                // hightlight
                $(element).closest('.form-group').removeClass('has-error');
            },

            success: function (label) {
                label.closest('.form-group').removeClass('has-error');
            },

            submitHandler: function (form) {
                success.show();
                error.hide();
//				form[0].submit(); // submit the form
            }

        }, config);
        return config;
    };
    // advance validation
    var handleValidation = function ($formTagert) {
        if ($formTagert && $formTagert.length > 0) {
            $form = $formTagert;
            var config;
            try {
                eval("config = " + $form.attr("config"));
            } catch (e) {
            }
            if (!config) config = {};
            validator = $formTagert.validate(handleValidateConfig(config, $formTagert));
            // apply validation on select2 dropdown value change, this only needed
            // for chosen dropdown integration.
            $('.select2me', $formTagert).change(function () {
                $formTagert.validate().element($(this));
            });
            $form.find('.date-time-picker').change(function () {
                $formTagert.validate().element($(this));
            });
            return validator;
        }
    }

    return {
        // main function to initiate the module
        init: function ($formTagert) {
            handleValidation($formTagert);
        },
        validate: function ($formTagert) {
            if ($formTagert && $formTagert.length > 0) {
                return handleValidation($formTagert).form();
            }
            return validator && validator.form();
        }

    };

}();