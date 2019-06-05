<div class="col-md-4 col-sm-4 col-xs-12" style="height: 400px;overflow-y: auto;">
    <div class="x_title">
        <h2>待拜访客户(近一个月)</h2>
        <div class="clearfix"></div>
    </div>
    <ul id="visitPersonList" class="list-unstyled top_profiles scroll-view">
        <li class="media event">
            <a class="pull-left border-aero profile_thumb">
                <i class="fa fa-user aero"></i>
            </a>
            <div class="media-body">
                <a class="title" href="#">Ms. Mary Jane</a>
                <p><strong>$2300. </strong> Agent Avarage Sales </p>
                <p> <small>12 Sales Today</small>
                </p>
            </div>
        </li>
    </ul>
</div>
<script>
    window.setInterval(visitPersonList,30000);
    function visitPersonList() {
        $.ajax({
            type: "post",
            url: "/custmgt/person/visitPersonList",
            success: function (json) {
                if (json.status == 200) {
                    var data=json.data;
                    if(data!=null&&data.length>0){
                        var html=[];
                        for(var i=0;i<data.length;i++){
                            var d=data[i];
                            html.push(' <li class="media event">');
                            html.push(' <a class="pull-left border-aero profile_thumb">');
                            html.push(' <i class="fa fa-user aero"></i></a>');
                            html.push(' <div class="media-body">');
                            html.push(' <a class="title" href="javascript:;" onclick="viewPerson('+d.id+')">'+d.name+'</a>');
                            html.push(' <p><strong>联系电话: '+d.phone+'</strong></p>');
                            html.push('  <p><small>拜访日期: '+d.visitTime+'</small></p>');
                            html.push('  </div></li>');
                        }
                        $("#visitPersonList").html(html.join(""));
                    }
                } else {
                    $.tool.alertError(json.message);
                }
            },
            error: function () {
                $.tool.alertError("网络超时！");
            }
        });
    }

    function viewPerson(id) {
        window.open("/custmgt/person/view/"+id);
    }
</script>