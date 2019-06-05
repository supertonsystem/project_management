<div>
    <div class="btn-group hidden-xs" id="consume_detail_toolbar">
    <@shiro.hasPermission name="giftmgt:consume:add">
        <button id="btn_add_consume_detail" type="button" class="btn btn-default btn-xs" title="新增">
            <i class="fa fa-plus"></i> 新增
        </button>
    </@shiro.hasPermission>
    </div>
    <div class="btn-group hidden-xs" id="claim_consume_detail_toolbar">
        <div class="btn-group">
            <button type="button" style="border-radius:0px" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                状态 <span class="caret"></span></button>
            <ul class="dropdown-menu" role="menu">
                <li><a id="btn_present_consume_detail" href="#">已送</a></li>
                <li><a id="btn_back_consume_detail" href="#">退回</a></li>
            </ul>
        </div>

        <button id="btn_sure_consume_detail" type="button" class="btn btn-default btn-xs" style="margin-left: 5px" title="确认领用">
             确认领用
        </button>
    </div>
    <table id="consume_detail_list" style="word-break:break-all; word-wrap:break-all;table-layout:fixed">
    </table>
</div>
<script>
    var addDetailList=[];
    var tempRepertory=[];
    var tempRepertoryRecord=[];
    //礼品ID，礼品库存数，礼品单价
    function addTempRepertory(id,num,price) {
        for (var i = 0; i < tempRepertory.length; i++) {
            var temp=tempRepertory[i];
            if (temp.id==id) {
                tempRepertory.splice(i, 1);
                i--; // 如果不减，将漏掉一个元素
            }
        }
        var r = {'id': id.toString(), 'num': num, 'price': price};
        tempRepertory.push(r)
    }
    
    function getTempRepertory(id) {
        for (var i in tempRepertory){
            var temp=tempRepertory[i];
            if(temp.id==id){
                return temp;
            }
        }
    }

    function getTempRepertoryRecordNumByRepertoryId(repertoryId) {
        var num=0;
        for (var i in tempRepertoryRecord){
            var temp=tempRepertoryRecord[i];
            //其他记录的总数
            if(temp.repertoryId==repertoryId){
                num+=parseInt(temp.num);
            }
        }
        return num;
    }

    function getTempRepertoryRecordNum(id,repertoryId) {
        var num=0;
        for (var i in tempRepertoryRecord){
            var temp=tempRepertoryRecord[i];
            //其他记录的总数
            if(temp.repertoryId==repertoryId&&id!=temp.id){
                num+=parseInt(temp.num);
            }
        }
        return num;
    }

    function addTempRepertoryRecord(id,num,repertoryId) {
        for (var i = 0; i < tempRepertoryRecord.length; i++) {
            var temp=tempRepertoryRecord[i];
            if (temp.id==id) {
                tempRepertoryRecord.splice(i, 1);
                i--; // 如果不减，将漏掉一个元素
            }
        }
        var r={'id':id.toString(),'repertoryId':repertoryId,'num':num};
        tempRepertoryRecord.push(r);
    }
    
    function detailOperateFormatter(code, row, index) {
        var operateBtn=[];
        var id=row.id;
        if(id==null||id==''){
            var amount=row.amount==""?0:row.amount;
            var num=row.num==""?0:row.num;
            operateBtn.push("<@shiro.hasPermission name='giftmgt:consumeDetail:add'><a class='btn btn-xs btn-danger' javascript:;' onclick='btnRemoveRow("+row.rowcount+","+row.rowId+","+amount+","+num+");'>删除</a></@shiro.hasPermission>");
        }else{
            operateBtn.push('<@shiro.hasPermission name="giftmgt:consumeDetail:delete"><a id="btn-remove" class="btn btn-xs btn-danger btn-remove" data-id="' + id + '" data-amount="' + row.amount + '" data-num="' + row.num + '">删除</a></@shiro.hasPermission>');
        }
        return operateBtn.join('');
    }
    //添加or编辑
    var options = {
        url: "/giftmgt/consumeDetail/listAll",
        getInfoUrl: "/giftmgt/consumeDetail/get/{id}",
        updateUrl: "/giftmgt/consumeDetail/edit",
        removeUrl: "/giftmgt/consumeDetail/remove",
        createUrl: "/giftmgt/consumeDetail/add",
        listUrl: "/giftmgt/consumeDetail/listAll",
        columns: [
            {
                field: 'id',
                title: '唯一标识',
                editable: false,
                visible: false,
                width: 40
            },{
                field: 'rowId',
                title: '序号',
                width: 40,
                formatter:function(value,row,index){
                    row.rowId=index;
                    return index+1;
                }
            },{
                field: 'register',
                title: '登记人',
                visible: false
            }, {
                field: 'projectId',
                title: '项目名称',
                editable: {
                    type: 'select',
                    title: '项目名称',
                    emptytext: "空文本",
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/custmgt/project/listAll?register='+${user.id},
                            async: false,
                            type: "get",
                            data: {},
                            success: function (json, status) {
                                if(status=='success'&&json!=null){
                                    for(var i = 0; i < json.data.length; i++) {
                                        var p=json.data[i];
                                        result.push({ value: p.id, text: p.name });
                                    }
                                }
                            }
                        });
                        return result;
                    }
                },
                width: 100
            }, {
                field: 'personId',
                title: '客户名称',
                editable: {
                    type: 'select',
                    title: '客户名称',
                    emptytext: "空文本",
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/custmgt/person/listAll?register='+${user.id},
                            async: false,
                            type: "get",
                            data: {},
                            success: function (json, status) {
                                if(status=='success'&&json!=null){
                                    for(var i = 0; i < json.data.length; i++) {
                                        var p=json.data[i];
                                        result.push({ value: p.id, text: p.name });
                                    }
                                }
                            }
                        });
                        return result;
                    }
                },
                width: 80
            }, {
                field: 'repertoryId',
                title: '礼品名称',
                width: 80,
                editable: {
                    type: 'select',
                    title: '礼品名称',
                    emptytext: "空文本",
                    url: function (params) {
                        var d = new $.Deferred();
                        if(params.value==null||params.value==''){
                            return d.reject('请选择礼品');
                        }
                        var fail=false;
                        $.ajax({
                            url: '/giftmgt/repertory/get/'+params.value,
                            async: false,
                            type: "post",
                            data: {},
                            success: function (json, status) {
                                if(status=='success'&&json!=null){
                                    if(json.data.repertory==""||json.data.repertory<=0){
                                        fail=true;
                                    }else {
                                        addTempRepertory(json.data.id,json.data.repertory,json.data.unit);
                                    }
                                }
                            }
                        });
                        if(fail) {
                            return d.reject('库存为0，请重新选择礼品'); //returning error via deferred object
                        }

                    },
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/giftmgt/repertory/listAll',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (json, status) {
                                if(status=='success'&&json!=null){
                                    for(var i = 0; i < json.data.length; i++) {
                                        var p=json.data[i];
                                        result.push({ value: p.id, text: p.name });
                                    }
                                }
                            }
                        });
                        return result;
                    }
                }
            }, {
                field: 'num',
                title: '份数',
                width: 50,
                editable: {
                    type: 'text',
                    title: '份数',
                    emptytext: "空文本",
                    url: function (params) {
                        var d = new $.Deferred();
                        //拿到礼品Id
                        var repertoryId= $("#consume_detail_list tr[data-index='"+params.pk+"'] td:nth-child(4) a:eq(0)")[0].dataset.value;
                        if(repertoryId==null||repertoryId==''){
                            return d.reject('请选择礼品');
                        }
                        var repertoryBean;
                        var fail=false;
                        var temp=getTempRepertory(repertoryId);
                        if(temp==null){
                            $.ajax({
                                url: '/giftmgt/repertory/get/'+repertoryId,
                                async: false,
                                type: "post",
                                data: {},
                                success: function (json, status) {
                                    if(status=='success'&&json!=null){
                                        repertoryBean=json.data;
                                        if(json.data.repertory==""||json.data.repertory<=0){
                                            fail=true;
                                        }
                                    }
                                }
                            });
                            //当前记录库存数总和
                            var totalNum=getTempRepertoryRecordNumByRepertoryId(repertoryId);
                            //当前无记录，直接返回
                            if(totalNum==0&&fail) {
                                return d.reject('库存为0，请重新选择礼品'); //returning error via deferred object
                            }
                            var available=parseInt(repertoryBean.repertory)+parseInt(totalNum);
                            //添加到当前数组对象
                            addTempRepertory(repertoryBean.id,available,repertoryBean.unit);
                            //同礼品其他份数
                            var otherNum=getTempRepertoryRecordNum(params.pk.toString(),repertoryId);
                            var residue=available-otherNum;
                            if(params.value>residue){
                                return d.reject('超过最大库存数:'+residue);
                            }
                        }else {
                            var otherNum=getTempRepertoryRecordNum(params.pk.toString(),repertoryId);
                            var residue=temp.num-otherNum;
                            if(params.value>residue){
                                return d.reject('超过最大库存数:'+residue);
                            }
                        }
                    },
                    validate: function (v) {
                        if (isNaN(v)) return '必须是数字';
                        var n = parseInt(v);
                        if (n <= 0) return '必须是正整数';
                        if (n >= 10000) return '超过最大限制10000';
                    }
                },
                formatter: function (value,row,index) {
                    if(value!=null&&value!=''){
                        addTempRepertoryRecord(row.rowId.toString(),value,row.repertoryId);
                    }
                    return value;
                }
            }, {
                field: 'amount',
                title: '金额',
                width: 50
            }, {
                field: 'sendTime',
                title: '送礼时间',
                editable: {
                    type: 'date',
                    emptytext: "空文本",
                    title: '送礼时间'
                },
                width: 80
            }, {
                field: 'sendSite',
                title: '送礼地点',
                width: 100,
                editable: {
                    type: 'text',
                    title: '送礼地点',
                    emptytext: "空文本"
                }
            }, {
                field: 'description',
                title: '明细说明',
                width: 100,
                editable: {
                    type: 'text',
                    title: '明细说明',
                    emptytext: "空文本"
                }
            }, {
                field: 'operate',
                title: '操作',
                width: 100,
                formatter: detailOperateFormatter //自定义方法，添加操作按钮
            }
        ],
        modalName: "送礼记录"
    };

    var newcount = 0;
    $("#btn_add_consume_detail").click(function () {
        newcount = newcount + 1;
        var count = $('#consume_detail_list').bootstrapTable('getData').length;
        var row = {index:count,row:{
            "id":"",
            "rowId" :"",
            "rowcount":newcount,
            "personId" : "",
            "projectId" : "",
            "repertoryId" : "",
            "description" : "",
            "num" : "",
            "amount" : "",
            "sendTime" : "",
            "sendSite" : "",
            "status" : "0",
            "rowindex":count,
            "operate":""
        }};
        $("#consume_detail_list").bootstrapTable('insertRow', row);
    });

    function initDetailListTable(consumeId,operation) {
        if(operation=='claim'){
            claimTable(consumeId);
        }else{
            addOrUpdateTable(consumeId);
        }
    }

    function addOrUpdateTable(consumeId) {
        $('#addOrUpdateForm #title').removeAttr('readonly');
        $('#addOrUpdateForm #description').removeAttr('readonly');
        $('#addOrUpdateModal #addOrUpdateBtn').show();
        $('#addOrUpdateModal #submitBtn').show();
        $('#consume_detail_toolbar').show();
        $('#claim_consume_detail_toolbar').hide();
        addDetailList=[];
        tempRepertory=[];
        tempRepertoryRecord=[];
        options.url=options.listUrl+"?consumeId="+consumeId;
        $('#consume_detail_list').bootstrapTable('destroy');
        //1.初始化Tablei
        $('#consume_detail_list').bootstrapTable({
            url: options.url,
            method: 'post',                      //请求方式（*）
            toolbar: '#consume_detail_toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sortStable: true,                   // 设置为 true 将获得稳定的排序
            queryParamsType: '',
            pagination: false,                   //是否显示分页（*）
            sidePagination: 'client',           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 1000,                       //每页的记录行数（*）
            pageList: [1000, 2002],        //可供选择的每页的行数（*）
            search: false,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
            strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
            searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
            minimumCountColumns: 1,             //最少允许的列数
            showRefresh: false,
            onEditableSave: function (field, row, oldValue, $el) {
                if(row.id==null||row.id==''){
                    $("#consume_detail_list").bootstrapTable('updateCell', {
                        index: row.rowId,       //行索引
                        field: field,       //列名
                        value: row[field]        //cell值
                    });
                    //修改礼品，重置份数和金额
                    if(field=='repertoryId'&&oldValue!=''&&oldValue!=null){
                        var oldNum=row.num;
                        if(oldNum!=''||oldNum!=null){
                            updateNumAndAmount(-oldNum,-row.amount);
                        }
                        $("#consume_detail_list").bootstrapTable('updateCell', {
                            index: row.rowId,       //行索引
                            field: 'amount',       //列名
                            value: ''        //cell值
                        });
                        $("#consume_detail_list").bootstrapTable('updateCell', {
                            index: row.rowId,       //行索引
                            field: 'num',       //列名
                            value: ''        //cell值
                        });
                    }
                    //更新份数，联动
                    if(field=='num'){
                        //第一次
                        if(oldValue==''||oldValue==null){
                            var temp=getTempRepertory(row.repertoryId.toString());
                            var amount=parseFloat(temp.price)*parseInt(row[field]);
                            updateNumAndAmount(row[field],amount);
                            $("#consume_detail_list").bootstrapTable('updateCell', {
                                index: row.rowId,       //行索引
                                field: 'amount',       //列名
                                value: amount        //cell值
                            });
                        }else{
                            var temp=getTempRepertory(row.repertoryId.toString());
                            //更新
                            var oldNum=oldValue;
                            var newNum=row[field];
                            var addNum;
                            var addAmount;
                            //数量增加
                            if(oldNum<newNum){
                                addNum=newNum-oldNum;
                                addAmount=parseFloat(temp.price)*parseInt(addNum);
                                updateNumAndAmount(addNum,addAmount);
                            }else {
                                //数量减少
                                addNum=oldNum-newNum;
                                addAmount=parseFloat(temp.price)*parseInt(addNum);
                                updateNumAndAmount(-addNum,-addAmount);
                            }
                            var amount=parseFloat(temp.price)*parseInt(row[field]);
                            $("#consume_detail_list").bootstrapTable('updateCell', {
                                index: row.rowId,       //行索引
                                field: 'amount',       //列名
                                value: amount        //cell值
                            });
                        }
                    }
                    //移除老的元素
                    for (var i = 0; i < addDetailList.length; i++) {
                        var addDetail=addDetailList[i];
                        if (addDetail.rowId===row.rowId) {
                            addDetailList.splice(i, 1); // 将使后面的元素依次前移，数组长度减1
                            i--; // 如果不减，将漏掉一个元素
                        }
                    }
                    addDetailList.push(row);
                }else{
                    $.ajax({
                        type: "post",
                        url: "/giftmgt/consumeDetail/edit",
                        data: 'id='+row.id+'&'+field+'='+row[field],
                        success: function (json, status) {
                            if (json.status != 200) {
                                alert(json.message);
                                return;
                            }
                            if(field=='repertoryId'&&oldValue!=''&&oldValue!=null){
                                var oldNum=row.num;
                                if(oldNum!=''||oldNum!=null){
                                    updateNumAndAmount(-oldNum,-row.amount);
                                }
                                $("#consume_detail_list").bootstrapTable('updateCell', {
                                    index: row.rowId,       //行索引
                                    field: 'amount',       //列名
                                    value: ''        //cell值
                                });

                                $("#consume_detail_list").bootstrapTable('updateCell', {
                                    index: row.rowId,       //行索引
                                    field: 'num',       //列名
                                    value: ''        //cell值
                                });
                            }
                            //更新份数，联动
                            if(field=='num'){
                                //第一次
                                if(oldValue==''||oldValue==null){
                                    var temp=getTempRepertory(row.repertoryId.toString());
                                    var amount=parseFloat(temp.price)*parseInt(row[field]);
                                    updateNumAndAmount(row[field],amount);
                                    $("#consume_detail_list").bootstrapTable('updateCell', {
                                        index: row.rowId,       //行索引
                                        field: 'amount',       //列名
                                        value: amount        //cell值
                                    });
                                }else{
                                    var temp=getTempRepertory(row.repertoryId.toString());
                                    //更新
                                    var oldNum=oldValue;
                                    var newNum=row[field];
                                    var addNum;
                                    var addAmount;
                                    //数量增加
                                    if(oldNum<newNum){
                                        addNum=newNum-oldNum;
                                        addAmount=parseFloat(temp.price)*parseInt(addNum);
                                        updateNumAndAmount(addNum,addAmount);
                                    }else {
                                        //数量减少
                                        addNum=oldNum-newNum;
                                        addAmount=parseFloat(temp.price)*parseInt(addNum);
                                        updateNumAndAmount(-addNum,-addAmount);
                                    }
                                    var amount=parseFloat(temp.price)*parseInt(row[field]);
                                    $("#consume_detail_list").bootstrapTable('updateCell', {
                                        index: row.rowId,       //行索引
                                        field: 'amount',       //列名
                                        value: amount        //cell值
                                    });
                                }
                            }
                        },
                        error: function () {
                            alert('编辑失败');
                        }
                    });
                }
            },
            columns: options.columns
        });
    }
    
    //新增数量，新增价格
    function updateNumAndAmount(addNum,addAmount) {
        var amount=$("#addOrUpdateForm #amount").val();
        if(amount==""||amount==null){
            amount=0;
        }
        var lastAmount=parseFloat(amount)+parseFloat(addAmount);
        $("#addOrUpdateForm #amount").val(lastAmount);
        //更新份数
        var num=$("#addOrUpdateForm #num").val();
        if(num==""||amount==null){
            num=0;
        }
        var lastNum=parseFloat(num)+parseFloat(addNum);
        $("#addOrUpdateForm #num").val(lastNum);
    }
    /* 删除 */
    $('#consume_detail_list').on('click', '.btn-remove', function () {
        var $this = $(this);
        var id = $this.attr("data-id");
        var amount = $this.attr("data-amount");
        var num = $this.attr("data-num");
        removeConsumeDetail(id,amount,num);
    });

    function removeConsumeDetail(ids,_amount,_num) {
        $.tool.confirm("确定删除吗？", function () {
            $.ajax({
                type: "post",
                url: options.removeUrl,
                traditional: true,
                data: {'ids': ids},
                success: function (json) {
                   // $.tool.ajaxSuccess(json);
                   // $("#consume_detail_list").bootstrapTable('refresh', {url: options.url});
                    var rowcounts = [];//定义一个数组
                    rowcounts.push(parseInt(ids));
                    $("#consume_detail_list").bootstrapTable('remove', {field: 'id', values: rowcounts});
                    if(_amount!=null&&_amount!=''){
                        var amount=$("#amount").val();
                        var r=parseFloat(amount)-parseFloat(_amount);
                        $("#amount").val(r);
                    }
                    if(_num!=null&&_num!=''){
                        var num=$("#num").val();
                        var r=parseInt(num)-parseInt(_num);
                        $("#num").val(r);
                    }
                },
                error: $.tool.ajaxError
            });
        }, function () {

        }, 5000);
    }
    function viewPorject(id) {
        window.open("/custmgt/project/view/"+id);
    }
    function viewPerson(id) {
        window.open("/custmgt/person/view/"+id);
    }
    //删除行
    function btnRemoveRow(index,rowId,_amount,_num) {
        tempRepertoryRecord=[];
        var ids = [];//定义一个数组
        ids.push(index);//将要删除的id存入数组
        $("#consume_detail_list").bootstrapTable('remove', {field: 'rowcount', values: ids});
        if(_amount!=null&&_amount!=''&&_amount!=0){
            var amount=$("#amount").val();
            var r=parseFloat(amount)-parseFloat(_amount);
            $("#amount").val(r);
        }
        if(_num!=null&&_num!=''&&_num!=0){
            var num=$("#num").val();
            var r=parseInt(num)-parseInt(_num);
            $("#num").val(r);
        }
    }

    function queryParams(params) {
        params = $.extend({}, params);
        return params;
    }

    // 认领相关
    var claimoptions = {
        url: "/giftmgt/consumeDetail/listAll",
        updateStatusUrl: "/giftmgt/consumeDetail/updateStatus",
        updateDrawStatusUrl: "/giftmgt/consumeDetail/updateDrawStatus",
        listUrl: "/giftmgt/consumeDetail/listAll",
        columns: [
            {
            checkbox: true,
                width: 25,
            formatter: function (i,row) {
                if(row.status!=0&&row.drawStatus!=0){
                    return {
                        disabled : true
                    }
                }else{
                    return {
                        disabled : false               // 存在则选中
                    }
                }
             }
            }, {
                field: 'id',
                title: '唯一标识',
                editable: false,
                visible: false,
                width: 40
            },{
                field: 'rowId',
                title: '序号',
                width: 40,
                formatter:function(value,row,index){
                    row.rowId=index;
                    return index+1;
                }
            },{
                field: 'register',
                title: '登记人',
                visible: false
            }, {
                field: 'projectName',
                title: '项目名称',
                width: 100
            }, {
                field: 'personName',
                title: '客户名称',
                width: 80
            }, {
                field: 'repertoryName',
                title: '礼品名称',
                width: 80
            }, {
                field: 'num',
                title: '份数',
                width: 50
            }, {
                field: 'amount',
                title: '金额',
                width: 50
            }, {
                field: 'sendTime',
                title: '送礼时间',
                width: 80
            }, {
                field: 'sendSite',
                title: '送礼地点',
                width: 100
            }, {
                field: 'description',
                title: '明细说明',
                width: 100
            }, {
                field: 'status',
                title: '状态',
                width: 50,
                formatter: function (value,row,index) {
                    if(value==0){
                        return '未送';
                    }
                    if(value==1){
                        return '已送';
                    }
                    if(value==2){
                        return '退回';
                    }
                    return '';
                }
        }, {
            field: 'drawStatus',
            title: '领用',
            width: 50,
            formatter: function (value,row,index) {
                if(value==0){
                    return '待领用';
                }
                if(value==1){
                    return '已领用';
                }
                return '';
            }
        }
        ],
        modalName: "送礼记录"
    };

    function claimTable(consumeId) {
        $('#addOrUpdateForm #title').attr('readonly',true);
        $('#addOrUpdateForm #description').attr('readonly',true);
        $('#addOrUpdateModal #addOrUpdateBtn').hide();
        $('#addOrUpdateModal #submitBtn').hide();
        $('#consume_detail_toolbar').hide();
        $('#claim_consume_detail_toolbar').show();

        addDetailList=[];
        tempRepertory=[];
        tempRepertoryRecord=[];
        claimoptions.url=claimoptions.listUrl+"?consumeId="+consumeId;
        claimoptions.updateStatusUrl="/giftmgt/consumeDetail/updateStatus"+"?consumeId="+consumeId;
        claimoptions.updateDrawStatusUrl="/giftmgt/consumeDetail/updateDrawStatus"+"?consumeId="+consumeId;
        $('#consume_detail_list').bootstrapTable('destroy');
        //1.初始化Tablei
        $('#consume_detail_list').bootstrapTable({
            url: claimoptions.url,
            method: 'post',                      //请求方式（*）
            toolbar: '#claim_consume_detail_toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            contentType: "application/x-www-form-urlencoded", // 发送到服务器的数据编码类型, application/x-www-form-urlencoded为了实现post方式提交
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sortStable: true,                   // 设置为 true 将获得稳定的排序
            queryParamsType: '',
            pagination: false,                   //是否显示分页（*）
            sidePagination: 'client',           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 1000,                       //每页的记录行数（*）
            pageList: [1000, 2002],        //可供选择的每页的行数（*）
            search: false,                       //是否启用搜索框 根据sidePagination选择从前后台搜索
            strictSearch: false,                 //设置为 true启用 全匹配搜索，否则为模糊搜索
            searchOnEnterKey: false,            // 设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
            minimumCountColumns: 1,             //最少允许的列数
            showRefresh: false,
            columns: claimoptions.columns
        });
    }
    //送出
    $("#btn_present_consume_detail").click(function () {
        var selecteded = $("#consume_detail_list").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }
        var ids = [];
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            var index=parseInt(s.rowId)+1;
            if(s.status!=0){
                $.tool.alertError("记录【"+index+"】的状态不处于\"未送\"的状态");
                return;
            }
            if(s.drawStatus!=1){
                $.tool.alertError("记录【"+index+"】未\"确认领用\"，无法操作");
                return;
            }
            ids.push(s.id);
        }

        $.ajax({
            type: "post",
            url: claimoptions.updateStatusUrl,
            traditional: true,
            data: {'ids': ids,'status':1},
            success: function (json) {
                $.tool.ajaxSuccess(json);
                $("#consume_detail_list").bootstrapTable('refresh', {url: claimoptions.url});
                $("#tablelist").bootstrapTable('refresh', {url: '/giftmgt/consume/list'});
            },
            error: $.tool.ajaxError
        });
    });
    //退回
    $("#btn_back_consume_detail").click(function () {
        var selecteded = $("#consume_detail_list").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }

        var ids = [];
        var backNum=0;
        var backMoney=0;
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            var index=parseInt(s.rowId)+1;
            if(s.status!=0){
                $.tool.alertError("记录【"+index+"】的状态不处于\"未送\"的状态");
                return;
            }
            if(s.drawStatus!=1){
                $.tool.alertError("记录【"+index+"】未\"确认领用\"，无法操作");
                return;
            }
            backNum+=parseInt(s.num);
            backMoney+=parseFloat(s.amount);
            ids.push(s.id);
        }

        $.ajax({
            type: "post",
            url: claimoptions.updateStatusUrl,
            traditional: true,
            data: {'ids': ids,'status':2},
            success: function (json) {
                $.tool.ajaxSuccess(json);
                var oldBackNum=$("#addOrUpdateModal #backNum").val();
                var oldBackMoney=$("#addOrUpdateModal #backMoney").val();
                if(oldBackNum==null||oldBackNum==""){
                    oldBackNum=0;
                }
                if(oldBackMoney==null||oldBackMoney==""){
                    oldBackMoney=0;
                }
                var bn=parseInt(oldBackNum)+parseInt(backNum);
                $("#addOrUpdateModal #backNum").val(bn);
                var bm=parseFloat(oldBackMoney)+parseFloat(backMoney);
                $("#addOrUpdateModal #backMoney").val(bm);
                $("#consume_detail_list").bootstrapTable('refresh', {url: claimoptions.url});
                $("#tablelist").bootstrapTable('refresh', {url: '/giftmgt/consume/list'});
            },
            error: $.tool.ajaxError
        });
    });
    //确认领用
    $("#btn_sure_consume_detail").click(function () {
        var selecteded = $("#consume_detail_list").bootstrapTable('getAllSelections');
        if (!selecteded || selecteded == '[]' || selecteded.length == 0) {
            $.tool.alertError("请至少选择一条记录");
            return;
        }
        var ids = [];
        for(var i = 0; i < selecteded.length; i++) {
            var s=selecteded[i];
            var index=parseInt(s.rowId)+1;
            if(s.drawStatus==1){
                $.tool.alertError("记录【"+index+"】\"已领用\"");
                return;
            }
            ids.push(s.id);
        }
        $.ajax({
            type: "post",
            url: claimoptions.updateDrawStatusUrl,
            traditional: true,
            data: {'ids': ids},
            success: function (json) {
                $.tool.ajaxSuccess(json);
                $("#consume_detail_list").bootstrapTable('refresh', {url: claimoptions.url});
            },
            error: $.tool.ajaxError
        });
    });
</script>