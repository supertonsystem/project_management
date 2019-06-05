<div id="viewModal"
     style="overflow: auto">
    <div class="modal-dialog" style="width: 1000px; " role="document">
        <div class="modal-content">
            <div class="modal-header" style="padding: 5px">
                <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                        data-dismiss="modal">返回
                </button>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <div class="modal-body" style="padding-top: 0px;">
                        <form id="viewForm">
                            <input type="hidden" name="id" id="id">
                            <div class="table-responsive">
                                <h3 align="center">礼品库存</h3>
                                <table class="table">
                                    <tbody>
                                    <tr id="tr_registerInfo">
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">登记时间:</span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static"
                                                  id="createTime">${consume.createTime?string("yyyy-MM-dd")}</span>
                                        </td>
                                        <td class="title" style="padding-left: 15px;padding-right: 9px;">
                                            <span class="control-label title">登记人:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static"
                                                  id="registerUserName">${consume.registerUserName}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">名&nbsp;&nbsp;&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="title">${consume.title}</span>
                                        </td>
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">状&nbsp;&nbsp;&nbsp;&nbsp;态:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="title">
                                            <#if consume.status==0>
                                               登记
                                            <#elseif consume.status==1>
                                               申请中
                                            <#else>
                                                已完成
                                            </#if></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title"
                                            style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">份&nbsp;&nbsp;&nbsp;&nbsp;数:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="num">${consume.num}</span>
                                        </td>
                                        <td class="title">
                                            <span class="control-label title">金&nbsp;&nbsp;&nbsp;&nbsp;额:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="amount">${consume.amount}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">退还份数: </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="backNum">${consume.backNum}</span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">退还金额:</span>
                                        </td>
                                        <td >
                                            <span class="form-control-static" id="backMoney">${consume.backMoney}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">礼品说明::</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;"
                                                      class="control-label" id="description"
                                                      readonly="readonly">${consume.description}</textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="panel panel-default" style="margin: 5px 20px">
                    <div class="panel-heading">
                        <h3 class="panel-title">送礼记录</h3>
                    </div>
                    <div class="panel-body" style="padding-top: 0px;">
                        <table id="consume_detail_view_list"
                               style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var view_options = {
        url: "/giftmgt/consumeDetail/listAll",
        columns: [
            {
                field: 'id',
                title: '唯一标识',
                editable: false,
                visible: false,
                width: 40
            }, {
                field: 'rowId',
                title: '序号',
                width: 40,
                formatter: function (value, row, index) {
                    row.rowId = index;
                    return index + 1;
                }
            }, {
                field: 'register',
                title: '登记人',
                visible: false
            }, {
                field: 'projectName',
                title: '项目名称',
                width: 100,
                formatter: function (data, row) {
                    return '<a href="javascript:;" onclick="viewPorject(' + row.projectId + ')">' + data + '</a>'
                }
            }, {
                field: 'personName',
                title: '客户名称',
                width: 80,
                formatter: function (data,row) {
                    return '<a href="javascript:;" onclick="viewPerson('+row.personId+')">'+data+'</a>'
                }
            }, {
                field: 'repertoryName',
                title: '礼品名称',
                width: 80
            }, {
                field: 'num',
                title: '份数',
                width: 50
            }, {
                field: 'amount',
                title: '金额',
                width: 50
            }, {
                field: 'sendTime',
                title: '送礼时间',
                width: 80
            }, {
                field: 'sendSite',
                title: '送礼地点',
                width: 100
            }, {
                field: 'description',
                title: '明细说明',
                width: 100
            }, {
                field: 'status',
                title: '使用',
                width: 50,
                formatter: function (data) {
                    if(data==0){
                        return '待送';
                    }
                    if(data==1){
                        return '已送'
                    }
                    if(data==2){
                        return '退回'
                    }
                    return '';
                }
            }, {
                field: 'drawStatus',
                title: '领用',
                width: 50,
                formatter: function (data) {
                    if(data==0){
                        return '待领用';
                    }
                    if(data==1){
                        return '已领用'
                    }
                    return '';
                }
            }
        ],
        modalName: "送礼记录"
    };

    //view_options.url = view_options.listUrl + "?consumeId=1";
    $('#consume_detail_view_list').bootstrapTable('destroy');
    //1.初始化Tablei
    $('#consume_detail_view_list').bootstrapTable({
        url: view_options.url+"?consumeId="+${consume.id},
        method: 'post',                      //请求方式（*）
        toolbar: '',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        sortStable: true,                   // 设置为 true 将获得稳定的排序
        queryParams: queryParams,//传递参数（*）
        queryParamsType: '',
        pagination: false,                   //是否显示分页（*）
        sidePagination: 'client',           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,                       //初始化加载第一页，默认第一页
        pageSize: 1000,                       //每页的记录行数（*）
        pageList: [1000, 2002],        //可供选择的每页的行数（*）
        search: false,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
        strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
        searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
        minimumCountColumns: 1,             //最少允许的列数
        showRefresh: false,
        columns: view_options.columns
    });

    function queryParams(params) {
        params = $.extend({}, params);
        return params;
    }

    function viewPorject(id) {
        window.open("/custmgt/project/view/"+id);
    }
    function viewPerson(id) {
        window.open("/custmgt/person/view/"+id);
    }
</script>