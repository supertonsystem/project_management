<#include "layout/header.ftl"/>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div role="main">
                <div class="">
<@shiro.hasPermission name="projectmgt:add">
                    <div class="row top_tiles">
                        <div class="animated flipInY col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="tile-stats">
                                <div class="icon"><i class="fa fa-plus-square"></i></div>
                                <div class="count"  id="todayAddCount">0</div>
                                <h3>新增</h3>
                                <p>今日新增的项目.</p>
                            </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div id="agenda" class="tile-stats">
                                <div class="icon"><i class="fa fa-list-ol"></i></div>
                                <div class="count"><a id="agendaCount">0</a></div>
                                <h3>待办</h3>
                                <p>待处理的项目.</p>
                            </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="tile-stats">
                                <div class="icon"><i class="fa fa-calendar"></i></div>
                                <div class="count" id="delayCount">0</div>
                                <h3>延期</h3>
                                <p>超过1天未处理的项目.</p>
                            </div>
                        </div>
                    </div>
</@shiro.hasPermission>
                </div>
                        <@shiro.hasPermission name="custmgt:persons">
                             <#include "custmgt/person_visit_dashboard.ftl"/>
                         </@shiro.hasPermission>
            </div>
        </div>
    </div>
</div>
<#include "layout/footer.ftl"/>
<script>
    $(function () {
        //进入页面先执行一次
<@shiro.hasPermission name="projectmgt:add">
        statistics();
</@shiro.hasPermission>
    <@shiro.hasPermission name="custmgt:persons">
        visitPersonList();
    </@shiro.hasPermission>
    });
<@shiro.hasPermission name="projectmgt:add">
    window.setInterval(statistics,30000);
</@shiro.hasPermission>
    function statistics() {
        $.ajax({
            type: "post",
            url: "/projectmgt/statistics",
            success: function (json) {
                if (json.status == 200) {
                    var data=json.data;
                    $("#agendaCount").html(data.agendaCount);
                    $("#delayCount").html(data.delayCount);
                    $("#todayAddCount").html(data.todayAddCount);
                } else {
                    $.tool.alertError(json.message);
                }
            },
            error: function () {
                $.tool.alertError("网络超时！");
            }
        });
    }
<@shiro.hasPermission name="projectmgt:add">
    $("#agenda").on("click",function(){
        window.location.href = "/projectmgt/agenda";
    });
</@shiro.hasPermission>
</script>