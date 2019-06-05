        <div class="x_panel" style="height: 500px;">
            <div class="modal-header" style="padding: 5px">
                <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                        data-dismiss="modal">返回
                </button>
                <button id="btn_sure_person" type="button" class="btn btn-default"
                        style="margin-bottom:0px;margin-right:0px" title="确认领用">
                    确认
                </button>
            </div>
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="choosePersonformSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name">
                            </div>
                            <div class="col-sm-4" style="text-align:left;">
                                <button type="button" style="margin-left:50px" id="choosePerson_btn_query" class="btn btn-primary">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="x_content">
                <div class="<#--table-responsive-->">
                    <table id="choose_person_tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
                    </table>
                </div>
            </div>
        </div>
<script>
    var choose_person_options = {
        url: "/custmgt/person/chooseListByProject",
        getInfoUrl: "/custmgt/person/get/{id}",
        updateUrl: "/custmgt/person/edit",
        removeUrl: "/custmgt/person/remove",
        createUrl: "/custmgt/person/add",
        columns: [
            {   checkbox: true,
                width: 25
            },
            {
                field: 'id',
                title: '序号',
                editable: false,
                width:40
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
                width: 60
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
                field: 'email',
                title: '电子邮箱',
                editable: false,
                width: 90
            }, {
                field: 'credit',
                title: '信用',
                editable: false,
                width: 40,
                formatter: function (data) {
                    if(data==0){
                        return '<span  class="btn-success btn-xs">优秀</span>'
                    }else if(data==1){
                        return '<span  class="btn-info btn-xs">良好</span>'
                    }else if(data==2){
                        return '<span class="btn-warning btn-xs">一般</span>'
                    }else if(data==3){
                        return '<span class="btn-danger btn-xs">较差</span>'
                    }
                    return '';
                }
            }
        ],
        modalName: "客户"
    };
    $('#choose_person_tablelist').bootstrapTable('destroy');
    //1.初始化Table
    $('#choose_person_tablelist').bootstrapTable({
        url: choose_person_options.url+"?excludeIds="+addPersonList.join(",")+"&projectId="+$('#addOrUpdateForm #id').val(),
        method: 'post',                      //请求方式（*）
        toolbar: '#choose_person_toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        sortStable: true,                   // 设置为 true 将获得稳定的排序
        queryParams: personqueryParams,//传递参数（*）
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
        columns: choose_person_options.columns
    });

    //查询
    $('#choosePerson_btn_query').on('click', function () {
        $("#choose_person_tablelist").bootstrapTable('refresh', {url: choose_person_options.url});
    });

    $("#btn_sure_person").click(function () {
        var selecteded = $("#choose_person_tablelist").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }
        $(this).off();
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            //添加临时id
            addPersonList.push(s.id);
            var count = $('#person_tablelist').bootstrapTable('getData').length;
            var row = {index:count,row:{
                "id":s.id,
                "rowId" :"",
                "name" : s.name,
                "sex" : s.sex,
                "post" : s.post,
                "companyName" : s.companyName,
                "phone" : s.phone,
                "mobile" : s.mobile
            }};
            $("#person_tablelist").bootstrapTable('insertRow', row);
        }
        $('#choose_list').modal('hide');
    });


    function personqueryParams(params) {
        params = $.extend({}, params);
        //获取搜索框的值
        var name = {'custPersonEntity.name': $("#choosePersonformSearch #name").val()};
        params = $.extend(params, name);
        return params;
    }

</script>