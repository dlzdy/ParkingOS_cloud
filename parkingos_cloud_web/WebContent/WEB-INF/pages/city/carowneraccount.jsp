<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�û��˻�</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>

</head>
<body>
<div id="accountobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var paytype = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"���"},{"value_no":1,"value_name":"֧����"},{"value_no":2,"value_name":"΢��"},{"value_no":3,"value_name":"����"},
{"value_no":4,"value_name":"���+֧����"},{"value_no":5,"value_name":"֧����"},{"value_no":6,"value_name":"���+����"},{"value_no":7,"value_name":"ͣ��ȯ"},{"value_no":8,"value_name":"�����"},
{"value_no":9,"value_name":"΢�Ź��ں�"},{"value_no":10,"value_name":"΢�Ź��ں�+���"},{"value_no":11,"value_name":"΢�Ŵ���ȯ"},{"value_no":12,"value_name":"Ԥ֧������"}];
var target = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ʱͣ����"},{"value_no":1,"value_name":"�Ǽ�ʱͣ����"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"80" ,issort:false,shide:true},
		{fieldcnname:"��������",fieldname:"create_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"�����˺�",fieldname:"uin",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"���",fieldname:"amount",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"����",fieldname:"type",inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ֵ"},{"value_no":1,"value_name":"����"}], twidth:"100",issort:false},
		{fieldcnname:"�շ�Ա�˺�",fieldname:"uid",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",inputtype:"select",noList:paytype, twidth:"100",issort:false},
		{fieldcnname:"��Դ/ȥ��",fieldname:"target",inputtype:"select",noList:target, twidth:"200",issort:false},
		{fieldcnname:"������",fieldname:"orderid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
					if(value == "-1"){
						return "";
					}else{
						return value;
					}
				}},
		{fieldcnname:"˵��",fieldname:"remark",inputtype:"text", twidth:"500",issort:false}
	];
var _accountT = new TQTable({
	tabletitle:"�û��˻���¼",
	ischeck:false,
	tablename:"account_tables",
	dataUrl:"cityuseraccount.do",
	iscookcol:false,
	buttons:getAuthButtons(),
	//quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#accountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_accountT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"account_search_w",Title:"�����˻���ϸ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "account_search_f",
					formObj:tObj,
					formWinId:"account_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("account_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_accountT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						});
					}
				});	
			}
		});
	
	}});
	
	if(bts.length>0)
		return bts;
	return false;
}

_accountT.C();
</script>

</body>
</html>
