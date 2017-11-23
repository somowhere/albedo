<div class="row">
    <div class="col-md-12">
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-blue">
                    <i class="fa fa-globe font-blue"></i>修改密码
                </div>
                <div class="actions">
                    <div class="btn-group">
                    </div>
                </div>
            </div>
            <div class="portlet-body form form-no-modal change-password-portlet">
                <!-- BEGIN FORM-->
                <div id="bootstrap-alerts"></div>
                <form id="changePasswordAjaxForm" action="${ctx}/api/account/changePassword" method="post"
                      class="form-horizontal form-validation form-bordered form-label-stripped"
                      config="{}">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3">原密码<span
                                    class="required">*</span>
                            </label>
                            <div class="col-md-5">
                                <input type="password" name="password"
                                       maxlength="64" data-required="1" class="form-control required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">新密码<span
                                    class="required">*</span></label>
                            <div class="col-md-5">
                                <input id="newPassword" name="newPassword" type="password" value=""
                                       htmlEscape="false" maxlength="64"
                                       class="form-control required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">确认密码</label>
                            <div class="col-md-5">
                                <input name="confirmPassword" type="password" value=""
                                       htmlEscape="false" maxlength="64" class="form-control required"
                                       equalTo="#newPassword"/>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <button type="button" class="btn add green" id="changePasswordAjaxFormSave">
                                        <i class="fa fa-check"></i> 保存
                                    </button>
                                    <button type="reset" class="btn default" id="changePasswordAjaxFormReset">重置
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $("#changePasswordAjaxFormSave").click(function () {
            var el = $(this), $targetEvent = $(".change-password-portlet"), $form = $("#changePasswordAjaxForm");
            if (FormValidation.validate()) {
                $.ajax({
                    url: $form.attr("action"),
                    type: $form.attr("method") || "POST",
                    data: UIExtendedModals.getValue($form.serialize()),
                    dataType: "json",
                    timeout: 60000,
                    success: function (re) {
                        var alertType = re.status == "0" ? "info" : re.status == "1" ? "success" : re.status == "-1" ? "danger" : "warning";
                        icon = re.status == "0" ? "info" : re.status == "1" ? "check" : "warning";
                        App.alert({
                            container: $targetEvent.find('#bootstrap-alerts'),
                            close: true,
                            focus: true,
                            type: alertType,
                            closeInSeconds: 8,
                            message: (re && re.message) ? re.message : '网络异常，请检查您的网络!',
                            icon: icon
                        });
                        if (re.status == "1") {
                            $("#changePasswordAjaxFormReset").trigger("click");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        UIExtendedModals.alertDialog($targetEvent, null, el);
                    }
                });
            }
        })
    })
</script>