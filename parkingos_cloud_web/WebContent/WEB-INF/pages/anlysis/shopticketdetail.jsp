<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�̻��Ż�ȯ</title>
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
<div id="parkaccountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var shop_id="${shop_id}";
var type="${type}";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hide:true},
		{fieldcnname:"��ӡʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"limit_day",fieldvalue:'',inputtype:"date",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�Żݵ�ʱ��(Сʱ)",fieldname:"money",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δʹ��"},{"value_no":1,"value_name":"��ʹ��"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":3,"value_name":"�Ż�ȯ"},{"value_no":4,"value_name":"ȫ��ȯ"}],twidth:"100" ,height:"",hide:true}
	];
var _parkaccountT = new TQTable({
	tabletitle:"�̻��Ż�ȯ",
	ischeck:false,
	tablename:"money_tables",
	dataUrl:"shopticketanlysis.do",
	iscookcol:false,
	param:"action=quickquerydetail&shop_id="+shop_id+"&type="+type,
	tableObj:T("#parkaccountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_parkaccountT.C();
</script>

</body>
</html>
