<#include "/layout/simple_header.ftl"/>
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
    }
</style>
<#include "/layout/simple_footer.ftl"/>
<div class="row">
    <div id="viewModal" tabindex="-1" role="dialog"
         style="overflow: auto">
        <div class="modal-dialog" style="width: 1000px; " role="document">
            <div class="modal-content">
                <div class="modal-header" style="padding: 5px">
                    <button id="closeCur" type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default">关闭
                    </button>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="info">
                        <div class="modal-body" style="padding-top: 0px;">
                            <form id="viewForm">
                                <input type="hidden" name="id" id="id">
                                <div class="table-responsive">
                                    <h3 align="center">客户信息</h3>
                                    <table class="table">
                                        <tbody>
                                        <tr id="tr_registerInfo">
                                            <td class="title_td"
                                                style="vertical-align:middle;width: 18%;text-align: right">
                                                <span class="control-label title">登记时间:</span>
                                            </td>
                                            <td style="width: 38%">
                                                <span class="form-control-static" id="createTime">${personEntity.createTime?string("yyyy-MM-dd")}</span>
                                            </td>
                                            <td class="title_td" style="padding-left: 15px;">
                                                <span class="control-label title">登记人:&nbsp;&nbsp; </span>
                                            </td>
                                            <td style="width: 38%">
                                                <span class="form-control-static" id="registerUserName">${personEntity.registerUserName}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td"
                                                style="vertical-align:middle;width: 18%;text-align: right">
                                                <span class="control-label title">姓&nbsp;&nbsp;&nbsp;&nbsp;名:&nbsp;&nbsp;&nbsp;</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="name">${personEntity.name}</span>
                                            </td>
                                            <td class="title_td"
                                                style="vertical-align:middle;width: 10%;padding-left: 15px;">
                                                <span class="control-label title">性&nbsp;&nbsp;&nbsp;&nbsp;别: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="sexName">${personEntity.sexName}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">公司名称:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="companyName">${personEntity.companyName}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">职&nbsp;&nbsp;&nbsp;&nbsp;位: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="post">${personEntity.post}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">公司性质:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="companyNature">${personEntity.companyNature}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">所属行业: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="industry">${personEntity.industry}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">公司规模:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="companyScale">${personEntity.companyScale}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">公司地址: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="companyAddress">${personEntity.companyAddress}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">联系电话:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="phone">${personEntity.phone}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">手机电话: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="mobile">${personEntity.mobile}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">家庭地址:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="homeAddress">${personEntity.homeAddress}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">单位网址: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="companyWebsite">${personEntity.companyWebsite}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">电子邮箱:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="email">${personEntity.email}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">传&nbsp;&nbsp;真: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="fax">${personEntity.fax}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">客户来源:</span>
                                            </td>
                                            <td>
                                                <span class="form-control-static" id="source">${personEntity.source}</span>
                                            </td>
                                            <td class="title_td" style="vertical-align:middle;padding-left: 15px;">
                                                <span class="control-label title">信用状况: </span>
                                            </td>
                                            <td style="vertical-align:middle">
                                                <span class="form-control-static" id="creditName">${personEntity.creditName}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">拜访日期:</span>
                                            </td>
                                            <td colspan="3">
                                                <span class="form-control-static" id="visitTime">
                                                 <#if personEntity.visitTime??>
                                                 ${personEntity.visitTime?string("yyyy-MM-dd")}
                                                 <#else>
                                                 </#if>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title_td" style="vertical-align:middle;text-align: right">
                                                <span class="control-label title">备&nbsp;&nbsp;&nbsp;&nbsp;注:</span>
                                            </td>
                                            <td colspan="3">
                                                <textarea style="max-height: 200px;min-height: 100px;"
                                                          class="control-label" id="remark"
                                                          readonly="readonly">${personEntity.remark}</textarea>
                                            </td>
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
</div>

<script>
    $(function () {
        $('#collapseTwo').collapse('hide')
    });
    $(function () {
        $('#collapseThree').collapse('hide')
    });
    $(function () {
        $('#collapseOne').collapse('show')
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
<@shiro.hasRole name="role:custmgt">
    var id='${personEntity.id}';
    addUpdateProjectTable(id,'view');
    addUpdateContactTable(id,'view');
    addUpdatePersonTable(id,'view');
</@shiro.hasRole>
    $("#closeCur").click(function () {
        window.close();
    });
</script>