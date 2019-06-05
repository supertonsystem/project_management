        <div>
            <div class="btn-group hidden-xs" id="project_toolbar">
            <@shiro.hasPermission name="custmgt:project:add">
                <button id="btn_add_project" type="button" class="btn btn-xs btn-default" title="新增">
                    <i class="fa fa-plus"></i> 新增
                </button>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="custmgt:project:delete">
                <button id="btn_delete_project_ids" type="button" class="btn btn-xs btn-default" title="删除选中">
                    <i class="fa fa-trash-o"></i> 删除
                </button>
            </@shiro.hasPermission>

            </div>
            <table id="project_tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
            </table>
        </div>
<script>
    var project_options = {
        url: "/custmgt/project/projectRelationList",
        getInfoUrl: "/custmgt/project/get/{id}",
        removeUrl: "/custmgt/project/remove",
        columns: [],
        modalName: "项目"
    };
    var projcet_url;
    function addUpdateProjectTable(personId,operation) {
        if(operation!='view'){
            project_options.columns=[
                {   checkbox: true,
                    width: 25
                },
                {
                    field: 'id',
                    title: '唯一标识',
                    editable: false,
                    visible: false,
                    width: 40
                },{
                    field: 'rowId',
                    title: '序号',
                    width: 40,
                    formatter:function(value,row,index){
                        row.rowId=index;
                        return index+1;
                    }
                }, {
                    field: 'number',
                    title: '编号',
                    width: 50
                }, {
                    field: 'name',
                    title: '项目名称',
                    width: 100,
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
                }, {
                    field: 'personId',
                    title: '关联id',
                    visible: false
                }
            ];
            $('#project_toolbar').show();
        }else{
            project_options.columns=[
                {
                    field: 'id',
                    title: '唯一标识',
                    editable: false,
                    visible: false,
                    width: 40
                },{
                    field: 'rowId',
                    title: '序号',
                    width: 40,
                    formatter:function(value,row,index){
                        row.rowId=index;
                        return index+1;
                    }
                }, {
                    field: 'number',
                    title: '编号',
                    width: 50
                }, {
                    field: 'name',
                    title: '项目名称',
                    width: 100,
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
                }, {
                    field: 'personId',
                    title: '关联id',
                    visible: false
                }
            ];
            $('#project_toolbar').hide();
        }
        addProjectList = [];
        projcet_url=project_options.url + "?personId=" + personId;

        $('#project_tablelist').bootstrapTable('destroy');

        $('#project_tablelist').bootstrapTable({
            url:projcet_url,
            method: 'post',                      //请求方式（*）
            toolbar: '#project_toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sortStable: true,                   // 设置为 true 将获得稳定的排序
            queryParamsType: '',
            pagination: false,                   //是否显示分页（*）
            sidePagination: 'client',           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 100,                       //每页的记录行数（*）
            pageList: [100, 200, 300, 500, 1000],        //可供选择的每页的行数（*）
            search: false,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
            strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
            searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
            minimumCountColumns: 1,             //最少允许的列数
            showRefresh: false,
            columns: project_options.columns
        });
    }
    $("#btn_add_project").click(function () {
        $('#choose_list .modal-content').html('');
        //如果是a链接，阻止其跳转到url页面
        event.preventDefault();
        //将id为deadAdd的页面元素作为模态框激活
        $('#choose_list').modal();
        //从url加载数据到模态框
        $('#choose_list').load('/custmgt/project/chooseView');
    });




    $("#btn_delete_project_ids").click(function () {
        var selecteded = $("#project_tablelist").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }
        var ids = [];
        var rowcounts = [];//定义一个数组
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            if(s.personId==null||s.personId==''){
                rowcounts.push(s.id);
                //移除临时记录
                addProjectList.remove(s.id);
            }else{
                ids.push(s.id);
            }

        }
        if(ids.length>0){
            deleteProjectPersonIds(ids);
           // $("#project_tablelist").bootstrapTable('refresh', {url: projcet_url});
            $("#project_tablelist").bootstrapTable('remove', {field: 'id', values: ids});
        }
        if(rowcounts.length>0){
            $("#project_tablelist").bootstrapTable('remove', {field: 'id', values: rowcounts});
        }
    });

    function deleteProjectPersonIds(ids) {
        $.ajax({
            type: "post",
            async: false,
            traditional: true,
            url: "/custmgt/project/deletePorjectRelation?personId="+$("#addOrUpdateForm #id").val(),
            data: {'projectIds': ids},
            success: function (json) {
            },
            error: $.tool.ajaxError
        });
    }

    function viewPorject(id) {
        window.open("/custmgt/project/view/"+id);
    }
</script>