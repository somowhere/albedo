var grid_selector = "#grid-table", pager_selector = "#grid-pager";
albedo.searchItemForm = function (grid_selector, formId) {
    var grid_selector = grid_selector ? grid_selector : "#grid-table",
        _search = $(grid_selector).jqGrid('getGridParam', "postData");
    var $target = formId ? $(formId).find("[searchItem='searchItem']") : $("[searchItem='searchItem']");
    $target.each(function () {
        var s = $(this).val() ? ($(this).attr("format") != "yyyy-MM-dd HH:mm:ss" ? $(this).val().replaceAll(" ", "") : $(this).val()) : undefined;
        s = s ? ("_search." + $(this).attr("name") + "= '" + s + "'") : ("_search." + $(this).attr("name") + "= " + s);
        eval(s);
    })
    $(grid_selector).jqGrid('setGridParam', {"postData": _search}).trigger("reloadGrid");
}

albedo.searchJsonItemForm = function (grid_selector, formId) {
    var i = 0, json_list = [], grid_selector = grid_selector ? grid_selector : "#grid-table",
        _search = $(grid_selector).jqGrid('getGridParam', "postData");
    var $target = formId ? $(formId).find("[searchItem='searchItem']") : $("[searchItem='searchItem']");
    $target.each(function () {
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
                _json.endValue = $(this).next().val() ? ($(this).attr("format") != "yyyy-MM-dd HH:mm:ss" ? $(this).next().val().replaceAll(" ", "") : $(this).next().val()) : undefined;
                if (!_json.endValue) return true;
            }
            _json.value = s;
            json_list[i++] = _json;
        }
    })
    _search.queryConditionJson = JSON.stringify(json_list);
    _search.pageTo = 1;
    $(grid_selector).jqGrid('setGridParam', {"postData": _search}).trigger("reloadGrid");
    _search.pageTo = -1;
}

albedo.confirmAjax = function (href, msg, callback) {
    if (!albedo.isExitsFunction(callback)) callback = function (data) {
        if (data) {
            if (data.type == "success") $(grid_selector).trigger("reloadGrid");
            albedo.g_showMsg(data.msg, data.type);
        }
    }
    top.$.jBox.confirm(msg ? msg : "确认要操作勾选的记录吗？", '系统提示', function (v, h, f) {
        if (v == 'ok') {
            $.post(href, callback);
        }
    }, {buttonsFocus: 1});
    top.$('.jbox-body .jbox-icon').css('top', '55px');
    return false;
}