<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������</title>
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
<style type="text/css">
.sel_fee{
	text-align: center;
    /* padding-top: 0px; */
    /* padding-bottom: 0px; */
    border-radius: 0px;
    background-color: #FFFFFF;
    outline: medium;
    border: 1px solid #5CCDBE;
    color: #5CCDBE;
    padding-left: 8px;
    padding-right: 8px;
    font-size: 12px;
    height: 24px;
    margin-top: 3px;
    line-height: 24px;
}
a:hover{
	background:#5CCDBE;
	color:#FFFFFF;
}
</style>
</head>
<body onload='addgroups()'>
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
var subauth=[false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�ѳ���"}];
var cityid = '${cityid}';
var btime="${btime}";
var etime="${etime}";
var groups = [];
var ishiddlegroup = true;
if(cityid!=''){
	groups = eval(T.A.sendData("getdata.do?action=getgroups&cityid=${cityid}"));
	ishiddlegroup = false;
}
var _mediaField = [
		{fieldcnname:"�������",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",twidth:"150",noList:parks,target:"berthsec_id",action:"getberthseg",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'berthsec_id');
			}},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:true},
		{fieldcnname:"���������",fieldname:"berth_id",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"�����շ�Ա�˺�",fieldname:"in_uid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				if(value == "-1"){
					return "";
				}else{
					return value;
				}
			}},
		{fieldcnname:"�����շ�Ա����",fieldname:"in_collector",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"�����շ�Ա�˺�",fieldname:"out_uid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				if(value == "-1"){
					return "";
				}else{
					return value;
				}
			}},
		{fieldcnname:"�����շ�Ա����",fieldname:"out_collector",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"����������ʱ��",fieldname:"in_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",shide:true},
		{fieldcnname:"����������ʱ��",fieldname:"out_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:true},
		{fieldcnname:"����������ʱ��",fieldname:"dura",fieldvalue:'',inputtype:"text", twidth:"140" ,height:"",issort:true,shide:true},
		{fieldcnname:"������Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"POS��ʵ�ս��",fieldname:"order_total",fieldvalue:'',inputtype:"number", height:"",issort:false,issort:true},
		{fieldcnname:"����������״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList: states,twidth:"100" ,height:"",issort:true},
		{fieldcnname:"Pos���������",fieldname:"orderid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				if(value == "-1"){
					return "";
				}else{
					return value;
				}
			}},
		{fieldcnname:"Pos����������ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false,shide:true},
		{fieldcnname:"Pos����������ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false,shide:true},
		{fieldcnname:"Pos���������ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false}
	];
var _orderT = new TQTable({
	tabletitle:"����������",
	ischeck:false,
	tablename:"order_tables",
	dataUrl:"citysensororder.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&btime="+btime+"&etime="+etime,
	tableObj:T("#orderobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "&nbsp;&nbsp;&nbsp;&nbsp;����������ʱ�䣺&nbsp;&nbsp;<input id='coutom_btime' class='Wdate' align='absmiddle' readonly value='"+btime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"/>"
	+" - <input id='coutom_etime' class='Wdate' align='absmiddle' readonly value='"+etime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false});\"/>";
	if(!ishiddlegroup)
		html+="&nbsp;&nbsp;&nbsp;&nbsp;�������ţ�&nbsp;&nbsp;<select style='width:130px' id='groups'></select>";
	html += "&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}
function addgroups(){
	if(ishiddlegroup)
		return ;
	var childs = groups;
	var groupselect = document.getElementById("groups");
	for(var i=0;i<childs.length;i++){
		var child = childs[i];
		var id = child.value_no;
		var name = child.value_name;
		groupselect.options.add(new Option(name, id));
	}
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	var groupid ="";
	if(!ishiddlegroup)
		groupid =T("#groups").value;
	_orderT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&groupid="+groupid+"&btime="+btime+"&etime="+etime,
	});
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	addgroups();
	if(!ishiddlegroup)
		T("#groups").value = groupid;
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
						btime =  T("#coutom_btime").value;
						etime =  T("#coutom_etime").value;
						_orderT.C({
							cpage:1,
							tabletitle:"�߼��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
							extparam:"action=query&btime="+btime+"&etime="+etime+"&"+Serializ(formName)
						});
						T("#coutom_btime").value=btime;
						T("#coutom_etime").value=etime;
						addgroups();
					}
				});	
			}
		})
	
	}});
	return authButs;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		var url = "";
		if(colname == "berthsec_id"){
			url = "cityberthseg.do?action=getberthseg&id="+value;
		}else if(colname == "dici_id"){
			url = "cityberth.do?action=getdici&id="+value;
		}
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

_orderT.C();
</script>

</body>
</html>
