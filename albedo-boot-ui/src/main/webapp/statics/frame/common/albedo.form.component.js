var albedoForm = function () {
    var _treeSearchInputFocusKey = function ($key) {
        if ($key.hasClass("empty")) {
            $key.removeClass("empty");
        }
    }
    var _treeSearchInputBlurKey = function ($key, tree) {
        if ($key.get(0).value === "") {
            $key.addClass("empty");
        }
        _treeSearchNode($key, tree);
    }
    var _treeSearchNode = function ($key, tree) {
        // 取得输入的关键字的值
        var value = $.trim($key.get(0).value);
        // 按名字查询
        var keyType = "name";
        if ($key.hasClass("empty")) {
            value = "";
        }
        // 如果和上次一次，就退出不查了。
        if ($key.attr("lastValue_") === value) {
            return;
        }
        // 保存最后一次
        $key.attr("lastValue_", value);

        // 如果要查空字串，就退出不查了。
        if (value === "") {
            {
                $container.slimScroll({
                    'scrollTo': 0
                });
            }
            return;
        }

        _treeSearchUpdateNodes(tree, false, tree.getNodes());
        _treeSearchUpdateNodes(tree, true, tree.getNodesByParamFuzzy(keyType, value));
    }
    var _treeSearchUpdateNodes = function (tree, highlight, nodeList) {
        var $container = tree.setting.treeObj;
        for (var i = 0, l = nodeList.length; i < l; i++) {
            nodeList[i].highlight = highlight;
            tree.updateNode(nodeList[i]);
            tree.expandNode(nodeList[i].getParentNode(), true, false, true);
            if (i == 0 && highlight) {
                var scorll = $("a[title='" + nodeList[i].name + "']").offset().top - $container.offset().top - 5;
//				$container.animate({scrollTop: scorll},500)
                $container.slimScroll({
                    'scrollTo': scorll
                });
            }
        }
    }

    /**public**/

    var treeShow = function ($thiz) {
        var name = $thiz.attr("name"),
            url = $thiz.attr("_url") ? $thiz.attr("_url") : "",
            checked = $thiz.attr("_checked") == "true" ? true : false,
            onlyCheckedChild = $thiz.attr("_onlyCheckedChild") ? $thiz.attr("_onlyCheckedChild") : false,
            onlyCheckedProperty = $thiz.attr("_onlyCheckedProperty") ? $thiz.attr("_onlyCheckedProperty") : false,
            checkIdInputName = $thiz.attr("_checkIdInputName") ? $thiz.attr("_checkIdInputName") : "",
            checkShowInputId = $thiz.attr("_checkShowInputId") ? $thiz.attr("_checkShowInputId") : "",
            notAllowSelectRoot = $thiz.attr("_notAllowSelectRoot") ? $thiz.attr("_notAllowSelectRoot") : false,
            notAllowSelectParent = $thiz.attr("_notAllowSelectParent") ? $thiz.attr("_notAllowSelectParent") : false,
            notAllowSelect = $thiz.attr("_notAllowSelect") ? $thiz.attr("_notAllowSelect") : false,
            allowCancelSelect = $thiz.attr("_allowCancelSelect") ? $thiz.attr("_allowCancelSelect") : false,
            nodesLevel = $thiz.attr("_nodesLevel") ? $thiz.attr("_nodesLevel") : "",
            afterLoadNodeFn = $thiz.attr("_afterLoadNodeFn") ? $thiz.attr("_afterLoadNodeFn") : "",
            clickNodeFn = $thiz.attr("_clickNodeFn") ? $thiz.attr("_clickNodeFn") : "",
            cancelClickNodeFn = $thiz.attr("_cancelClickNodeFn") ? $thiz.attr("_cancelClickNodeFn") : "",
            beforeCheckNodeFn = $thiz.attr("_beforeCheckNodeFn") ? $thiz.attr("_beforeCheckNodeFn") : "",
            checkNodeFn = $thiz.attr("_checkNodeFn") ? $thiz.attr("_checkNodeFn") : "";

        var $key, lastValue_ = "", nodeList = [];
        var tree, setting = {
            view: {
                selectedMulti: false, fontCss: function (treeId, treeNode) {
                    return (!!treeNode.highlight) ? {"font-weight": "bold"} : {"font-weight": "normal"};
                }
            },
            check: {enable: checked, nocheckInherit: true},
            data: {key:{name:'label'},simpleData: {enable: true,idKey:'id',pIdKey: 'pid'}},
            callback: {
                beforeClick: function (treeId, treeNode) {
                    if (allowCancelSelect && tree && tree.getSelectedNodes()[0] && tree.getSelectedNodes()[0].id == treeNode.id) {
                        tree.cancelSelectedNode();
                        cancelClickNodeFn && eval(cancelClickNodeFn + "(treeId, treeNode);")
                        return false;
                    } else if (notAllowSelect) {
                        return false;
                    } else if (!notAllowSelect && notAllowSelectRoot && treeNode.level == 0) {
                        toastr.warning("不能选择根节点（" + treeNode.name + "）请重新选择。");
                        return false;
                    } else if (!notAllowSelect && notAllowSelectParent && treeNode.isParent) {
                        toastr.warning("不能选择父节点（" + treeNode.name + "）请重新选择。");
                        return false;
                    } else {
                        return true;
                    }
                }

            }
        };
        clickNodeFn && eval("setting.callback.onClick = " + clickNodeFn);
        beforeCheckNodeFn && eval("setting.callback.beforeCheck = " + beforeCheckNodeFn);

        if (checked && !checkNodeFn && checkShowInputId) {
            var _checkedNode_ = function (treeNode, showInput, showName) {
                if (treeNode.checked) {
                    if (!showName) showName = treeNode.name;
                    else showName = showName + "," + treeNode.name;
                    if (checkIdInputName) showInput.after($('<input type="hidden" name="' + checkIdInputName + '" />').val(treeNode.id));
                }
                return showName;
            }
            setting.callback.onCheck = function (event, treeId, treeNode, clickFlag) {
                var showInput = $("#" + checkShowInputId), showName = showInput.val();
                if (tree) {
                    nodes = tree.getCheckedNodes(), showName = "", eval("flag = ((onlyCheckedProperty && nodes[i]." + onlyCheckedProperty + ") || !onlyCheckedProperty)")
                    if (checkIdInputName) $("input[name='" + checkIdInputName + "']").remove();
                    if (nodes && nodes.length > 0) {
                        for (var i = 0; i < nodes.length; i++) {
                            if (!nodes[i].getCheckStatus().half && ((onlyCheckedChild && !nodes[i].isParent) || !onlyCheckedChild) && flag) {
                                showName = _checkedNode_(nodes[i], showInput, showName);
                            }
                        }
                    }
                    console.log(nodes);
                }
                showInput.val(showName);
            };
        }
        checkNodeFn && eval("setting.callback.onCheck = " + checkNodeFn);
        var refreshTree = function () {
            $.get(url, function (rs) {
                if (rs && rs.status != 1) {
                    toastr.warning(rs.message);
                    return;
                }
                var zNodes = rs.data;
                tree = $.fn.zTree.init($thiz, setting, zNodes);
                if (nodesLevel)for (var i = 0; i < nodesLevel; i++) {
                    var nodes = tree.getNodesByParam("level", i);
                    for (var j = 0; j < nodes.length; j++) {
                        tree.expandNode(nodes[j], true, false, true);
                    }
                }
                if (!nodesLevel) tree.expandAll(true);
                if (checkIdInputName) $("input[name='" + checkIdInputName + "']").each(function () {
                    if ($(this).val()) {
                        var node = tree.getNodeByParam("id", $(this).val());
                        if (node) tree.checkNode(node, true, true);
                    }
                });
                var selectNodeId = $thiz.attr("_selectNodeId") ? $thiz.attr("_selectNodeId") : "";
                eval("var selectId=" + selectNodeId);
                if (selectNodeId) {
                    if (selectId) selectNodeId = selectId;
                    var node = (selectNodeId == 1 ? tree.getNodes()[0] : tree.getNodeByParam("id", selectNodeId));
                    tree.selectNode(node);
                }
            });
        }
        refreshTree();
        $thiz.prev("div").find("input").bind("focus", function () {
            _treeSearchInputFocusKey($(this));
        }).bind("blur", function () {
            _treeSearchInputBlurKey($(this), tree);
        })
            .bind("change keydown cut input propertychange", function () {
                _treeSearchNode($(this), tree);
            });
        var $portlet = $thiz.parents(".portlet");
        $portlet.find("a.tree-search").off("click").click(function () {
            $portlet.find(".tree-search-div").slideToggle(200);
            $portlet.find(".tree-search-input").focus();
        });
        $portlet.find("a.tree-refresh").off("click").click(function () {
            refreshTree();
        });
        $portlet.find("a.tree-expand").off("click").click(function () {
            var zTree = $.fn.zTree.getZTreeObj($thiz.attr("id"));
            var expand = ($(this).find("i").attr("class").indexOf("expand") == -1);
            $(this).find("i").attr("class", "fa fa-" + (expand == true ? "expand" : "compress"));
            zTree.expandAll(expand);
        });

    };

    var handleTreeSelect = function ($thiz, $thizVal) {
        // 是否限制选择，如果限制，设置为disabled
        if ($thizVal.attr("disabled")) {
            return true;
        }

        var name = $thiz.attr("name"), nameLevel = $thiz.attr("_nameLevel"), nameLevel = (nameLevel ? nameLevel : "1"),
            url = $thiz.attr("_url") ? $thiz.attr("_url") : "",
            module = $thiz.attr("_module") ? $thiz.attr("_module") : "",
            checked = $thiz.attr("_checked") == "true" ? $thiz.attr("_checked") : "",
            extId = $thiz.attr("_extId") ? $thiz.attr("_extId") : "",
            nodesLevel = $thiz.attr("_nodesLevel") ? $thiz.attr("_nodesLevel") : "",
            title = $thiz.attr("_title") ? $thiz.attr("_title") : "",
            value = $thizVal.val() ? $thizVal.val() : "",
            allowClear = $thiz.attr("_allowClear") ? $thiz.attr("_allowClear") : "",
            notAllowSelectParent = $thiz.attr("_notAllowSelectParent") ? $thiz.attr("_notAllowSelectParent") : "",
            dialogWidth = $thiz.attr("_dialogWidth") ? $thiz.attr("_dialogWidth") : 320,
            dialogHeight = $thiz.attr("_dialogHeight") ? $thiz.attr("_dialogHeight") : 360,
            notAllowSelectRoot = $thiz.attr("_notAllowSelectRoot") ? $thiz.attr("_notAllowSelectRoot") : "",
            selectScopeModule = $thiz.attr("_selectScopeModule") ? $thiz.attr("_selectScopeModule") : "",
            selectedValueFn = $thiz.attr("_selectedValueFn") ? $thiz.attr("_selectedValueFn") : "",
            saveHalfState = $thiz.attr("_saveHalfState") ? $thiz.attr("_saveHalfState") : "";

        if (name && name.indexOf(".") != -1) name = name.replace(".", "-");

        var html = '<div id="' + name + 'TreeModal" class="modal modal-dialog fade" tabindex="-1" data-focus-on="input:first">' +
            '<div class="modal-header">' +
            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>' +
            '<h4 class="modal-title">' + (title ? title : "数据选择") + '</h4>' +
            '</div>' +
            '<div class="modal-body albedo-treeSelect-div albed-treeSelect-' + name + '">' +
            '<div class="search-item-div" style="position:absolute;right:15px;top:20px;cursor:pointer;z-index:22;">' +
            '<i class="fa fa-search icon-on-right fa-lg"></i><label id="txt">&nbsp;&nbsp;</label>' +
            '</div>' +
            '<div id="search" class="control-group" style="padding:0px 0 0px 15px;display: none;">' +
            '<div class="portlet-input input-inline" style="width: 240px !important;">' +
            '<div class="input-icon right">' +
            '<i class="icon-magnifier"></i>' +
            '<input type="text" id="key" name="key" maxlength="50" class="form-control input-circle" placeholder="请输入..."> </div>' +
            '</div>' +
            '</div>' +
            '<div id="tree-' + name + '" class="ztree scroller" style="padding:0 15px 10px;height:' + (dialogHeight - 30) + 'px;"></div>' +
            '</div>' +
            '<div class="modal-footer">' +
            '<button type="button" class="btn blue confirm">确定</button>' +
            '<button type="button" class="btn default" data-dismiss="modal">关闭</button>' +
            (allowClear ? '<button type="button" class="btn blue clear">清除</button>' : '') +
            '</div>' +
            '</div>';
        var $modal = $(html), lastValue = "", nodeList = [];
        var setting = {
            check: {enable: checked, nocheckInherit: true},
            data: {key:{name:'label'},simpleData: {enable: true,idKey:'id',pIdKey: 'pid'}},
            view: {
                selectedMulti: false,
                fontCss: function (treeId, treeNode) {
                    return (!!treeNode.highlight) ? {"font-weight": "bold"} : {"font-weight": "normal"};
                }
            },
            callback: {
                beforeClick: function (id, node) {
                    if (checked == "true") {
                        tree.checkNode(node, !node.checked, true, true);
                        return false;
                    }
                },
                onDblClick: function () {
                    $modal.find('.confirm').trigger("click");
                }
            }
        };
        $.get(url + (url.indexOf("?") == -1 ? "?" : "&") + "extId=" + extId + "&module=" + module + "&t=" + new Date().getTime(), function (rs) {
            if (rs && rs.status != 1) {
                toastr.warning(rs.message);
                return;
            }
            var zNodes = rs.data;
            // 初始化树结构
            var tree = $.fn.zTree.init($modal.find("#tree-" + name), setting, zNodes);
            // 默认指定层级节点
            if (nodesLevel) {
                for (var i = 0; i < nodesLevel; i++) {
                    var nodes = tree.getNodesByParam("level", i);
                    for (var i = 0; i < nodes.length; i++) {
                        tree.expandNode(nodes[i], true, false, false);
                    }
                }
            } else {
                tree.expandAll(true);// 默认全部节点
            }
            // 默认选择节点
            var ids = value.split(",");
            for (var i = 0; i < ids.length; i++) {
                var node = tree.getNodeByParam("id", ids[i]);
                if (checked == "true") {
                    try {
                        tree.checkNode(node, true, true);
                    } catch (e) {
                    }
                    tree.selectNode(node, false);
                } else {
                    tree.selectNode(node, true);
                }
            }
        });
        $modal.find("#key").bind("focus", function (e) {
            _treeSearchInputFocusKey($(this));
        }).bind("blur", function (e) {
            _treeSearchInputBlurKey($(this), $.fn.zTree.getZTreeObj("tree-" + name));
        }).bind("change keydown cut input propertychange", function () {
            _treeSearchNode($(this), $.fn.zTree.getZTreeObj("tree-" + name));
        });
        $modal.find(".search-item-div").click(function () {
            $modal.find("#search").slideToggle(200);
            $modal.find("#txt").toggle();
            $modal.find("#key").focus();
        });
        //, maxHeight: dialogHeight, height: dialogHeight
        $modal.modal({width: dialogWidth}).off('click', '.confirm').on('click', '.confirm', function () {
            var tree = $.fn.zTree.getZTreeObj("tree-" + name);
            var ids = [], names = [], nodes = [];
            if (checked == "true") {
                nodes = tree.getCheckedNodes(true);
            } else {
                nodes = tree.getSelectedNodes();
            }
            for (var i = 0; i < nodes.length; i++) {
                if (checked == "true") {
                    if (notAllowSelectParent && nodes[i].isParent) {
                        continue; // 如果为复选框选择，则过滤掉父节点
                    }
                    if (nodes[i].getCheckStatus().half) {
                        continue; // 过滤半选中状态
                    }
                }
                if (notAllowSelectRoot && nodes[i].level == 0) {
                    toastr.warning("不能选择根节点（" + nodes[i].name + "）请重新选择。");
                    return false;
                }
                if (notAllowSelectParent && nodes[i].isParent) {
                    toastr.warning("不能选择父节点（" + nodes[i].name + "）请重新选择。");
                    return false;
                }
                if (!module && selectScopeModule) {
                    if (nodes[i].module == "") {
                        toastr.warning("不能选择公共模型（" + nodes[i].name + "）请重新选择。");
                        return false;
                    } else if (nodes[i].module != module) {
                        toastr.warning("不能选择当前栏目以外的栏目模型，请重新选择。");
                        return false;
                    }
                }
                ids.push(nodes[i].id);
                var t_node = nodes[i];
                var t_name = "";
                var name_l = 0;
                do {
                    name_l++;
                    t_name = t_node.label + " " + t_name;
                    t_node = t_node.getParentNode();
                } while (name_l < nameLevel);
                names.push(t_name);
                if (checked != "true")break; // 如果为非复选框选择，则返回第一个选择
            }
            $thizVal.val(ids);
            $thiz.val(names);
            if (albedo.isExitsVariable(selectedValueFn) && albedo.isExitsFunction(selectedValueFn)) {
                eval(selectedValueFn + "('" + ids + "','" + names + "')");
            }
            $modal.modal("hide");
        });
        App.initSlimScroll('.scroller');
        if (allowClear) {
            $modal.off('click', '.clear').on('click', '.clear', function () {
                $thizVal.val("");
                $thiz.val("");
                $modal.modal("hide");
            });
        }
    };

    var $tempStoreForm;

    var handleGridSelect = function ($thiz, $thizVal) {
        // 是否限制选择，如果限制，设置为disabled
        if ($thizVal.attr("disabled")) {
            return true;
        }

        var name = $thiz.attr("name"), id = $thizVal.attr("id"), colNames = $thiz.attr("_colNames"),
            gridOptions = $thiz.attr("_gridOptions"), colModel = $thiz.attr("_colModel"),
            searchFormId = $thiz.attr("_searchFormId"),
            url = $thiz.attr("_url") ? $thiz.attr("_url") : "",
            checked = $thiz.attr("_checked") == "true" ? true : false,
            disableDblClickRow = $thiz.attr("_disableDblClickRow") == "true" ? true : false,
            extId = $thiz.attr("_extId") ? $thiz.attr("_extId") : "",
            width = $thiz.attr("_width") ? $thiz.attr("_width") : 920,
            height = $thiz.attr("_height") ? $thiz.attr("_height") : 735,
            pageSize = $thiz.attr("_pageSize") ? $thiz.attr("_pageSize") : 10,
            title = $thiz.attr("_title") ? $thiz.attr("_title") : "",
            value = $thizVal.val() ? $thizVal.val() : "",
            allowClear = $thiz.attr("_allowClear") ? $thiz.attr("_allowClear") : "",
            showProperty = $thiz.attr("_showProperty") ? $thiz.attr("_showProperty") : "name",
            selectedValueFn = $thiz.attr("_selectedValueFn") ? $thiz.attr("_selectedValueFn") : "",
            grid_select_ = "#" + id + '-grid-table', pager_select_ = "#" + id + '-grid-pager';

        if (name && name.indexOf(".") != -1) name = name.replace(".", "-");

        var thStr = "";
        if (colNames) {
            var thOption = eval(colNames);
            for (var i = 0; i < thOption.length; i++) {
                var th = thOption[i];
                if (th && th.name) {
                    thStr += ("<th" + (th.width ? " width=" + th.width : "") + (th.cssClass ? " class=" + th.cssClass : "") + ">" + th.name + "</th>");
                } else if (th && typeof(th) == "string") {
                    thStr += ("<th>" + th + "</th>");
                }
            }
        }

        var html = '<div id="' + name + 'GridModal" class="modal modal-dialog fade" tabindex="-1" data-focus-on="input:first">' +
            '<div class="modal-header">' +
            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>' +
            '<h4 class="modal-title">' + (title ? title : "数据选择") + '</h4>' +
            '</div>' +
            '<div class="modal-body albedo-gridSelect-div albed-gridSelect-' + name + '">' +
            '<hr /><div id="bootstrap-alerts"></div>' +
            '<table class="table table-striped table-bordered table-hover dataTable no-footer dt-responsive" id="data-table-' + id + '"><thead>' +
            '<tr role="row" class="heading">' + thStr +
            '</tr></thead>' +
            '</table>' +
            '</div>' +
            '<div class="modal-footer">' +
            '<button type="button" class="btn blue confirm">确定</button>' +
            '<button type="button" class="btn default" data-dismiss="modal">关闭</button>' +
            (allowClear ? '<button type="button" class="btn blue clear">清除</button>' : '') +
            '</div>' +
            '</div>';
        var $modal = $(html);
        var ids = [], names = [], nodes = [];

        if ($(searchFormId).find("form") && $(searchFormId).find("form").length > 0) {
            $tempStoreForm = $(searchFormId).find("form").clone(true);
        }

        $modal.modal({width: width}).find(".albedo-gridSelect-div").prepend($tempStoreForm);

        App.initUniform($modal.find(":radio, :checkbox"));

        var $tableTarget = $modal.find("#data-table-" + id);
        var gridSelect = new Datatable();
        try {
            eval("gridOptions=" + gridOptions);
        } catch (e) {
        }
        gridOptions = $.extend(true, {
            "formSearch": $modal.find(".form-search"),
            "ajax": {
                "url": url,
                type: 'GET',
                "dataType": 'json'
            },
            "dom": "<'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
            "columns": eval(colModel),
            "rowCallback": function (row, data) {
                if (value) {
                    var selected = value.split(",");
                    if ($.inArray(data.id, selected) !== -1) {
                        $(row).addClass('selected');
                        ids.push(data.id);
                        names.push(eval("data." + showProperty));
                        nodes.push(data);
                    }
                }
            }
        }, gridOptions);

        gridSelect.init({
            src: $tableTarget,
            dataTable: gridOptions
        });

        $tableTarget.on('xhr.dt', function (e, settings, rsData, xhr) {
            $modal.find("#data-table-" + id + ' tbody').off('click', 'tr').on('click', 'tr', function () {
                var id = this.id;
                if (!checked) {
                    ids = [], names = [], nodes = [];
                }
                if (checked && $(this).attr("class").indexOf("selected") != -1) { //取消 选择
                    ids.removeByValue(id);
                    for (var index = 0; index < rsData.data.length; index++) {
                        var item = rsData.data[index];
                        if (item.id == id) {
                            names.removeByValue(eval("item." + showProperty));
                            nodes.removeByValue(item);
                            break;
                        }
                    }
                } else {
                    ids.push(id);
                    for (var index = 0; index < rsData.data.length; index++) {
                        var item = rsData.data[index];
                        if (item.id == id) {
                            eval("names.push(item." + showProperty + ")");
                            nodes.push(item);
                        }
                    }
                }
                if (!checked) {
                    $(this).parents('tbody').find('tr').removeClass("selected");
                }
                $(this).toggleClass('selected');
            })
            $modal.find("#data-table-" + id + ' tbody').off('dblclick', 'tr').on('dblclick', 'tr', function () {
                var id = this.id;
                if (!checked && !disableDblClickRow && rsData) {
                    var ids = [], names = [], nodes = [];
                    ids.push(id);
                    for (var index = 0; index < rsData.data.length; index++) {
                        var item = rsData.data[index];
                        if (item.id == id) {
                            eval("names.push(item." + showProperty + ")");
                            nodes.push(item);
                        }
                    }
                    $thizVal.val(ids);
                    $thiz.val(names);
                    if (albedo.isExitsVariable(selectedValueFn) && albedo.isExitsFunction(selectedValueFn)) {
                        eval(selectedValueFn + "('" + ids + "','" + names + "',nodes)");
                    }
                    $modal.modal("hide");
                }
            });
            albedoForm.init($modal);
        })


        $modal.off('click', '.filter-submit-table').on('click', '.filter-submit-table', function () {
            gridSelect.submitFilter();
        }).off('click', '.confirm').on('click', '.confirm', function () {
            if (checked) {
                if (ids.length <= 0) {
                    toastr.warning("请至少选择一条数据");
                    return false;
                }
            } else {
                if (ids.length != 1) {
                    toastr.warning("请选择一条数据");
                    return false;
                }
            }
            $thizVal.val(ids);
            $thiz.val(names);
            if (albedo.isExitsVariable(selectedValueFn) && albedo.isExitsFunction(selectedValueFn)) {
                eval(selectedValueFn + "('" + ids + "','" + names + "',nodes)");
            }
            $modal.modal("hide");
        });
//		App.initSlimScroll('.scroller');
        if (allowClear) {
            $modal.off('click', '.clear').on('click', '.clear', function () {
                $thizVal.val("");
                $thiz.val("");
                $modal.modal("hide");
            });
        }
    };
    var handleDateTimePicker = function ($tagert) {

        if (!jQuery().datetimepicker) {
            return;
        }
        $tagert = ($tagert && $tagert.length > 0) ? $tagert.find('.date-time-picker') : $('.date-time-picker');
        $tagert.each(function () {
            var $tempInput = $tagert.find("input");
            eval("var options=" + ($tempInput && $tempInput.length > 0 ? $tempInput.attr("options") : $(this).attr("options")));
            // default settings
            options = $.extend(true, {
                language: 'zh-CN',
                autoclose: true,
                isRTL: App.isRTL(),
                format: "yyyy-mm-dd hh:ii:ss",
                pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
            }, options);
            // $("div.datetimepicker.dropdown-menu").remove();
            $(this).off("click");
            $(this).datetimepicker("remove").datepicker("remove");
            $(this).datetimepicker(options);
        });
        $('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
    }
    var handleDatePicker = function ($tagert) {
        $tagert = ($tagert && $tagert.length > 0) ? $tagert.find('.date-picker') : $('.date-picker');
        $tagert.each(function () {
            var $tempInput = $tagert.find("input");
            eval("var options=" + ($tempInput && $tempInput.length > 0 ? $tempInput.attr("options") : $(this).attr("options")));
            // default settings
            options = $.extend(true, {
                language: 'zh-CN',
                autoclose: true,
                isRTL: App.isRTL(),
                format: "yyyy-mm-dd"
            }, options);
            // $("div.datetimepicker.dropdown-menu").remove();
            $(this).datetimepicker("remove").datepicker("remove");
            $(this).datepicker(options);
        });
    };
    var handleFileUpload = function ($tagert) {
        $tagert = ($tagert && $tagert.length > 0) ? $tagert.find('input[type="file"]') : $('input[type="file"]');
        var clearVal = function () {
            var $parent = $(this).parents(".fileinput");
            var $file = $parent.find("input[type='hidden']");
            var tempVal = "," + $file.val() + ",";
            tempVal = tempVal.replace($(this).attr("img-value") + ",", "");
            tempVal = tempVal.length > 2 ? tempVal.substring(1, tempVal.length - 1) : "";
            $file.val(tempVal);
            $(this).parent(".fileinput-preview").remove();
            if (tempVal == "") {
                $parent.attr("class", "fileinput fileinput-new");
            }
        };


        $tagert.length > 0 && $tagert.fileupload && $tagert.each(function () {
            var options = $(this).attr("options"), $parent = $(this).parents(".fileinput"),
                multiple = $(this).attr("multiple"), showType = $(this).attr("showType");

            options = $.extend(true, {
                autoUpload: true,
                singleFileUploads: false,
                url: App.getCtxPath() + "/file/upload",
                type: "POST",
                dataType: 'json',
                done: function (e, data) {
                    if (data && data.result && data.result.status == 1) {
                        var files = data.result.data;
                        var $preview = $parent.find(".btn-img-div");
                        if ("image" == showType) {
                            $parent.find(".fileinput-exists.fileinput-preview").remove();
                            if (multiple) {
                                var fileVal = $parent.find("input[type='hidden']").val();
                                $parent.find("input[type='hidden']").val(fileVal && fileVal.length > 0 ? (fileVal + "," + files) : files);
                                fileVal = $parent.find("input[type='hidden']").val();
                                if (fileVal) {
                                    var fileArray = fileVal.split(',');
                                    for (var i = 0; i < fileArray.length; i++) {
                                        if (i < fileArray.length && fileArray[i] && typeof(fileArray[i]) == "string") $preview.before($("<div class=\"fileinput-preview fileinput-exists thumbnail\" ></div>").append(
                                            $("<img title='双击移除' src='" + App.getCtxPath() + "/file/get" + fileArray[i] + "' class=\"fileinput-img\" img-value=\"" + fileArray[i] + "\" />").dblclick(clearVal)));
                                    }
                                }
                            } else {
                                $preview.before($("<div class=\"fileinput-preview fileinput-exists thumbnail\" ></div>").append(
                                    $("<img title='双击移除' src='" + App.getCtxPath() + "/file/get" + files + "' class=\"fileinput-img\" img-value=\"" + files + "\" />").dblclick(clearVal)));
                                $parent.find("input[type='hidden']").val(files);
                            }
                        } else {
                            $parent.find(".form-control").attr("title", files).val(files);
                            $parent.find("input[type='hidden']").val(files);
                        }

                    } else {
                        toastr.warning(data.result.msg);
                    }
                }
            }, options);
            $(this).fileupload(options);
            var $parent = $(this).parents(".fileinput");
            $parent.find(".fileinput-remove").click(function () {
                $parent.find("input[type='hidden']").val('');
                if ("image" == showType) {
                    $parent.find(".fileinput-preview").remove();
                } else {
                    $parent.find(".form-control").attr("title", '').val('');
                }
            });
            $parent.find(".fileinput-img").dblclick(clearVal);

        });
    };

    //* END:CORE HANDLERS *//

    return {
        initDateTimePicker: function ($tagert) {
            handleDateTimePicker($tagert);
        }, initDatePicker: function ($tagert) {
            handleDatePicker($tagert);
        }, gridSelect: function ($thiz, $thizVal) {
            handleGridSelect($thiz, $thizVal);
        }, treeSelect: function ($thiz, $thizVal) {
            handleTreeSelect($thiz, $thizVal);
        },
        initTree: function ($tagertShowTree) {
            $tagertShowTree = ($tagertShowTree && $tagertShowTree.length > 0) ? $tagertShowTree.find(".ztree-show") : $(".ztree-show");
            $tagertShowTree.each(function () {
                treeShow($(this));
            });
        },

        initFileUpload: function ($tagert) {
            handleFileUpload($tagert);
        },

        //main function to initiate the theme
        init: function ($tagert) {
            handleDateTimePicker($tagert);
            handleDatePicker($tagert);
            handleFileUpload($tagert);
            albedoForm.initTree($tagert);
            if ($tagert && $tagert.length > 0) {
                var exp = "input[type=checkbox]:not(.toggle, .md-check, .md-radiobtn, .make-switch, .icheck), input[type=radio]:not(.toggle, .md-check, .md-radiobtn, .star, .make-switch, .icheck)";
                App.initUniform($tagert.find(exp));
            }
            ;
        }
    }
}();
jQuery(document).ready(function () {
    albedoForm.init(); // init core componets
});

