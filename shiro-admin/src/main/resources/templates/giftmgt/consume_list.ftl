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
            <li class="active">领用列表</li>
        </ol>
        <div class="x_panel">
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="formSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">标题</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="title" name="title">
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
                    <@shiro.hasPermission name="giftmgt:consume:add">
                        <button id="btn_add" type="button" class="btn btn-default" title="新增">
                            <i class="fa fa-plus"></i> 新增
                        </button>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="giftmgt:consume:batchDelete">
                        <button id="btn_delete_ids" type="button" class="btn btn-default" title="删除选中">
                            <i class="fa fa-trash-o"></i> 批量删除
                        </button>
                    </@shiro.hasPermission>
                    </div>
                    <table id="tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/footer.ftl"/>
<!--领用新增/编辑弹框-->
<div class="modal fade" id="addOrUpdateModal" tabindex="-1" role="dialog"
     style="overflow: auto" data-backdrop="static">
    <div class="modal-dialog" style="width: 1000px; " role="document">
        <div class="modal-content">
            <div class="modal-header" style="padding: 5px">
                <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                        data-dismiss="modal">返回
                </button>
                <button type="button" style="margin-bottom:0px;margin-right:0px"
                       id="addOrUpdateBtn" class="btn btn-primary addOrUpdateBtn">保存
                </button>
                <button type="button" style="margin-bottom:0px;margin-right:0px"
                        id="submitBtn" class="btn btn-primary submitBtn">提交
                </button>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <div class="modal-body" style="padding-top: 0px;">
                        <form id="addOrUpdateForm">
                            <input type="hidden" name="id" id="id">
                            <input type="hidden" name="register" id="register">
                            <div class="table-responsive">
                                <h3 align="center">礼品领用</h3>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="title" style="padding-left: 40px;"><span
                                                class="control-label title">标&nbsp;&nbsp;&nbsp;&nbsp;题:</span>
                                        </td>
                                        <td>
                                            <input type="text" style="width: 200px;float: left" class="form-control" name="title"
                                                   id="title"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">状&nbsp;&nbsp;&nbsp;&nbsp;态: </span></td>
                                        <td>
                                            <select id="status" name="status" style="width: 200px;" class="form-control" disabled="disabled">
                                                    <option value="0"  selected = "selected">登记</option>
                                                    <option value="1">待确认</option>
                                                    <option value="2">已完成</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" ><span
                                                class="control-label title">份&nbsp;&nbsp;&nbsp;&nbsp;数: </span></td>
                                        <td>
                                            <input type="text" style="width: 200px" class="form-control" name="num"
                                                   readonly="readonly" id="num"/>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">金&nbsp;&nbsp;&nbsp;&nbsp;额:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control" name="amount"
                                                   id="amount" readonly="readonly"/></td>
                                    </tr>
                                    <tr>
                                        <td class="title" ><span
                                                class="control-label title">退还份数: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="number" style="width: 200px" class="form-control" name="backNum"  min="0"
                                                   id="backNum"  readonly="readonly"/>
                                        </td>
                                        <td class="title" ><span
                                                class="control-label title">退还金额:</span></td>
                                        <td>
                                            <input type="number" min="0" style="width: 200px" class="form-control"
                                                               name="backMoney" id="backMoney"  readonly="readonly"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" >
                                            <span class="control-label title">情况说明:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 700px;" class="control-label" id="description" name="description"></textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                    <div class="panel panel-default" style="margin: 5px 20px">
                        <div class="panel-heading">
                            <h3 class="panel-title">送礼记录</h3>
                        </div>
                        <div class="panel-body" style="padding-top: 0px;">
                        <#--<table id="consume_detail_list" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">-->
                            <#--</table>-->
                            <#include "/giftmgt/consume_detail_addUpdate.ftl"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--领用查看弹框-->
<div class="modal" id="viewConsume"  style="display: none;">

</div>

