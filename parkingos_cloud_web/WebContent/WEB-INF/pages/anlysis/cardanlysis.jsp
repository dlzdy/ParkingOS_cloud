<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ֵ���������</title>
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
<div id="cardanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"��Ӫ���ű��",fieldname:"groupid",inputtype:"text", twidth:"200" ,issort:false,fhide:true},
		{fieldcnname:"��������",fieldname:"e_all_count",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"�ڳ�����",fieldname:"b_all_balance",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"��ĩ����",fieldname:"e_all_balance",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"���ڷ�������",fieldname:"slot_act_count",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"���ڷ�����ֵ",fieldname:"slot_act_balance",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"���ڴ�ֵ",fieldname:"slot_charge",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"��������",fieldname:"slot_consume",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"����ע��������",fieldname:"slot_refund_count",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"����ע�������",fieldname:"slot_refund_balance",inputtype:"text", twidth:"150",issort:false}
	];
var _cardanlysisT = new TQTable({
	tabletitle:"��ֵ���������",
	ischeck:false,
	tablename:"cardanlysis_tables",
	dataUrl:"cardanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query&btime="+btime+"&etime="+etime,
	tableObj:T("#cardanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "&nbsp;&nbsp;&nbsp;&nbsp;ʱ�䣺&nbsp;&nbsp;<input id='coutom_btime' class='Wdate' align='absmiddle' readonly value='"+btime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"/>"
	+" - <input id='coutom_etime' class='Wdate' align='absmiddle' readonly value='"+etime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false});\"/>"+
	"&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	_cardanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}

_cardanlysisT.C();
</script>

</body>
</html>
