        <div>
            <div class="btn-group hidden-xs" id="contact_toolbar">
            <@shiro.hasPermission name="custmgt:contact:add">
                <button id="btn_add_contact" type="button" class="btn btn-xs btn-default" title="新增">
                    <i class="fa fa-plus"></i> 新增
                </button>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="custmgt:contact:delete">
                <button id="btn_delete_contact_ids" type="button" class="btn btn-xs btn-default" title="删除选中">
                    <i class="fa fa-trash-o"></i> 删除
                </button>
            </@shiro.hasPermission>

            </div>
            <table id="contact_tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
            </table>
        </div>
<script>
    var contact_options = {
        url: "/custmgt/contact/listAll",
        getInfoUrl: "/custmgt/contact/get/{id}",
        removeUrl: "/custmgt/contact/remove",
        columns: [
        ],
        modalName: "联系方式"
    };
    var contact_url;
    function addUpdateContactTable(personId,operation) {
        if(operation!='view'){
            contact_options.columns=[{checkbox: true,
                width: 25
                },
                {
                    field: 'id',
                    title: '序号',
                    editable: false,
                    width: 40,
                    formatter:function(value,row,index){
                        return '<a href="javascript:;" onclick="viewContact('+value+')">'+value+'</a>';
                    }
                }, {
                    field: 'meetTime',
                    title: '会面时间',
                    width: 70
                }, {
                    field: 'meetAddress',
                    title: '会面地址',
                    width: 120,
                    formatter: function (data, row) {
                        var html = "<div style='width: 110px' class='colStyle' title='" + data + "'>" + data + "</div>";
                        return html;
                    }
                }, {
                    field: 'peopleNum',
                    title: '人数',
                    editable: false,
                    width: 40
                }, {
                    field: 'participant',
                    title: '参与人员',
                    editable: false,
                    width: 100
                }, {
                    field: 'expenses',
                    title: '开销费用',
                    editable: false,
                    width: 70
                }, {
                    field: 'activityMode',
                    title: '活动方式',
                    editable: false,
                    width: 70
                }
            ];
            $('#contact_toolbar').show();
        }else{
            contact_options.columns=[
                {
                    field: 'id',
                    title: '序号',
                    editable: false,
                    width: 40,
                    formatter:function(value,row,index){
                        return '<a href="javascript:;" onclick="viewContact('+value+')">'+value+'</a>';
                    }
                }, {
                    field: 'meetTime',
                    title: '会面时间',
                    width: 70
                }, {
                    field: 'meetAddress',
                    title: '会面地址',
                    width: 120,
                    formatter: function (data, row) {
                        var html = "<div style='width: 110px' class='colStyle' title='" + data + "'>" + data + "</div>";
                        return html;
                    }
                }, {
                    field: 'peopleNum',
                    title: '人数',
                    editable: false,
                    width: 40
                }, {
                    field: 'participant',
                    title: '参与人员',
                    editable: false,
                    width: 100
                }, {
                    field: 'expenses',
                    title: '开销费用',
                    editable: false,
                    width: 70
                }, {
                    field: 'activityMode',
                    title: '活动方式',
                    editable: false,
                    width: 70
                }
            ];
            $('#contact_toolbar').hide();
        }
        addContactList = [];
        contact_url=contact_options.url + "?personId=" + personId;

        $('#contact_tablelist').bootstrapTable('destroy');

        $('#contact_tablelist').bootstrapTable({
            url:contact_url,
            method: 'post',                      //请求方式（*）
            toolbar: '#contact_toolbar',                //工具按钮用哪个容器
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
            columns: contact_options.columns
        });
    }
    $("#btn_add_contact").click(function () {
        //如果是a链接，阻止其跳转到url页面
        event.preventDefault();
        //将id为deadAdd的页面元素作为模态框激活
        $('#choose_list').modal();
        //从url加载数据到模态框
        $('#choose_list').load('/custmgt/contact/chooseView');
    });


    $("#btn_delete_contact_ids").click(function () {
        var selecteded = $("#contact_tablelist").bootstrapTable('getAllSelections');
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
                addContactList.remove(s.id);
            }else{
                ids.push(s.id);
            }

        }
        if(ids.length>0){
            deleteContactPersonIds(ids);
           // $("#contact_tablelist").bootstrapTable('refresh', {url: contact_url});
            $("#contact_tablelist").bootstrapTable('remove', {field: 'id', values: ids});
        }
        if(rowcounts.length>0){
            $("#contact_tablelist").bootstrapTable('remove', {field: 'id', values: rowcounts});
        }
    });

    function deleteContactPersonIds(ids) {
        $.ajax({
            type: "post",
            async: false,
            traditional: true,
            url: "/custmgt/contact/deletePersonIds",
            data: {'ids': ids},
            success: function (json) {
            },
            error: $.tool.ajaxError
        });
    }

    function viewContact(id) {
        window.open("/custmgt/contact/view/"+id);
    }
</script>