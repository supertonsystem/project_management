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
        width: 600px;
        height: 170px;
    }
    .focus {
        display: block;
        background-image: url('/assets/images/focus.png');
        background-repeat: no-repeat;
        width: 16px;
        height: 16px;
        float: left;
    }
    .unfocus{
        display: block;
        background-image: url('/assets/images/unfocus.png');
        background-repeat: no-repeat;
        width: 16px;
        height: 16px;
        float: left;
    }

    .title{
        font-weight: bold;
    }
</style>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">项目列表</li>
        </ol>
        <div class="x_panel">
            <div class="panel panel-default" style="margin-bottom:0px">
                <div class="panel-heading">查询条件</div>
                <div>
                    <form id="formSearch" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1" for="txt_search_title">项目名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="title" name="title">
                            </div>
                            <label class="control-label col-sm-1" for="txt_search_status">状态</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="status">
                                    <option value="">全部</option>
                                    <option value="1">进行中</option>
                                    <option value="2">已完成</option>
                                </select>
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
                <@shiro.hasPermission name="projectmgt:excel">
                    <div class="btn-group hidden-xs" id="toolbar">
                        <button type="button" id="exportExcel" class="btn btn-success" style=" margin-right: 5px;">
                            Excel导出
                        </button>
                        <button type="button" id="importExcel" class="btn btn-primary">Excel上传</button>
                    </div>
                </@shiro.hasPermission>
                    <div style="float: right;margin-top: 15px;">
                        <ul class="list-inline prod_color">
                            <li style="margin: 0px" title="截至计划时间5天">
                                <div class="color" style="background: #3399CC;text-align: center;color: white">5</div>
                            </li>
                            <li style="margin: 0px" title="截至计划时间1天">
                                <div class="color" style="background: #EB7347;text-align: center;color: white">1</div>
                            </li>
                            <li style="margin: 0px" title="超过计划时间">
                                <div class="color" style="background: #D24D57;text-align: center;color: white">超</div>
                            </li>
                        </ul>
                    </div>
                    <table id="tablelist" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/footer.ftl"/>
<!--上传excel-->
<div class="modal fade" id="importExcelModal" tabindex="1" role="dialog" aria-labelledby="importExcelLabel">
    <div class="modal-dialog" style="width: 800px; ">
        <div class="modal-content">
            <form enctype="multipart/form-data">
                <div class="form-group">
                    <div class="file-loading">
                        <input id="file-zh" type="file" class="file" data-theme="fas">
                    </div>
                </div>
            </form>
        </div>
    </div
