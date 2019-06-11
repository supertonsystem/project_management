<#include "/layout/header.ftl"/>
<style>
    .fileInputContainer{
        height:90px;
        background:url(upfile.png);
        position:relative;
        width: 125px;
    }
    .fileInput{
        height:90px;
        width: 125px;
        overflow: hidden;
        position:absolute;
        right:0;
        top:0;
        opacity: 0;
        filter:alpha(opacity=0);
        cursor:pointer;
    }
</style>
<div class="clearfix"></div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">首页</a></li>
            <li class="active">客户列表</li>
        </ol>
        <div class="col-md-12">
            <div class="x_panel">
                <div class="x_content">
                    <div class="row">
                        <div style="padding-left: 10px">
                        <@shiro.hasPermission name="custmgt:person:add">
                            <button id="btn_add" type="button" class="btn btn-default" title="新增客户">
                                <i class="fa fa-plus"></i> 新增
                            </button>
                        </@shiro.hasPermission>
                            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="search_name" style="float: right;width: 200px" placeholder="Search for..." value="${name}">
                                    <span class="input-group-btn" >
                                          <button class="btn btn-default" id="search" type="button">搜索</button>
                                        </span>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    <#list persons as person>
                        <div class="col-md-4 col-sm-4 col-xs-12 profile_details text-center">
                            <div class="well profile_view" style="padding: 0px 0px">
                                <div class="col-sm-12 ">
                                    <div class="left col-xs-8" style="margin-top:1px;text-align: left">
                                        <h2><a href="javascript:;" onclick="view(${person.id})">${person.name}</a></h2>
                                        <br/>
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-tag"></i><span style="margin-left: 5px;">职位: ${person.post}</span></li>
                                            <li><i class="fa fa-building"></i><span style="margin-left: 5px;">公司名称: ${person.companyName}</span></li>
                                            <li><i class="fa fa-phone-square"></i><span style="margin-left: 5px;">联系电话: ${person.phone}</span></li>
                                            <li><i class="fa fa-envelope"></i><span style="margin-left: 4px;">电子邮箱: ${person.email}</span></li>
                                            <li><i class="fa fa-bell"></i><span style="margin-left: 5px;">拜访日期:<#if person.visitTime??>
                                            ${person.visitTime?string("yyyy-MM-dd")}
                                            <#else>
                                            </#if>
                                                    </span></li>
                                        </ul>
                                    </div>
                                    <div class="right col-xs-4 text-center fileInputContainer">
                                        <input class="fileInput" name="${person.id}" onchange="uploadPersonIcon(this)" data-id="${person.id}" type="file" accept="image/jpeg,image/png,image/jpg">
                                        <img onerror='this.src="/assets/images/user.png"' style="height: 120px;width: 200px" src="/person/icon/${person.icon}" id="img_${person.id}" alt="" class="img-circle img-responsive">
                                    </div>
                                </div>
                                <div class="col-xs-12 bottom text-center">
                                    <div class="col-xs-12 col-sm-6 emphasis">
                                        <p class="ratings">
                                            <a>信用</a>
                                            <a href="#"><span class="fa fa-star"></span></a>
                                            <#if person.credit==0>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                            <#elseif person.credit==1>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star-o"></span></a>
                                            <#elseif person.credit==2>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star-o"></span></a>
                                                <a href="#"><span class="fa fa-star-o"></span></a>
                                            <#elseif person.credit==3>
                                                <a href="#"><span class="fa fa-star"></span></a>
                                                <a href="#"><span class="fa fa-star-o"></span></a>
                                                <a href="#"><span class="fa fa-star-o"></span></a>
                                                <a href="#"><span class="fa fa-star-o"></span></a>
                                            </#if>

                                        </p>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 emphasis" style="text-align: right;">
                                        <#if user.id==person.register>
                                            <a class="btn btn-xs btn-primary btn-update" data-id="${person.id}"><i class="fa fa-edit"></i>&nbsp;编辑</a>
                                            <a class="btn btn-xs btn-danger btn-remove" data-id="${person.id}"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                    </div>
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
    var addProjectList = [];
    var addContactList = [];
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
    <div class="modal-dialog" style="width: 1000px; " role="document">
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
                                <h3 align="center">客户信息</h3>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;width: 18%;text-align: right;padding-right: 19px;">
                                            <span class="control-label title">姓&nbsp;&nbsp;&nbsp;&nbsp;名:</span></td>
                                        <td>
                                            <input type="text" style="width: 200px;float: left;" class="form-control"
                                                   name="name" id="name"/>
                                            <em style="color: red;float: left;padding-left: 5px;padding-top: 12px;">*<em/>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 20px;"><span
                                                class="control-label title">性&nbsp;&nbsp;&nbsp;&nbsp;别: </span></td>
                                        <td style="vertical-align:middle">
                                            <div>
                                                <label class="radio-inline" style="padding-left: 0px;">
                                                    <input type="radio" name="sex" id="sex" value="0" checked> 男
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="sex" id="sex" value="1"> 女
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">公司名称:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="companyName" id="companyName"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">职&nbsp;&nbsp;&nbsp;&nbsp;位: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="post"
                                                   id="post"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">公司性质:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="companyNature" id="companyNature"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">所属行业: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="industry"
                                                   id="industry"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">公司规模:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="companyScale" id="companyScale"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">公司地址: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control"
                                                   name="companyAddress" id="companyAddress"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">联系电话:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control" name="phone"
                                                   id="phone"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">手机电话: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="mobile"
                                                   id="mobile"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">家庭地址:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control"
                                                   name="homeAddress" id="homeAddress"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">单位网址: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control"
                                                   name="companyWebsite" id="companyWebsite"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">电子邮箱:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control" name="email"
                                                   id="email"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">传&nbsp;&nbsp;&nbsp;&nbsp;真: </span></td>
                                        <td style="vertical-align:middle">
                                            <input type="text" style="width: 200px" class="form-control" name="fax"
                                                   id="fax"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">客户来源:</span></td>
                                        <td><input type="text" style="width: 200px" class="form-control" name="source"
                                                   id="source"/></td>
                                        <td class="title" style="vertical-align:middle;padding-left: 20px;"><span
                                                class="control-label title">信用状况: </span></td>
                                        <td style="vertical-align:middle">
                                            <div>
                                                <label class="radio-inline" style="padding-left: 0px;">
                                                    <input type="radio" name="credit" id="credit" value="0" checked> 优秀
                                                </label>
                                                <label class="radio-inline" style="padding-left: 0px;">
                                                    <input type="radio" name="credit" id="credit" value="1"> 良好
                                                </label>
                                                <label class="radio-inline" style="padding-left: 0px;">
                                                    <input type="radio" name="credit" id="credit" value="2"> 一般
                                                </label>
                                                <label class="radio-inline" style="padding-left: 0px;">
                                                    <input type="radio" name="credit" id="credit" value="3"> 较差
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right"><span
                                                class="control-label title">拜访日期:</span></td>
                                        <td>
                                            <div style="width: 200px;">
                                                <div class="form-group" style="margin-bottom:0px;">
                                                    <div class='input-group date' id='visitTime_datetimepicker' style="margin-bottom: 0px;vertical-align:middle">
                                                        <input type='text' class="form-control" name="visitTime" id="visitTime" />
                                                        <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right;padding-right: 19px;"><span
                                                class="control-label title">备&nbsp;&nbsp;&nbsp;&nbsp;注:</span></td>
                                        <td colspan="3"><textarea id="remark" name="remark" rows="6"
                                                                  style="width: 620px"></textarea></td>
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
                                项目信息
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in">
                        <div class="panel-body" style="padding: 0px 5px;">
                            <#include "/custmgt/project_addUpdate.ftl"/>
                        </div>
                    </div>
                </div>
                <div class="panel panel-success">
                    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion"
                         href="#collapseTwo">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseTwo">
                                联系信息
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse">
                        <div class="panel-body" style="padding: 0px 5px;">
                            <#include "/custmgt/contact_addUpdate.ftl"/>
                        </div>
                    </div>
                </div>
                <div class="panel panel-info">
                    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion"
                         href="#collapseThree">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseThree">
                                关联人员
                            </a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse">
                        <div class="panel-body" style="padding: 0px 5px;">
                            <#include "/custmgt/person_addUpdate.ftl"/>
                        </div>
                    </div>
                </div>
            </div>
        </@shiro.hasRole>
        </div>
    </div>
