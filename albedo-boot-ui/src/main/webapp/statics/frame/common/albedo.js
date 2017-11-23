if (!Array.prototype.map)
    Array.prototype.map = function (fn, scope) {
        var result = [], ri = 0;
        for (var i = 0, n = this.length; i < n; i++) {
            if (i in this) {
                result[ri++] = fn.call(scope, this[i], i, this);
            }
        }
        return result;
    };
if ($.fn.dataTable)
    $.fn.dataTable.ext.sErrMode = function (settings, tn, msg) {
        if (window.console && console.log) {
            console.log(msg);
        }
    };
var SUCCESS = "success", QUESTION = "question", WRANING = "warning", ERROR = "error", msg_ = false;
/**
 * 获取元素的outerHTML
 */
$.fn.outerHTML = function () {
    // IE, Chrome & Safari will comply with the non-standard outerHTML, all
    // others (FF) will have a fall-back for cloning
    return (!this.length) ? this : (this[0].outerHTML || (function (el) {
        var div = document.createElement('div');
        div.appendChild(el.cloneNode(true));
        var contents = div.innerHTML;
        div = null;
        return contents;
    })(this[0]));
};
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        var name = this.name,tempObj = o[name],val = this.value || '',
            startIndex= name.indexOf('['), endIndex = name.indexOf(']');
        if(startIndex!=-1 && endIndex!=-1){
            var prefix = name.substr(0, startIndex);
            tempObj = o[prefix];
            if (!tempObj) {
                tempObj = []
            }
            var subName = name.substring(endIndex+2),index = name.substring(startIndex+1,endIndex);
            if(tempObj[index]){
                tempObj[index][subName] = val;
            }else{
                var temp = {};
                temp[subName] = val;
                tempObj.push(temp);
            }
            o[prefix] = tempObj;
        }else{
            if (tempObj) {
                if (!tempObj.push) {
                    tempObj = [tempObj];
                }
                tempObj.push(val || '');
            } else {
                tempObj = val || '';
            }
            o[name] = tempObj;
        }

    });
    return o;
};
var albedo = {
    language: {
        // metronic spesific
        "metronicGroupActions": "选中 _TOTAL_ 条记录：",
        "metronicAjaxRequestGeneralError": "请求失败，请检测您的网络连接",

        // data tables spesific
        "lengthMenu": "<span class='seperator'>|</span>View _MENU_ records",
        "info": "<span class='seperator'>|</span>Found total _TOTAL_ records",
        "infoEmpty": "没有找到记录",
        "emptyTable": "没有记录",
        "zeroRecords": "没有找到匹配的记录",
        "paginate": {
            "previous": "上一页",
            "next": "下一页",
            "last": "末页",
            "first": "首页",
            "page": "当前页码",
            "pageOf": "总页数"
        },
        "sProcessing": "处理中...",
        "sLengthMenu": " _MENU_ 条目",
        "sZeroRecords": "没有相关数据",
        "sInfo": "显示第 _START_ 到 _END_ 条记录，共 _TOTAL_ 条记录 ",
        "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
        "sInfoPostFix": "",
        "sSearch": "搜索:",
        "sUrl": "",
        "sEmptyTable": "数据为空",
        "sLoadingRecords": "载入中...",
        "sInfoThousands": ",",
        "oPaginate": {
            "sFirst": "首页",
            "sPrevious": "上一页",
            "sNext": "下一页",
            "sLast": "末页",
            "page": "当前页码",
            "pageOf": "总页数"
        },
        "oAria": {
            "sSortAscending": ": 以升序排列此列",
            "sSortDescending": ": 以降序排列此列"
        },
        "buttons": {
            "copyTitle": "复制到剪贴板",
            "copyInfo": "复制 %d 行数据"
        }
    },
    setCookie: function (key, value) {
        Cookies.set(key, value, {
            expires: 7,
            path: '/'
        });
    },
    removeCookie: function (key) {
        Cookies.set(key, null, {
            expires: 0,
            path: '/'
        });
    },
    getCookie: function (key) {
        return Cookies.get(key);
    },
    setUserCookie: function (key, value) {
        Cookies.set(key + userId, value, {
            expires: 7,
            path: '/'
        });
    },
    getUserCookie: function (key) {
        return Cookies.get(key + userId);
    },
    refreshCacheBuster: function () {
        var url = _form.attr("action");
        var d = new Date();
        url = url.replace(/[?|&]cacheBuster=\d+/, '');
        // Some url's allready have '?' attached
        url += config.url.indexOf('?') === -1 ? '?' : '&'
        url += 'cacheBuster=' + d.getTime();
        _form.attr("action", url);
    },
    goTo: function (url, blank) {
        if (blank) {
            window.open(url);
        } else {
            window.location.href = url;
        }
    },// /<summary>获得字符串实际长度，中文2，英文1</summary>
    // /<param name="str">要获得长度的字符串</param>
    getLength: function (str) {
        var realLength = 0, len = str.length, charCode = -1;
        for (var i = 0; i < len; i++) {
            charCode = str.charCodeAt(i);
            if (charCode >= 0 && charCode <= 128)
                realLength += 1;
            else
                realLength += 2;
        }
        return realLength;
    },
    // /<summary>切割的最大长度的字符串以</summary>
    // /<param name="str">要获得切割的字符串</param>
    // /<param name="maxLength">最大长度</param>
    // /<param name="suffix">后缀 默认'...'</param>
    subMaxStr: function (str, maxLength, suffix) {
        if (str) {
            var realLength = 0, len = str.length, charCode = -1, suffix = suffix ? suffix
                : '...';
            for (var i = 0; i < len; i++) {
                charCode = str.charCodeAt(i);
                if (charCode >= 0 && charCode <= 128)
                    realLength += 1;
                else
                    realLength += 2;
                if (realLength > maxLength) {
                    str = str.substring(0, i) + suffix;
                    break;
                }
            }
        } else {
            str = '';
        }

        return str;
    },
    toCamelCase: function (str, s) {
        if (!s)
            s = '.';
        if (str) {
            var rs = "", upperCase = false;
            for (var i = 0; i < str.length; i++) {
                var c = str.charAt(i);
                if (c == s) {
                    upperCase = true
                } else if (upperCase) {
                    upperCase = false;
                    rs += c.toUpperCase();
                } else {
                    rs += c;
                }
            }
            str = rs;
        }
        return str;
    },// 是否存在指定函数
    isExitsFunction: function (funcName) {
        try {
            if (typeof (eval(funcName)) == "function") {
                return true;
            }
        } catch (e) {
        }
        return false;
    }
    // 是否存在指定变量
    ,
    isExitsVariable: function (variableName) {
        try {
            return typeof (variableName) == "undefined" ? false : true;
        } catch (e) {
        }
        return false;
    },
    setFormBoxValue: function ($thiz, val) {
        if ($thiz) {
            if ($thiz.is('input') || $thiz.is('textarea')) {
                if ($thiz.attr("type") == "radio"
                    || $thiz.attr("type") == "checkbox") {
                    $thiz.each(function () {
                        $(this).val() == val
                        && $(this).attr("checked", "checked");
                    });
                } else {
                    $thiz.val(val);
                }
            } else if ($thiz.is('select')) {
                $thiz.val(val);
                if ($thiz.attr('class')
                    && $thiz.attr('class').indexOf('chosen-select') != -1) {
                    $thiz.select2("destroy");
                    $thiz.select2();
                }
            } else if ($thiz.is('lebel')) {
                $thiz.text(val);
            }
        }
    },

    /**
     * json初始化普通表单
     *
     * json {属性：值,属性：值} formId
     */
    jsonFrom: function (json, formId) {
        albedo.jsonFromObject(json, $("#" + formId));
    },
    jsonFromObject: function (json, $form) {
        if (json) {
            $form.find("[name]") && $form.find("[name]").each(function () {
                var name = albedo.toCamelCase($(this).attr('name'));
                albedo.setFormBoxValue($(this), json[name]);
            });
        }
    }
    /**
     * json初始化查询表单
     *
     * json {queryCondition对象} formId
     */
    ,
    jsonInitSearchFrom: function (json, formId) {
        var $form = $(formId);
        if (json) {
            for (var i in json) {
                var $item = $form.find("[name='" + json[i].fieldName + "']");
                if ($item.length == 0)
                    $item = $form
                        .find("[realname='" + json[i].fieldName + "']");
                albedo.setFormBoxValue($item, json[i].value);
                if (json[i].operation == "between") {
                    albedo.setFormBoxValue($item.next(), json[i].endValue);
                }
            }
        }
    },
    /**
     * json初始化查询表单
     *
     * json {queryCondition对象} formId
     */
    parseJsonItemForm: function (formId) {
        return albedo.parseJsonItemFormTarget($(formId))
    },
    /**
     * json初始化查询表单
     *
     * json {queryCondition对象} formId
     */
    parseJsonItemFormTarget: function ($formId) {
        var i = 0, json_list = [];
        var $target = $formId.length > 0 ? $formId.find("[searchItem='searchItem']")
            : $("[searchItem='searchItem']");
        $target
            .each(function () {
                if (($(this).attr('type') == 'radio' || $(this)
                        .attr('type') == 'checkbox')
                    && !$(this).is(":checked"))
                    return true;
                var s = $(this).val() ? ($(this).attr("format") != "yyyy-MM-dd HH:mm:ss" ? $(
                    this).val().replaceAll(" ", "")
                    : $(this).val())
                    : undefined;
                if (s) {
                    var fieldName = $(this).attr("realName") ? $(this)
                        .attr("realName") : $(this).attr("name");
                    if ($(this).attr('type') == 'checkbox' && json_list
                        && json_list.length > 0) {
                        for (var j = 0; j < json_list.length; j++) {
                            if (json_list[j].fieldName == fieldName) {
                                json_list[j].value += "," + s;
                                return true;
                            }
                        }
                    }
                    var _json = {};
                    _json.fieldName = fieldName;
                    _json.attrType = $(this).attr("attrType") ? $(this)
                        .attr("attrType") : 'String';
                    if (_json.attrType == "date"
                        || _json.attrType == "Date") {
                        _json.format = $(this).attr("format") ? $(this)
                            .attr("format") : 'yyyy-MM-dd';
                    }
                    _json.fieldNode = $(this).attr("fieldNode") ? $(this)
                        .attr("fieldNode") : '';
                    _json.operate = $(this).attr("operate") ? $(this).attr(
                        "operate") : 'like';
                    _json.weight = $(this).attr("weight") ? $(this).attr(
                        "weight") : 0;
                    _json.analytiColumn = $(this).attr("analytiColumn") ? $(this).attr(
                        "analytiColumn") : true;
                    _json.analytiColumnPrefix = $(this).attr("analytiColumnPrefix") ? $(this).attr(
                        "analytiColumnPrefix") : null;
                    if (_json.operate == "between") {
                        var endValue = $("input[for-date='" + $(this).attr("name") + "']").val();
                        _json.endValue = endValue ? ($(this)
                            .attr("format") != "yyyy-MM-dd HH:mm:ss" ? endValue.replaceAll(" ", "") : endValue)
                            : undefined;
                        if (!_json.endValue)
                            return true;
                    }
                    _json.value = s;
                    json_list[i++] = _json;
                }
            })
        return JSON.stringify(json_list);
    }
};

