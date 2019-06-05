        <div class="x_panel" style="height: 500px;">
            <div class="modal-header" style="padding: 5px">
                <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                        data-dismiss="modal">返回
                </button>
                <button id="btn_sure_projcet" type="button" class="btn btn-default"
                        style="margin-bottom:0px;margin-right:0px" title="确认领用">
                    确认
                </button>
            </div>
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="chooseProjectformSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name">
                            </div>
                            <div class="col-sm-4" style="text-align:left;">
                                <button type="button" style="margin-left:50px" id="chooseProject_btn_query" class="btn btn-primary">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="x_content">
                <div class="<#--table-responsive-->">
                    <table id="choose_project_tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
                    </table>
                </div>
            </div>
        </div>
<script>
    var choose_projcet_options = {
        url: "/custmgt/project/chooseList",
        getInfoUrl: "/custmgt/project/get/{id}",
        updateUrl: "/custmgt/project/edit",
        removeUrl: "/custmgt/project/remove",
        createUrl: "/custmgt/project/add",
        columns: [
            {   checkbox: true,
                width: 25
            },
            {
                field: 'id',
                title: '序号',
                visible: false
            },
            {
                field: 'personId',
                title: '关联客户',
                visible: false
            }, {
                field: 'number',
                title: '编号',
                width: 50,
                formatter: function (data, row) {
                    return '<a href="javascript:;" onclick="viewPorject(' + row.id + ')">' + data + '</a>'
                }
            }, {
                field: 'name',
                title: '名称',
                width: 50,
                formatter: function (data, row) {
                    return '<a href="javascript:;" onclick="viewPorject(' + row.id + ')">' + data + '</a>'
                }
            }, {
                field: 'companyName',
                title: '公司名称',
                editable: false,
                width: 120
            }, {
                field: 'startTime',
                title: '开工日期',
                editable: false,
                width: 50
            }, {
                field: 'endTime',
                title: '完工日期',
                editable: false,
                width: 50
            }, {
                field: 'period',
                title: '工期',
                editable: false,
                width: 30
            }, {
                field: 'owner',
                title: '甲方负责人',
                editable: false,
                width: 50
            }, {
                field: 'pmName',
                title: '项目经理',
                editable: false,
                width: 50
            }
        ],
        modalName: "项目"
    };
    $('#choose_project_tablelist').bootstrapTable('destroy');
    //1.初始化Table
    $('#choose_project_tablelist').bootstrapTable({
        url: choose_projcet_options.url+"?excludeIds="+addProjectList.join(",")+"&personId="+$('#addOrUpdateForm #id').val(),
        method: 'post',                      //请求方式（*）
        toolbar: '#choose_project_toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        sortStable: true,                   // 设置为 true 将获得稳定的排序
        queryParams: projectqueryParams,//传递参数（*）
        queryParamsType: '',
        pagination: true,                   //是否显示分页（*）
        sidePagination: 'server',           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,                       //初始化加载第一页，默认第一页
        pageSize: 10,                       //每页的记录行数（*）
        pageList: [10, 20, 30, 50, 100],        //可供选择的每页的行数（*）
        search: false,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
        strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
        searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
        minimumCountColumns: 1,             //最少允许的列数
        showRefresh: false,
        columns: choose_projcet_options.columns
    });

    //查询
    $('#chooseProject_btn_query').on('click', function () {
        $("#choose_project_tablelist").bootstrapTable('refresh', {url: choose_projcet_options.url});
    });

    $("#btn_sure_projcet").click(function () {
        var selecteded = $("#choose_project_tablelist").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }
        //解决重复点击事件
        $(this).off();
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            //添加临时id
            addProjectList.push(s.id);
            var count = $('#project_tablelist').bootstrapTable('getData').length;
            var row = {index:count,row:{
                "id":s.id,
                "rowId" :"",
                "number" : s.number,
                "name" : s.name,
                "companyName" : s.companyName,
                "startTime" : s.startTime,
                "endTime" : s.endTime,
                "period" : s.period,
                "owner" : s.owner,
                "pmName" : s.pmName,
                "personId": s.personId
            }};
            $("#project_tablelist").bootstrapTable('insertRow', row);
        }
        $('#choose_list').modal('hide');
    });

//    function view(id) {
//        $.ajax({
//            type: "post",
//            async: false,
//            url: "/custmgt/project/get/" + id,
//            success: function (json) {
//                var data = json.data;
//                resetViewForm(data);
//                $("#viewModal").modal('show');
//            },
//            error: $.tool.ajaxError
//        });
//    }

    function projectqueryParams(params) {
        params = $.extend({}, params);
        //获取搜索框的值
        var name = {'custProjectEntity.name': $("#chooseProjectformSearch #name").val()};
        params = $.extend(params, name);
        return params;
    }
</script>