<%@ page language="java" contentType="text/html; charset=gb2312"
         pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>������������</title>
    <link href="css/tq.css" rel="stylesheet" type="text/css">
    <link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

    <script src="js/tq.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.public.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.form.js?033434" type="text/javascript">//��</script>
    <script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
    <script src="js/tq.window.js?0817" type="text/javascript">//����</script>
    <script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
    <script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
    <script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
    <script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
    <script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="unionparksobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
    function getMarketers (){
        var markets = eval(T.A.sendData("getdata.do?action=markets"));
        return markets;
    }
    function getBizcircles(){
        var bizs = eval(T.A.sendData("parking.do?action=getbizs"));
        return bizs;
    }
    var role=${role};
    var marketers=getMarketers();
    var bizcircles = getBizcircles();
    var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
    var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
    var etc_states=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
    var etc_add_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"},{"value_no":4,"value_name":"Pos������"}]
    var union_id = '${unionId}';
    var server_id = '${serverId}';
    var union_key='${unionKey}'
    var isfixed = false;
    if(role==7)
        isfixed=true;
    var _mediaField = [
        {fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false,edit:false},
        {fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"250" ,height:"",issort:false},
        {fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"280" ,height:"",issort:false},
        {fieldcnname:"ͣ�����绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"160" ,height:"",issort:false},
        {fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"160" ,height:"",hide:true},
        {fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"160" ,height:"",hide:true},
        {fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
        {fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false}
    ];

    var _unionparksT = new TQTable({
        tabletitle:"ѡ��ͣ�����ϴ�������",
        //ischeck:false,
        tablename:"unionparks_tables",
        dataUrl:"parking.do",
        iscookcol:false,
        //dbuttons:false,
        buttons:getAuthButtons(),
        //searchitem:true,
        isidentifier:false,
        param:"action=uploadpark",
        tableObj:T("#unionparksobj"),
        fit:[true,true,true],
        tableitems:_mediaField,
        checktype:"radio",
        isoperate:getAuthIsoperateButtons()
    });

    function getAuthButtons(){
        var bus = [];
        if(role!=6&&role!=8)
            bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
                T.each(_unionparksT.tc.tableitems,function(o,j){
                    o.fieldvalue ="";
                    if(o.fieldname=='strid'||o.fieldname=='nickname'||o.fieldname=='cmobile')
                        o.shide=true;
                });
                Twin({Id:"unionparks_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
                    TSform ({
                        formname: "unionparks_search_f",
                        formObj:tObj,
                        formWinId:"unionparks_search_w",
                        formFunId:tObj,
                        formAttr:[{
                            formitems:[{kindname:"",kinditemts:_mediaField}]
                        }],
                        buttons : [//����
                            {name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("unionparks_search_w");} }
                        ],
                        SubAction:
                            function(callback,formName){
                                _unionparksT.C({
                                    cpage:1,
                                    tabletitle:"�߼��������",
                                    extparam:"&action=uploadpark&"+Serializ(formName)
                                })
                            }
                    });
                }
                })

            }});
        bus.push({ dname:  "�ϴ�������ƽ̨", icon: "sendsms.gif", onpress:function(Obj){
            var sids = _unionparksT.GS();
            var ids="";
            if(!sids){
                T.loadTip(1,"����ѡ�񳵳�",2,"");
                return;
            }
            var unionInfo = eval('('+T.A.sendData("parking.do?action=getUnionInfo&park_id="+sids)+')');
            if(unionInfo.union_id==''){
                if(union_id == ''){
                    T.loadTip(1,"����ѡ�������˳���ƽ̨�˻�",2,"");
                    return;
                }
            }else{
                union_id = unionInfo.union_id;
                server_id = unionInfo.server_id;
                union_key = unionInfo.union_key;
            }
            Twin({Id:"send_message_w",Title:"ͬ��������ƽ̨",Width:550,sysfun:function(tObj){
                Tform({
                    formname: "send_message_ff",
                    formObj:tObj,
                    recordid:"id",
                    suburl:"parking.do?action=sendparktounion",
                    method:"POST",
                    Coltype:2,
                    dbuttonname:["ȷ���ϴ�"],
                    formAttr:[{
                        formitems:[{kindname:"",kinditemts:[
                            {fieldcnname:"�������",fieldname:"seleids",fieldvalue:sids,inputtype:"multi"},
                            {fieldcnname:"���� ƽ̨���",fieldname:"union_id",fieldvalue:union_id,inputtype:"text",edit:false},
                            {fieldcnname:"�����̱��",fieldname:"server_id",fieldvalue:server_id,inputtype:"text",edit:false},
                            {fieldcnname:"ǩ��KEY",fieldname:"union_key",fieldvalue:union_key,inputtype:"text",edit:false}
                        ]}]
                    }],
                    buttons : [//����
                        {name: "cancel", dname: "ȡ��", tit:"ȡ��ͬ��������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
                    ],
                    Callback:function(f,rcd,ret,o){
                        if(ret!==''){
                            T.loadTip(1,ret,2,"");
                            TwinC("send_message_w");
                            _unionparksT.M();
                        }else{
                            T.loadTip(1,"ͬ��������ʧ��",2,o);
                        }
                    }
                });
            }
            })

        }})
        bus.push({dname:"���ز���ͣ��������ee",icon:"edit_add.png",onpress:function(Obj){
            location = "parking.do?action=unionparks";
        }});
        return bus;
    }
    function getAuthIsoperateButtons(){
        var bts = [];

        if(bts.length <= 0){return false;}
        return bts;
    }
    _unionparksT.C();
</script>

</body>
</html>
