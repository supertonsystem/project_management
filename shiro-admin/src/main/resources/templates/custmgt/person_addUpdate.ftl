        <div>
            <div class="btn-group hidden-xs" id="person_toolbar">
            <@shiro.hasPermission name="custmgt:person:add">
                <button id="btn_add_person" type="button" class="btn btn-xs btn-default" title="新增">
                    <i class="fa fa-plus"></i> 新增
                </button>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="custmgt:person:delete">
                <button id="btn_delete_person_ids" type="button" class="btn btn-xs btn-default" title="删除选中">
                    <i class="fa fa-trash-o"></i> 删除
                </button>
            </@shiro.hasPermission>

            </div>
            <table id="person_tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
            </table>
        </div>
<script>
    var person_options = {
        url: "/custmgt/person/personRelationList",
        getInfoUrl: "/custmgt/person/get/{id}",
        removeUrl: "/custmgt/person/remove",
        columns: [],
        modalName: "关联人员"
    };
    var person_url;
    function addUpdatePersonTable(sourceId,operation) {
        if(operation!='view'){
            person_options.columns=[
                {   checkbox: true,
                    width: 25
                },
                {
                    field: 'id',
                    title: '序号',
                    width: 40,
                    editable: false
                }, {
                    field: 'name',
                    title: '姓名',
                    width: 50,
                    formatter: function (data,row) {
                        return '<a href="javascript:;" onclick="viewPerson('+row.id+')">'+data+'</a>'
                    }
                }, {
                    field: 'sex',
                    title: '性别',
                    editable: false,
                    width: 30,
                    formatter: function (data) {
                        if(data==0){
                            return '男';
                        }else if(data==1){
                            return '女';
                        }
                        return '';
                    }
                }, {
                    field: 'post',
                    title: '职位',
                    width: 40
                }, {
                    field: 'companyName',
                    title: '公司名称',
                    editable: false,
                    width: 120
                }, {
                    field: 'phone',
                    title: '联系电话',
                    editable: false,
                    width: 70
                }, {
                    field: 'mobile',
                    title: '手机号码',
                    editable: false,
                    width: 70
                }, {
                    field: 'sourceId',
                    title: '关联id',
                    visible: false
                }
            ];
            $('#person_toolbar').show();
        }else{
            person_options.columns=[
                {
                    field: 'id',
                    title: '序号',
                    editable: false,
                    width: 40
                }, {
                    field: 'name',
                    title: '姓名',
                    width: 50,
                    formatter: function (data,row) {
                        return '<a href="javascript:;" onclick="viewPerson('+row.id+')">'+data+'</a>'
                    }
                }, {
                    field: 'sex',
                    title: '性别',
                    editable: false,
                    width: 30,
                    formatter: function (data) {
                        if(data==0){
                            return '男';
                        }else if(data==1){
                            return '女';
                        }
                        return '';
                    }
                }, {
                    field: 'post',
                    title: '职位',
                    width: 40
                }, {
                    field: 'companyName',
                    title: '公司名称',
                    editable: false,
                    width: 120
                }, {
                    field: 'phone',
                    title: '联系电话',
                    editable: false,
                    width: 70
                }, {
                    field: 'mobile',
                    title: '手机号码',
                    editable: false,
                    width: 70
                }, {
                    field: 'sourceId',
                    title: '关联id',
                    visible: false
                }
            ];
            $('#person_toolbar').hide();
        }
        addPersonList = [];
        person_url=person_options.url + "?sourceId=" + sourceId;

        $('#person_tablelist').bootstrapTable('destroy');

        $('#person_tablelist').bootstrapTable({
            url:person_url,
            method: 'post',                      //请求方式（*）
            toolbar: '#person_toolbar',                //工具按钮用哪个容器
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
            columns: person_options.columns
        });
    }
    $("#btn_add_person").click(function () {
        //如果是a链接，阻止其跳转到url页面
        event.preventDefault();
        //将id为deadAdd的页面元素作为模态框激活
        $('#choose_list').modal();
        //从url加载数据到模态框
        $('#choose_list').load('/custmgt/person/chooseView');
    });

    function viewPerson(id) {
        window.open("/custmgt/person/view/"+id);
    }

    $("#btn_delete_person_ids").click(function () {
        var selecteded = $("#person_tablelist").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }
        var ids = [];
        var rowcounts = [];//定义一个数组
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            if(s.sourceId==null||s.sourceId==''){
                rowcounts.push(s.id);
                //移除临时记录
                addPersonList.remove(s.id);
            }else{
                ids.push(s.id);
            }

        }
        if(ids.length>0){
            deletePersonRelationIds(ids);
           // $("#person_tablelist").bootstrapTable('refresh', {url: person_url});
            $("#person_tablelist").bootstrapTable('remove', {field: 'id', values: ids});
        }
        if(rowcounts.length>0){
            $("#person_tablelist").bootstrapTable('remove', {field: 'id', values: rowcounts});
        }
    });

    function deletePersonRelationIds(ids) {
        $.ajax({
            type: "post",
            async: false,
            traditional: true,
            url: "/custmgt/person/deletePersonRelation?sourceId="+$("#addOrUpdateForm #id").val(),
            data: {'destIds': ids},
            success: function (json) {
            },
            error: $.tool.ajaxError
        });
    }
</script>