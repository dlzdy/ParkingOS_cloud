<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ڳ�����</title>
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
var paytype=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Զ�����"},{"value_no":1,"value_name":"�ֶ�����"}];
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
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
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",hide:true},
		{fieldcnname:"��������",fieldname:"groupid",fieldvalue:'',inputtype:"cselect",noList:groups,target:"comid",action:"getparks",twidth:"170" ,height:"",issort:false,shide:ishiddlegroup,fhide:ishiddlegroup},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,target:"in_passid,berthsec_id",action:"getcompass,getberthseg",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'berthsec_id');
			}},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:true},
		{fieldcnname:"�����շ�Ա",fieldname:"uid",fieldvalue:'',inputtype:"text",twidth:"80" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'uid');
			}},
		{fieldcnname:"Ԥ�����",fieldname:"prepaid",fieldvalue:'',inputtype:"number",twidth:"100", height:"",issort:false,issort:true,
			process:function(value,cid,id){
				if(value <= 0){
					return "";
				}else{
					return value;
				}
			}},
		{fieldcnname:"��������",fieldname:"parking_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":"-1","value_name":"ȫ��"},{"value_no":"","value_name":"ͨ��ɨ��"},{"value_no":"0","value_name":"NFCˢ��"},{"value_no":"1","value_name":"Ibeacon"},{"value_no":"2","value_name":"�ֻ�ɨ��"},{"value_no":"3","value_name":"ͨ��ɨ��"},{"value_no":"4","value_name":"ֱ��"},{"value_no":"5","value_name":"�¿�"},{"value_no":"6","value_name":"��λ��ά��"},{"value_no":"7","value_name":"�¿��ڶ�����"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",hide:true,shide:true},
		{fieldcnname:"ʱ��",fieldname:"duration",fieldvalue:'',inputtype:"text", twidth:"140" ,height:"",issort:true,shide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ֧��"},{"value_no":1,"value_name":"��֧��"},{"value_no":2,"value_name":"�ӵ�"}] ,twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"�鿴����ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,shide:true,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
			}},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"160" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'in_passid');
			}},
        {fieldcnname:"�����������",fieldname:"order_id_local",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hidden:true}

];

var _orderT = new TQTable({
	tabletitle:"�ڳ�����",
	//ischeck:false,
	tablename:"order_tables",
	dataUrl:"cityunorder.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&btime="+btime+"&etime="+etime,
	tableObj:T("#orderobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isidentifier:false,
	isoperate:getAuthIsoperateButtons()
});

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
	/*if(subauth[1])
		authButs.push({dname:"0Ԫ����",icon:"toxls.gif",onpress:function(Obj){
		var sids = _orderT.GS();
		//var a = _orderT.GSByField("c_type");
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ�񶩵�",2,"");
			return;
		}
		Tconfirm({Title:"ȷ��0Ԫ���㶩����?",Content:"ȷ��0Ԫ������ѡ������?",OKFn:function(){
			T.A.sendData("cityunorder.do?action=completezeroorder","post","ids="+sids,
		function complete(ret){
			T.loadTip(1,"����ɹ�"+ret+"��",2,"");
			location.reload();
		}
		)}})
	}})*/
	return authButs;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}
function coutomsearch(){
	var html = "&nbsp;&nbsp;&nbsp;&nbsp;����ʱ�䣺&nbsp;&nbsp;<input id='coutom_btime' class='Wdate' align='absmiddle' readonly value='"+btime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"/>"
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
	var groupid = '';
	if(!ishiddlegroup)
		groupid = T("#groups").value;
	_orderT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&groupid_start="+groupid
	});
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	addgroups();
	if(!ishiddlegroup)
		T("#groups").value = groupid;
}
function viewdetail(value,id){
	var car_number =_orderT.GD(id,"car_number");
	var comid = _orderT.GD(id,"comid");
    var orderIdLocal =_orderT.GD(id,"order_id_local");
	var tip = "����ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip+"  --> ���ƣ�"+car_number,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		//Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
        Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpicsnew&comid="+comid+"&orderid="+orderIdLocal+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
    })
}

function setcname(value,pid,colname){
	var url = "";
	if(colname == "uid"){
		url = "cityorder.do?action=getcollname&id="+value;
	}else if(colname == "freereasons"){
		url = "cityorder.do?action=getfreereason&id="+value;
	}else if(colname == "in_passid" || colname == "out_passid"){
		url = "cityorder.do?action=getpassname&id="+value;
	}else if(colname == "berthsec_id"){
		url = "cityberthseg.do?action=getberthseg&id="+value;
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

_orderT.C();
</script>

</body>
</html>
