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
                    <@shiro.hasPermission name="custmgt:project:add">
                        <button id="btn_add" type="button" class="btn btn-default" title="新增">
                            <i class="fa fa-plus"></i> 新增
                        </button>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="custmgt:project:batchDelete">
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
<div class="modal fade" style="width: 1000px;height: 500px;border-radius: 5px"  tabindex="-1" role="dialog" id="choose_list" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
<script>
    var addPersonList = [];
    $('#choose_list').on('show.bs.modal', function (e) {
        var modalWidth = $("#choose_list").width();
        var modalHeight = $("#choose_list").height();
        var left=($(window).width()- parseInt(modalWidth))/2+ "px";
        var top=($(window).height()- parseInt(modalHeight))/2+ "px";
        $("#choose_list").css({"margin-left":left,"margin-top":top});
    });
</script>
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
                                <h3 align="center">项目信息</h3>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">项目编号:</span></td>
                                        <td colspan="3">
                                            <input type="text" style="width: 581px;float: left;" class="form-control"
                                                   name="number" id="number"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span
                                                class="control-label title">项目名称: </span></td>
                                        <td style="vertical-align:middle" colspan="3">
                                            <input type="text" style="width: 581px;float: left;" class="form-control" name="name"
                                                   id="name"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">公司名称:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="companyName" id="companyName"/></td>
                                        <td class="title_td" style="vertical-align:middle"><span
                                                class="control-label title">区&nbsp;&nbsp;&nbsp;&nbsp;域: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="area"
                                                   id="area"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">省&nbsp;&nbsp;&nbsp;&nbsp;份:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="province" id="province"/></td>
                                        <td class="title_td" style="vertical-align:middle"><span
                                                class="control-label title">地&nbsp;&nbsp;&nbsp;&nbsp;址: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="address"
                                                   id="address"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">开工日期:</span></td>
                                        <td>
                                            <div style="width: 200px;">
                                                <div class="form-group" style="margin-bottom:0px;">
                                                    <div class='input-group date' id='startTime_datetimepicker' style="margin-bottom: 0px;vertical-align:middle">
                                                        <input type='text' class="form-control" name="startTime" id="startTime" />
                                                        <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle"><span
                                                class="control-label title">完工日期: </span></td>
                                        <td style="vertical-align:middle">
                                            <div style="width: 200px;">
                                                <div class="form-group" style="margin-bottom:0px;">
                                                    <div class='input-group date' id='endTime_datetimepicker' style="margin-bottom: 0px;vertical-align:middle">
                                                        <input type='text' class="form-control"  name="endTime" id="endTime"/>
                                                        <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">工&nbsp;&nbsp;&nbsp;&nbsp;期:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control" name="period"
                                                   id="period"/></td>
                                        <td class="title_td" style="vertical-align:middle"><span
                                                class="control-label title">甲方部门: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="ownerDepartment"
                                                   id="ownerDepartment"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">甲方负责人:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="owner" id="owner"/></td>
                                        <td class="title_td" style="vertical-align:middle"><span
                                                class="control-label title">部&nbsp;&nbsp;&nbsp;&nbsp;门：</span></td>
                                        <td style="vertical-align:middle">
                                            <select id="department" name="department" class="form-control col-md-5 col-xs-5"
                                                    placeholder="请选择部门" style="width: 200px;">
                                                <option value="">请选择</option>
                                            <@customTag method="availableDepartments">
                                                <#if availableDepartments?? && availableDepartments?size gt 0>
                                                    <#list availableDepartments as item>
                                                        <option value="${item.id?c}">${item.name}</option>
                                                        <#if item.nodes?? && item.nodes?size gt 0>
                                                            <#list item.nodes as node>
                                                                <option value="${node.id?c}">&nbsp;&nbsp;|-${node.name}</option>
                                                            </#list>
                                                        </#if>
                                                    </#list>
                                                <#else>
                                                    <option value="">无</option>
                                                </#if>
                                            </@customTag>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">项目经理:</span></td>
                                        <td colspan="3"><input type="text" style="width: 200px" class="form-control" name="pm"
                                                   id="pm"/></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        <@shiro.hasRole name="role:custmgt">
            <div class="panel-group" id="accordion" style="padding: 0px 15px">
                <div class="panel panel-default">
                    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion"
                         href="#collapseOne">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseOne">
                                关联客户
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in">
                        <div class="panel-body" style="padding: 0px 5px;">
                            <#include "/custmgt/project_person_addUpdate.ftl"/>
                        </div>
                    </div>
                </div>
            </div>
        </@shiro.hasRole>
        </div>
    </div>
