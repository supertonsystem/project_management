<#include "/layout/header.ftl"/>
<style type="text/css">
    .input-group[class*=col-] {
        padding-left: 10px;
    }

    .colStyle {
        word-break: keep-all; /* 不换行 */
        white-space: nowrap; /* 不换行 */
        overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow: ellipsis; /* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/
        -o-text-overflow: ellipsis;
        -icab-text-overflow: ellipsis;
        -khtml-text-overflow: ellipsis;
        -moz-text-overflow: ellipsis;
        -webkit-text-overflow: ellipsis;
    }

    #content, #delayReason, #officeOpinion, #gmOpinion, #remark {
        word-wrap: break-word;
        word-break: normal;
        width: 90%;
    }

    .historicActivityImage {
        display: block;
        background-repeat: no-repeat;
        background-position: 0px -100px;
        width: 500px;
        height: 170px;
    }

    .title {
        font-weight: bold;
        vertical-align:middle;
        text-align: right;
    }
</style>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">库存列表</li>
        </ol>
        <div class="x_panel">
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="formSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name">
                            </div>
                            <div class="col-sm-4" style="text-align:left;">
                                <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="x_content">
                <div class="<#--table-responsive-->">
                    <div class="btn-group hidden-xs" id="toolbar">
                    <@shiro.hasPermission name="giftmgt:repertory:add">
                        <button id="btn_add" type="button" class="btn btn-default" title="新增">
                            <i class="fa fa-plus"></i> 新增
                        </button>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="giftmgt:repertory:batchDelete">
                        <button id="btn_delete_ids" type="button" class="btn btn-default" title="删除选中">
                            <i class="fa fa-trash-o"></i> 批量删除
                        </button>
                    </@shiro.hasPermission>
                        <button type="button" id="exportExcel" class="btn btn-success" style=" margin-left: 5px;">
                            Excel导出
                        </button>
                    </div>
                    <table id="tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/footer.ftl"/>
<!--库存新增/编辑弹框-->
<div class="modal fade" id="addOrUpdateModal" tabindex="-1" role="dialog"
     style="overflow: auto" data-backdrop="static">
    <div class="modal-dialog" style="width: 850px; " role="document">
        <div class="modal-content">
            <div class="modal-header" style="padding: 5px">
                <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                        data-dismiss="modal">返回
                </button>
                <button type="button" style="margin-bottom:0px;margin-right:0px"
                        class="btn btn-primary addOrUpdateBtn">保存
                </button>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <div class="modal-body" style="padding-top: 0px;">
                        <form id="addOrUpdateForm">
                            <input type="hidden" name="id" id="id">
                            <div class="table-responsive">
                                <h3 align="center">礼品库存</h3>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="title" style="padding-left: 40px;"><span
                                                class="control-label title">礼品名称:</span>
                                        </td>
                                        <td>
                                            <input type="text" style="width: 200px;float: left" class="form-control" name="name" autofocus="autofocus"
                                                   id="name" required="required"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">礼品类别: </span></td>
                                        <td>
                                            <select id="typeId" name="typeId" style="width: 200px;float: left" class="form-control"
                                                    placeholder="请选礼品类别"  required="required">
                                                <option value="">请选择</option>
                                            <@giftMgtTag method="type">
                                                <#if types?? && types?size gt 0>
                                                    <#list types as item>
                                                        <option value="${item.id?c}">${item.type}</option>
                                                    </#list>
                                                <#else>
                                                    <option value="">无</option>
                                                </#if>
                                            </@giftMgtTag>
                                            </select>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" ><span
                                                class="control-label title">礼品数量:</span></td>
                                        <td>
                                            <input type="number" style="width: 200px;float: left" class="form-control" name="sum" min="0"
                                                   id="sum"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*</em>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">库存数量: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="number" style="width: 200px;float: left" class="form-control" name="repertory"  min="0"
                                                   id="repertory"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*</em>
                                            <a id="addRepertory" tabindex="0"  role="button" class="fa fa-plus" style="margin: 10px 5px;" title="增加库存"></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" ><span
                                                class="control-label title">单&nbsp;&nbsp;&nbsp;&nbsp;价:</span></td>
                                        <td>
                                            <input type="number" min="0" style="width: 200px;float: left" class="form-control"
                                                   name="unit" id="unit"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">总&nbsp;&nbsp;&nbsp;&nbsp;价：</span></td>
                                        <td style="vertical-align:middle">
                                            <input type="number" min="0"  style="width: 200px" class="form-control"
                                                   name="amount" id="amount"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" >
                                            <span class="control-label title">礼品说明:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 600px;" class="control-label" id="description" name="description"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" >
                                            <span class="control-label title">库存记录:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 200px;width: 600px;" class="control-label" id="remark" name="remark" readonly="readonly"></textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--库存查看弹框-->

<div class="modal fade" id="viewModal" tabindex="-1" role="dialog"
     style="overflow: auto">
    <div class="modal-dialog" style="width: 850px; " role="document">
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
                                            <span class="form-control-static" id="createTime"></span>
                                        </td>
                                        <td class="title" style="padding-left: 15px;padding-right: 9px;">
                                            <span class="control-label title">登记人:&nbsp;&nbsp;&nbsp; </span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="registerUserName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">礼品名称:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="name"></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">礼品类别:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="typeName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">礼品数量:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="sum"></span>
                                        </td>
                                        <td class="title">
                                            <span class="control-label title">库存数量:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="repertory"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">单&nbsp;&nbsp;&nbsp;&nbsp;价:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="unit"></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">总&nbsp;&nbsp;&nbsp;&nbsp;价:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="amount"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">礼品说明:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;" class="control-label" id="description" readonly="readonly"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">库存记录:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 200px;width: 500px;" class="control-label" id="remark" readonly="readonly"></textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
        $('#addRepertory').popover(
                {
                    trigger: 'click',
                    title: "增加库存",
                    placement: 'bottom',
                    html: true,
                    content: addRepertoryDiv
                }
            );

        function addRepertoryDiv() {
            return '<input type="number" min="0" style="width: 100px;height: 30px;" class="form-control"' +
                    'name="addRepertoryNum" id="addRepertoryNum"/> ' +
                    '<button id="AddRepertoryBtn" type="button" style="margin-top:5px;"' +
                    ' class="btn btn-xs btn-default">确定' +
                    ' </button><button id="hideAddRepertoryDiv" type="button" style="margin-top:5px;"' +
                    ' class="btn btn-xs btn-primary">取消' +
                    ' </button>';
        }

        $('#addRepertory').on('shown.bs.popover', function () {
            $("#hideAddRepertoryDiv").click(function () {
                $('#addRepertory').popover('hide');
            });
            $("#AddRepertoryBtn").click(function () {
                var num=$("#addRepertoryNum").val();
                if(num==null||num==''){
                    alert('库存数不能为空');
                    return;
                }
                if (!(/(^[1-9]\d*$)/.test(num))) {
                    alert('输入的不是正整数');
                    return;
                }

                $.ajax({
                    type: "post",
                    url: "/giftmgt/repertory/addRepertoryNum",
                    data: {'id':$("#addOrUpdateModal #id").val(),'repertoryNum':num},
                    success: function (json) {
                        var result=json.data;
                        $('#addOrUpdateModal #sum').val(result.sum);
                        $('#addOrUpdateModal #amount').val(result.amount);
                        $('#addOrUpdateModal #repertory').val(result.repertory);
                        $('#addOrUpdateModal #remark').val(result.remark);
                        $('#addOrUpdateModal #addRepertory').popover('hide');
                    },
                    error: $.tool.ajaxError
                });
            });
        });

        function operateFormatter(code, row, index) {
            var currentUserId = '${user.id}';
            var trUserId = row.register;
            var id=row.id;
            var operateBtn = [
                '<@shiro.hasPermission name="giftmgt:repertory:edit"><a class="btn btn-xs btn-primary btn-update" data-id="' + id + '"><i class="fa fa-edit"></i>编辑</a></@shiro.hasPermission>'
            ];
            if (currentUserId == trUserId) {
                operateBtn.push('<@shiro.hasPermission name="giftmgt:repertory:delete"><a class="btn btn-xs btn-danger btn-remove" data-id="' + id + '"><i class="fa fa-trash-o"></i>删除</a></@shiro.hasPermission>');
            }
            return operateBtn.join('');
        }

        $(function () {
            var options = {
                url: "/giftmgt/repertory/list",
                getInfoUrl: "/giftmgt/repertory/get/{id}",
                updateUrl: "/giftmgt/repertory/edit",
                removeUrl: "/giftmgt/repertory/remove",
                createUrl: "/giftmgt/repertory/add",
                columns: [
                    {
                        field: 'id',
                        title: '序号',
                        editable: false,
                        width: 35,
                        formatter: function (data,row) {
                            return '<a href="javascript:;" onclick="view('+row.id+')">'+data+'</a>'
                        }
                    },{
                        field: 'register',
                        title: '登记人',
                        visible: false
                    }, {
                        field: 'createTime',
                        title: '登记时间',
                        sortable: true,
                        editable: false,
                        width: 60
                    }, {
                        field: 'name',
                        title: '礼品名称',
                        width: 100,
                        formatter: function (data,row) {
                            return '<a href="javascript:;" onclick="view('+row.id+')">'+data+'</a>'
                        }
                    }, {
                        field: 'giftRepertory.giftType.type',
                        title: '类别',
                        width: 60
                    }, {
                        field: 'sum',
                        title: '数量',
                        editable: false,
                        width: 50
                    }, {
                        field: 'repertory',
                        title: '库存',
                        editable: false,
                        width: 50
                    }, {
                        field: 'unit',
                        title: '单价',
                        editable: false,
                        width: 40,
                        formatter: function (data,row) {
                            return data+' 元'
                        }
                    }, {
                        field: 'amount',
                        title: '总金额',
                        editable: false,
                        width: 60,
                        formatter: function (data,row) {
                            return data+' 元'
                        }
                    }, {
                        field: 'description',
                        title: '说明',
                        editable: false,
                        width: 150,
                        formatter: function (data) {
                            var html = "<div style='width: 140px' class='colStyle' title='" + data + "'>" + data + "</div>";
                            return html;
                        }
                    }, {
                        field: 'operate',
                        title: '操作',
                        width: 80,
                        formatter: operateFormatter //自定义方法，添加操作按钮
                    }
                ],
                modalName: "礼品库存"
            };

            //1.初始化Table
            $('#tablelist').bootstrapTable({
                url: options.url,
                method: 'post',                      //请求方式（*）
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                sortStable: true,                   // 设置为 true 将获得稳定的排序
                queryParams: queryParams,//传递参数（*）
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
                onEditableSave: function (field, row, oldValue, $el) {
                    $.ajax({
                        type: "post",
                        url: "/Editable/Edit",
                        data: row,
                        dataType: 'JSON',
                        success: function (data, status) {
                            if (status == "success") {
                                alert('提交数据成功');
                            }
                        },
                        error: function () {
                            alert('编辑失败');
                        },
                        complete: function () {
                        }
                });
            },
                columns: options.columns
            });

            $("#btn_add").click(function () {
                resetForm();
                $("#addOrUpdateModal").modal('show');
                $(".addOrUpdateBtn").unbind('click');
                $(".addOrUpdateBtn").click(function () {
                    var name = $('#addOrUpdateForm #name').val();
                    if(name==null||name==''){
                        alert('礼品名称不能为空');
                        return;
                    }
                    var typeId = $('#addOrUpdateForm #typeId').val();
                    if(typeId==null||typeId==''){
                        alert('礼品类别不能为空');
                        return;
                    }
                    var sum = $('#addOrUpdateForm #sum').val();
                    if(sum==null||sum==''){
                        alert('礼品总量不能为空');
                        return;
                    }
                    var repertory = $('#addOrUpdateForm #repertory').val();
                    if(repertory==null||repertory==''){
                        alert('礼品库存不能为空');
                        return;
                    }
                    var unit = $('#addOrUpdateForm #unit').val();
                    if(unit==null||unit==''){
                        alert('礼品单价不能为空');
                        return;
                    }
                    var amount = $('#addOrUpdateForm #amount').val();
                    if(amount==null||amount==''){
                        alert('礼品总价不能为空');
                        return;
                    }
                    $(this).off();
                    $.ajax({
                        type: "post",
                        url: options.createUrl,
                        data: $("#addOrUpdateForm").serialize(),
                        success: function (json) {
                            $.tool.ajaxSuccess(json);
                            $("#addOrUpdateModal").modal('hide');
                            $.tableUtil.refresh();
                        },
                        error: $.tool.ajaxError
                    });
                });
            });


            /* 修改 */
            $('#tablelist').on('click', '.btn-update', function () {
                var $this = $(this);
                var id = $this.attr("data-id");
                $.ajax({
                    type: "post",
                    url: options.getInfoUrl.replace("{id}", id),
                    success: function (json) {
                        var info = json.data;
                        resetForm(info);
                        $("#addOrUpdateModal").modal('show');
                        $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("修改" + options.modalName);

                        $(".addOrUpdateBtn").unbind('click');
                        $(".addOrUpdateBtn").click(function () {
                            var name = $('#addOrUpdateForm #name').val();
                            if (name == null || name == '') {
                                alert('礼品名称不能为空');
                                return;
                            }
                            var typeId = $('#addOrUpdateForm #typeId').val();
                            if (typeId == null || typeId == '') {
                                alert('礼品类别不能为空');
                                return;
                            }
                            var sum = $('#addOrUpdateForm #sum').val();
                            if (sum == null || sum == '') {
                                alert('礼品总量不能为空');
                                return;
                            }
                            var repertory = $('#addOrUpdateForm #repertory').val();
                            if (repertory == null || repertory == '') {
                                alert('礼品库存不能为空');
                                return;
                            }
                            var unit = $('#addOrUpdateForm #unit').val();
                            if (unit == null || unit == '') {
                                alert('礼品单价不能为空');
                                return;
                            }
                            $(this).off();
                            $.ajax({
                                type: "post",
                                url: options.updateUrl,
                                data: $("#addOrUpdateForm").serialize(),
                                success: function (json) {
                                    $.tool.ajaxSuccess(json);
                                    $("#addOrUpdateModal").modal('hide');
                                    $.tableUtil.refresh();
                                },
                                error: $.tool.ajaxError
                            });
                        });
                    },
                    error: $.tool.ajaxError
                });
            });

            /* 删除 */
            $('#tablelist').on('click', '.btn-remove', function () {
                var $this = $(this);
                var id = $this.attr("data-id");
                remove(id);
            });

            function remove(ids) {
                $.tool.confirm("确定删除吗？", function () {
                    $.ajax({
                        type: "post",
                        url: options.removeUrl,
                        traditional: true,
                        data: {'ids': ids},
                        success: function (json) {
                            $.tool.ajaxSuccess(json);
                            $.tableUtil.refresh();
                        },
                        error: $.tool.ajaxError
                    });
                }, function () {

                }, 5000);
            }
            //查询
            $('#btn_query').on('click', function () {
                $("#tablelist").bootstrapTable('refresh', {url: options.url});
            });
        });

        function view(id) {
            $.ajax({
                type: "post",
                async: false,
                url: "/giftmgt/repertory/get/"+id,
                success: function (json) {
                    var data = json.data;
                    resetViewForm(data);
                    $("#viewModal").modal('show');
                },
                error: $.tool.ajaxError
            });
        }
        $("#addOrUpdateForm #unit").change(function(){
            var sum=$("#addOrUpdateForm #sum").val();
            if(sum==null||sum==''){
                alert('请先填写礼品数量');
                return;
            }
            $("#addOrUpdateForm #amount").val($(this).val()*sum);
        });
        //日期空间init

        $('#meetTime_datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            showClear: true,
            showClose: true,
            focusOnShow: true,
            locale: moment.locale('zh-cn'),
            widgetPositioning: { horizontal: 'right', vertical: 'top'}
        });

        function queryParams(params) {
            params = $.extend({}, params);
            //获取搜索框的值
            var name = {'giftRepertoryEntity.name': $("#formSearch #name").val()};
            params = $.extend(params, name);
            return params;
        }
        //excel导出
        $("#exportExcel").click(function () {
            window.location.href ="repertory/exportExcel";
        });

        function resetViewForm(info) {
            $("#viewModal form span,#viewModal form textarea").each(function () {
                var $this = $(this);
                viewText($this, this.type, info);
            });
        }

        function resetForm(info) {
            $("#addOrUpdateModal form input,#addOrUpdateModal form select,#addOrUpdateModal form textarea").each(function () {
                var $this = $(this);
                clearText($this, this.type, info);
            });
            if(info){
                $("#addOrUpdateModal form em").each(function () {
                    var $this = $(this);
                    $this.css('display','none');
                });
                $("#addRepertory").css('display','inline-block');
            }else{
                $("#addOrUpdateModal form em").each(function () {
                    var $this = $(this);
                    $this.css('display','block');
                });
                $("#addRepertory").css('display','none');
            }
        }

        function viewText($this, type, info) {
            var thisName = $this.attr("id");
            var thisValue = info[thisName];
            if (type == 'radio') {
                $this.iCheck(((thisValue== $this.val())) ? 'check' : 'uncheck')
            } else if (type == 'checkbox') {
                $this.iCheck((thisValue || thisValue == 1) ? 'check' : 'uncheck');
            } else {
                $this.html(thisValue);
            }
        }

        function clearText($this, type, info) {
            var $div = $this.parents(".item");
            if ($div.hasClass("bad")) {
                $div.removeClass("bad");
                $div.find("div.alert").remove();
            }
            if (info) {
                var thisName = $this.attr("id");
                var thisValue = info[thisName];
                if (type == 'radio') {
                    $this.iCheck(((thisValue== $this.val())) ? 'check' : 'uncheck')
                } else if (type == 'checkbox') {
                    $this.iCheck((thisValue || thisValue == 1) ? 'check' : 'uncheck');
                }else if (thisName == 'pm') {
                    $this.val(thisValue);
                    $this.selectPageRefresh();
                } else {
                    if (thisName != 'password') {
                        $this.val(thisValue);
                    }
                }
                if(thisName=='name'||thisName=='typeId'
                        ||thisName=='sum'||thisName=='repertory'
                        ||thisName=='amount'||thisName=='unit'){
                    $this.attr('readonly',true);
                }
                if(type=='select-one'){
                    $this.attr('disabled','disabled');
                }

            } else {
                if (type === 'radio' || type === 'checkbox') {
                    //  $this.iCheck('uncheck');
                } else {
                    $this.val('');
                    var thisName = $this.attr("id");
                    if(thisName!='remark'){
                        $this.attr('readonly',false);
                    }
                    if(type=='select-one'){
                        $this.removeAttr('disabled');
                    }
                }

            }
        }

        //解决模态框背景色越来越深的问题
        $(document).on('show.bs.modal', '.modal', function (event) {
            $(this).appendTo($('body'));
        }).on('shown.bs.modal', '.modal.in', function (event) {
            setModalsAndBackdropsOrder();
        }).on('hidden.bs.modal', '.modal', function (event) {
            setModalsAndBackdropsOrder();
        });

        function setModalsAndBackdropsOrder() {
            var modalZIndex = 1040;
            $('.modal.in').each(function (index) {
                var $modal = $(this);
                modalZIndex++;
                $modal.css('zIndex', modalZIndex);
                $modal.next('.modal-backdrop.in').addClass('hidden').css('zIndex', modalZIndex - 1);
            });
            $('.modal.in:visible:last').focus().next('.modal-backdrop.in').removeClass('hidden');
        }
    </script>