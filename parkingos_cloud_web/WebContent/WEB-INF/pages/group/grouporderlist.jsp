<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
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
<script src="js/jquery.js" type="text/javascript"></script>
</head>
<body>
<div id="orderobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<form action="" method="post" id="choosecom"></form>
<script language="javascript">
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/
var comid = ${comid};
var groupid = "${groupid}";
var collectors = eval(T.A.sendData("order.do?action=getalluser"));
//function addcollectors(){
//	var childs = eval(T.A.sendData("cityorder.do?action=getcollectors"));
//	jQuery("#collectors").empty();
//	for(var i=0;i<childs.length;i++){
//		var child = childs[i];
//		var id = child.value_no;
//		var name = child.value_name;
//		collectors.append("<option value='"+id+"'>"+name+"</option>");
//	}
//}
var freereasons = eval(T.A.sendData("getdata.do?action=getfreereasons&id=${comid}"));
var pass = eval(T.A.sendData("getdata.do?action=getcompassbygroupid&id="+groupid));

var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ֧��"},{"value_no":1,"value_name":"��֧��"},{"value_no":2,"value_name":"�ӵ�"}];
var parks = eval(T.A.sendData("getdata.do?action=getparksbygroup&id="+groupid));
var paytype=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}];
var _mediaField = [
	{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
	{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,twidth:"150",target:"in_passid,out_passid,freereasons",action:"getcompass,getcompass,getfreereasons",twidth:"100" ,height:"",issort:false},
	{fieldcnname:"�տ����˺�",fieldname:"uid",fieldvalue:'',inputtype:"text",twidth:"80" ,height:"",issort:false},
	{fieldcnname:"�տ�������",fieldname:"uidname",fieldvalue:'',inputtype:"select",noList:collectors,twidth:"100" ,height:"",issort:false,shide:true},
	{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"NFCˢ��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"�ֻ�ɨ��"},{"value_no":3,"value_name":"ͨ��ɨ��"},{"value_no":4,"value_name":"ֱ��"},{"value_no":5,"value_name":"ȫ���¿�"},{"value_no":6,"value_name":"��λ��ά��"},{"value_no":7,"value_name":"�¿��ڶ�����"},{"value_no":8,"value_name":"�ֶ��¿�"}] ,twidth:"100" ,height:"",issort:true},
	{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:true},
	{fieldcnname:"��λ��",fieldname:"berthnumber",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"160" ,height:"",issort:false,
		process:function(value,pid){
			return setcname(value,pid,'berthnumber');
		}},
	{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",hide:true},
	{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:true},
	{fieldcnname:"ʱ��",fieldname:"duration",fieldvalue:'',inputtype:"text", twidth:"140" ,height:"",issort:true,shide:true},
	{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����Ԥ֧���ֽ�"},{"value_no":5,"value_name":"����Ԥ֧��������"},{"value_no":6,"value_name":"����Ԥ֧���̼ҿ�"},{"value_no":8,"value_name":"���"},{"value_no":9,"value_name":"ˢ��"}] ,twidth:"80" ,height:"",issort:true},
	{fieldcnname:"���ԭ��",fieldname:"freereasons",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"160" ,height:"",issort:false,
		process:function(value,pid){
			return setcname(value,pid,'freereasons');
		}},
	{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
	{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList: states,twidth:"100" ,height:"",issort:true,shide:true},
	{fieldcnname:"���㷽ʽ",fieldname:"isclick",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}] ,twidth:"100" ,height:"",issort:true},
	{fieldcnname:"�鿴����ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,shide:true,
		process:function(value,cid,id){
			return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
		}},
	{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"select",noList:pass,action:"",twidth:"160" ,height:"",issort:false},
	{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"select",noList:pass,action:"",twidth:"160" ,height:"",issort:false}
];
/*var _excelField = [
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"NFCˢ��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"�ֻ�ɨ��"},{"value_no":3,"value_name":"ͨ��ɨ��"},{"value_no":4,"value_name":"ֱ��"},{"value_no":5,"value_name":"�¿�"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:true},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����Ԥ֧���ֽ�"},{"value_no":5,"value_name":"����Ԥ֧��������"},{"value_no":6,"value_name":"����Ԥ֧���̼ҿ�"},{"value_no":8,"value_name":"���"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
		{fieldcnname:"�տ���",fieldname:"uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ֧��"},{"value_no":1,"value_name":"��֧��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���㷽ʽ",fieldname:"isclick",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ϵͳ����"},{"value_no":1,"value_name":"�ֶ�����"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false}
	];*/
var _excelField = [
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
		{fieldcnname:"���㷽ʽ",fieldname:"isclick",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}] ,twidth:"100" ,height:"",issort:false}
	];

var _orderT = new TQTable({
	tabletitle:"��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
	//ischeck:false,
	tablename:"order_tables",
	dataUrl:"grouporder.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&groupid="+groupid,
	tableObj:T("#orderobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getSelectValue(valuse){
	var m = "";
	for(var a=0;a<valuse.length;a++){
		m +="<option value='"+valuse[a].value_no+"'>"+valuse[a].value_name+"</option>";
	}
	return m;
}

function coutomsearch(){
	var html=  "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp&nbsp;���㷽ʽ <select id ='isclick' name='isclick' style='width:120px;vertical-align:middle;' onchange=searchdata(this); >"+getSelectValue(paytype)+"</select></div>";
	html +=    "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp&nbsp;�տ��� <select id ='uid' name='uid' style='width:120px;vertical-align:middle;' onchange=searchdata(this); >"+getSelectValue(collectors)+"</select></div>";

	if(groupid != ""){
		html += "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='companys' onchange='searchcom();'></select></div>";
	}
	return html;
}

function searchdatabycom(obj){
	var comid = T("#companys").value;
	var value =obj.value;
	var extp ='comid='+comid;
	if(comid==-2){
		extp+='&groupid='+groupid;
	}
	extp+='&fieldsstr=id__c_type__car_number__create_time__end_time__duration__pay_type__total__uid__state__isclick__id__in_passid__out_passid';
	_orderT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&"+extp
	})
	setSelectValue();
	addcoms();
	T("#companys").value = comid;
}
var isclickValue="";
var uidValue="";
var comValue="-2";
function searchdata(obj){
	var oid = obj.id;
	var value =obj.value;
	var extp = oid+"_start="+value;
	if(oid=='isclick'&&value=='0'){//�Զ�������˵�δ����Ķ���
		extp+='&state_start=1';
	}
	if(oid=='isclick'){
		if(uidValue!='')
			extp +="&uid_start="+uidValue;
		isclickValue =value;
	}else if(oid='uid'){
		if(isclickValue!=''){
			extp +="&isclick_start="+isclickValue;
			if(isclickValue=='0'){//�Զ�������˵�δ����Ķ���
				extp+='&state_start=1';
			}
		}
		uidValue=value;
	}
	if(groupid != ""){
		comid = T("#companys").value;
		extp += "&comid="+comid;
	}
	_orderT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&"+extp
	})
	setSelectValue();
	addcoms();
	T("#companys").value = comValue;
}
function searchcom(){
	comid = T("#companys").value;
	var extp = "comid="+comid+"&authid=${authid}&r"+Math.random();
	comId = comid;
	T("#companys").value =comid;
	_orderT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&"+extp
	})
	addcoms();
	T("#companys").value = comid;
}
function setSelectValue(){
	var isclickSelect = T("#isclick");
	var uidSelect = T("#uid");
	for(var i=0;i<isclickSelect.options.length;i++){
		if(isclickSelect.options[i].value==isclickValue)
			isclickSelect.options[i].selected = true;
	}
	for(var i=0;i<uidSelect.options.length;i++){
		if(uidSelect.options[i].value==uidValue)
			uidSelect.options[i].selected = true;
	}
}
function getAuthButtons(){
	var authButs = [];
	if(subauth[0])
		authButs.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_orderT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"order_search_w",Title:"��������",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "order_search_f",
					formObj:tObj,
					formWinId:"order_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("order_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_orderT.C({
							cpage:1,
							tabletitle:"�߼��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
							extparam:"&groupid="+groupid+"&action=query&"+Serializ(formName)
						})
						addcoms();
					}
				});
			}
		})

	}});

	/**authButs.push({dname:"�鿴�Զ�����",icon:"toxls.gif",onpress:function(Obj){
		_orderT.C({
			cpage:1,
			tabletitle:"��������-->�Զ�����",
			extparam:"&comid="+comid+"&action=query&otype=0"
		})
		addcoms();
		}});
	authButs.push({dname:"�鿴�ֶ�����",icon:"toxls.gif",onpress:function(Obj){
		_orderT.C({
			cpage:1,
			tabletitle:"��������-->�ֶ�����",
			extparam:"&comid="+comid+"&action=query&otype=1"
		})
		addcoms();
		}});
	authButs.push({dname:"�鿴ȫ������",icon:"toxls.gif",onpress:function(Obj){
		_orderT.C({
			cpage:1,
			tabletitle:"��������-->ȫ������",
			extparam:"&comid="+comid+"&action=query"
		})
		addcoms();
		}});**/
	if(subauth[1])
		authButs.push({dname:"��������",icon:"toxls.gif",onpress:function(Obj){
		Twin({Id:"order_export_w",Title:"��������<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "order_export_f",
					formObj:tObj,
					formWinId:"order_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_excelField}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="order.do?action=exportExcel&comid="+comid+"&rp="+2147483647+"&fieldsstr="+"id__c_type__car_number__create_time__end_time__duration__pay_type__total__uid__state__isclick__id__in_passid__out_passid&"+Serializ(formName)
						TwinC("order_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});
			}
		})
	}})
	if(subauth[2])
		authButs.push({dname:"0Ԫ����",icon:"toxls.gif",onpress:function(Obj){
		var sids = _orderT.GS();
		//var a = _orderT.GSByField("c_type");
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ�񶩵�",2,"");
			return;
		}
		Tconfirm({Title:"ȷ��0Ԫ���㶩����",Content:"ȷ��0Ԫ������ѡ������",OKFn:function(){
			T.A.sendData("order.do?action=completezeroorder&comid="+comid,"post","ids="+sids,
		function complete(ret){
			T.loadTip(1,"����ɹ�"+ret+"��",2,"");
			location.reload();
		}
		)}})
	}})


	return authButs;
}
function getAuthIsoperateButtons(){
	var bts = [];

	if(bts.length <= 0){return false;}
	return bts;
}