</div>
<script>
    Array.prototype.indexOf = function (val) {
        for (var i = 0; i < this.length; i++) {
            if (this[i] == val) return i;
        }
        return -1;
    };

    Array.prototype.remove = function (val) {
        var index = this.indexOf(val);
        if (index > -1) {
            this.splice(index, 1);
        }
    };
    $(function () { $('#collapseTwo').collapse('hide')});

    $('#pm').selectPage({
        showField: 'nickname',
        keyField: 'id',
        data: '/user/ajaxlist',
        searchField: 'keywords',
        //ajax请求后服务端返回的数据格式处理
        //返回的数据里必须包含list（Array）和totalRow（number|string）两个节点
        eAjaxSuccess: function (d) {
            var result;
            if (d) result = d.data;
            else result = undefined;
            return result;
        },
        params: function(){
            var ownerDepId = $("#department").val();
            return {'user.depId': ownerDepId};
        }
    });

        function operateFormatter(code, row, index) {
            var currentUserId = '${user.id}';
            var trUserId = row.register;
            var id=row.id;
            var operateBtn = [

            ];
            if (currentUserId == trUserId) {
                operateBtn.push('<@shiro.hasPermission name="custmgt:project:edit"><a class="btn btn-xs btn-primary btn-update" data-id="' + id + '"><i class="fa fa-edit"></i>&nbsp;编辑</a></@shiro.hasPermission>');
                operateBtn.push('<@shiro.hasPermission name="custmgt:project:delete"><a class="btn btn-xs btn-danger btn-remove" data-id="' + id + '"><i class="fa fa-trash-o"></i>&nbsp;删除</a></@shiro.hasPermission>');
            }
            return operateBtn.join('');
        }

        $(function () {
            var options = {
                url: "/custmgt/project/list?custProjectEntity.register="+${user.id},
                getInfoUrl: "/custmgt/project/get/{id}",
                updateUrl: "/custmgt/project/edit",
                removeUrl: "/custmgt/project/remove",
                createUrl: "/custmgt/project/add",
                columns: [
                    {
                        field: 'id',
                        title: '序号',
                        visible: false
                    }, {
                        field: 'number',
                        title: '编号',
                        width: 45
                    },{
                        field: 'registerUserName',
                        title: '登记人',
                        width: 50
                    }, {
                        field: 'createTime',
                        title: '登记时间',
                        sortable: true,
                        editable: false,
                        width: 60
                    }, {
                        field: 'name',
                        title: '项目名称',
                        width: 100,
                        formatter: function (data,row) {
                            return '<a href="javascript:;" onclick="viewPorject('+row.id+')">'+data+'</a>'
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
                        width: 40
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
                contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                sortStable: true,
                showToggle:true,
                // 设置为 true 将获得稳定的排序
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
                columns: options.columns
            });

            $("#btn_add").click(function () {
                resetForm();
            <@shiro.hasRole name="role:custmgt">
                addUpdatePersonTable(-1,'');
            </@shiro.hasRole>
                $("#addOrUpdateModal").modal('show');
                $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("添加" + options.modalName);
                $(".addOrUpdateBtn").unbind('click');
                $(".addOrUpdateBtn").click(function () {
                    var name = $('#addOrUpdateForm #name').val();
                    if(name==null||name==''){
                        alert('项目名称不能为空');
                        return;
                    }
                    var number = $('#addOrUpdateForm #number').val();
                    if(number==null||number==''){
                        alert('项目编号不能为空');
                        return;
                    }
                    $(this).off();
                    $.ajax({
                        type: "post",
                        url: options.createUrl+"?addPersonIds="+addPersonList.join(","),
                        traditional: true,
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
                    <@shiro.hasRole name="role:custmgt">
                        addUpdatePersonTable(id,'');
                    </@shiro.hasRole>
                        $("#addOrUpdateModal").modal('show');
                        $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("修改" + options.modalName);

                        $(".addOrUpdateBtn").unbind('click');
                        $(".addOrUpdateBtn").click(function () {
                                var name = $('#addOrUpdateForm #name').val();
                                if(name==null||name==''){
                                    alert('项目名称不能为空');
                                    return;
                                }
                                var number = $('#addOrUpdateForm #number').val();
                                if(number==null||number==''){
                                    alert('项目编号不能为空');
                                    return;
                                }
                            $(this).off();
                                $.ajax({
                                    type: "post",
                                    url: options.updateUrl+"?addPersonIds="+addPersonList.join(","),
                                    traditional: true,
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

        function viewPorject(id) {
            window.open("/custmgt/project/view/"+id);
        }

        function viewPerson(id) {
            window.open("/custmgt/person/view/"+id);
        }
        //日期空间init
        $('#startTime_datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            showClear: true,
            showClose: true,
            focusOnShow: true,
            locale: moment.locale('zh-cn')
        });
        $('#endTime_datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            showClear: true,
            showClose: true,
            focusOnShow: true,
            locale: moment.locale('zh-cn')
        });

        function queryParams(params) {
            params = $.extend({}, params);
            //获取搜索框的值
            var name = {'custProjectEntity.name': $("#formSearch #name").val()};
            params = $.extend(params, name);
            return params;
        }


        function resetForm(info) {
            $("#addOrUpdateModal form input,#addOrUpdateModal form select,#addOrUpdateModal form textarea").each(function () {
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