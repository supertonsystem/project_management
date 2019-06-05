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
<div  id="viewModal" tabindex="-1" role="dialog"
     style="overflow: auto">
    <div class="modal-dialog" style="width: 850px; " role="document">
        <div class="modal-content">
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <div class="modal-body" style="padding-top: 0px;">
                        <form id="viewForm">
                            <input type="hidden" name="id" id="id">
                            <div class="table-responsive">
                                <h3 align="center">项目信息</h3>
                                <table class="table">
                                    <tbody>
                                    <tr id="tr_registerInfo">
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">登记时间:</span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="createTime">${projectEntity.createTime?string("yyyy-MM-dd")}</span>
                                        </td>
                                        <td class="title_td" style="padding-left: 15px;text-align: right;padding-right: 9px;">
                                            <span class="control-label title">登记人:&nbsp;&nbsp;&nbsp; </span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="registerUserName">${projectEntity.registerUserName}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">编&nbsp;&nbsp;&nbsp;&nbsp;号:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="number">${projectEntity.number}</span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">名&nbsp;&nbsp;&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp; </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="name">${projectEntity.name}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">公司名称:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="companyName">${projectEntity.companyName}</span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">区&nbsp;&nbsp;&nbsp;&nbsp;域: &nbsp;&nbsp; </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="area">${projectEntity.area}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">省&nbsp;&nbsp;&nbsp;&nbsp;份:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="province">${projectEntity.province}</span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">地&nbsp;&nbsp;&nbsp;&nbsp;址:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="address">${projectEntity.address}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">开工日期:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="startTime">
                                            <#if projectEntity.startTime??>
                                             ${projectEntity.startTime?string("yyyy-MM-dd")}
                                            <#else>
                                            </#if>
                                            </span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">完工日期: </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="endTime">
                                            <#if projectEntity.endTime??>
                                             ${projectEntity.endTime?string("yyyy-MM-dd")}
                                            <#else>
                                            </#if>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">工&nbsp;&nbsp;&nbsp;&nbsp;期:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="period">${projectEntity.period}</span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">甲方部门: </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="ownerDepartment">${projectEntity.ownerDepartment}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">甲方负责人:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="owner">${projectEntity.owner}</span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">部&nbsp;&nbsp;&nbsp;&nbsp;门： </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="departmentName">${projectEntity.departmentName}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">项目经理:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="pmName">${projectEntity.pmName}</span>
                                        </td>
                                        <td class="title_td" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">客户名称:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="personName">${projectEntity.personName}</span>
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
                                关联客户
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in">
                        <div class="panel-body" style="padding: 0px 5px;">
                            <#include "/custmgt/project_person_addUpdate.ftl"/>
                        </div>
                    </div>
                </div>
            </div>
        </@shiro.hasRole>
        </div>
    </div>
</div>
<#include "/layout/simple_footer.ftl"/>
<script>
    $(function () {
        $('#collapseOne').collapse('show')
    });
    var id='${projectEntity.id}';
    addUpdatePersonTable(id,'view');
</script>
