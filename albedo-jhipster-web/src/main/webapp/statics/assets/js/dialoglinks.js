/*
* 加载对话框
* 在<a>标签上加上类dialog，通过jquery来加载一个页面
* 属性data-url：需要加载的页面的url地址
* 属性data-table-id：关闭对话框后需要刷新数据的datatable
* 属性data-refresh：是否刷新当前页面
* 属性data-delay：关闭对话框后延迟加载的时间，单位毫秒
* 
* 
* */
var UIExtendedModals = function () {
	var formInit = function($targetEvent){
    	$targetEvent.find(".mask").each(function(){
            $(this).inputmask($(this).attr("mask-format"), {
                placeholder: "",
                clearMaskOnLostFocus: true
            });
        })
        albedoForm.init($targetEvent);
        FormValidation.init($targetEvent.find('.form-validation'));
        UIExtendedModals.select2($targetEvent);
    };
    return {
    	index: function(){
    		albedo.setUserCookie("module-load-url", "");
    		location.href=App.getCtxPath()+"/index";
    	},
    	login: function(){
    		location.href=App.getCtxPath()+"/login";
    	},
    	initPage: function(){
    		var self=this;
            // general settings
            $(document).off("click.pageModal").on("click.pageModal", "a.pageModal", function () {
            	var el = $(this);
            	Layout.setSidebarMenuActiveLink("click", el);
            	App.scrollTo();
            	$(".page-content-wrapper").find(".page-content .row").remove();
                var $modal = $(".page-content-wrapper").find(".page-content");
                var loadUrl = el.attr('data-url'),loadUrlName = el.attr('data-url-name'),target = el.attr('data-target');
                if(target){
                	albedo.setUserCookie("module-load-url", "");
                	window.open(loadUrl,target);
                	return;
                }
                albedo.setUserCookie("module-load-url-name", loadUrlName);
                try{
                $modal.load(loadUrl, function () {
                	$('body').modalmanager('removeLoading');
                	
                	try{
                		eval("var rs = "+$modal.text());
						if(rs && rs.status!="1"){
							toastr.error(rs.message, {closeButton:true,positionClass: 'toast-bottom-right'})
							if(rs.status=="-99"){
								$modal.text("");
								UIExtendedModals.login();
								return;
							}
							flag = false;
							$modal.modal('hide');
							return;
						}
                	}catch (e) {
					}
					UIExtendedModals.initDialog();
					formInit($modal);
					App.initSlimScroll('.scroller');
                });
                }catch (e) {
                	console.log(e);
                	App.unblockUI();
    			}
            });
            
            var requestUrl = location.href, loadUrlName =  requestUrl.substring(requestUrl.lastIndexOf("#")+1,requestUrl.length);
            if(!loadUrlName){
            	loadUrlName = albedo.getUserCookie("module-load-url-name");
            }
            if(loadUrlName){
            	var $targetItem = $("a.pageModal[data-url-name='"+loadUrlName+"']");
            	if($targetItem && $targetItem.length>0){
            		$targetItem.trigger("click");
            	}else{
            		loadUrlName = albedo.getUserCookie("module-load-url-name");
            		$("a.pageModal[data-url-name='"+loadUrlName+"']").trigger("click");
            	}
            	
            }
            
    	},
        initDialog: function () {
            var self = this;
            // general settings
            self.initBootbox();
            $(document).off("click.dialog").on("click.dialog", "a.dialog", function () {
                var el = $(this);
                var $modal = $($(this).data('modal-id')||'#ajax-modal');
                $('body').modalmanager('loading');
                var loadUrl = el.attr('data-url'),isModal = el.data("is-modal") == true ? true : false;
                $modal.load(loadUrl+(loadUrl.indexOf("?")==-1? "?" : "&")+'isModal='+isModal, function () {
                	var flag = true;
                	try{
                		eval("var rs = "+$modal.text());
						if(rs && rs.status!="1"){
							flag = false;
							App.alert({ 
								container: el.parents(".portlet").find("#bootstrap-alerts") || el.parents(".portlet").find(".portlet-body") || $("#bootstrap-alerts"),
			                	place: 'prepend',
			                    close: true,
			                    focus: true,
			                    type: "warning",
			                    closeInSeconds: 8,
			                    message: (rs && rs.message) ? rs.message : '网络异常，请检查您的网络!',
			                    icon: "warning" 
			                });
							$('body').modalmanager('removeLoading');
							$modal.modal('hide');
							return;
						}
                	}catch (e) {
					}
                	if(flag){
                		flag = isModal;
                	}
                    var $targetEvent = $modal;
					if(flag){
						$modal.prepend('<div id="target_table" data-delay="'+(el.data("delay")||false)+'" data-refresh="'+(el.data("refresh")||false)+'" data-table-id="'+el.attr("data-table-id")+'"></div>');
	                    $.fn.modal.defaults.width=el.data('modal-width');
						$modal.modal({width: el.data('modal-width')});
					}else{
						$modal.modal('hide');
						$('body').modalmanager('removeLoading');
                        el.parents(".portlet").siblings('.portlet').hide();
						el.parents(".portlet").hide().after($modal.find(".portlet").attr("portlet-id", el.data("table-id")));
						$targetEvent = el.parents(".row").find(".portlet[portlet-id='"+el.data("table-id")+"']");
						$modal.empty();
					}
                    formInit($targetEvent);
					$targetEvent.off('click', '.list').on('click', '.list', function () {
	                    $(this).parents(".portlet").remove();
	                    $($(this).attr("data-table-id")).parents(".portlet").show()
	                });
					
					$(document).off("keydown").keydown(function(e){ 
						if (e.which == 13) {
		                    if(FormValidation.validate()){
								App.confirm({
									content: "您确定要提交表单数据吗？",
					        		width: null, // "append" or "prepend" in container 
					                confirm:function(){
					                	$targetEvent.find(".add, .update").trigger("click");
					                }
					            });
		                    }
			            }
					}); 
					
					$targetEvent.off('click', '.add, .update').on('click', '.add, .update', function () {
	                    var operation = $(this).hasClass("add") ? 'add' : 'update', $form = $targetEvent.find('.form-validation'), validateFun = $form.attr("validateFun"), 
	                    flag = true;
	                    if(FormValidation.validate()){
	                    	albedo.isExitsFunction(validateFun) && eval("flag = "+validateFun+"()");
	                    	if(flag){
		                        $targetEvent.modal('loading');
		                        var url = $form.attr("action");
		                        $.ajax({
		                            url: url,
		                            type: $form.attr("method")||"POST",
		                            // data: JSON.stringify($form.serializeObject()),
                                    data: self.getValue($form.serialize()),
		                            dataType: "json",
		                            timeout: 60000,
		                            success: function (re) {
		                                self.alertDialog($targetEvent, re, el);
		                            },
		                            error: function (XMLHttpRequest, textStatus, errorThrown) {
		                            	console.log(errorThrown);
		                                self.alertDialog($targetEvent, null, el);
		                            }
		                        });
	                    	}
	                    }
	                });
                });
            });
        },
        alertDialog: function ($modal, re, el) {
        	var alertType="warning", icon = "warning",isModal= el && el.data("is-modal") == true;
            try{$modal.modal('removeLoading');}catch(e){}
            var isForm = $modal.find('.form-validation').length>0;
            if (re && el) {
            	var tableId=el.data("table-id"),refresh=el.data("refresh"),delay=el.data("delay"),
            	alertType = re.status=="0" ? "info" : re.status=="1" ? "success" : re.status=="-1" ? "danger" : "warning";
            	icon = re.status=="0" ? "info" : re.status=="1" ? "check" : "warning";
            	if(re.status=="1" && (tableId||refresh)){
            		if (refresh){
                        window.location.reload();
                    }else {
                    	if(!isModal){
                    		$modal.find(".list").trigger("click");
                    	}
                        if (delay) {
                            $modal.modal('loading');
                            setTimeout(function () {
                                $(tableId).DataTable().ajax.reload();
                                $modal.modal('removeLoading');
                            }, delay)
                        }else {
                            $(tableId).DataTable().ajax.reload();
                        }
                        var ajaxReloadAfterFu = el.data("reload-after");
                        if(albedo.isExitsFunction(ajaxReloadAfterFu)){
                        	eval(ajaxReloadAfterFu+"(re)");
                        }
                    }
            		isForm = false;
            	}
            }
        	if(!isForm) $modal.modal('hide');
        	App.alert({ 
            	container: isForm ? $modal.find('#bootstrap-alerts') : el.parents(".portlet").find('#bootstrap-alerts'), 
                close: true,
                focus: true,
                type: alertType,
                closeInSeconds: 8,
                message: (re && re.message) ? re.message : '网络异常，请检查您的网络!',
                icon: icon 
            });
            
        },
        getValue: function (datastr) {
            var obj = {};
            datastr = datastr.split('&');
            for (var i = 0; i < datastr.length; i++) {
                var key = datastr[i].substr(0, datastr[i].indexOf('=')),
                    value = datastr[i].substr(datastr[i].indexOf('=') + 1);
                if (!obj[key]) {
                    obj[key] = value;
                } else {
                    obj[key] = obj[key].concat(',', value);
                }
            }
            datastr = "";
            for (var key in obj) {
                datastr += '&' + key + '=' + obj[key];
                //(key.indexOf('password') > -1 && (obj[key] != '') ? $.md5(decodeURIComponent(obj[key])) : obj[key]);
            }
            return datastr;
        },
        initBootbox: function () {
            var self=this;
            $(document).off("click.confirm").on("click.confirm", "a.confirm", function () {
                var el = $(this);
                $(document).off("keydown");
                App.confirm({
					content: el.data("title")||"确认删除？",
	                confirm:function($modal){
	                     $.ajax({
	                         url: el.attr("data-url"),
	                         type: el.data("method")||"POST",
	                         dataType: "json",
	                         timeout: 15000,
	                         success: function (re) {
	                             self.alertDialog($modal, re, el);
	                         },
	                         error: function (XMLHttpRequest, textStatus, errorThrown) {
	                        	 console.log(XMLHttpRequest);
	                             self.alertDialog($modal, null, el);
	                         }
	                     });
	                }
	            });
            });
        },
        select2:function($tagert) {
        	if(!$tagert || $tagert.length<=0){
        		return;
        	}
            var placeholder = "请选择";

            $tagert.find(".select2, .select2-multiple").select2({
                placeholder: placeholder,
                width: null
            });

            $tagert.find(".select2-allow-clear").select2({
                allowClear: true,
                placeholder: placeholder,
                width: null
            });
//            $tagert.find("select[name*='data-table-']").select2({
//                allowClear: false,
//                placeholder: placeholder,
//                width: 80
//            });
            // @see https://select2.github.io/examples.html#data-ajax
            function formatRepo(repo) {
                if (repo.loading) return repo.text;

                var markup = "<div class='select2-result-repository clearfix'>" +
                    "<div class='select2-result-repository__avatar'><img src='" + repo.owner.avatar_url + "' /></div>" +
                    "<div class='select2-result-repository__meta'>" +
                    "<div class='select2-result-repository__title'>" + repo.full_name + "</div>";

                if (repo.description) {
                    markup += "<div class='select2-result-repository__description'>" + repo.description + "</div>";
                }

                markup += "<div class='select2-result-repository__statistics'>" +
                    "<div class='select2-result-repository__forks'><span class='glyphicon glyphicon-flash'></span> " + repo.forks_count + " Forks</div>" +
                    "<div class='select2-result-repository__stargazers'><span class='glyphicon glyphicon-star'></span> " + repo.stargazers_count + " Stars</div>" +
                    "<div class='select2-result-repository__watchers'><span class='glyphicon glyphicon-eye-open'></span> " + repo.watchers_count + " Watchers</div>" +
                    "</div>" +
                    "</div></div>";

                return markup;
            }

            function formatRepoSelection(repo) {
                return repo.full_name || repo.text;
            }

            $tagert.find(".js-data-example-ajax").each(function(){
            	eval("var options="+$(this).attr("options"));
            	// default settings
                options = $.extend(true, {
                    width: "off",
                    ajax: {
//                        url: "https://api.github.com/search/repositories",
                        dataType: 'json',
                        delay: 250,
                        data: function(params) {
                            return {
                                q: params.term, // search term
                                page: params.page
                            };
                        },
                        processResults: function(data, page) {
                            // parse the results into the format expected by Select2.
                            // since we are using custom formatting functions we do not need to
                            // alter the remote JSON data
                            return {
                                results: data.items
                            };
                        },
                        cache: true
                    },
                    escapeMarkup: function(markup) {
                        return markup;
                    }, // let our custom formatter work
                    minimumInputLength: 1,
                    templateResult: formatRepo,
                    templateSelection: formatRepoSelection
                }, options);
            	
            	$(this).select2(options);
            });

            $tagert.find("button[data-select2-open]").click(function() {
                $("#" + $(this).data("select2-open")).select2("open");
            });

            $tagert.find(":checkbox").on("click", function() {
                $(this).parent().nextAll("select").prop("disabled", !this.checked);
            });

            // copy Bootstrap validation states to Select2 dropdown
            //
            // add .has-waring, .has-error, .has-succes to the Select2 dropdown
            // (was #select2-drop in Select2 v3.x, in Select2 v4 can be selected via
            // body > .select2-container) if _any_ of the opened Select2's parents
            // has one of these forementioned classes (YUCK! ;-))
            $tagert.find(".select2, .select2-multiple, .select2-allow-clear, .js-data-example-ajax").on("select2:open", function() {
                if ($(this).parents("[class*='has-']").length) {
                    var classNames = $(this).parents("[class*='has-']")[0].className.split(/\s+/);

                    for (var i = 0; i < classNames.length; ++i) {
                        if (classNames[i].match("has-")) {
                            $("body > .select2-container").addClass(classNames[i]);
                        }
                    }
                }
            });

            $tagert.find(".js-btn-set-scaling-classes").on("click", function() {
                $("#select2-multiple-input-sm, #select2-single-input-sm").next(".select2-container--bootstrap").addClass("input-sm");
                $("#select2-multiple-input-lg, #select2-single-input-lg").next(".select2-container--bootstrap").addClass("input-lg");
                $(this).removeClass("btn-primary btn-outline").prop("disabled", true);
            });
        }
    };
}();

jQuery(document).ready(function () {
	$.fn.select2.defaults.set("theme", "bootstrap");
    $.fn.modal.defaults.spinner = $.fn.modalmanager.defaults.spinner =
        '<div class="loading-spinner" style="width: 200px; margin-left: -100px;">' +
        '<div class="progress progress-striped active">' +
        '<div class="progress-bar" style="width: 100%;"></div>' +
        '</div>' +
        '</div>';
    $.fn.modalmanager.defaults.resize = true;
    UIExtendedModals.initPage();
    UIExtendedModals.initDialog();
});