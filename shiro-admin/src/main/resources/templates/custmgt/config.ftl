<#include "/layout/header.ftl"/>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">配置管理</li>
        </ol>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                    配置信息
                </h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="form-group">
                        <label class="checkbox-inline">
                            <input type="checkbox" id="globalCustMgtControl" value="${globalCustMgtControl.value}"> 全局隐藏
                        </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/footer.ftl"/>

<script>
    var globalCustMgtControl='${globalCustMgtControl.value}';
    if(globalCustMgtControl==1){
        $('#globalCustMgtControl').iCheck('check');
    }else{
        $('#globalCustMgtControl').iCheck('uncheck');
    }
    var pop=-1;
    $('#globalCustMgtControl').on('ifChanged', function(event){
        var checked=$('#globalCustMgtControl').prop('checked');
        if(pop==-1){
            pop=0;
        }else{
            return;
        }
        $.ajax({
            type: "post",
            async: false,
            url: "/custmgt/config/globalCustMgtControl",
            data: {'globalCustMgtControl': checked},
            success: function (json) {
                pop=-1;
            },
            error: $.tool.ajaxError
        });
        pop=-1;
    });
</script>
