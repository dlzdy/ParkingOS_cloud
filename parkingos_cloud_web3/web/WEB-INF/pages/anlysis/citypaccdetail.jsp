<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���������շѼ�¼</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>

</head>
<body>
<div id="detailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}";
var etime="${etime}";
var parkid="${parkid}";
var tip = "���������շѼ�¼";
var _mediaField = [
		{fieldcnname:"ͣ������",fieldname:"create_time",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��������",fieldname:"end_time",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"ͣ��ʱ��",fieldname:"duration",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"������",fieldname:"total",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",inputtype:"text", twidth:"100",issort:false}
	];
var _detailT = new TQTable({
	tabletitle:tip,
	ischeck:false,
	tablename:"detail_tables",
	dataUrl:"cityparkaccanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=mpaydetail&parkid="+parkid+"&btime="+btime+"&etime="+etime,
	tableObj:T("#detailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:false
});

function coutomsearch(){
	var html = "ʱ�䣺"+btime+" �� "+etime;
	return html;
}

_detailT.C();
</script>

</body>
</html>
