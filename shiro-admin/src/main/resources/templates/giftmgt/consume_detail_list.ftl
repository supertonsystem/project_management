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
        vertical-align: middle;
        text-align: right;
    }
</style>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">送礼列表</li>
        </ol>
        <div class="x_panel">
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="formSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">项目名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name">
                            </div>
                            <label class="control-label col-sm-1" for="txt_search_title">客户名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="personName" name="personName">
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
<!--领用查看弹框-->

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
                                <h3 align="center">送礼记录</h3>
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
                                            <span class="control-label title">登记人:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="registerUserName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">礼品名称:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="repertoryName"></span>
                                        </td>
                                        <td class="title"
                                            style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">客户名称:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="personName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">金&nbsp;&nbsp;&nbsp;&nbsp;额:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="amount"></span>
                                        </td>
                                        <td class="title"
                                            style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">份&nbsp;&nbsp;&nbsp;&nbsp;数:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="num"></span>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">退还份数: </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="backNum"></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">退还金额:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="backMoney"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">礼品说明::</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;"
                                                      class="control-label" id="description"
                                                      readonly="readonly"></textarea>
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
        var id = row.id;
        var operateBtn = [
            '<@shiro.hasPermission name="giftmgt:consumeDetail:edit"><a class="btn btn-xs btn-primary btn-update" data-id="' + id + '"><i class="fa fa-edit"></i>编辑</a></@shiro.hasPermission>'
        ];
        if (currentUserId == trUserId) {
            operateBtn.push('<@shiro.hasPermission name="giftmgt:consumeDetail:delete"><a class="btn btn-xs btn-danger btn-remove" data-id="' + id + '"><i class="fa fa-trash-o"></i>删除</a></@shiro.hasPermission>');
        }
        return operateBtn.join('');
    }

    $(function () {
        var options = {
            url: "/giftmgt/consumeDetail/list"+"?giftConsumeDetailEntity.register="+${user.id},
            getInfoUrl: "/giftmgt/consumeDetail/get/{id}",
            updateUrl: "/giftmgt/consumeDetail/edit",
            removeUrl: "/giftmgt/consumeDetail/remove",
            createUrl: "/giftmgt/consumeDetail/add",
            columns: [
                {
                    field: 'id',
                    title: '序号',
                    editable: false,
                    width: 35,
                    formatter: function (data, row) {
                        return '<a href="javascript:;" onclick="view(' + row.id + ')">' + data + '</a>'
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
                        if(row.projectId!=null){
                            return '<a href="javascript:;" onclick="viewPorject(' + row.projectId + ')">' + data + '</a>'
                        }
                        return data;
                    }
                }, {
                    field: 'personName',
                    title: '客户名称',
                    editable: false,
                    width: 50,
                    formatter: function (data, row) {
                        if(row.personId!=null){
                            return '<a href="javascript:;" onclick="viewPerson(' + row.personId + ')">' + data + '</a>'
                        }
                        return data;
                    }
                }, {
                    field: 'repertoryName',
                    title: '礼品名称',
                    editable: false,
                    width: 60
                }, {
                    field: 'num',
                    title: '份数',
                    editable: false,
                    width: 40
                }, {
                    field: 'amount',
                    title: '金额',
                    editable: false,
                    width: 50
                }, {
                    field: 'sendTime',
                    title: '送出时间',
                    editable: false,
                    width: 50
                }, {
                    field: 'sendSite',
                    title: '送礼地点',
                    editable: false,
                    width: 100,
                    formatter: function (data) {
                        var html = "<div style='width: 90px' class='colStyle' title='" + data + "'>" + data + "</div>";
                        return html;
                    }
                }, {
                    field: 'description',
                    title: '明细说明',
                    editable: false,
                    width: 100,
                    formatter: function (data) {
                        var html = "<div style='width: 90px' class='colStyle' title='" + data + "'>" + data + "</div>";
                        return html;
                    }
                }, {
                    field: 'status',
                    title: '送礼状态',
                    editable: false,
                    width: 50,
                    formatter: function (data) {
                        if (data != null) {
                            if (data == 0) {
                                return "待送";
                            } else if (data == 1) {
                                return "已送";
                            }else if (data == 2) {
                                return "退回";
                            }
                        }
                    }
                }, {
                    field: 'drawStatus',
                    title: '使用状态',
                    editable: false,
                    width: 50,
                    formatter: function (data) {
                        if (data != null) {
                            if (data == 0) {
                                return "待领用";
                            } else if (data == 1) {
                                return "已领用";
                            }
                        }
                    }
                }
            ],
            modalName: "礼品库存"
        };

        //1.初始化Table
        $('#tablelist').bootstrapTable({
            url: options.url,
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                 //工具按钮用哪个容器
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
    //excel导出
    $("#exportExcel").click(function () {
        window.location.href ="consumeDetail/exportExcel";
    });
    function view(id) {
        $.ajax({
            type: "post",
            async: false,
            url: "/giftmgt/consumeDetail/get/" + id,
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

    function viewPorject(id) {
        window.open("/custmgt/project/view/"+id);
    }

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
        var projectName = {'projectName': $("#formSearch #name").val()};
        params = $.extend(params, projectName);
        var personName = {'personName': $("#formSearch #personName").val()};
        params = $.extend(params, personName);
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
            $this.iCheck(((thisValue == $this.val())) ? 'check' : 'uncheck')
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
                $this.iCheck(((thisValue == $this.val())) ? 'check' : 'uncheck')
            } else if (type == 'checkbox') {
                $this.iCheck((thisValue || thisValue == 1) ? 'check' : 'uncheck');
            } else if (thisName == 'pm') {
                $this.val(thisValue);
                $this.selectPageRefresh();
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
</script>