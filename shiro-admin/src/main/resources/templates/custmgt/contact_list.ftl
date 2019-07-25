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
            <li class="active">联系列表</li>
        </ol>
        <div class="x_panel">
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="formSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">客户名称</label>
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
                    <@shiro.hasPermission name="custmgt:contact:add">
                        <button id="btn_add" type="button" class="btn btn-default" title="新增">
                            <i class="fa fa-plus"></i> 新增
                        </button>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="custmgt:contact:batchDelete">
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
<!--项目新增/编辑弹框-->
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
                                <h3 align="center">联系信息</h3>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="title" style="vertical-align:middle"><span
                                                class="control-label title">客户名称: </span></td>
                                        <td style="vertical-align:middle">
                                            <select id="personId" name="personId" style="width: 200px;float: left" class="form-control"
                                                    required="required">
                                                <option value="">请选择</option>
                                            <@custMgtTag method="person" userId="${user.id}">
                                                <#if persons?? && persons?size gt 0>
                                                    <#list persons as item>
                                                        <option value="${item.id?if_exists}">${item.name?if_exists}</option>
                                                    </#list>
                                                <#else>
                                                    <option value="">无</option>
                                                </#if>
                                            </@custMgtTag>
                                            </select>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">开销费用: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="expenses"
                                                   id="expenses"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="padding-left: 40px;"><span
                                                class="control-label title">会面时间:</span>
                                        </td>
                                        <td>
                                            <div style="width: 200px;float: left">
                                                <div class="form-group" style="margin-bottom:0px;">
                                                    <div class='input-group date' id='meetTime_datetimepicker' style="margin-bottom: 0px;vertical-align:middle">
                                                        <input type='text' class="form-control" name="meetTime" id="meetTime" />
                                                        <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">会面地址: </span></td>
                                        <td>
                                            <input type="text" style="width: 200px" class="form-control" name="meetAddress"
                                                   id="meetAddress"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" ><span
                                                class="control-label title">参与人员:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="participant" id="participant"/></td>
                                        <td class="title" ><span
                                                class="control-label title">人&nbsp;&nbsp;&nbsp;&nbsp;数：</span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control"
                                                   name="peopleNum" id="peopleNum"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" ><span
                                                class="control-label title">活动方式:</span></td>
                                        <td colspan="3"><input type="text" style="width: 200px" class="form-control" name="activityMode"
                                                   id="activityMode"/></td>
                                    </tr>
                                    <tr>
                                        <td class="title" >
                                            <span class="control-label title">聊天记录:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 600px;" class="control-label" id="chat" name="chat"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" >
                                            <span class="control-label title">备&nbsp;&nbsp;&nbsp;&nbsp;注:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 600px;" class="control-label" id="remark" name="remark"></textarea>
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
<!--项目查看弹框-->

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
                                <h3 align="center">联系信息</h3>
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
                                        <td class="title" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">客户名称:  </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="personName"></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">客户职位:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="personPost"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">会面时间:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="meetTime"></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">会面地址:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="meetAddress"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">活动方式:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="activityMode"></span>
                                        </td>
                                        <td class="title">
                                            <span class="control-label title">开销费用: </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="expenses"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">参与人员:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="participant"></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">人&nbsp;&nbsp;&nbsp;&nbsp;数:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="peopleNum"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">聊天记录:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;" class="control-label" id="chat" readonly="readonly"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">备&nbsp;&nbsp;&nbsp;&nbsp;注:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;" class="control-label" id="remark" readonly="readonly"></textarea>
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
        function operateFormatter(code, row, index) {
            var currentUserId = '${user.id}';
            var trUserId = row.register;
            var id=row.id;
            var operateBtn = [

            ];
            if (currentUserId == trUserId) {
                operateBtn.push('<@shiro.hasPermission name="custmgt:contact:edit"><a class="btn btn-xs btn-primary btn-update" data-id="' + id + '"><i class="fa fa-edit"></i>编辑</a></@shiro.hasPermission>');
                operateBtn.push('<@shiro.hasPermission name="custmgt:contact:delete"><a class="btn btn-xs btn-danger btn-remove" data-id="' + id + '"><i class="fa fa-trash-o"></i>删除</a></@shiro.hasPermission>');
            }
            return operateBtn.join('');
        }

        $(function () {
            var options = {
                url: "/custmgt/contact/list"+"?custContactEntity.register="+${user.id},
                getInfoUrl: "/custmgt/contact/get/{id}",
                updateUrl: "/custmgt/contact/edit",
                removeUrl: "/custmgt/contact/remove",
                createUrl: "/custmgt/contact/add",
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
                        width: 50
                    }, {
                        field: 'person.name',
                        title: '客户名称',
                        editable: false,
                        width: 60,
                        formatter: function (data, row) {
                            if(row.person!=null){
                                return '<a href="javascript:;" onclick="viewPerson(' + row.person.id + ')">' + data + '</a>'
                            }
                           return data;
                        }
                    }, {
                        field: 'person.post',
                        title: '客户职位',
                        editable: false,
                        width: 60
                    }, {
                        field: 'meetTime',
                        title: '会面时间',
                        width: 50
                    }, {
                        field: 'meetAddress',
                        title: '会面地址',
                        width: 150,
                        formatter: function (data) {
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
                        width: 120
                    }, {
                        field: 'operate',
                        title: '操作',
                        width: 80,
                        formatter: operateFormatter //自定义方法，添加操作按钮
                    }
                ],
                modalName: "项目"
            };

            //1.初始化Table
            $('#tablelist').bootstrapTable({
                url: options.url,
                method: 'post',                      //请求方式（*）
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                showToggle:true,
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
                minimumCountColumns: 12,             //最少允许的列数
                showRefresh: false,
                columns: options.columns
                });

            $("#btn_add").click(function () {
                resetForm();
                $("#addOrUpdateModal").modal('show');
                $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("添加" + options.modalName);
                $(".addOrUpdateBtn").unbind('click');
                $(".addOrUpdateBtn").click(function () {
                    var meetTime = $('#addOrUpdateForm #meetTime').val();
                    if(meetTime==null||meetTime==''){
                        alert('会面时间不能为空');
                        return;
                    }
                    var peopleNum = $('#addOrUpdateForm #peopleNum').val();
                    if(peopleNum!=null||peopleNum!=''){
                        if (isNaN(peopleNum)){
                            alert('人数必须是数字');
                            return;
                        }
                        var n = parseInt(peopleNum);
                        if (n <= 0){
                            alert('人数必须是正整数');
                            return;
                        }
                    }

                    var expenses = $('#addOrUpdateForm #expenses').val();
                    if(expenses!=null||expenses!=''){
                        if (isNaN(expenses)){
                            alert('开销费用必须是数字');
                            return ;
                        }
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
                $(this).off();
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
                            var meetTime = $('#addOrUpdateForm #meetTime').val();
                            if(meetTime==null||meetTime==''){
                                alert('会面时间不能为空');
                                return;
                            }
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
                url: "/custmgt/contact/get/"+id,
                success: function (json) {
                    var data = json.data;
                    resetViewForm(data);
                    $("#viewModal").modal('show');
                },
                error: $.tool.ajaxError
            });
        }
        function viewPerson(id) {
            window.open("/custmgt/person/view/"+id);
        }

        //日期空间init

        $('#meetTime_datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            showClear: true,
            showClose: true,
            focusOnShow: true,
            locale: moment.locale('zh-cn')
        });

        function queryParams(params) {
            params = $.extend({}, params);
            //获取搜索框的值
            var name = {'personName': $("#formSearch #name").val()};
            params = $.extend(params, name);
            return params;
        }

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
        }

        function viewText($this, type, info) {
            var thisName = $this.attr("id");
            var thisValue = info[thisName];
            if (type == 'radio') {
                $this.iCheck(((thisValue== $this.val())) ? 'check' : 'uncheck')
            } else if (type == 'checkbox') {
                $this.iCheck((thisValue || thisValue == 1) ? 'check' : 'uncheck');
            } else if (thisName == 'personName') {
                if(info.person!=null){
                    $this.html(info.person.name);
                }
            }  else if (thisName == 'personPost') {
                if(info.person!=null){
                    $this.html(info.person.post);
                }
            }else {
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
                }else if (thisName == 'personId') {
                    $this.val(thisValue);
                } else {
                    if (thisName != 'password') {
                        $this.val(thisValue);
                    }
                }
            } else {
                if (type === 'radio' || type === 'checkbox') {
                    //  $this.iCheck('uncheck');
                } else {
                    $this.val('');
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

        function viewContact(id) {
            window.open("/custmgt/contact/view/"+id);
        }

        //excel导出
        $("#exportExcel").click(function () {
            window.location.href ="contact/exportExcel";
        });
    </script>