String.prototype.startWith = function (str) {
    var reg = new RegExp("^" + str);
    return reg.test(this);
}

String.prototype.endWith = function (str) {
    var reg = new RegExp(str + "$");
    return reg.test(this);
}
/**
 * 替换所有 reallyDo：被搜索的子字符串。 replaceWith：用于替换的子字符串。
 *
 * @returns
 */
String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")),
            replaceWith);
    } else {
        return this.replace(reallyDo, replaceWith);
    }
}
String.prototype.endWith = function (str) {
    if (str == null || str == "" || this.length == 0
        || str.length > this.length)
        return false;
    if (this.substring(this.length - str.length) == str)
        return true;
    else
        return false;
    return true;
}
String.prototype.startWith = function (str) {
    if (str == null || str == "" || this.length == 0
        || str.length > this.length)
        return false;
    if (this.substr(0, str.length) == str)
        return true;
    else
        return false;
    return true;
}
Array.prototype.removeByValue = function (val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == val) {
            this.splice(i, 1);
            break;
        }
    }
}
/**
 * //使用方法 var now = new Date(); var nowStr = now.format("yyyy-MM-dd hh:mm:ss");
 * //使用方法2: var testDate = new Date(); var testStr =
 * testDate.format("YYYY年MM月dd日hh小时mm分ss秒"); alert(testStr);
 *
 * @param format
 * @returns
 */
Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    };
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
                : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}
