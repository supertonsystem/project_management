<div class="col-md-4 col-sm-4 col-xs-12" style="height: 400px;overflow-y: auto;">
    <div class="x_title">
        <h2>待拜访(近一个月)</h2>
        <div class="clearfix"></div>
    </div>
    <ul id="visitPersonList" class="list-unstyled top_profiles scroll-view">
        <li class="media event">
            暂无
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
                            html.push(' <li class="media event" style="background: #ffffff">');
                            html.push("<div style='float: left;margin-right: 10px;margin-top: 6px'><img onerror='this.src=\"/assets/images/user.jpg\"' style='height: 45px;width: 50px' src='/person/icon/"+d.icon+"'></div>");
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