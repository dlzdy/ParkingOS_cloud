<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������ͳ��</title>
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
<div id="orderanlyobj" style="width:100%;height:100%;margin:0px;"></div>
<form action="" method="post" id="choosecom"></form>
<script >
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var comid = "${comid}";
var groupid = "${groupid}";
var cityid = "${cityid}";
var btime="${btime}"
var etime="${etime}";
var viewtype="custom";
var tip = "�����ѯ";
var _mediaField = [
		//{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"30",issort:false},
    {fieldcnname:"����",fieldname:"groupid",inputtype:"text", twidth:"80",issort:false},
    {fieldcnname:"����",fieldname:"comid",inputtype:"text", twidth:"80",issort:false},
    {fieldcnname:"�շ�Ա",fieldname:"name",inputtype:"text", twidth:"120",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewworkdetail('h','"+value+"','"+cid+"')\" style='color:blue'>"+value+"(��������)"+"</a>";
			}},
		{fieldcnname:"�ʺ�",fieldname:"out_uid",inputtype:"text", twidth:"80",issort:false},
		{fieldcnname:"����",fieldname:"sdate",inputtype:"text", twidth:"200" ,issort:false},
		{fieldcnname:"�ܶ�����",fieldname:"scount",inputtype:"text", twidth:"80",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('h','"+value+"','"+cid+"',0)\" style='color:blue'>"+value+"</a>";
			}},
		//{fieldcnname:"Ӧ�ս��",fieldname:"amount_receivable",inputtype:"text", twidth:"90",issort:false},
		{fieldcnname:"�¿�������",fieldname:"monthcount",inputtype:"text", twidth:"80",issort:false},
		{fieldcnname:"�ֽ����",fieldname:"cash_pay",inputtype:"text", twidth:"80",issort:false},
        {fieldcnname:"�ֽ�Ԥ��",fieldname:"cash_prepay",inputtype:"text", twidth:"80",issort:false},
		{fieldcnname:"����֧��",fieldname:"electronic_pay",inputtype:"text", twidth:"80",issort:false},
		{fieldcnname:"��ѽ��",fieldname:"free_pay",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"����ȯ֧��",fieldname:"reduce_pay",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ϼ�",fieldname:"amount_receivable",inputtype:"text", twidth:"100",issort:false}
	];
var _orderanlyT = new TQTable({
	tabletitle:"����ͳ��&nbsp;&nbsp;<span id='total_money'></span>",
	ischeck:false,
	tablename:"parkorderanlysis_tables",
	dataUrl:"orderanly.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query&comid="+comid,
	tableObj:T("#orderanlyobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html=    "<input type='button' onclick='searchtoday();' value='����'/>&nbsp;&nbsp;<input type='button' onclick='searchtoweek();' value='����'/>&nbsp;&nbsp;<input type='button' onclick='searchlastweek();' value='����'/>&nbsp;&nbsp;<input type='button' onclick='searchtomonth();' value='����'/>&nbsp;&nbsp;ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-01 %H:%m:%s',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-01 %H:%m:%s',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	if(groupid != "" || cityid != ""){
		html += "&nbsp;&nbsp;&nbsp;&nbsp;��ǰ����:&nbsp;&nbsp;<select id='companys' onchange='searchcoms();' ></select>";
	}
    html += "&nbsp;&nbsp;<span id='total_money'></span>";
	return html;
}
function searchcoms(){
	comid = T("#companys").value;
	T("#choosecom").action="orderanly.do?comid="+comid+"&authid=${authid}&r"+Math.random();
	T("#choosecom").submit(); 
}
function searchtoday(){
	viewtype='today';
	tip = "����ͳ��";
	_orderanlyT.C({
		cpage:1,
		tabletitle:"����ͳ��",
		extparam:"&action=query&type=today&comid="+comid
	})
	addcoms();
}
function searchtoweek(){
	viewtype='toweek';
	tip ="����ͳ��";
	_orderanlyT.C({
		cpage:1,
		tabletitle:"����ͳ��",
		extparam:"&action=query&type=toweek&comid="+comid
	})
	addcoms();
}
function searchlastweek(){
	viewtype='lastweek';
	tip ="����ͳ��";
	_orderanlyT.C({
		cpage:1,
		tabletitle:"����ͳ��",
		extparam:"&action=query&type=lastweek&comid="+comid
	})
	addcoms();
}
function searchtomonth(){
	viewtype='tomonth';
	tip = "����ͳ��";
	_orderanlyT.C({
		cpage:1,
		tabletitle:"����ͳ��",
		extparam:"&action=query&type=tomonth&comid="+comid
	})
	addcoms();
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	viewtype="custom";
	tip = "�����ѯ";
	_orderanlyT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&comid="+comid
	})
	addcoms();
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
}

function viewdetail(type,value,id,pay_type){
	//alert(type+","+id);
	var total =_orderanlyT.GD(id,"amount_receivable");
	var count = _orderanlyT.GD(id,"scount");
	var name =_orderanlyT.GD(id,"name");
	var uid = _orderanlyT.GD(id,"out_uid");
	var pmoney=_orderanlyT.GD(id,"cash_pay");
    var ppremoney=_orderanlyT.GD(id,"cash_prepay");
	var pmobile=_orderanlyT.GD(id,"electronic_pay");
	var free=_orderanlyT.GD(id,"free_pay");
	//alert(uid);
	Twin({
		Id:"parkorder_detail_"+id,
		Title:tip+"  --> �շ�Ա��"+name,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='parkorder_detail_'"+id+" id='parkorder_detail_'"+id+" src='orderanly.do?action=detail&otype="+viewtype+"&uid="+uid+"&btime="+btime+"&etime="+etime+"&total="+total+"&count="+count+"&pmobile="+pmobile+"&pmoney="+pmoney+"&ppremoney="+ppremoney+"&comid="+comid+"&free="+free+"&pay_type="+pay_type+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}
function viewworkdetail(type,value,id,pay_type){
	//alert(type+","+id);
	var total =_orderanlyT.GD(id,"amount_receivable");
	var count = _orderanlyT.GD(id,"scount");
	var name =_orderanlyT.GD(id,"name");
	var uid = _orderanlyT.GD(id,"out_uid");
	var pmoney=_orderanlyT.GD(id,"cash_pay");
	var pmobile=_orderanlyT.GD(id,"electronic_pay");
	var free=_orderanlyT.GD(id,"free_pay");
	//alert(uid);
	Twin({
		Id:"parkorder_detail_"+id,
		Title:tip+"  --> �շ�Ա��"+name,
		Width:T.gww()-50,
		Height:T.gwh()-25,
		sysfunI:id,
		Content:"<iframe name='parkorder_detail_'"+id+" id='parkorder_detail_'"+id+" src='orderanly.do?action=work&otype="+viewtype+"&uid="+uid+"&comid="+comid+"&btime="+btime+"&etime="+etime+"&total="+total+"&count="+count+"&pmobile="+pmobile+"&pmoney="+pmoney+"&free="+free+"&pay_type="+pay_type+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_orderanlyT.C();
function addcoms(){
	if(groupid != "" || cityid != ""){
		var childs = eval(T.A.sendData("getdata.do?action=getcoms&groupid=${groupid}&cityid=${cityid}"));
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
if(groupid != "" || cityid != ""){//���Ź���Ա��¼����ʾ�����б�
	addcoms();
}
</script>

</body>
</html>
