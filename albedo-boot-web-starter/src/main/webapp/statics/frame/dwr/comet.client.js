var MESSAGE_TYPE = "MESSAGE_TYPE", /*** 消息类型*/
MESSAGE_DATA = "MESSAGE_DATA", /*** 消息内容*/
MESSAGE_TYPE_1 = "MESSAGE_TYPE_1", /*** 消息类型  对象 */
MESSAGE_TYPE_2 = "MESSAGE_TYPE_2";
/*** 消息类型  集合 */

//推送信息
function showMessage(autoMessage) {
    if (typeof(autoMessage) == "object") {
        var data = autoMessage;
    }
    else {
        eval("var data=" + autoMessage);
    }
    if (albedo.isExitsVariable(callCometShowMsg) && albedo.isExitsFunction(callCometShowMsg)) {
        callCometShowMsg(data);
    } else {
        $.jBox.messager("消息类型:" + data.MESSAGE_TYPE + "<br />消息内容:" + data.MESSAGE_DATA, '新消息');
    }
}
function staffLine(autoMessage) {
    if (onlineUserDataGrid) onlineUserDataGrid.reload();
}
subStrReplace = function (str, length) {
    if (g_notEmpty(str) && length && str.length > length) {
        str = str.substring(0, length) + "...";
    }
    return str;
}
dwr.engine._errorHandler = function (message, ex) {
    if (dwr && dwr.engine && dwr.engine._debug)
        dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);
};


