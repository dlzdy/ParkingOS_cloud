<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��λ��ת��</title>
<link href="css/zTreeStyle1.css" rel="stylesheet" type="text/css">
<link href="css/demo.css" rel="stylesheet" type="text/css">
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
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
 <script src="js/echarts/echarts.js"></script>


</head>
<body>

<div id="employeecountobj" style="width:100%;height:100%;margin:0px;"></div>

<script type="text/javascript" >
var btime="${btime}";
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"�շ�Ա���",fieldname:"comid",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"company_name",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"������",fieldname:"count",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"������Ӧ��",fieldname:"total",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"����Ӧ��",fieldname:"count",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"����Ӧ��ռ��(%)",fieldname:"total",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"ʵ��",fieldname:"count",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"ʵ��ռ��(%)",fieldname:"total",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"δ��",fieldname:"count",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"δ��ռ��(%)",fieldname:"total",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"׷��",fieldname:"count",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"׷��ռ��(%)",fieldname:"total",inputtype:"number", twidth:"100",issort:false}
		];
var _employeecountT = new TQTable({     
	tabletitle:"δ���������",
	ischeck:false,
	tablename:"employeecount_tables",
	dataUrl:"employeecount.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#employeecountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "&nbsp;&nbsp; ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}

function searchdata(){
    
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;

	//data=eval(T.A.sendData("parkingturnover.do?action=echarts&btime="+btime+"&etime="+etime));
	_escapecountT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime,
	});
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;

   
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_employeecountT.C();

</script>
</body>
</html>
