<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>dd��¼</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>

</head>
<body>
<div id="dddetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var btime="${btime}";
var etime="${etime}";
var p_lot="${p_lot}";
var tip = "ͣ��λ�¿���������";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"���²�Ʒ����",fieldname:"p_name",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"�շѱ�׼(Ԫ/��)",fieldname:"price",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��������",fieldname:"create_time",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��Ч����",fieldname:"b_time",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��������",fieldname:"e_time",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"Ӧ�����",fieldname:"total",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"ʵ�ս��",fieldname:"act_total",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"�Żݽ��",fieldname:"favtotal",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��Ա����",fieldname:"name",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��Ա�ֻ�",fieldname:"mobile",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��Ա����",fieldname:"car_number",inputtype:"text",twidth:"200",issort:false}
	];
var _dddetailT = new TQTable({
	tabletitle:tip,
	ischeck:false,
	tablename:"dddetail_tables",
	dataUrl:"plotprod.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=ppdetail&btime="+btime+"&etime="+etime+"&p_lot="+p_lot,
	tableObj:T("#dddetailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:false
});

function coutomsearch(){
	/* var tip = "ʱ�䣺"+btime+" �� "+etime;
	if(otype=='today')
	 tip="���ն���";
	else if(otype=='toweek')
	 tip="���ܶ���";
	else if(otype=='lastweek')
	 tip="���ܶ���";
	else if(otype=='tomonth')
	 tip="���¶���";
	if(pay_type==7){
		var html=   tip+" ���ϼ���ѣ�<font color='red'>"+total+"</font> Ԫ ";//"&nbsp;&nbsp;�ϼ���ѣ�900.00Ԫ";
	}else{
		var html=   tip+" ���ϼƣ�<font color='red'>"+total+"</font> Ԫ�������ֽ�֧�� ��<font color='red'>"+pmoney+"</font>Ԫ���ֻ�֧�� ��<font color='red'>"+pmobile+"</font>Ԫ����<font color='red'> "+count+" </font>�� ";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	}
	return html; */
}

function viewdetail(type,value,id){
	var car_number =_dddetailT.GD(id,"car_number");
	var tip = "����ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip+"  --> ���ƣ�"+car_number,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
	})
}

_dddetailT.C();
</script>

</body>
</html>
