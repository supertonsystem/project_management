<div class="top_nav">
    <div class="nav_menu">
        <nav>
            <div class="nav toggle" style="padding-top:5px">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="javascript:;" style="line-height: 1px" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                       <#if user?exists>${user.nickname?if_exists}<#else>管理员</#if>
                        <span class=" fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-usermenu pull-right">
                        <li><a href="/passport/logout"><i class="fa fa-sign-out pull-right"></i> 退出系统</a></li>
                        <li><a href="javascript:;" onclick="updatePwd()">修改密码</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</div>

<div class="modal fade" id="updatePwdModal" tabindex="-1" role="dialog" aria-labelledby="updatePwdLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addroleLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <form id="updatePwdForm" class="form-horizontal form-label-left" novalidate>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="description">旧密码: <span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="password" class="form-control col-md-7 col-xs-12" name="oldPwd" id="oldPwd" required="required"/>
                        </div>
                    </div>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="available">新密码: <span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="password" class="form-control col-md-7 col-xs-12" name="newPwd" id="newPwd" required="required"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary updatePwdBtn">保存</button>
            </div>
        </div>
    </div>
</div>
