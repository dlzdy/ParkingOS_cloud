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
<script src="js/tq.datatable.js?2ee22s2" type="text/javascript">//���</script>
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
var freereasons = eval(T.A.sendData("getdata.do?action=getfreereasons&id=${comid}"));
function getpass (){
	var pass = eval(T.A.sendData("getdata.do?action=getcompass&id=${comid}"));
	return pass;
}
var paytype=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}];
var pass = getpass();
var cartypes = eval(T.A.sendData("getdata.do?action=getcartype&id=${comid}"));
//,noList:[{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"ͨ��ɨ��"},{"value_no":"1","value_name":"Ibeacon"},{"value_no":"2","value_name":"�ֻ�ɨ��"},{"value_no":"3","value_name":"ͨ��ɨ��"},{"value_no":"4","value_name":"ֱ��"},{"value_no":"5","value_name":"ȫ���¿�"},{"value_no":"6","value_name":"��λ��ά��"},{"value_no":"7","value_name":"�¿��ڶ�����"},{"value_no":"8","value_name":"�ֶ��¿�"}] 
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",hide:true},
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:true},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:true},
		{fieldcnname:"����",fieldname:"car_type",fieldvalue:'',inputtype:"select",noList:cartypes, twidth:"100" ,height:"",issort:true},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:true},
		{fieldcnname:"ʱ��",fieldname:"duration",fieldvalue:'',inputtype:"text", twidth:"140" ,height:"",issort:true},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����Ԥ֧���ֽ�"},{"value_no":5,"value_name":"����Ԥ֧��������"},{"value_no":6,"value_name":"����Ԥ֧���̼ҿ�"},{"value_no":8,"value_name":"���"},{"value_no":9,"value_name":"ˢ��"}] ,twidth:"80" ,height:"",issort:true},
		{fieldcnname:"�Ż�ԭ��",fieldname:"freereasons",fieldvalue:'',inputtype:"select",noList:freereasons ,twidth:"80" ,height:""},
		{fieldcnname:"Ӧ�ս��",fieldname:"amount_receivable",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"ʵ�ս��",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"����Ԥ�����",fieldname:"electronic_prepay",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"�ֽ�Ԥ�����",fieldname:"cash_prepay",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"���ӽ�����",fieldname:"electronic_pay",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"�ֽ������",fieldname:"cash_pay",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"������",fieldname:"reduce_amount",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"�볡�շ�Ա",fieldname:"uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false,issort:true},
		{fieldcnname:"�տ���",fieldname:"out_uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false,issort:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},
            {"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�ѽ���"},{"value_no":2,"value_name":"�ӵ�"}] ,twidth:"100" ,height:"",issort:true},
		//{fieldcnname:"���㷽ʽ",fieldname:"isclick",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}] ,twidth:"100" ,height:"",issort:true},
		{fieldcnname:"�鿴����ͼƬ",fieldname:"url",inputtype:"text", twidth:"100",issort:false
			,process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
			}},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:true},
		{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:true},
		//��Ӹ�ͤ/����վ��Ϣ
		//{fieldcnname:"��ͤ/����վ",fieldname:"work_station_uuid",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"��"}],twidth:"140" ,height:"",issort:true},
		/*��ӳ����շ�ϵͳ�Ķ������*/
		{fieldcnname:"�����������",fieldname:"order_id_local",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hidden:true}
	];
var _searchField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:true},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:true},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":8,"value_name":"���"},{"value_no":9,"value_name":"ˢ��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
		{fieldcnname:"�տ���",fieldname:"uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�ѽ���"},{"value_no":2,"value_name":"�ӵ�"}] ,twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"���㷽ʽ",fieldname:"isclick",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}] ,twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"���ԭ��",fieldname:"freereasons",fieldvalue:'',inputtype:"select",noList:freereasons ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�鿴����ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
			}},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		/*��ӳ����շ�ϵͳ�Ķ������*/
		{fieldcnname:"�����������",fieldname:"order_id_local",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hidden:true}
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
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false}
		//{fieldcnname:"���㷽ʽ",fieldname:"isclick",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}] ,twidth:"100" ,height:"",issort:false}
	];

var _orderT = new TQTable({
	tabletitle:"��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
	//ischeck:false,
	tablename:"order_tables",
	dataUrl:"order.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#orderobj"),
	fit:[true,true,true],
	isidentifier:false,
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
	var html= "";
		//"<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp&nbsp;���㷽ʽ <select id ='isclick' name='isclick' style='width:120px;vertical-align:middle;' onchange=searchdata(this); >"+getSelectValue(paytype)+"</select></div>";
	html +=    "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp&nbsp;�տ��� <select id ='out_uid' name='out_uid' style='width:120px;vertical-align:middle;' onchange=searchdata(this); >"+getSelectValue(collectors)+"</select></div>";
	
	if(groupid != ""){
		html += "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='companys' onchange='searchcom();'></select></div>";
	}
	return html;
}

function searchcom(){
	comid = T("#companys").value;
	T("#choosecom").action="order.do?comid="+comid+"&authid=${authid}&r"+Math.random();
	T("#choosecom").submit(); 
}

var isclickValue="";
var uidValue="";
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
    addcoms();
    setSelectValue();
}
function setSelectValue(){
	var uidSelect = document.getElementById('out_uid');
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
						formitems:[{kindname:"",kinditemts:_searchField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("order_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_orderT.C({
							cpage:1,
							tabletitle:"�߼��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
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

function viewdetail(type,value,id){
	var car_number =_orderT.GD(id,"car_number");
	var orderIdLocal =_orderT.GD(id,"order_id_local");
	var tip = "����ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip+"  --> ���ƣ�"+car_number,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		/*�޸�ͼƬע��ԭ�������߼�*/
		/* Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>" */
		Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpicsnew&orderid="+orderIdLocal+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
	})
}
_orderT.C();

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
