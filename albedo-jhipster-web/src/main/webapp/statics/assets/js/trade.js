var TableDatatablesResponsive = function () {

    var initTable1 = function () {
        var grid = new Datatable();
        grid.init({
            src: $("#vip_order"),
            onSuccess: function (grid, response) {
                // grid:        grid object
                // response:    json object of server side ajax response
                // execute some code after table records loaded
            },
            onError: function (grid) {
                // execute some code on network or other general error
            },
            onDataLoad: function(grid) {
                // execute some code on ajax data load
            },
            loadingMessage: 'Loading...',
            dataTable: { // here you can define a typical datatable settings from http://datatables.net/usage/options
                language: albedo.language,
                // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
                // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/scripts/datatable.js).
                // So when dropdowns used the scrollable div should be removed.
                "dom": "<'row'<'col-md-8 col-sm-12'><'col-md-4 col-sm-12'<'table-group-actions pull-right'>>r>t<'row'<'col-xs-5'li><'col-xs-7'p>>",
                "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.
                "pagingType": "bootstrap_full_number",
                "serverSide": true,
                "lengthMenu": [
                    [10, 20, 50, 100, 150],
                    [10, 20, 50, 100, 150] // change per page values here
                ],
                "pageLength": 10, // default record count per page
                "ajax": {
                    "url": ctx+"/sys/staff/findList", // ajax source
                    data: function (d) {
                        var pm = {};
                        pm.draw=d.draw;
                        pm.pageSize=d.length;
                        pm.pageNo=d.start/d.length+1;
                        var column = d.columns[d.order[0].column];
                        pm.sortName = column.name ? column.name : column.data;
                        pm.sortOrder = d.order[0].dir;
                        pm.queryConditionJson = albedo.parseJsonItemForm();
                        return pm;
                    }
                },
                "columns": [
                    {data: function ( row, type, val, meta ) {return '<input type="checkbox" class="group-checkable" />';}},
                    { data: "orgName","name":"org.name" },
                    { data: "loginId" },
                    { data: "status" },
                    { data: "name","defaultContent": "" },
                    { data: "mobile" },
                    { data: "type" },
                    { data: "roleNames", orderable:false, searchable:false },
                    { orderable:false, searchable:false, data: function ( row, type, val, meta ) {return "<a href=''>编辑</a>"+"<a href='javascript:void'>删除</a>";} }
                ],
                "order": [
                    [1, "asc"]
                ]// set first column as a default sort by asc
            }
        });
    }

    return {
        //main function to initiate the module
        init: function () {

            if (!jQuery().dataTable) {
                return;
            }
            initTable1();
        }

    };

}();

jQuery(document).ready(function() {
    TableDatatablesResponsive.init();
});