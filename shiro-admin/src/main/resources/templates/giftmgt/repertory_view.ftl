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
        vertical-align:middle;
        text-align: right;
    }
</style>
<#include "/layout/simple_footer.ftl"/>
<!--库存查看弹框-->
<div id="viewModal"
     style="overflow: auto">
    <div class="modal-dialog" style="width: 850px; " role="document">
        <div class="modal-content">
            <div class="modal-header" style="padding: 5px">
                <button type="button" style="margin-bottom:0px;margin-right:0px" class="btn btn-default"
                        data-dismiss="modal">返回
                </button>
            </div>
                <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <div class="modal-body" style="padding-top: 0px;">
                        <form id="viewForm">
                            <input type="hidden" name="id" id="id">
                            <div class="table-responsive">
                                <h3 align="center">礼品库存</h3>
                                <table class="table">
                                    <tbody>
                                    <tr id="tr_registerInfo">
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">登记时间:</span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="createTime">${repertory.createTime?string("yyyy-MM-dd")}<span
                                        </td>
                                        <td class="title" style="padding-left: 15px;padding-right: 9px;">
                                            <span class="control-label title">登记人:&nbsp;&nbsp;&nbsp; </span>
                                        </td>
                                        <td style="width: 30%">
                                            <span class="form-control-static" id="registerUserName">${repertory.registerUserName}<span
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="width: 18%;">
                                            <span class="control-label title">礼品名称:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="name">${repertory.name}</span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;width: 10%;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">礼品类别:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="typeName">${repertory.typeName}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">礼品数量:</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="sum">${repertory.sum}</span>
                                        </td>
                                        <td class="title">
                                            <span class="control-label title">库存数量:</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="repertory">${repertory.repertory}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title" style="vertical-align:middle;text-align: right">
                                            <span class="control-label title">单&nbsp;&nbsp;&nbsp;&nbsp;价:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td>
                                            <span class="form-control-static" id="unit">${repertory.unit}</span>
                                        </td>
                                        <td class="title" style="vertical-align:middle;padding-left: 15px;text-align: right;">
                                            <span class="control-label title">总&nbsp;&nbsp;&nbsp;&nbsp;价:&nbsp;&nbsp;&nbsp;</span>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <span class="form-control-static" id="amount">${repertory.amount}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="title">
                                            <span class="control-label title">礼品说明:</span>
                                        </td>
                                        <td colspan="3">
                                            <textarea style="max-height: 200px;min-height: 100px;width: 500px;" class="control-label" id="description" name="repertory.description" readonly="readonly">${repertory.residue}</textarea>
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
