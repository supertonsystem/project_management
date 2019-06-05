<#include "/layout/header.ftl"/>
<style  type="text/css">
    .input-group[class*=col-] {
        padding-left: 10px;
    }
    .historicActivityImage {
        display: block;
        background-repeat: no-repeat;
        background-position: 0px -100px;
        width: 600px;
        height: 170px;
    }
    .colStyle {
        padding-top: 3px;
        word-break:keep-all;/* 不换行 */
        white-space:nowrap;/* 不换行 */
        overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/
        -o-text-overflow:ellipsis;
        -icab-text-overflow: ellipsis;
        -khtml-text-overflow: ellipsis;
        -moz-text-overflow: ellipsis;
        -webkit-text-overflow: ellipsis;

    }
</style>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">待办</li>
        </ol>
        <div class="x_panel" style="padding: 0px 10px">
            <div class="x_content">
                <div class="<#--table-responsive-->">
                    <div class="btn-group hidden-xs" id="toolbar">
                    <@shiro.hasPermission name="projectmgt:add">
                        <button id="btn_add" type="button" class="btn btn-default" style=" margin-right: 5px;" title="新增">
                            <i class="fa fa-plus"></i> 新增
                        </button>
                    </@shiro.hasPermission>
                    </div>
                    <div style="float: right;margin-top: 15px;">
                        <ul class="list-inline prod_color">
                            <li style="margin: 0px"title="截至计划时间5天" >
                                <div class="color" style="background: #3399CC;text-align: center;color: white">5</div>
                            </li>
                            <li style="margin: 0px" title="截至计划时间1天" >
                                <div class="color" style="background: #EB7347;text-align: center;color: white">1</div>
                            </li>
                            <li style="margin: 0px" title="超过计划时间" >
                                <div class="color" style="background: #D24D57;text-align: center;color: white">超</div>
                            </li>
                        </ul>
                    </div>
                    <table id="tablelist">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/footer.ftl"/>
<!--选择处理人-->
<div class="modal fade bs-example-modal-sm" id="selectOperator" tabindex="-1" role="dialog"
     aria-labelledby="selectOperatorLabel">
    <div class="modal-dialog modal-sm" style="width: 500px;" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="selectRoleLabel">选择处理人</h4>
            </div>
            <div class="modal-body">
                <form id="boxRoleForm">
                    <div class="zTreeDemoBackground left">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary ztreesubmit">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>