</div>
<script>
    function uploadPersonIcon(data) {
        var file = $(data)[0].files[0];
        if (typeof (file) == "undefined" || file.size <= 0) {
            alert("请选择图片");
            return;
        }
        if(file.type !== 'image/jpeg' && file.type !== 'image/png' && file.type !== 'image/jpg') {
            alert('只支持上传png图片!');
            return;
        }
        //判断文件大小
        var size = file.size;
        if(size >= 5*1024*1024){
            alert('文件不能大于5M!');
            return false;
        }
        var id=$(data).attr("data-id");
        var formData = new FormData();
        formData.append("file",file);
        formData.append("id",id);

        $.ajax({
            type: "post",
            url: "/custmgt/person/uploadIcon",
            data: formData,
            processData: false,
            contentType: false,
            success: function (json) {
                $.tool.ajaxSuccess(json);
                if(json.status==200){
                    $('#img_'+id).attr('src',URL.createObjectURL($(data)[0].files[0]));
                }
            },
            error: $.tool.ajaxError
        });
    }

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
    $(function () { $('#collapseThree').collapse('hide')});
    $(function () { $('#collapseOne').collapse('show')});
    var options = {
        url: "/custmgt/person/list"+"?custPersonEntity.register="+${user.id},
        getInfoUrl: "/custmgt/person/get/{id}",
        updateUrl: "/custmgt/person/edit",
        removeUrl: "/custmgt/person/remove",
        createUrl: "/custmgt/person/add"
    };

    $("#btn_add").click(function () {
    <@shiro.hasRole name="role:custmgt">
        addUpdateProjectTable(-1,'');
        addUpdateContactTable(-1,'');
        addUpdatePersonTable(-1,'');
    </@shiro.hasRole>
        resetForm();
        $("#addOrUpdateModal").modal('show');
        $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("添加" + options.modalName);
        $(".addOrUpdateBtn").unbind('click');
        $(".addOrUpdateBtn").click(function () {
            var name = $('#addOrUpdateForm #name').val();
            if(name==null||name==''){
                alert('客户名称不能为空');
                return;
            }
            $(this).off();
            $.ajax({
                type: "post",
                url: options.createUrl,
                data: $("#addOrUpdateForm").serialize()+"&addProjectIds="+addProjectList.join(",")+"&addContactIds="+addContactList.join(",")+"&addPersonIds="+addPersonList.join(","),
                success: function (json) {
                    $.tool.ajaxSuccess(json);
                    $("#addOrUpdateModal").modal('hide');
                    window.location.reload();
                },
                error: $.tool.ajaxError
            });
        });
    });


    /* 修改 */
    $('.emphasis').on('click', '.btn-update', function () {
        var $this = $(this);
        var id = $this.attr("data-id");
        $.ajax({
            type: "post",
            url: options.getInfoUrl.replace("{id}", id),
            success: function (json) {
                var info = json.data;
                resetForm(info);
            <@shiro.hasRole name="role:custmgt">
                addUpdateProjectTable(id,'');
                addUpdateContactTable(id,'');
                addUpdatePersonTable(id,'');
            </@shiro.hasRole>
                $("#addOrUpdateModal").modal('show');
                $("#addOrUpdateModal").find(".modal-dialog .modal-content .modal-header h4.modal-title").html("修改" + options.modalName);

                $(".addOrUpdateBtn").unbind('click');
                $(".addOrUpdateBtn").click(function () {
                    if (validator.checkAll($("#addOrUpdateForm"))) {
                        $(this).off();
                        $.ajax({
                            type: "post",
                            url: options.updateUrl,
                            data: $("#addOrUpdateForm").serialize()+"&addProjectIds="+addProjectList.join(",")+"&addContactIds="+addContactList.join(",")+"&addPersonIds="+addPersonList.join(","),
                            success: function (json) {
                                $.tool.ajaxSuccess(json);
                                $("#addOrUpdateModal").modal('hide');
                                window.location.reload();
                            },
                            error: $.tool.ajaxError
                        });
                    }
                });
            },
            error: $.tool.ajaxError
        });
    });

    /* 删除 */
    $('.emphasis').on('click', '.btn-remove', function () {
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
                    window.location.reload();
                },
                error: $.tool.ajaxError
            });
        }, function () {

        }, 5000);
    }
    //查询
    $('#search').on('click', function () {
        var name=$('#search_name').val();
        window.location.href='http://192.168.0.52:8080/custmgt/persons'+"?custPersonEntity.name="+name;
    });

    function view(id) {
        window.open("/custmgt/person/view/"+id);
    }
    //日期空间init
    $('#visitTime_datetimepicker').datetimepicker({
        format: 'YYYY-MM-DD',
        showClear: true,
        showClose: true,
        focusOnShow: true,
        locale: moment.locale('zh-cn'),
        minDate: new Date(),
        widgetPositioning: { horizontal: 'right', vertical: 'top'}
    });
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