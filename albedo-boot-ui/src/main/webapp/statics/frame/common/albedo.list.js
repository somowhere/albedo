var formId = "#inputForm";
$(function () {
    var jsonVal = $("[name='queryConditionJson']").val();
    if (jsonVal) {
        eval("var json_data = " + jsonVal);
        albedo.jsonInitSearchFrom(json_data, formId);
    }
    // 表格排序
    if ($("#orderBy") && $("#orderBy").val()) {
        var orderBy = $("#orderBy").val().split(" ");
        $("#contentTable th.sort").each(function () {
            if ($(this).hasClass(orderBy[0])) {
                $(this).html($(this).html() + " <i class=\"fa fa-2 fa-sort-amount-" + orderBy[1].toLowerCase() + "\"></i>");
            }
        });
    }
    $("#contentTable th.sort").click(function () {
        var order = $(this).attr("class").split(" ");
        var sort = $("#orderBy").val().split(" ");
        for (var i = 0; i < order.length; i++) {
            if (order[i] == "sort") {
                order = order[i + 1];
                break;
            }
        }
        if (order == sort[0]) {
            sort = (sort[1] && sort[1].toUpperCase() == "DESC" ? "ASC" : "DESC");
            $("#orderBy").val(order + " DESC" != order + " " + sort ? "" : order + " " + sort);
        } else {
            $("#orderBy").val(order + " ASC");
        }
        page();
    });
    $("#contentTable th input.checkAll").click(function () {
        $("td input.checkItem").prop("checked", $(this).prop("checked") ? true : false);
        $("input[name='idList']").remove();
        $("td input.checkItem").each(function () {
            if ($(this).prop("checked")) $(formId).append($("<input name='idList' type='hidden' />").val($(this).val()));
        });
    });
    $("td input.checkItem").click(function () {
        $(this).prop("checked") ? $(formId).append($("<input name='idList' type='hidden' />").val($(this).val())) : $("input[name='idList'][value='" + $(this).val() + "']").remove();
        ;
    })

})
function page(n, s) {
    $("#pageNo").val(n);
    $("#pageSize").val(s);
    var i = 0, json_list = [];
    $("[searchItem='searchItem']").each(function () {
        if (($(this).attr('type') == 'radio' || $(this).attr('type') == 'checkbox') && !$(this).is(":checked")) return true;
        var s = $(this).val() ? ($(this).attr("format") != "yyyy-MM-dd HH:mm:ss" ? $(this).val().replaceAll(" ", "") : $(this).val()) : undefined;
        if (s) {
            var fieldName = $(this).attr("realName") ? $(this).attr("realName") : $(this).attr("name");
            if ($(this).attr('type') == 'checkbox' && json_list && json_list.length > 0) {
                for (var j = 0; j < json_list.length; j++) {
                    if (json_list[j].fieldName == fieldName) {
                        json_list[j].value += "," + s;
                        return true;
                    }
                }
            }
            var _json = {};
            _json.fieldName = fieldName;
            _json.attrType = $(this).attr("attrType") ? $(this).attr("attrType") : 'String';
            if (_json.attrType == "date" || _json.attrType == "Date") {
                _json.format = $(this).attr("format") ? $(this).attr("format") : 'yyyy-MM-dd';
            }
            _json.fieldNode = $(this).attr("fieldNode") ? $(this).attr("fieldNode") : '';
            _json.operation = $(this).attr("operation") ? $(this).attr("operation") : 'like';
            _json.weight = $(this).attr("weight") ? $(this).attr("weight") : 0;
            if (_json.operation == "between") {
                var endVal = $(this).nextAll("input").val();
                _json.endValue = endVal ? ($(this).attr("format") != "yyyy-MM-dd HH:mm:ss" ? endVal.replaceAll(" ", "") : endVal) : undefined;
                if (!_json.endValue) return true;
            }
            _json.value = s;
            json_list[i++] = _json;
        }
    })
    var $json = $(formId).find("[name='queryConditionJson']");
    if ($json.length > 0) {
        $json.val(JSON.stringify(json_list));
    } else {
        $(formId).append("<input type='hidden' name='queryConditionJson' value='" + JSON.stringify(json_list) + "' />");
    }
    $(formId).submit();
    return false;
}
albedo.confirmBacthPost = function (href, callback, msg, emptyMsg) {
    if (!callback) callback = function (v, h, f) {
        $(formId).attr("action", href).submit();
    }
    if ($(formId + " input[name='idList']").length > 0) {
        top.$.jBox.confirm(msg ? msg : "确认要操作勾选的记录吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                callback(v, h, f);
            }
        }, {buttonsFocus: 1});
    } else {
        albedo.g_showMsg(emptyMsg ? emptyMsg : "请勾选要批量删除的记录", WRANING);
    }
    return false;
}