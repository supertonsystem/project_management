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
                                <h3 align="center">联系信息</h3>
                                <table class="table">
                                    <tbody>
                                    <tr id="tr_registerInfo">
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">登记时间:</span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="createTime">${contactEntity.createTime?string("yyyy-MM-dd")}</span>
                                        </td>
                                        <td class="title_td" style="padding-left: 15px;text-align: right;padding-right: 9px;">
                                            <span class="control-label title">登记人:&nbsp;&nbsp;&nbsp; </span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="registerUserName">${contactEntity.registerUserName}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">客户名称:  </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="personName">${contactEntity.person.name}</span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">客户职位:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="personPost">${contactEntity.person.post}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">会面时间:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="meetTime">
                                            <#if contactEntity.meetTime??>
                                            ${contactEntity.meetTime?string("yyyy-MM-dd")}
                                            <#else>
                                            </#if></span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">会面地址:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="meetAddress">${contactEntity.meetAddress}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">活动方式:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="activityMode">${contactEntity.activityMode}</span>
                                        </td>
                                        <td class="title_td" style="padding-left: 15px;text-align: right;padding-right: 9px;">
                                            <span class="control-label title">开销费用: </span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="expenses">${contactEntity.expenses}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">参与人员:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="participant">${contactEntity.participant}</span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">人&nbsp;&nbsp;&nbsp;&nbsp;数:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="peopleNum">${contactEntity.peopleNum}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">聊天记录:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;" class="control-label" id="chat" readonly="readonly">${contactEntity.chat}
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title_td" style="vertical-align:middle;width: 18%;text-align: right">
                                            <span class="control-label title">备&nbsp;&nbsp;&nbsp;&nbsp;注:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;" class="control-label" id="remark" readonly="readonly">${contactEntity.remark}
                                            </textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/simple_footer.ftl"/>
<script>
    $("#closeCur").click(function () {
        window.close();
    });
</script>
