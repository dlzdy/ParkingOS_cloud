<%@ page language="java" contentType="text/html; charset=gb2312"
         pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>��Ա����</title>
    <link href="css/tq.css" rel="stylesheet" type="text/css">
    <link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

    <script src="js/tq.js?081eee7" type="text/javascript">//���</script>
    <script src="js/tq.public.js?0832423" type="text/javascript">//���</script>
    <script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.form.js?0817" type="text/javascript">//��</script>
    <script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
    <script src="js/tq.window.js?0817" type="text/javascript">//����</script>
    <script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
    <script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
    <script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
    <script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
    <script src="js/jquery.js" type="text/javascript"></script>
</head>
<body>
<div id="vipuserobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<form action="" method="post" id="choosecom"></form>
<script language="javascript">
    var role=${role};
    if(parseInt(role)==15||parseInt(role)==3){
        window.onload = jslimit()
    }
    /*Ȩ��*/
    var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
    var subauth=[false,false,false,false,false,false,false];
    //"�鿴,ע��,�༭,�޸ĳ���,ɾ��,����"
    var ownsubauth=authlist.split(",");
    for(var i=0;i<ownsubauth.length;i++){
        subauth[ownsubauth[i]]=true;
    }
    /*Ȩ��*/

    var comid = ${comid};
    var groupid = "${groupid}";
    var pnames= eval(T.A.sendData("getdata.do?action=getpname&id="+comid));
    var carTypes= eval(T.A.sendData("getdata.do?action=getcartype&id="+comid));
    var month_select = [];
    for(var i=1;i<36;i++){
        month_select.push({"value_no":i,"value_name":i});
    }
    var _mediaField = [
        {fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,edit:false,hide:true},
        //{fieldcnname:"�ײ�����",fieldname:"pid",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"��"}], twidth:"100" ,height:"",edit:false},
        {fieldcnname:"�ײ�����",fieldname:"pid",fieldvalue:'',inputtype:"select",noList:pnames, twidth:"140" ,height:"",edit:false},
        //ע�͵��¿���Ա��ţ��ֻ����룬��ַ����չʾ
        //{fieldcnname:"�¿����",fieldname:"card_id",fieldvalue:'',inputtype:"text", twidth:"160" ,height:"",issort:false,edit:false},
        //{fieldcnname:"�ֻ�����",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"130" ,height:"",issort:false},
        {fieldcnname:"��������",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
        //{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
        {fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"130" ,height:"",issort:false},
        {fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false},
        {fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"date",twidth:"140" ,height:"",issort:false,edit:false,
            //��ʱ��չʾ����������ʱ����
            /*process:function(value,trId,colId){
                if(value.length>10)
                    return value.substring(0,10);
            }*/
        },
        {fieldcnname:"����ʱ��",fieldname:"e_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false,
            /*process:function(value,trId,colId){
                if(value.length>10)
                    return value.substring(0,10);
            }*/
        },
        {fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
        {fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
        {fieldcnname:"��ϵ�绰",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��������",fieldname:"car_type_id",fieldvalue:'',inputtype:"select",noList:carTypes, twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��˫������",fieldname:"limit_day_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}], twidth:"150" ,height:"",issort:false},

        //{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
    ];
    var _addField = [
        //{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
        {fieldcnname:"��������(ѡ��)",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
        //{fieldcnname:"��ַ(ѡ��)",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
        /*�޸��¿���Ա���card_id��¼Ϊ���ݿ������id*/
        /*{fieldcnname:"�¿����",fieldname:"card_id",fieldvalue:'',inputtype:"number", twidth:"160" ,height:"",issort:false},*/
        {fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'${firstprovince}',inputtype:"text", twidth:"200" ,height:"",issort:false},
        {fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"cselect",noList:pnames,target:"total,act_total",params:["months","p_name"],action:"getprodsum,getprodsum",twidth:"180" ,height:"",issort:false},
        {fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'${btime}',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"cselect",noList:month_select,target:"total,act_total",params:["months","p_name"],action:"getprodsum,getprodsum", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'${total}',inputtype:"text", twidth:"150" ,height:"",issort:false,edit:true},
        {fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'${act_total}',inputtype:"text", twidth:"100" ,height:""},
        {fieldcnname:"��ϵ�绰",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
        //{fieldcnname:"��������",fieldname:"car_type_id",fieldvalue:'',inputtype:"select",noList:carTypes, twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��˫������",fieldname:"limit_day_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}], twidth:"150" ,height:"",issort:false},
        //{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
        //{fieldcnname:"�����Ѵ���ʱ",fieldname:"flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��ʾ���Ʋ�һ��"},{"value_no":1,"value_name":"�����ֳ���"}], twidth:"180" ,height:"",issort:false}
        {fieldcnname:"��ע",fieldname:"remark",fieldvalue:'��ƽ̨ע��',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false}
    ];
    var _editField = [
        //{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
        {fieldcnname:"��������(ѡ��)",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
        //{fieldcnname:"��ַ(ѡ��)",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
        //{fieldcnname:"�¿���Ա���",fieldname:"card_id",fieldvalue:'',inputtype:"number", twidth:"160" ,height:"",issort:false,edit:false},
        //{fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
        {fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"cselect",noList:pnames,target:"total,act_total",params:["months","p_name"],action:"getprodsum,getprodsum",twidth:"150" ,height:"",issort:false,edit:false},
        {fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"cselect",noList:month_select,target:"total,act_total",params:["months","p_name"],action:"getprodsum,getprodsum", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,edit:true},
        {fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"150" ,height:""},
        //{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
        //{fieldcnname:"�����Ѵ���ʱ",fieldname:"flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��ʾ���Ʋ�һ��"},{"value_no":1,"value_name":"�����ֳ���"}], twidth:"180" ,height:"",issort:false}
        //{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false}
    ];
    var _renewField = [
        //{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
        {fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
        {fieldcnname:"��������",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false,edit:false},
        //{fieldcnname:"��ַ(ѡ��)",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false,edit:false,fhide:true,shide:true},
        {fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"cselect",noList:pnames,target:"total,act_total",params:["months","p_name"],action:"getprodsum,getprodsum",twidth:"180" ,height:"",issort:false},
        {fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false,edit:false},
        {fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"cselect",noList:month_select,target:"total,act_total",params:["months","p_name"],action:"getprodsum,getprodsum", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,edit:true},
        {fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
        //{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false}
    ];
    var rules =[{name:"b_time",type:"",url:"",requir:true,warn:"��ѡ��ʱ��",okmsg:""},
        /*ע�͵�ԭ�����¿���Ա��ż�������*/
        /*{name:"card_id",type:"",url:"",requir:true,warn:"��ѡ��ʱ��",okmsg:""},*/
        {name:"car_number",type:"",url:"",requir:true,warn:"����д���ƺ�",okmsg:""},
        {name:"act_total",type:"",url:"",requir:true,warn:"������ʵ�ս��",okmsg:""}];
    var _vipuserT = new TQTable({
        tabletitle:"VIP��Ա����",
        ischeck:false,
        tablename:"vipuser_tables",
        dataUrl:"vipuser.do",
        iscookcol:false,
        //dbuttons:false,
        quikcsearch:coutomsearch(),
        buttons:getAuthButtons(),
        //searchitem:true,
        param:"action=query&comid="+comid,
        tableObj:T("#vipuserobj"),
        fit:[true,true,true],
        tableitems:_mediaField,
        isoperate:getAuthIsoperateButtons()
    });

    function coutomsearch(){
        var html = "";
        if(groupid != ""){
            html = "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='companys' onchange='searchdata();' ></select></div>";
        }
        return html;
    }

    function searchdata(){
        comid = T("#companys").value;
        T("#choosecom").action="vipuser.do?comid="+comid+"&authid=${authid}&r"+Math.random();
        T("#choosecom").submit();
    }

    //"�鿴,ע��,�༭,�޸ĳ���,ɾ��,����"
    function getAuthButtons(){
        var authButs=[];
        if(subauth[1])
            authButs.push({dname:"ע���Ա ",icon:"edit_add.png",onpress:function(Obj){
                T.each(_vipuserT.tc.tableitems,function(o,j){
                    o.fieldvalue ="";
                });
                //var total = T.A.sendData("getdata.do?action=getprodsum&p_name="+p_name+"&months=1");
                Twin({Id:"vipuser_add",Title:"ע���Ա",Width:550,sysfun:function(tObj){
                    Tform({
                        formname: "vipuser_add_f",
                        formObj:tObj,
                        formWinId:"vipuser_add_w",
                        formFunId:tObj,
                        recordid:"id",
                        Coltype:2,
                        suburl:"vipuser.do?action=create&comid="+comid,
                        method:"POST",
                        formAttr:[{
                            formitems:[{kindname:"",kinditemts:_addField}],
                            rules:rules
                        }],
                        buttons : [//����
                            {name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_add");} }
                        ],
                        Callback:
                            function(f,rcd,ret,o){
                                if(ret=="1"){
                                    T.loadTip(1,"��ӳɹ���",2,"");
                                    TwinC("vipuser_add");
                                    _vipuserT.M();
                                }else if(ret==-1){
                                    T.loadTip(1,"���ʧ�ܣ�",2,"");
                                }else if(ret==-2){
                                    T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
                                }else if(ret==-3){
                                    T.loadTip(1,"���ʧ�ܣ��¿�����ظ���",2,"");
                                }else
                                    T.loadTip(2,ret,7,"");
                            }
                    });
                    //T("#vipuser_add_f_act_total").value=total;
                }
                })}});
        if(subauth[0])
            authButs.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
                T.each(_vipuserT.tc.tableitems,function(o,j){
                    o.fieldvalue ="";
                });
                Twin({Id:"vipuser_search_w",Title:"������Ա",Width:550,sysfun:function(tObj){
                    TSform ({
                        formname: "vipuser_search_f",
                        formObj:tObj,
                        formWinId:"vipuser_search_w",
                        formFunId:tObj,
                        formAttr:[{
                            formitems:[{kindname:"",kinditemts:_mediaField}]
                        }],
                        buttons : [//����
                            {name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_search_w");} }
                        ],
                        SubAction:
                            function(callback,formName){
                                _vipuserT.C({
                                    cpage:1,
                                    tabletitle:"�߼��������",
                                    extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
                                })
                                addcoms();
                            }
                    });
                }
                })

            }});
        if(subauth[5])
            authButs.push({dname:"������Ա",icon:"toxls.gif",onpress:function(Obj){

                Twin({Id:"vipuser_export_w",Title:"������Ա<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
                    TSform ({
                        formname: "vipuser_export_f",
                        formObj:tObj,
                        formWinId:"vipuser_export_w",
                        formFunId:tObj,
                        dbuttonname:["ȷ�ϵ���"],
                        formAttr:[{
                            formitems:[{kindname:"",kinditemts:[{fieldcnname:"���²�Ʒ����",fieldname:"pid",fieldvalue:'',inputtype:"select",noList:pnames}
                                ,{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date"},{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"date"}
                                ,{fieldcnname:"����ʱ��",fieldname:"e_time",fieldvalue:'',inputtype:"date"}
                            ]}],
                        }],
                        //formitems:[{kindname:"",kinditemts:_excelField}],
                        SubAction:
                            function(callback,formName){
                                T("#exportiframe").src="vipuser.do?action=exportExcel&comid="+comid+"&rp="+2147483647+"&fieldsstr="+"id__pid__create_time__b_time__e_time&"+Serializ(formName)
                                TwinC("vipuser_export_w");
                                T.loadTip(1,"���ڵ��������Ժ�...",2,"");
                            }
                    });
                }
                })
            }});
        return authButs;
    }
    //"ע��,�༭,�޸ĳ���,ɾ��,����"
    function getAuthIsoperateButtons(){
        var bts = [];
        if(subauth[2])
        /*bts.push({name:"�༭",fun:function(id){
            var p_name = _vipuserT.GD(id,"p_name");
            var mobile = _vipuserT.GD(id,"mobile");
            var name = _vipuserT.GD(id,"name");
            var address = _vipuserT.GD(id,"address");
            //var car_number = _vipuserT.GD(id,"car_number");
            var b_time = _vipuserT.GD(id,"b_time");
            var months = _vipuserT.GD(id,"months");
            var remark = _vipuserT.GD(id,"remark");
            var p_lot = _vipuserT.GD(id,"p_lot");
            var total = _vipuserT.GD(id,"total");
            var act_total = _vipuserT.GD(id,"act_total");
            Twin({Id:"vipuser_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
                    Tform({
                        formname: "vipuser_edit_f",
                        formObj:tObj,
                        recordid:"vipuser_id",
                        suburl:"vipuser.do?comid="+comid+"&action=edit&id="+id,
                        method:"POST",
                        Coltype:2,
                        formAttr:[{
                            formitems:[{kindname:"",kinditemts:_editField}],
                            rules:rules
                        }],
                        buttons : [//����
                            {name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("vipuser_edit_"+id);} }
                        ],
                        Callback:
                        function(f,rcd,ret,o){
                            if(ret=="1"){
                                T.loadTip(1,"�༭�ɹ���",2,"");
                                TwinC("vipuser_edit_"+id);
                                _vipuserT.M();
                            }else if(ret==-1){
                                T.loadTip(1,"�༭ʧ�ܣ�",2,"");
                            }else if(ret==-2){
                                 T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
                            }else
                                T.loadTip(2,ret,7,"");
                        }
                    });
                    T("#vipuser_edit_f_p_name").value=p_name;
                    T("#vipuser_edit_f_mobile").value=mobile;
                    T("#vipuser_edit_f_name").value=name;
                    T("#vipuser_edit_f_address").value=address;
                    //T("#vipuser_edit_f_car_number").value=car_number;
                    T("#vipuser_edit_f_b_time").value=b_time;
                    T("#vipuser_edit_f_months").value=months;
                    T("#vipuser_edit_f_remark").value=remark;
                    T("#vipuser_edit_f_p_lot").value=p_lot;
                    T("#vipuser_edit_f_total").value=total;
                    T("#vipuser_edit_f_act_total").value=act_total;
                }
            })
        }}); */
        bts.push({name:"�༭",fun:function(id){
           var name = _vipuserT.GD(id,"name");
           var pname = _vipuserT.GD(id, "pid");
           var b_time = _vipuserT.GD(id,"b_time");
           var months = _vipuserT.GD(id,"months");
           var remark = _vipuserT.GD(id,"remark");
           var total = _vipuserT.GD(id,"total");
           var act_total = _vipuserT.GD(id,"act_total");
           T.each(_vipuserT.tc.tableitems,function(o,j){
               o.fieldvalue = _vipuserT.GD(id)[j]
           });
        	Twin({Id:"vipuser_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
                    Tform({
                        formname: "vipuser_edit_f",
                        formObj:tObj,
                        recordid:"vipuser_id",
                        suburl:"vipuser.do?comid="+comid+"&action=edit&id="+id,
                        method:"POST",
                        formAttr:[{
                            //formitems:[{kindname:"",kinditemts:_vipuserT.tc.tableitems}],
                            formitems:[{kindname:"",kinditemts:_editField}],
                            rules:rules
                        }],
                        buttons : [//����
                            {name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("vipuser_edit_"+id);} }
                        ],
                        Callback:
                        function(f,rcd,ret,o){
                            if(ret=="1"){
                                T.loadTip(1,"�༭�ɹ���",2,"");
                                TwinC("vipuser_edit_"+id);
                                _vipuserT.M()
                            }else{
                                T.loadTip(1,ret,2,o)
                            }
                        }
                    });
                    T("#vipuser_edit_f_name").value=name;
                    T("#vipuser_edit_f_b_time").value=b_time;
                    T("#vipuser_edit_f_months").value=months;
                    T("#vipuser_edit_f_remark").value=remark;
                    T("#vipuser_edit_f_total").value=total;
                    T("#vipuser_edit_f_act_total").value=act_total;
                    T("#vipuser_edit_f_p_name").value=pname;
                }
            })
        }});
            if(subauth[3])
                bts.push({name:"�޸ĳ���",fun:function(id){
                    var carnumber =_vipuserT.GD(id,"car_number");
                    //var cars = T.A.sendData("vipuser.do?action=getcar&uin="+uin);
                    Twin({Id:"vipuser_addcar_"+id,Title:"�޸ĳ���",Width:450,sysfunI:id,sysfun:function(id,tObj){
                        Tform({
                            formname: "vipuser_addcar_f",
                            formObj:tObj,
                            recordid:"vipuser_id",
                            suburl:"vipuser.do?action=addcar&id="+id,
                            method:"POST",
                            Coltype:2,
                            formAttr:[{
                                formitems:[{kindname:"",kinditemts:[{fieldcnname:"���ƺ���(�������,��Ӣ�ķ�','����)",fieldname:"carnumber",inputtype:"text",width:"300"}]}]
                            }],
                            buttons : [//����
                                {name: "cancel", dname: "ȡ��", tit:"ȡ����ӳ���",icon:"cancel.gif", onpress:function(){TwinC("vipuser_addcar_"+id);} }
                            ],
                            Callback:function(f,rcd,ret,o){
                                if(parseInt(ret)>0){
                                    T.loadTip(1,"�޸���"+ret+"�����ƣ�",2,"");
                                    TwinC("vipuser_addcar_"+id);
                                    _vipuserT.M();
                                }else {
                                    T.loadTip(2,ret,7,"");
                                }
                            }
                        });
                    }
                    })
                    T("#vipuser_addcar_f_carnumber").value=carnumber;
                }});

        if(subauth[4])
            bts.push({name:"ɾ��",fun:function(id){
                var id_this = id ;
                Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("vipuser.do?action=delete","post","selids="+id_this,
                    function deletebackfun(ret){
                        if(ret=="1"){
                            T.loadTip(1,"ɾ���ɹ���",2,"");
                            _vipuserT.M();
                        }else if(ret=="-1"){
                            T.loadTip(1,"�˳����ѹ����������������²�Ʒ",2,"");
                        }else if(ret=="-2"){
                            T.loadTip(1,"�˳�������ɾ�����¿���ɾ��",2,"");
                        }else if(ret=="-3"){
                            T.loadTip(1,"ɾ������ʧ�ܣ��¿���ɾ��",2,"");
                        }else {
                            T.loadTip(1,ret,2,"");
                        }
                        _vipuserT.M();
                    }
                )}})
            }});
        if(subauth[6])
            bts.push({name:"����",fun:function(id){
                var p_name = _vipuserT.GD(id,"pid");
                //ע�͵���Ա�绰����
                //var mobile = _vipuserT.GD(id,"mobile");
                var b_time = _vipuserT.GD(id,"e_time");
                var remark = "��ƽ̨����";
                //ע�͵���Ա��Ӧ�ĳ�λ��Ϣ
                //var p_lot = _vipuserT.GD(id,"p_lot");
                var carnumber = _vipuserT.GD(id,"car_number");
                var name = _vipuserT.GD(id,"name");
                var address = _vipuserT.GD(id,"address");
                var total = T.A.sendData("getdata.do?action=getprodsum&p_name="+p_name+"&months=1");
                Twin({Id:"vipuser_renew_"+id,Title:"�¿�����",Width:550,sysfunI:id,sysfun:function(id,tObj){
                    Tform({
                        formname: "vipuser_renew_f",
                        formObj:tObj,
                        recordid:"vipuser_id",
                        suburl:"vipuser.do?comid="+comid+"&action=renew&id="+id,
                        method:"POST",
                        Coltype:2,
                        formAttr:[{
                            formitems:[{kindname:"",kinditemts:_renewField}],
                            rules:rules
                        }],
                        buttons : [//����
                            {name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("vipuser_renew_"+id);} }
                        ],
                        Callback:
                            function(f,rcd,ret,o){
                                if(ret=="1"){
                                    T.loadTip(1,"���ѳɹ���",2,"");
                                    TwinC("vipuser_renew_"+id);
                                    _vipuserT.M();
                                }else if(ret==-1){
                                    T.loadTip(1,"����ʧ�ܣ�",2,"");
                                }else if(ret==-2){
                                    T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
                                }else
                                    T.loadTip(2,ret,7,"");
                            }
                    });
                    T("#vipuser_renew_f_p_name").value=p_name;
                    //T("#vipuser_renew_f_mobile").value=mobile;
                    T("#vipuser_renew_f_b_time").value=b_time;
                    T("#vipuser_renew_f_remark").value=remark;
                    //T("#vipuser_renew_f_p_lot").value=p_lot;
                    T("#vipuser_renew_f_total").value=total;
                    T("#vipuser_renew_f_act_total").value=total;
                    T("#vipuser_renew_f_name").value=name;
                    T("#vipuser_renew_f_car_number").value=carnumber;
                    //T("#vipuser_renew_f_address").value=address
                }
                })
            }});
        if(bts.length <= 0){return false;}
        return bts;
    }

    function getPackageName(id){
        if(pnames){
            for(var i=0;i<pnames.length;i++){
                var pid = pnames[i].value_no;
                if(pid==id){
                    return pnames[i].value_name;
                }
            }
        }
    }

    function setname(pid,colname){
        var uin = _vipuserT.GD(pid,"uin");
        T.A.C({
            url:"vipuser.do?action=getcar&uin="+uin,
            method:"GET",//POST or GET
            param:"",//GETʱΪ��
            async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
            dataType:"0",//0text,1xml,2obj
            success:function(ret,tipObj,thirdParam){
                if(ret&&ret!='null'){
                    updateRow(pid,colname,ret);
                }
            },//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
            failure:function(ret,tipObj,thirdParam){
                return false;
            },//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
            thirdParam:"",//�ص������еĵ���������
            tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
            waitTip:"���ڻ�ȡ�������...",
            noCover:true
        })
        return "<font style='color:#666'>��ȡ��...</font>";
    }

    /*���±������*/
    function updateRow(rowid,name,value){
        //alert(value);
        if(value)
            _vipuserT.UCD(rowid,name,value);
    }

    _vipuserT.C();

    function addcoms(){
        if(groupid != ""){
            var childs = eval(T.A.sendData("getdata.do?action=getcoms&groupid=${groupid}"));
            jQuery("#companys").empty();
            for(var i=0;i<childs.length;i++){
                var child = childs[i];
                var id = child.value_no;
                var name = child.value_name;
                jQuery("#companys").append("<option value='"+id+"'>"+name+"</option>");
            }
            T("#companys").value = comid;
        }
    }
    if(groupid != ""){//���Ź���Ա��¼����ʾ�����б�
        addcoms();
    }
</script>

</body>
</html>