</div>
<!--项目查看弹框-->
<div class="modal fade" id="addOrUpdateModal" tabindex="-1" role="dialog" aria-labelledby="addroleLabel"
     style="overflow: auto">
    <div class="modal-dialog" style="width: 850px; " role="document">
        <div class="modal-content">
            <ul id="myTab" class="nav nav-tabs bar_tabs right">
                <li style="float: left;">
                    <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                            data-dismiss="modal">返回
                    </button>
                    <button type="button" style="margin-bottom:0px;margin-right:0px;display: none"
                            class="btn btn-primary addOrUpdateBtn">保存
                    </button>
                </li>
                <li>
                    <a href="#historicActivityImage" data-toggle="tab">
                        查看流程
                    </a>
                </li>
                <li>
                    <a href="#historicActivity" data-toggle="tab">
                        流程记录
                    </a>
                </li>
                <li class="active">
                    <a href="#info" data-toggle="tab">
                        项目信息
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <div class="modal-body" style="padding-top: 0px;">
                        <form id="addOrUpdateForm">
                            <input type="hidden" name="id" id="id">
                            <input type="hidden" name="taskId" id="taskId">
                            <input type="hidden" name="processInstanceId" id="processInstanceId">
                            <div class="table-responsive">
                                <h3 align="center">项目进度管理</h3>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td style="text-align: right;line-height: 30px;"><span class="control-label title"
                                                                                               for="name">项目名称:</span>
                                        </td>
                                        <td colspan="3" style="vertical-align: middle"><span class="control-label"
                                                                                             id="title"></span></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;line-height: 30px;"><span class="control-label title"
                                                                                               for="name">项目编号:</span>
                                        </td>
                                        <td colspan="3" style="vertical-align: middle"><span class="control-label"
                                                                                             id="number"></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 12%;text-align: right;"><span
                                                class="control-label title">登记时间:</span></td>
                                        <td style="width: 38%"><span class="control-label" id="createTime"></span></td>
                                        <td style="width: 12%;text-align: right;"><span
                                                class="control-label title">登记人: </span></td>
                                        <td style="width: 38%"><span class="control-label" id="registerUserName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">责任部门:</span></td>
                                        <td><span class="control-label" id="ownerDepName"></span></td>
                                        <td style="text-align: right;"><span class="control-label title">责任人: </span></td>
                                        <td><span class="control-label" id="ownerUserName"></span></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">核实部门:</span></td>
                                        <td><span class="control-label" id="checkDepName"></span></td>
                                        <td style="text-align: right;"><span class="control-label title">绩效奖金: </span></td>
                                        <td><span class="control-label" id="price"></span></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">内容描述:</span></td>
                                        <td colspan="3"><textarea style="max-height: 200px;min-height: 100px;" class="control-label" id="content" readonly="readonly"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">计划时间:</span></td>
                                        <td><span class="control-label" id="plannedTime"></span></td>
                                        <td style="text-align: right;"><span class="control-label title">完成时间: </span></td>
                                        <td><span class="control-label" id="finishTime"></span></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">实际进度:</span></td>
                                        <td colspan="3">
                                            <div class="input-group col-md-4 col-sm-4 col-xs-4">
                                                <input type="number" class="form-control text-center" name="progress" id="progress" value="0"
                                                       min="0" max="100" step="1">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">延期原因:</span></td>
                                        <td colspan="3">
                                            <div id="div_delayReason">
                                                <textarea  style="max-height: 200px;min-height: 100px;"class="control-label" id="delayReason" readonly="readonly"></textarea>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">办公室意见:</span></td>
                                        <td colspan="3"><textarea style="max-height: 200px;min-height: 100px;" class="control-label" id="officeOpinion" readonly="readonly"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">总经理意见:</span></td>
                                        <td colspan="3"><textarea  style="max-height: 200px;min-height: 100px;"class="control-label" id="gmOpinion" readonly="readonly"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;"><span class="control-label title">备&nbsp;&nbsp;&nbsp;&nbsp;注:</span>
                                        </td>
                                        <td colspan="3"><textarea style="max-height: 200px;min-height: 100px;" class="control-label" id="remark" readonly="readonly"></textarea></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="tab-pane fade" id="historicActivity">
                    <div id="historicActivityTable" align="center" style="margin: 10px 10px">
                    </div>
                </div>
                <div class="tab-pane fade" id="historicActivityImage">
                    <div align="center" style="margin: 10px 0px">
                        <span id="historicActivityImg" class="historicActivityImage"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        //focus、mylist
        var type='${type}';
        /**
         * 操作按钮
         * @param code
         * @param row
         * @param index
         * @returns {string}
         */
        function operateFormatter(code, row, index) {
            var css = 'btn-default';
            var name = "查看";
            if(type=='mylist'){
                if (row.status == 1) {
                    name = "编辑";
                    css = 'btn-dark'
                }
            }
            var operateBtn = [
                '<a class="btn btn-xs ' + css + ' btn-view" data-id="' + row.id + '"><i class="fa fa-edit"></i>&nbsp;' + name + '</a>'
            ];
            return operateBtn.join('');
        }

        $(function () {
            var options = {
                url: "/projectmgt/list",
                myurl: "/projectmgt/mylist?projectMgt.ownerUserId="+${user.id},
                allurl: "/projectmgt/list",
                focusurl: "/projectmgt/focuslist?projectMgt.focus=1",
                getInfoUrl: "/projectmgt/get/{id}",
                updateUrl: "/projectmgt/edit",
                exportExcelUrl: "/projectmgt/exportExcel",
                historicActivityUrl: "/projectmgt/historicActivity",//处理人
                columns: [
                    {
                        field: 'id',
                        title: '序号',
                        editable: false,
                        visible: false
                    }, {
                        field: 'number',
                        title: '项目编号',
                        editable: false,
                        width: 90,
                        formatter: function (value, row, index) {
                            if(row.focus==1){
                                return "<@shiro.hasPermission name='projectmgt:focus'><i class='focus' title='取消关注' onclick='focusOperate(\""+row.id+"\",\""+0+"\");'></i></@shiro.hasPermission><i style='float: left'>"+value+"</i>";
                            }else {
                                return "<@shiro.hasPermission name='projectmgt:focus'><i class='unfocus' title='点击关注' onclick='focusOperate(\""+row.id+"\",\""+1+"\");'></i></@shiro.hasPermission><i style='float: left'>"+value+"</i>";
                            }
                        }
                    }, {
                        field: 'createTime',
                        title: '登记时间',
                        sortable: true,
                        editable: false,
                        width: 90
                    }, {
                        field: 'title',
                        title: '标题',
                        editable: false,
                        width: 220,
                        formatter: function (data) {
                            var html = "<div style='width: 210px' class='colStyle'  title='" + data + "'>" + data + "</div>";
                            return html;
                        }
                    }, {
                        field: 'ownerUserName',
                        title: '责任人',
                        editable: false,
                        width: 80
                    }, {
                        field: 'ownerDepName',
                        title: '责任部门',
                        editable: false,
                        sortable: true,
                        width: 90
                    }, {
                        field: 'progress',
                        title: '进度',
                        editable: false,
                        width: 100,
                        formatter: function (data) {
                            var html = "<div class='progress progress_sm'>";
                            html += "<div class='progress-bar bg-green' role='progressbar' data-transitiongoal='" + data + "'  style='width: " + data + "%;'></div>";
                            html += "</div>";
                            html += "<div><small>当前进度:" + data + "%</small>" +
                                    "</div>";
                            return html;
                        }
                    }, {
                        field: 'plannedTime',
                        title: '计划时间',
                        editable: false,
                        width: 90
                    }, {
                        field: 'finishTime',
                        title: '完成时间',
                        editable: false,
                        width: 90
                    }, {
                        field: 'remark',
                        title: '备注',
                        editable: false,
                        width: 120,
                        formatter: function (data) {
                            var html = "<div style='width: 110px' class='colStyle'  title='" + data + "'>" + data + "</div>";
                            return html;
                        }
                    }, {
                        field: 'taskName',
                        title: '当前环节',
                        editable: false,
                        width: 80
                    }, {
                        field: 'statusName',
                        title: '状态',
                        editable: false,
                        width: 70
                    }, {
                        field: 'operate',
                        title: '操作',
                        width: 120,
                        formatter: operateFormatter //自定义方法，添加操作按钮
                    }
                ],
                modalName: "项目"
            };
            if(type=='mylist'){
                options.url=options.myurl;
            }else if(type=='focus'){
                options.url=options.focusurl;
            }else{
                options.url=options.allurl;
            }
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
                showRefresh: false,                  //是否显示刷新按钮
                rowStyle: function (row, index) {
                    //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
                    if (row.status == 1 && row.remindGrade != '') {
                        if (row.remindGrade == 'danger') {
                            return {css: {'background-color': '#D24D57', "color": '#FFFFFF'}};
                        } else if (row.remindGrade == 'warning') {
                            return {css: {'background-color': '#EB7347', "color": '#FFFFFF'}};
                        } else if (row.remindGrade == 'info') {
                            return {css: {'background-color': '#3399CC', "color": '#FFFFFF'}};
                        }
                    }
                    return "";
                },
                columns: options.columns
            });

            /* 查看 */
            $('#tablelist').on('click', '.btn-view', function () {
                var $this = $(this);
                var userId = $this.attr("data-id");
                var projectmgt;
                var taskInfo;
                $.ajax({
                    type: "post",
                    async: false,
                    url: options.getInfoUrl.replace("{id}", userId),
                    success: function (json) {
                        var data = json.data;
                        //项目信息
                        projectmgt = data.projectMgt;
                        //任务信息
                        taskInfo = data.task;
                        //进行中的任务可以修改延期原因和实际进度
                        if(type=='mylist'){
                            if (projectmgt.status == 1) {
                                updateBtn(projectmgt);
                            } else {
                                viewBtn(projectmgt);
                            }
                        }else {
                            viewBtn(projectmgt);
                        }
                        $("#processInstanceId").val(projectmgt.processInstanceId);
                        resetForm(projectmgt);
                        $("#addOrUpdateModal").modal('show');

                    },
                    error: $.tool.ajaxError
                });
                // 选取第一个标签页
                $('#myTab a:last').tab('show');
            });

            function updateBtn(data) {
                //保存按钮
                $(".addOrUpdateBtn").show();
                $(".addOrUpdateBtn").unbind('click');
                $(".addOrUpdateBtn").click(function () {
                    if (validator.checkAll($("#addOrUpdateForm"))) {
                        var pVal=$("#progress").val();
                        if(pVal!=null && pVal!=""){
                            if(pVal<0||pVal>100){
                                alert('实际进度数值不合法');
                                return;
                            }
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
                    }
                });
                $("#div_delayReason").html('<textarea class="form-control" rows="8" name="delayReason" id="delayReason" >' + data.delayReason + '</textarea>');
                $("#div_progress").show();
                $("#progress").val(data.progress);
                $("#div_static_progress").hide();
            }

            function viewBtn(data) {
                $(".addOrUpdateBtn").hide();
                $("#div_delayReason").html('<p class="form-control-static" id="delayReason">' + data.delayReason + '</p>');
                $("#div_static_progress").show();
                $("#static_progress").html(data.progress);
                $("#div_progress").hide();
            }

            $('#btn_query').on('click', function () {
                $("#tablelist").bootstrapTable('refresh', {url: options.url});
            });

            $("#exportExcel").click(function () {
                var title = $("#title").val();
                var status = $("#status").val();
                var currentUserId =${user.id};
                var url=options.exportExcelUrl + "?projectMgt.title=" + title + "&projectMgt.status=" + status+"&pageSize="+100000;
                if(type=='mylist'){
                    url+="&projectMgt.ownerUserId=" + currentUserId;
                }
                if(type=='focus'){
                    url+="&projectMgt.focus=1";
                }
                window.location.href =url;
            });

            $("#importExcel").click(function () {
                $("#importExcelModal").modal('show');
            });

            //tab页切换
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                // 获取已激活的标签页的名称
                var activeTab = $(e.target).text().trim();
                if (activeTab == '流程记录') {
                    $.ajax({
                        type: "post",
                        url: options.historicActivityUrl,
                        data: $.param({"projectMgtId": $("#id").val()}),
                        success: function (json) {
                            $("#historicActivityTable").html("");
                            var htmlStr = "<table class=\"table table-striped\">";
                            htmlStr += "<thead><tr><th>任务名称</th><th>处理人</th><th>处理时间</th>";
                            htmlStr += "<tbody>";
                            if (json.data == null || json.data.projectMgtInfo == null || json.data.projectMgtInfo.status == 0 || json.data.historicActivity.length == 0) {
                                htmlStr += "<tr> <td colspan=\"3\" align='center'>暂无记录</td></tr>";
                            } else {
                                var projectMgtInfo = json.data.projectMgtInfo;
                                var historicActivity = json.data.historicActivity;
                                for (var i = 0; i < historicActivity.length; i++) {
                                    var r = historicActivity[i];
                                    if (i == historicActivity.length - 1 && projectMgtInfo.status == 1) {
                                        htmlStr += "<tr style='background-color:#F0E68C'>";
                                    } else {
                                        htmlStr += "<tr>";
                                    }
                                    htmlStr += "<td>" + r.activityName + "</td><td>" + r.assigneeUserName + "</td><td>" + r.startTime + "</td></tr>";
                                }
                            }
                            htmlStr += "</tbody>";
                            $("#historicActivityTable").append(htmlStr);
                        },
                        error: $.tool.ajaxError
                    });
                }
            });
        });


        function focusOperate(id,focus) {
            $.ajax({
                type: "post",
                url: "/projectmgt/edit",
                data: "id="+id+"&focus="+focus,
                success: function (json) {
                    $.tool.ajaxSuccess(json);
                    $.tableUtil.refresh();
                },
                error: $.tool.ajaxError
            });
        }

        function queryParams(params) {
            params = $.extend({}, params);
            //获取搜索框的值
            var title = {'projectMgt.title': $("#title").val()};
            params = $.extend(params, title);
            var status = {'projectMgt.status': $("#status").val()};
            params = $.extend(params, status);
            <#--if(type=='mylist'){-->
                <#--var currentUserId = {'projectMgt.ownerUserId': ${user.id}};-->
                <#--params = $.extend(params, currentUserId);-->
            <#--}-->
            return params;
        }

        function resetForm(info) {
            $("#addOrUpdateModal form input,#addOrUpdateModal form span,#addOrUpdateModal form select,#addOrUpdateModal form textarea").each(function () {
                var $this = $(this);
                clearText($this, this.type, info);
            });
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

                if (thisName != 'id') {
                    $this.html(thisValue);
                } else {
                    $this.val(thisValue);
                }
            } else {
                if (type === 'radio' || type === 'checkbox') {
                    $this.iCheck('uncheck');
                } else {
                    $this.html('');
                }
            }
        }

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            // 获取已激活的标签页的名称
            var activeTab = $(e.target).text().trim();
            if (activeTab == '查看流程') {
                var src = "/projectmgt/image?processInstanceId=" + $('#processInstanceId').val();
                $('#historicActivityImg').css("background-image", "url(" + src + ")");
                $('#historicActivityImg').css("display", "block");
            } else {
                $('#historicActivityImg').css("display", "none");
            }
        });

        <@shiro.hasPermission name="projectmgt:excel">
        $('#file-zh').fileinput({
            theme: 'fas',
            language: 'zh',
            uploadUrl: '/projectmgt/importExcel',
            showClose: false,
            showRemove: false,
            allowedFileExtensions: ['xls', 'xlst', 'xlt']
        }).on('fileerror', function (event, data, msg) {
            alert('服务器内部失败,请联系管理员');
            $(event.target).fileinput('clear').fileinput('unlock');
        }).on("fileuploaded", function (event, data, previewId, index) {
            if (data && data.response.status != 200) {
                alert('上传失败,' + data.response.message);
                $(event.target).fileinput('clear').fileinput('unlock');
            } else {
                $("#importExcelModal").modal('hide');
                $.tableUtil.refresh();
            }
        });
        </@shiro.hasPermission>

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