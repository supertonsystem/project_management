<#include "/layout/header.ftl"/>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">部门管理</li>
        </ol>
        <div class="x_panel">
            <div class="x_content">
                <div class="<#--table-responsive-->">
                    <div class="btn-group hidden-xs" id="toolbar">
                        <@shiro.hasPermission name="department:add">
                        <button id="btn_add" type="button" class="btn btn-default" title="新增部门">
                            <i class="fa fa-plus"></i> 新增部门
                        </button>
                        </@shiro.hasPermission>
                        <@shiro.hasPermission name="department:batchDelete">
                            <button id="btn_delete_ids" type="button" class="btn btn-default" title="删除选中">
                                <i class="fa fa-trash-o"></i> 批量删除
                            </button>
                        </@shiro.hasPermission>
                    </div>
                    <table id="tablelist">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/footer.ftl"/>
<!--添加用户弹框-->
<div class="modal fade" id="addOrUpdateModal" tabindex="-1" role="dialog" aria-labelledby="addroleLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addroleLabel">添加部门</h4>
            </div>
            <div class="modal-body">
                <form id="addOrUpdateForm" class="form-horizontal form-label-left" novalidate>
                    <input type="hidden" name="id">
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">部门名称: <span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" class="form-control col-md-7 col-xs-12" name="name" id="name" required="required" placeholder="请输入部门名称"/>
                        </div>
                    </div>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="type">父级资源: </label>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <select id="parentId" name="parentId" class="form-control col-md-5 col-xs-5">
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
                    </div>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="sort">排序:</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" class="form-control col-md-7 col-xs-12" name="sort" id="sort"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary addOrUpdateBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--/添加用户弹框-->
<script>
    /**
     * 操作按钮
     * @param code
     * @param row
     * @param index
     * @returns {string}
     */
    function operateFormatter(code, row, index) {
        var operateBtn = [
            '<@shiro.hasPermission name="department:edit"><a class="btn btn-xs btn-primary btn-update" data-id="' + row.id + '"><i class="fa fa-edit"></i>编辑</a></@shiro.hasPermission>'
        ];
         operateBtn.push('<@shiro.hasPermission name="department:delete"><a class="btn btn-xs btn-danger btn-remove" data-id="' + row.id + '"><i class="fa fa-trash-o"></i>删除</a></@shiro.hasPermission>');
        return operateBtn.join('');
    }

    $(function () {
        var options = {
            url: "/department/list",
            getInfoUrl: "/department/get/{id}",
            updateUrl: "/department/edit",
            removeUrl: "/department/remove",
            createUrl: "/department/add",
            columns: [
                {
                    checkbox: true
                },{
                    field: 'name',
                    title: '部门名称',
                    editable: false
                }, {
                    field: 'parent.name',
                    title: '父级部门',
                    editable: false
                }, {
                    field: 'sort',
                    title: '排序',
                    editable: false
                },{
                    field: 'operate',
                    title: '操作',
                    formatter: operateFormatter //自定义方法，添加操作按钮
                }
            ],
            modalName: "部门"
        };
        //1.初始化Table
        $.tableUtil.init(options);
        //2.初始化Button的点击事件
        $.buttonUtil.init(options);
    });
</script>