function viewdetail(value,id){
	var car_number =_orderT.GD(id,"car_number");
	var tip = "����ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip+"  --> ���ƣ�"+car_number,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
	})
}
_orderT.C();

function addcoms(){
	if(groupid != ""){
		var childs = eval(T.A.sendData("getdata.do?action=getcoms&groupid=${groupid}"));
		jQuery("#companys").empty();
		jQuery("#companys").append("<option value='-2'>ȫ��</option>");
		for(var i=0;i<childs.length;i++){
			var child = childs[i];
			var id = child.value_no;
			var name = child.value_name;
			jQuery("#companys").append("<option value='"+id+"'>"+name+"</option>");
		}
		T("#companys").value = -2;
	}
}
function setcname(value,pid,colname){
	var url = "";
	if(colname == "uid"){
		url = "cityorder.do?action=getcollname&id="+value;
	}else if(colname == "freereasons"){
		url = "cityorder.do?action=getfreereason&id="+value;
	}else if(colname == "in_passid" || colname == "out_passid"){
		url = "cityorder.do?action=getpassname&id="+value;
	}else if(colname == "berthnumber"){
		url = "grouporder.do?action=getcid&id="+value;
	}
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:url,
			method:"GET",//POST or GET
			param:"",//GETʱΪ��
			async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
			dataType:"0",//0text,1xml,2obj
			success:function(ret,tipObj,thirdParam){
				if(ret){
					updateRow(pid,colname,ret);
				}
				else
					updateRow(pid,colname,value);
			},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
			failure:function(ret,tipObj,thirdParam){
				return false;
			},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
			thirdParam:"",//�ص������еĵ���������
			tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
			waitTip:"���ڻ�ȡ����...",
			noCover:true
		})
	}else{
		return "��"
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}
/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
		_orderT.UCD(rowid,name,value);
}
if(groupid != ""){//���Ź���Ա��¼����ʾ�����б�
	addcoms();
}
</script>

</body>
</html>