<script>
    var audit=false;
    <@shiro.hasPermission name="giftmgt:consume:audit">
            audit=true;
    </@shiro.hasPermission>

    function operateFormatter(code, row, index) {
        var currentUserId = '${user.id}';
        var trUserId = row.register;
        var id=row.id;
        var operateBtn = [
        ];
        if (currentUserId == trUserId&&row.status==0) {
            operateBtn.push('<@shiro.hasPermission name="giftmgt:consume:edit"><a class="btn btn-xs btn-primary btn-update" style="margin-bottom:0px;line-height:1.3" data-id="' + id + '"><i class="fa fa-edit"></i> 编辑</a></@shiro.hasPermission>');
            operateBtn.push('<@shiro.hasPermission name="giftmgt:consume:delete"><a class="btn btn-xs btn-danger btn-remove" style="margin-bottom:0px;line-height:1.3" data-id="' + id + '"><i class="fa fa-trash-o"></i> 删除</a></@shiro.hasPermission>');
        }
        //申请中 可以修改领用状态
        if(row.status==1){
            if(currentUserId==trUserId){
                operateBtn.push('<@shiro.hasPermission name="giftmgt:consume:edit"><a class="btn btn-xs btn-primary btn-claim" style="margin-bottom:0px;line-height:1.3" data-id="' + id + '"><i class="fa fa-edit"></i> 确认</a></@shiro.hasPermission>');
            }else{
                operateBtn.push('<@shiro.hasPermission name="giftmgt:consume:audit"><a class="btn btn-xs btn-primary btn-claim" style="margin-bottom:0px;line-height:1.3" data-id="' + id + '"><i class="fa fa-edit"></i> 确认</a></@shiro.hasPermission>');
            }
        }

        return operateBtn.join('');
    }

    $(function () {
        var options = {
            url: "/giftmgt/consume/list"+"?giftConsumeEntity.register="+${user.id},
            getInfoUrl: "/giftmgt/consume/get/{id}",
            updateUrl: "/giftmgt/consume/edit",
            removeUrl: "/giftmgt/consume/remove",
            createUrl: "/giftmgt/consume/add",
            submitUrl: "/giftmgt/consume/submit",
            saveUrl: "/giftmgt/consume/add",
            detailUrl: "/giftmgt/consumeDetail/listAll",
            columns: [
                {
                    field: 'id',
                    title: '序号',
                    editable: false,
                    width: 35
                },{
                    field: 'register',
                    title: '登记人Id',
                    visible: false
                },{
                    field: 'registerUserName',
                    title: '登记人',
                    visible: audit,
                    width: 60
                }, {
                    field: 'createTime',
                    title: '登记时间',
                    sortable: true,
                    editable: false,
                    width: 60
                }, {
                    field: 'title',
                    title: '标题',
                    width: 150,
                    formatter: function (data,row) {
                        return "<a href='javascript:;' onclick='view("+row.id+")' >"+data+"</a>"
                    }
                }, {
                    field: 'num',
                    title: '份数',
                    editable: false,
                    width: 50
                }, {
                    field: 'amount',
                    title: '金额',
                    editable: false,
                    width: 60
                }, {
                    field: 'backNum',
                    title: '退还份数',
                    editable: false,
                    width: 40
                }, {
                    field: 'backMoney',
                    title: '退还金额',
                    editable: false,
                    width: 50
                }, {
                    field: 'description',
                    title: '说明',
                    editable: false,
                    width: 120,
                    formatter: function (data) {
                        var html = "<div style='width: 110px' class='colStyle' title='" + data + "'>" + data + "</div>";
                        return html;
                    }
                }, {
                    field: 'status',
                    title: '状态',
                    editable: false,
                    width: 60,
                    formatter: function (data) {
                        if(data==0){
                            return '登记';
                        }
                        if(data==1){
                            return '待确认'
                        }
                        if(data==2){
                            return '已完成'
                        }
                        return '';
                    }
                }, {
                    field: 'operate',
                    title: '操作',
                    width: 90,
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
            detailView: true,
            detailFormatter: detailFormatter,
            columns: options.columns
        });

        $("#btn_add").click(function () {
            //重置
            initDetailListTable(-1,'save');
            resetForm();
            $("#addOrUpdateModal").modal('show');
            options.saveUrl=options.createUrl;
            addOrUpdateBtn();
            submitBtn();
        });

        function detailFormatter(index, row, element) {
            var html=[];
            $.ajax({
                type: "post",
                url: options.detailUrl,
                async: false,
                data:{"consumeId":row.id},
                success: function (json) {
                    if(json.data!=null){
                        var info=json.data;
                        html.push('<div class="panel panel-default" style="margin-bottom:1xp;">');
                        html.push(' <div class="panel-body">');
                        html.push(' <div class="table-responsive" style="padding: 0px 10px 10px 10px;background: #E8E8E8">');
                        html.push('<h4 style="padding-left: 5px;">送礼明细</h4>');
                        html.push('<table class="table" style="background: #E8E8E8">');
                        html.push('<thead><tr><th style="padding-left: 5px;">项目名称</th><th style="padding-left: 5px;">客户名称</th><th style="padding-left: 5px;">礼品名称</th><th style="padding-left: 5px;">份数</th><th style="padding-left: 5px;">金额</th>');
                        html.push('<th style="padding-left: 5px;">送礼时间</th><th style="padding-left: 5px;">送礼地点</th><th style="padding-left: 5px;">明细说明</th><th style="padding-left: 5px;">使用</th><th style="padding-left: 5px;">领用</th></tr>');
                        html.push('<tbody>');
                        for(var i=0;i<info.length;i++){
                            html.push('<tr>');
                            html.push('<td><a href="javascript:;" onclick="viewPorject('+info[i].projectId+')">'+info[i].projectName+'</a></td>');
                            html.push('<td><a href="javascript:;" onclick="viewPerson('+info[i].personId+')">'+info[i].personName+'</a></td>');
                            html.push('<td>'+info[i].repertoryName+'</td>');
                            html.push('<td>'+info[i].num+'</td>');
                            html.push('<td>'+info[i].amount+'</td>');
                            if(info[i].sendTime==null){
                                html.push('<td></td>');
                            }else {
                                html.push('<td>'+info[i].sendTime+'</td>');
                            }
                            html.push('<td>'+info[i].sendSite+'</td>');
                            html.push('<td>'+info[i].description+'</td>');
                            if(info[i].status==0){
                                html.push('<td>待送</td>');
                            } else if(info[i].status==1){
                                html.push('<td>已送</td>');
                            }else {
                                html.push('<td>退回</td>');
                            }
                            if(info[i].drawStatus==0){
                                html.push('<td>待确认</td>');
                            }else {
                                html.push('<td>已确认</td>');
                            }
                            html.push('</tr>');
                        }
                        html.push('</tbody>');
                        html.push('</table>');
                        html.push('</div>');
                        html.push('</div>');
                        html.push('</div>');
                    }
                },
                error: $.tool.ajaxError
            });
            return html.join("");
        }
        /* 修改 */
        $('#tablelist').on('click', '.btn-update', function () {
            var $this = $(this);
            var id = $this.attr("data-id");
            initDetailListTable(id,'edit');
            $.ajax({
                type: "post",
                url: options.getInfoUrl.replace("{id}", id),
                success: function (json) {
                    var info = json.data;
                    resetForm(info);
                    options.saveUrl=options.updateUrl;
                    $("#addOrUpdateModal").modal('show');
                    $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("修改" + options.modalName);
                    addOrUpdateBtn();
                    submitBtn();
                },
                error: $.tool.ajaxError
            });
        });


        /* 认领 */
        $('#tablelist').on('click', '.btn-claim', function () {
            var $this = $(this);
            var id = $this.attr("data-id");
            initDetailListTable(id,'claim');
            $.ajax({
                type: "post",
                url: options.getInfoUrl.replace("{id}", id),
                success: function (json) {
                    var info = json.data;
                    resetForm(info);
                    $("#addOrUpdateModal").modal('show');
                    $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("修改" + options.modalName);

                },
                error: $.tool.ajaxError
            });
        });
        
        function addOrUpdateBtn() {
            //保存操作
            $(".addOrUpdateBtn").unbind('click');
            $(".addOrUpdateBtn").click(function () {
                if (validator.checkAll($("#addOrUpdateForm"))) {
                    var title = $('#addOrUpdateForm #title').val();
                    if(title==null||title==''){
                        alert('标题不能为空');
                        return;
                    }
                    if(addDetailList.length==0&&tempRepertoryRecord.length==0){
                        alert('送礼记录不能为空');
                        return;
                    }
                    for (var i = 0; i < addDetailList.length; i++) {
                        var addDetail=addDetailList[i];
                        if(addDetail.personId==''){
                            alert('送礼明细【客户名称】不能为空');
                            return;
                        }
                        if(addDetail.projectId==''){
                            alert('送礼明细【项目名称】不能为空');
                            return;
                        }
                        if(addDetail.num==null||addDetail.num==''){
                            alert('送礼明细【份数】不能为空');
                            return;
                        }
                    }
                    $(this).off();
                    $.ajax({
                        type: "post",
                        url: options.saveUrl,
                        data: $("#addOrUpdateForm").serialize()+"&detailList="+JSON.stringify(addDetailList),
                        success: function (json) {
                            if(json!=null){
                                if(json.status==500){
                                    $.tool.ajaxSuccess(json);
                                    $.tableUtil.refresh();
                                }else{
                                    $.tool.ajaxSuccess(json);
                                    $("#addOrUpdateModal").modal('hide');
                                    $.tableUtil.refresh();
                                }
                            }
                        },
                        error: $.tool.ajaxError
                    });
                }
            });
        }

        
        function submitBtn() {
            //提交操作
            $(".submitBtn").unbind('click');
            $(".submitBtn").click(function () {
                var title = $('#addOrUpdateForm #title').val();
                if(title==null||title==''){
                    alert('标题不能为空');
                    return;
                }
                if(addDetailList.length==0&&tempRepertoryRecord.length==0){
                    alert('送礼记录不能为空');
                    return;
                }
                for (var i = 0; i < addDetailList.length; i++) {
                    var addDetail=addDetailList[i];
                    if(addDetail.personId==''){
                        alert('送礼明细【客户名称】不能为空');
                        return;
                    }
                    if(addDetail.projectId==''){
                        alert('送礼明细【项目名称】不能为空');
                        return;
                    }
                    if(addDetail.num==null||addDetail.num==''){
                        alert('送礼明细【份数】不能为空');
                        return;
                    }
                }
                $(this).off();
                $.ajax({
                    type: "post",
                    url: options.submitUrl,
                    data: $("#addOrUpdateForm").serialize()+"&detailList="+JSON.stringify(addDetailList),
                    success: function (json) {
                        if(json!=null){
                            if(json.status==500){
                                $.tool.ajaxSuccess(json);
                                $.tableUtil.refresh();
                            }else{
                                $.tool.ajaxSuccess(json);
                                $("#addOrUpdateModal").modal('hide');
                                $.tableUtil.refresh();
                            }
                        }
                    },
                    error: $.tool.ajaxError
                });
            });
        }


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
        //如果是a链接，阻止其跳转到url页面
        event.preventDefault();
        //将id为deadAdd的页面元素作为模态框激活
        $('#viewConsume').modal();
        //从url加载数据到模态框
        $('#viewConsume').load("/giftmgt/consume/view/"+id);
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
        if($("#title").val()!=''){
            var title = {'giftConsumeEntity.title': $("#title").val()};
            params = $.extend(params, title);
        }
        return params;
    }

    function viewPorject(id) {
        window.open("/custmgt/project/view/"+id);
    }
    function viewPerson(id) {
        window.open("/custmgt/person/view/"+id);
    }
    function resetViewForm(info) {
        $("#viewModal form span,#viewModal form textarea").each(function () {
            var $this = $(this);
            viewText($this, this.type, info);
        });
//        //独立设置a标签
//        $('#repertoryName').text(info['repertoryName']);
//        $('#repertoryName').attr("href","repertory/view/"+info['repertoryId'])
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
            } else {
                if (thisName != 'password') {
                    $this.val(thisValue);
                }
            }
        } else {
            if (type === 'radio' || type === 'checkbox'|| type === 'select-one') {
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