<!--选择退回节点-->
<div class="modal fade bs-example-modal-sm" id="rollbackTaskList" tabindex="-1" role="dialog"
     aria-labelledby="rollbackTaskListLabel">
    <div class="modal-dialog modal-sm" style="width: 400px;" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="selectRoleLabel">选择节点</h4>
            </div>
            <div class="modal-body">
                <form id="boxRoleForm">
                    <div class="row">
                        <div class="item form-group col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label col-md-3 col-sm-3 col-xs-3" for="name">节点名称: <span class="required">*</span></label>
                            <div class="col-md-7 col-sm-7 col-xs-7" style="padding-top: 0px;">
                                <select id="rollbackTaskSelect" name="rollbackTaskSelect" class="form-control"
                                        placeholder="请选择节点">
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary rollbacktasksubmit">确认</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade bs-example-modal-sm" id="opinionModal" tabindex="-1" role="dialog"
     aria-labelledby="selectOperatorLabel" data-backdrop="static">
    <div class="modal-dialog modal-sm" style="width: 500px;" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="selectRoleLabel">填写意见</h4>
            </div>
            <div class="modal-body">
                <label for="name">意见内容</label>
                <textarea class="form-control" rows="6" name="content" id="opinionContent"></textarea>
                <br/>
                <label for="name">快捷标签</label>
                <select multiple class="form-control" id="opinionMuSelect">
                    <option value="同意">同意</option>o
                    <option value="不同意">不同意</option>
                </select>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="opinionModalSubmit">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

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
<!--添加用户弹框-->
<div class="modal fade" id="addOrUpdateModal" tabindex="-1" role="dialog" aria-labelledby="addroleLabel" style="overflow: auto">
    <div class="modal-dialog" style="width: 900px; " role="document" data-backdrop="static" >
        <div class="modal-content" >
            <ul id="myTab" class="nav nav-tabs bar_tabs right">
                <li style="float: left;">
                    <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default" data-dismiss="modal">返回</button>
                    <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-primary addOrUpdateBtn">保存</button>
                    <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-primary processsubmit">提交</button>
                    <button type="button" style="margin-bottom:0px;margin-right:0px;display: none" class="btn btn-warning rollbacksubmit">退回</button>
                </li>
                <li id="historicActivityImageLi">
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
                    <div class="modal-body">
                        <form id="addOrUpdateForm" class="form-horizontal form-label-left table table-bordered" novalidate>
                            <input type="hidden" name="id" id="id">
                            <input type="hidden" name="taskId" id="taskId">
                            <input type="hidden" name="processInstanceId" id="processInstanceId">
                            <div class="row" align="center" style="margin-top: 10px;">
                                <h3>项目进度管理</h3>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group col-md-12 col-sm-12 col-xs-12">
                                    <label class="control-label col-md-1 col-sm-1 col-xs-1" style="width: 12%;padding-right: 16px;" for="name">项目名称: </label>
                                    <div class="col-md-9 col-sm-9 col-xs-9" style="position: relative">
                                        <input type="text" class="form-control" name="title" id="title" required="required"  style="width: 605px;"
                                               placeholder="请输入项目名称"/>
                                    </div>
                                    <div id="required_title" style="position: absolute;top: 23px;left: 730px;"> <span class="required" style="color: red">*</span></div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group col-md-12 col-sm-12 col-xs-12">
                                    <label class="control-label col-md-1 col-sm-1 col-xs-1" style="width: 12%;padding-right: 16px;" for="name">项目编号: </label>
                                    <div class="col-md-9 col-sm-9 col-xs-9" style="position: relative">
                                        <input type="text" class="form-control" name="number" id="number" required="required"  style="width: 605px;"
                                               placeholder="请输入项目编号"/>
                                    </div>
                                    <div id="required_number" style="position: absolute;top: 23px;left: 730px;"> <span class="required" style="color: red">*</span></div>
                                </div>
                            </div>
                            <div class="row" style="padding-left: 5%;">
                                <div class="item form-group col-md-6 col-sm-6 col-xs-6" id="createTime-group" style="display: none">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3" for="createTime">登记时间:&nbsp;&nbsp;</label>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input type="text" class="form-control" id="createTime" />
                                    </div>
                                </div>
                                <div class="item form-group col-md-6 col-sm-6 col-xs-6" id="registerUserName-group" style="display: none">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3" for="registerUserName">登&nbsp;记&nbsp;&nbsp;人:</label>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input type="text" class="form-control" id="registerUserName" />
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group col-md-6 col-sm-6 col-xs-6">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3" for="ownerDepId">责任部门:&nbsp;&nbsp;</label>
                                    <div class="col-md-6 col-sm-6 col-xs-6" style="position: relative">
                                        <select id="ownerDepId" name="ownerDepId" class="form-control col-md-5 col-xs-5"
                                                placeholder="请选择责任部门" required="required">
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
                                    </div>
                                    <div id="required_ownerDepId" style="position: absolute;top: 23px;left: 306px;"> <span class="required" style="color: red">*</span></div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 2%;">
                                <div class="item form-group col-md-10 col-sm-10 col-xs-10">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-2"  style="padding-right: 14px;" for="ownerUserId">责&nbsp;任&nbsp;人:</label>
                                    <div class="col-md-8 col-sm-8 col-xs-8" style="margin-left: 10px;" title="请选择责任人">
                                        <input type="text" class="form-control ownerUserId" name="ownerUserId" id="ownerUserId"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group col-md-6 col-sm-6 col-xs-6">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3" for="checkDepId">核实部门: &nbsp;</label>
                                    <div class="col-md-6 col-sm-6 col-xs-6" style="position: relative">
                                        <select id="checkDepId" name="checkDepId" class="form-control col-md-5 col-xs-5"
                                                placeholder="请选择核实部门" required="required">
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
                                    </div>
                                    <div id="required_checkDepId" style="position: absolute;top: 23px;left: 306px;"> <span class="required" style="color: red">*</span></div>
                                </div>
                                <div class="item form-group col-md-6 col-sm-6 col-xs-6">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3" for="price">绩效奖金:</label>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input type="text" class="form-control" name="price" id="price"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 2%;">
                                <div class="item form-group col-md-10 col-sm-10 col-xs-10" id="div_group_delayReason">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-2" for="content">内容描述:</label>
                                    <div class="col-md-10 col-sm-10 col-xs-10" >
                                        <textarea class="form-control" rows="6" name="content" id="content" style="margin-left: 10px;width: 600px;"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group form-group col-md-6 col-sm-6 col-xs-6">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3">计划时间:&nbsp;&nbsp;</label>
                                    <!--指定 date标记-->
                                    <div class='input-group date col-md-6 col-sm-6 col-xs-6' style="float: left"
                                         id='plannedtime_datetimepicker'>
                                        <input type='text' class="form-control" name="plannedTime" id="plannedTime"/>
                                        <span class="input-group-addon" id="plannedTime-input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                                    </div>
                                </div>
                                <div class="item form-group form-group col-md-6 col-sm-6 col-xs-6">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-3">完成时间:</label>
                                    <div class="input-group date col-md-6 col-sm-6 col-xs-6" id='finishtime_datetimepicker' style="width: 190px;">
                                        <input type='text' class="form-control" name="finishTime" id="finishTime"
                                        />
                                        <span class="input-group-addon" id="finishTime-input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group  col-md-9 col-sm-9 col-xs-9">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-2" for="progress">实际进度:&nbsp;&nbsp;&nbsp;</label>
                                    <div class="input-group col-md-4 col-sm-4 col-xs-4">
                                        <input type="number" class="form-control text-center" name="progress" id="progress" value="0"
                                               min="0" max="100" step="1">
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 2%;">
                                <div class="item form-group col-md-10 col-sm-10 col-xs-10" id="div_group_delayReason">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-2" for="delayReason">延期原因:</label>
                                    <div class="col-md-10 col-sm-10 col-xs-10" >
                                        <textarea class="form-control" rows="6" name="delayReason" id="delayReason" style="margin-left: 10px;width: 600px;"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 2%;">
                                <div class="item form-group col-md-10 col-sm-10 col-xs-10" id="div_group_officeOpinion">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-2" for="officeOpinion">办公室意见:</label>
                                    <div class="col-md-10 col-sm-10 col-xs-10" >
                                        <textarea class="form-control" rows="6" name="officeOpinion" id="officeOpinion" style="margin-left: 10px;width: 600px;"></textarea>
                                        <div style="margin: 10px 10px 0px 10px;"><button class="btn btn-primary btn-sm"  type="button" id="officeOpinionModalBtn">填写意见</button></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 2%;">
                                <div class="item form-group col-md-10 col-sm-10 col-xs-10" id="div_group_gmOpinion">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-2" for="gmOpinion">总经理意见:</label>
                                    <div class="col-md-10 col-sm-10 col-xs-10" >
                                        <textarea class="form-control" rows="6" name="gmOpinion" id="gmOpinion" style="margin-left: 10px;width: 600px;"></textarea>
                                        <div style="margin: 10px 10px 0px 10px;"><button class="btn btn-primary btn-sm"  type="button" id="gmOpinionModalBtn">填写意见</button></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  style="padding-left: 5%;">
                                <div class="item form-group col-md-10 col-sm-10 col-xs-10" style="padding-left: 30px;">
                                    <label class="control-label col-md-1 col-sm-1 col-xs-1" for="remark" style="padding-left: 5px;">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</label>
                                    <div class="col-md-11 col-sm-11 col-xs-11" style="padding-left: 30px;">
                                        <textarea class="form-control" rows="6" name="remark" id="remark" style="margin-left: 6px;width: 600px;"></textarea>
                                    </div>
                                </div>
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
        $('#ownerUserId').selectPage({
            showField: 'nickname',
            keyField: 'id',
            data: '/user/ajaxlist',
            searchField: 'keywords',
            //启用多选模式
            multiple : true,
            //限制最多选中三个项目
            maxSelectLimit : 10,
            //设置选中项目后不关闭列表
            selectToCloseList : false,
            //ajax请求后服务端返回的数据格式处理
            //返回的数据里必须包含list（Array）和totalRow（number|string）两个节点
            eAjaxSuccess: function (d) {
                var result;
                if (d) result = d.data;
                else result = undefined;
                return result;
            }
        });
        /**
         * 操作按钮
         * @param code
         * @param row
         * @param index
         * @returns {string}
         */
        function operateFormatter(code, row, index) {
            var operateBtn = [
                '<@shiro.hasPermission name="projectmgt:edit"><a class="btn btn-xs btn-dark btn-update" data-id="' + row.id + '"><i class="fa fa-edit"></i>&nbsp;处理</a></@shiro.hasPermission>'
            ];
            operateBtn.push('<@shiro.hasPermission name="projectmgt:delete"><a class="btn btn-xs btn-danger btn-remove" data-id="' + row.id + '"><i class="fa fa-trash-o"></i>&nbsp;删除</a></@shiro.hasPermission>');
            return operateBtn.join('');
        }


        $(function () {
            var options = {
                url: "/projectmgt/agendalist",
                getInfoUrl: "/projectmgt/handle/{id}",
                updateUrl: "/projectmgt/edit",
                removeUrl: "/projectmgt/remove",
                startUrl: "/projectmgt/start",
                completeUrl: "/projectmgt/complete",//流程提交
                optSelectUrl: "/projectmgt/operatorSelect",//处理人
                historicActivityUrl: "/projectmgt/historicActivity",//处理人
                chooseUrl:"/projectmgt/start",//默认url
                rollbackTaskUrl:"/projectmgt/rollbackTaskList",
                rollbackUrl:"/projectmgt/rollback",
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
                        width: 80
                    },{
                        field: 'createTime',
                        title: '登记时间',
                        editable: false,
                        sortable: true,
                        width: 80
                    }, {
                        field: 'title',
                        title: '标题',
                        editable: false,
                        width: 250,
                        formatter: function (data) {
                            var html="<div style='width: 240px' class='colStyle'  title='"+data+"'>"+data+"</div>";
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
                        width: 80
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
                        width: 100
                    }, {
                        field: 'finishTime',
                        title: '完成时间',
                        editable: false,
                        width: 100
                    }, {
                        field: 'statusName',
                        title: '状态',
                        editable: false,
                        width: 80
//                        formatter: function (data) {
//                            if ('进行中' == data) {
//                                return '<span class="label label-info">' + data + '</span>';
//                            }
//                            if ('已完成' == data) {
//                                return '<span class="label label-success">' + data + '</span>';
//                            }
//                        }
                    }, {
                        field: 'operate',
                        title: '操作',
                        width: 120,
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
                sortStable: true,                   // 设置为 true 将获得稳定的排序
                queryParams: $.tableUtil.queryParams,//传递参数（*）
                queryParamsType: '',
                pagination: true,                   //是否显示分页（*）
                sidePagination: 'client',           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,                       //初始化加载第一页，默认第一页
                pageSize: 10,                       //每页的记录行数（*）
                pageList: [10, 20, 30, 50, 100],        //可供选择的每页的行数（*）
                search: false,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
                strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
                searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
                minimumCountColumns: 1,             //最少允许的列数
                showRefresh: false,                  //是否显示刷新按钮
                onEditableSave: function (field, row, oldValue, $el) {
                    if (options.updateUrl) {
                        $.ajax({
                            type: "post",
                            url: options.updateUrl,
                            data: {strJson: JSON.stringify(row)},
                            success: function (json) {
                                if (json.status == 200) {
                                    $.tool.alert(json.message);
                                } else {
                                    $.tool.alertError(json.message);
                                }
                            },
                            error: function () {
                                $.tool.alertError("网络超时！");
                            }
                        });
                    } else {
                        $.tool.alertError("无效的请求地址！");
                        return;
                    }
                },
                rowStyle: function (row, index) {
                    //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
                    if(row.status==1&&row.remindGrade!=''){
                        if(row.remindGrade=='danger'){
                            return {css:{'background-color':'#D24D57',"color":'#FFFFFF'}};
                        }else if(row.remindGrade=='warning'){
                            return {css:{'background-color':'#EB7347',"color":'#FFFFFF'}};
                        }else if(row.remindGrade=='info'){
                            return {css:{'background-color':'#3399CC',"color":'#FFFFFF'}};
                        }
                    }
                    return "";
                },
                columns: options.columns
            });
            /* 新增 */
            $("#btn_add").click(function () {
                addElementInfo();
                resetForm();
                $("#addOrUpdateModal").modal('show');
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
                        $(this).off();
                        $.ajax({
                            type: "post",
                            url: options.startUrl,
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
                options.chooseUrl=options.completeUrl;
                initZtree();
            });

            $(".processsubmit").unbind('click');
            $(".processsubmit").click(function () {
                if (validator.checkAll($("#addOrUpdateForm"))) {
                    $(this).off();
                    $.ajax({
                        type: "post",
                        url: options.chooseUrl,
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

            /* 处理*/
            $('#tablelist').on('click', '.btn-update', function () {
                $(this).off();
                var $this = $(this);
                var id = $this.attr("data-id");
                var projectmgt;
                var taskInfo;
                $.ajax({
                    type: "post",
                    async: false,
                    url: options.getInfoUrl.replace("{id}", id),
                    success: function (json) {
                        var data = json.data;
                        //项目信息
                        projectmgt = data.projectMgt;
                        //任务信息
                        taskInfo = data.task;
                        //填充部门信息
                        resetForm(projectmgt);
                        if(taskInfo!=null){
                            $("#taskId").val(taskInfo.id);
                        }
                        $("#processInstanceId").val(projectmgt.processInstanceId);
                        $("#addOrUpdateModal").modal('show');
                        $("#registerUserName-group").show();
                        $("#createTime-group").show();
                        $('#myTab a:last').tab('show');
                        $("#historicActivityImageLi").show();
                        $("#required_checkDepId").hide();
                        $("#required_number").hide();
                        $("#required_title").hide();
                        $("#required_ownerDepId").hide();
                    },
                    error: $.tool.ajaxError
                });

                if(taskInfo.name=="登记"){
                    //保存按钮
                    $(".addOrUpdateBtn").show();
                    $(".addOrUpdateBtn").unbind('click');
                    $(".addOrUpdateBtn").click(function () {
                        if (validator.checkAll($("#addOrUpdateForm"))) {
                            var pVal=$("#progress").val();
                            if(pVal!=null && pVal!=""){
                                if(pVal<0 || pVal>100){
                                    alert('实际进度数值不合法');
                                    return;
                                }
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
                        }
                    });
                    saveElementInfo();
                }else if(taskInfo.name=="部门审批"){
                    $(".addOrUpdateBtn").hide();
                    forbidElementInfo();
                    $('#officeOpinionModalBtn').hide();
                    $('#gmOpinionModalBtn').hide();
                    //退回按钮
                    $(".rollbacksubmit").show();
                    rollback();
                }else if(taskInfo.name=="办公室"){
                    $(".addOrUpdateBtn").show();
                    $(".addOrUpdateBtn").unbind('click');
                    $(".addOrUpdateBtn").click(function () {
                        if (validator.checkAll($("#addOrUpdateForm"))) {
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
                        }
                    });

                    forbidElementInfo();
                    $("#officeOpinion").removeAttr('readonly');
                    $("#remark").removeAttr('readonly');
                    $('#finishTime').removeAttr('disabled');
                    $('#finishTime').removeAttr('readonly');
                    $('#finishTime-input-group-addon').show();
                    $('#plannedTime').removeAttr('disabled');
                    $('#plannedTime').removeAttr('readonly');
                    $('#plannedTime-input-group-addon').show();
                    $('#officeOpinionModalBtn').show();
                    $('#gmOpinionModalBtn').hide();
                    $("#delayReason").attr('readonly',false);
                    //退回按钮
                    $(".rollbacksubmit").show();
                    rollback();
                }else if(taskInfo.name == '总经理'){
                    $(".addOrUpdateBtn").hide();
                    forbidElementInfo();
                    $("#gmOpinion").removeAttr('readonly');
                    $('#officeOpinionModalBtn').hide();
                    $('#gmOpinionModalBtn').show();
                    //退回按钮
                    $(".rollbacksubmit").show();
                    rollback();
                }
                options.chooseUrl=options.completeUrl;
                initZtree();
            });

            //选择完处理人后提交操作
            $('#selectOperator').on('click', '.ztreesubmit', function () {
                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                var nodes = treeObj.getCheckedNodes(true);
                if(nodes.length==0){
                    alert('请选择处理人');
                    return;
                }
                $(this).off();
                var ids = new Array();
                for (var i = 0; i < nodes.length; i++) {
                    //获取选中节点的值
                    ids.push(nodes[i].id);
                }
                $.ajax({
                    type: "post",
                    url: options.chooseUrl,
                    data: $.param({"operatorId": ids.join(",")}) + "&" + $("#addOrUpdateForm").serialize(),
                    success: function (json) {
                        $('#selectOperator').modal('hide');
                        $("#addOrUpdateModal").modal('hide');
                        $.tableUtil.refresh();
                    },
                    error: $.tool.ajaxError
                });
            });


            function rollback() {
                $.ajax({
                    type: "post",
                    async: false,
                    url: options.rollbackTaskUrl+"?processInstanceId="+$("#processInstanceId").val()+"&currentTaskId="+$("#taskId").val(),
                    success: function (json) {
                        var data = json.data;
                        if(data!=null){
                            if(data.length==1){
                                var task=data[0];
                                $(".rollbacksubmit").unbind('click');
                                $(".rollbacksubmit").click(function () {
                                    $.tool.confirm("确定退回吗？", function () {
                                        if (validator.checkAll($("#addOrUpdateForm"))) {
                                            $(this).off();
                                            $.ajax({
                                                type: "post",
                                                url: options.rollbackUrl+"?taskId="+task.taskId,
                                                success: function (json) {
                                                    $.tool.ajaxSuccess(json);
                                                    $("#addOrUpdateModal").modal('hide');
                                                    $.tableUtil.refresh();
                                                },
                                                error: $.tool.ajaxError
                                            });
                                        }
                                    }, function () {
                                    }, 5000);
                                });
                            }else{
                                $(".rollbacksubmit").unbind('click');
                                $(".rollbacksubmit").click(function () {
                                    $('#rollbackTaskList').modal('show');
                                });
                                $("#rollbackTaskSelect").html("");
                                for (var i = 0; i < data.length; i++) {
                                    var r = data[i];
                                    $("#rollbackTaskSelect").append("<option value='"+r.taskId+"'>"+r.activityName+"</option>");
                                }
                                $(".rollbacktasksubmit").click(function () {
                                    var checkValue=$("#rollbackTaskSelect").val();
                                    $(this).off();
                                    $.ajax({
                                        type: "post",
                                        url: options.rollbackUrl+"?taskId="+checkValue,
                                        success: function (json) {
                                            $("#rollbackTaskList").modal('hide');
                                            $("#addOrUpdateModal").modal('hide');
                                            $.tableUtil.refresh();
                                        },
                                        error: $.tool.ajaxError
                                    });
                                });

                            }
                        }
                    },
                    error: $.tool.ajaxError
                });
            }
            //初始化树
            function initZtree() {
                //选择人初始化
                $.ajax({
                    async: false,
                    type: "POST",
                    data: {taskId:  $("#taskId").val()},
                    url: options.optSelectUrl,
                    dataType: 'json',
                    success: function (json) {
                        if(json.data!=null&&json.status==200){
                            var data = json.data;
                            var setting = {
                                check: {
                                    enable: true,
                                    chkboxType: {"Y": "ps", "N": "ps"},
                                    chkStyle: "radio"
                                },
                                data: {
                                    simpleData: {
                                        enable: true
                                    }
                                }
                            };
                            var tree = $.fn.zTree.init($("#treeDemo"), setting, data);
                            tree.expandAll(true);//全部展开
                            //父节点不能选择
                            var nodes = tree.transformToArray(tree.getNodes());
                            for (var i=0, l=nodes.length; i < l; i++) {
                                if (nodes[i].isParent){
                                    tree.setChkDisabled(nodes[i], true);
                                }
                            }
                            $(".processsubmit").unbind('click');
                            $(".processsubmit").click(function () {
                                if (validator.checkAll($("#addOrUpdateForm"))) {
                                    $('#selectOperator').modal('show');
                                }
                            });
                        }
                    }
                });
            }

            /* 删除 */
            function remove(ids) {
                $.tool.confirm("确定删除该" + options.modalName + "信息？", function () {
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

            /* 删除 */
            $('#tablelist').on('click', '.btn-remove', function () {
                var $this = $(this);
                var selectedId = $this.attr("data-id");
                remove(selectedId);
            });

            //日期空间init
            $('#plannedtime_datetimepicker').datetimepicker({
                format: 'YYYY-MM-DD',
                showClear: true,
                showClose: true,
                focusOnShow: true,
                locale: moment.locale('zh-cn')
            });
            $('#finishtime_datetimepicker').datetimepicker({
                format: 'YYYY-MM-DD',
                showClear: true,
                showClose: true,
                focusOnShow: true,
                locale: moment.locale('zh-cn')
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
                            if (json.data==null || json.data.projectMgtInfo==null||json.data.projectMgtInfo.status == 0||json.data.historicActivity.length==0) {
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



            //tag 点击事件
            $("#officeAgree").click(function () {
                var html="<span class=\"tag\">\n" +
                        "<span>同意&nbsp;&nbsp;</span>\n" +
                        "<a href=\"#\" title=\"Removing tag\">x</a>\n" +
                        "</span>";
                $("#officeOpinion").append(html);
            });
            $(".sp_container").css("width","300px");
        });


        function resetForm(info) {
            $("#addOrUpdateModal form input,#addOrUpdateModal form select,#addOrUpdateModal form textarea").each(function () {
                var $this = $(this);
                clearText($this, this.type, info);
            });
            if(!info){
                $('#ownerUserId').selectPageClear();
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
                    $this.iCheck(((thisValue && 1 == $this.val()) || (!thisValue && 0 == $this.val())) ? 'check' : 'uncheck')
                } else if (type == 'checkbox') {
                    $this.iCheck((thisValue || thisValue == 1) ? 'check' : 'uncheck');
                } else if (thisName == 'ownerUserId') {
                    $this.val(thisValue);
                    $this.selectPageRefresh();
                } else {
                    if (thisName != 'password') {
                        $this.val(thisValue);
                    }
                }
            } else {
                if (type === 'radio' || type === 'checkbox') {
                    $this.iCheck('uncheck');
                } else {
                        $this.val('');
                }
            }
        }

        /**
         * 意见相关
         */
        $('#officeOpinionModalBtn').on('click',function () {
            $(this).off();
            $("#opinionContent").val('');
            $('#opinionModal').modal('show');
            $('#opinionModalSubmit').unbind('click');
            $('#opinionModalSubmit').click(function () {
                var nickName='${user.nickname}';
                //弹窗办公室意见内容
                var contentModal=$("#opinionContent").val();
                if(contentModal==''||contentModal.length==0){
                    alert('请填写意见');
                    return;
                }
                var hh="\r\n";
                var v=$("#officeOpinion").val();
                var content=contentModal;
                content+=hh;
                content+="             "+nickName+"   "+new Date().format("yyyy-MM-dd hh:mm:ss");
                content+=hh;
                content+=hh;
                $("#officeOpinion").val(v+content);
                $('#opinionModal').modal('hide');
            });
        });

        $('#gmOpinionModalBtn').on('click',function () {
            $(this).off();
            $("#opinionContent").val('');
            $('#opinionModal').modal('show');
            $('#opinionModalSubmit').unbind('click');
            $('#opinionModalSubmit').click(function () {
                var nickName='${user.nickname}';
                //弹窗办公室意见内容
                var contentModal=$("#opinionContent").val();
                if(contentModal==''||contentModal.length==0){
                    alert('请填写意见');
                    return;
                }
                var hh="\r\n";
                var v=$("#gmOpinion").val();
                var content=contentModal;
                content+=hh;
                content+="             "+nickName+"   "+new Date().format("yyyy-MM-dd hh:mm:ss");
                content+=hh;
                content+=hh;
                $("#gmOpinion").val(v+content);
                $('#opinionModal').modal('hide');
            });
        });

        $("#opinionMuSelect").change(function(){
            var checkValue=$("#opinionMuSelect").val();
            var v=$("#opinionContent").val();
            $("#opinionContent").val(v+checkValue);
        });

        /**
         * tab页相关
         */
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            // 获取已激活的标签页的名称
            var activeTab = $(e.target).text().trim();
            if(activeTab=='查看流程'){
                var src="/projectmgt/image?processInstanceId="+ $('#processInstanceId').val();
                $('#historicActivityImg').css("background-image","url("+src+")");
                $('#historicActivityImg').css("display","block");
            }else{
                $('#historicActivityImg').css("display","none");
            }
        });


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
        //禁用元素
        function forbidElementInfo() {
            //所有元素只读
            $('#addOrUpdateModal').find('input,textarea,select').not('button,hidden').attr('readonly',true);
            //下拉框禁选
            $('#addOrUpdateModal').find('select').attr('disabled',true);
            //下拉框只读
            $('#ownerUserId').selectPageDisabled(true);
            //进度组件隐藏
            $('.input-group-addon').hide();

        }
        //新增操作元素启用
        function addElementInfo(){
            $('#addOrUpdateModal').find('input,textarea,select').not('button,hidden').attr('readonly',false);
            $('#addOrUpdateModal').find('select').attr('disabled',false);
            $('#ownerUserId').selectPageDisabled(false);
            $('.input-group-addon').show();
            $(".addOrUpdateBtn").show();
            $("#registerUserName-group").hide();
            $("#createTime-group").hide();
            $("#required_checkDepId").show();
            $("#required_title").show();
            $("#required_number").show();
            $("#required_ownerDepId").show();
            $("#historicActivityImageLi").hide();
            $(".rollbacksubmit").hide();
            $('#officeOpinionModalBtn').hide();
            $('#gmOpinionModalBtn').hide();
            // 选取第一个标签页
            $('#myTab a:last').tab('show');

            $("#delayReason").attr('readonly',true);
            $("#officeOpinion").attr('readonly',true);
            $("#gmOpinion").attr('readonly',true);
            $("#remark").attr('readonly',true);
            $("#taskId").val("");
        }

        function saveElementInfo() {
            $('#addOrUpdateModal').find('input,textarea,select').not('button,hidden').attr('readonly',false);
            $('#addOrUpdateModal').find('select').attr('disabled',false);
            $('#ownerUserId').selectPageDisabled(false);
            $('.input-group-addon').show();
            $(".addOrUpdateBtn").show();
            $("#registerUserName-group").show();
            $("#createTime-group").show();
            $("#delayReason").attr('readonly',true);
            $("#officeOpinion").attr('readonly',true);
            $("#gmOpinion").attr('readonly',true);
            $("#remark").attr('readonly',true);
            $("#registerUserName").attr('readonly',true);
            $("#createTime").attr('readonly',true);
            $(".rollbacksubmit").hide();
            $('#officeOpinionModalBtn').hide();
            $('#gmOpinionModalBtn').hide();
            // 选取第一个标签页
            $('#myTab a:last').tab('show');
        }

    </script>