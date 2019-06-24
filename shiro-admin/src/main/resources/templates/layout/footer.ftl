<footer>
    <div class="pull-right">
        Copyright © 2018 <a href="http://www.superton.net/cn/index.php" target="_blank">superton</a>. All Rights Reserved.
    </div>
    <div class="clearfix"></div>
</footer>
</div>
</div>
<script src="/assets/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/assets/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/assets/js/jquery/jquery-confirm.js" type="text/javascript"></script>
<script src="/assets/js/jquery/jquery.fancybox.js" type="text/javascript"></script>
<script src="/assets/js/mustache/mustache.js" type="text/javascript"></script>
<script src="/assets/js/xss.js" type="text/javascript"></script>
<script src="/assets/js/nprogress.js"></script>
<script src="/assets/js/toastr.js"></script>
<script src="/assets/js/icheck.js"></script>
<script src="/assets/js/bootstrap-table.min.js"></script>

<script src="/assets/js/bootstrap-table-zh-CN.min.js"></script>

<script src="/assets/js/moment.min.js"></script>
<#--<script src="/assets/js/daterangepicker.min.js"></script>-->
<script src="/assets/js/bootstrap-datetimepicker.js"></script>
<script src="/assets/js/bootstrap-progressbar.min.js"></script>
<script src="/assets/js/jquery/jquery.ztree.core.min.js"></script>
<script src="/assets/js/jquery/jquery.ztree.excheck.min.js"></script>
<script src="/assets/js/moment-with-locales.min.js"></script>
<script src="/assets/js/bootstrap-datetimepicker.js"></script>
<script src="/assets/js/jquery-form.js"></script>
<script src="/assets/js/suteng.tool.js"></script>
<script src="/assets/js/suteng.core.js"></script>
<script src="/assets/js/suteng.table.js"></script>
<script src="/assets/js/selectpage.js"></script>
<script src="/assets/js/jquery.spinner.js"></script>
<script src="/assets/js/fileinput/fileinput.js"></script>
<script src="/assets/js/fileinput/zh.js"></script>
<script src="/assets/js/fileinput/fas/theme.js"></script>
<script src="/assets/js/validator.js"></script>
<script src="/assets/js/validator/bootstrapValidator.min.js"></script>
<script src="/assets/js/validator/zh_CN.js"></script>
<script src="/assets/js/x-editable/bootstrap-editable.js"></script>
<script src="/assets/js/x-editable/bootstrap-table-editable.js"></script>
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.js"></script>
<!--[if lt IE 9]>
    <script src="/assets/js/html5shiv.js"></script>
    <script src="/assets/js/respond.min.js"></script>
<![endif]-->
</body>
</html>

<script>
    function updatePwd() {
        $("#updatePwdModal").modal('show');
    }

    $('.updatePwdBtn').on('click', function () {
        var oldPwd=$('#oldPwd').val();
        if(oldPwd==null||oldPwd==''){
            alert('旧密码不能为空');
            return;
        }
        var newPwd=$('#newPwd').val();
        if(newPwd==null||newPwd==''){
            alert('新密码不能为空');
            return;
        }
        $.ajax({
            type: "post",
            url: '/user/updatePwd',
            data: {'oldPwd': oldPwd,'newPwd':newPwd},
            success: function (json) {
                if(json.status==200){
                    $.tool.alert(json.message,3000,function () {
                        window.location.href='/passport/logout';
                    });
                }else{
                    $.tool.ajaxSuccess(json);
                }
            },
            error: $.tool.ajaxError
        });
    });
</script>