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
            <div class="x_content">
                <div class="<#--table-responsive-->">
                    <div class="btn-group hidden-xs" id="toolbar">
                    <@shiro.hasPermission name="giftmgt:type:add">
                        <button id="btn_add" type="button" class="btn btn-default" title="新增">
                            <i class="fa fa-plus"></i> 新增
                        </button>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="giftmgt:type:batchDelete">
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
<script>

        function operateFormatter(value, row, index) {
            var operateBtn=[];
            var id=row.id;
            if(id==null||id==''){
                operateBtn.push("<@shiro.hasPermission name='giftmgt:type:add'><a class='btn btn-xs btn-success' javascript:;' onclick='btnSaveRow("+JSON.stringify(row)+","+index+");'><i class='fa fa-save'></i>&nbsp;保存</a></@shiro.hasPermission>");
                operateBtn.push("<@shiro.hasPermission name='giftmgt:type:add'><a class='btn btn-xs btn-danger' javascript:;' onclick='btnRemoveRow("+index+");'><i class='fa fa-trash-o'></i>&nbsp;删除</a></@shiro.hasPermission>");
            }else{
                operateBtn.push('<@shiro.hasPermission name="giftmgt:type:delete"><a id="btn-remove" class="btn btn-xs btn-danger btn-remove" data-id="' + id + '"><i class="fa fa-trash-o"></i>&nbsp;删除</a></@shiro.hasPermission>');
            }
            return operateBtn.join('');
        }

        $(function () {
            var options = {
                url: "/giftmgt/type/list",
                getInfoUrl: "/giftmgt/type/get/{id}",
                updateUrl: "/giftmgt/type/edit",
                removeUrl: "/giftmgt/type/remove",
                createUrl: "/giftmgt/type/add",
                columns: [
                    {
                        field: 'id',
                        title: '序号',
                        editable: false,
                        width: 40
                    },{
                        field: 'rowindex',
                        title: 'rowindex',
                        visible: false,
                        formatter:function(value,row,index){
                            return index;
                        }
                    },{
                        field: 'type',
                        title: '类别',
                        editable: true,
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
                search: true,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
                strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
                searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
                minimumCountColumns: 1,             //最少允许的列数
                showRefresh: true,                  //显示刷新按钮
                onEditableSave: function (field, row, oldValue, $el) {
                    if(row.id==null||row.id==''){
                        $("#tablelist").bootstrapTable('updateCell', {
                            index: row.rowindex,       //行索引
                            field: field,       //列名
                            value: row[field]        //cell值
                        });
                    }else{
                        $.ajax({
                            type: "post",
                            url: "/giftmgt/type/edit",
                            data: 'id='+row.id+'&'+field+'='+row[field],
                            success: function (json, status) {
                                if (json.status != 200) {
                                    alert('编辑失败');
                                    return;
                                }
                                $.tool.ajaxSuccess(json);
                            },
                            error: function () {
                                alert('编辑失败');
                            }
                        });
                    }
            },
                columns: options.columns
            });
            $("#btn_add").click(function () {
                var count = $('#tablelist').bootstrapTable('getData').length;
                var row = {index:count,row:{
                            "id":"",
                            "type" : "",
                            "rowindex":count,
                            "operate":""
                        }};
                $("#tablelist").bootstrapTable('insertRow', row);
            });


            /* 删除 */
            $('#tablelist').on('click', '#btn-remove', function () {
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

        //保存行
        function btnSaveRow(row, index) {
            if(row.type==null||row.type==''){
                alert('类别不能为空');
                return;
            }
            $.ajax({
                type: "post",
                url: "/giftmgt/type/add",
                data: row,
                dataType: 'JSON',
                success: function (json) {
                    var data=json.data;
                    if(data!=null){
                        $("#tablelist").bootstrapTable('updateCell', {
                            index: index,       //行索引
                            field: 'id',       //列名
                            value: data.id        //cell值
                        });
                    }else {
                        $.tool.ajaxError(json);
                    }
                },
                error: $.tool.ajaxError
            });
        }
        //删除行
        function btnRemoveRow(index) {
            var ids = [];//定义一个数组
            ids.push(index);//将要删除的id存入数组
            $("#tablelist").bootstrapTable('remove', {field: 'rowindex', values: ids});
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
            return params;
        }
    </script>