<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����ȯͳ��</title>
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
</head>
<body>
<div id="shopanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false},
		{fieldcnname:"�̼�����",fieldname:"name",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�������",fieldname:"uplimit",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�Ѵ�ӡ��(��)",fieldname:"allpcount",inputtype:"text", twidth:"100",issort:false/* ,
			process:function(value,cid,id){
					return "<a href=# onclick=\"viewdetail('all','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
				} */},
		{fieldcnname:"�Ѵ�ӡ���(Сʱ)",fieldname:"allptotal",inputtype:"text", twidth:"120",issort:false},
		{fieldcnname:"��ʹ����(��)",fieldname:"upcount",inputtype:"text", twidth:"100",issort:false/* ,
			process:function(value,cid,id){
						return "<a href=# onclick=\"viewdetail('used','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
					} */},
		{fieldcnname:"�ѵֿ۶��(Сʱ)",fieldname:"uptotal",inputtype:"text", twidth:"120",issort:false},
		{fieldcnname:"ʵ�ʵֿ۶��(Сʱ)",fieldname:"dtotal",inputtype:"text", twidth:"120",issort:false},
		{fieldcnname:"ʵ�ʵֿ۽��(Ԫ)",fieldname:"dmoney",inputtype:"text", twidth:"120",issort:false}
	];
var _shopanlysisT = new TQTable({
	tabletitle:"�̻�����ȯ",
	ischeck:false,
	tablename:"shopanlysis_tables",
	dataUrl:"shopticketanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#shopanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true
});

function coutomsearch(){
	var html=    "&nbsp;&nbsp;ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;���ͣ�<select id ='ttype' name='media' style='width:120px' ><option value='3'>����ȯ</option><option value='4'>ȫ��ȯ</option></select>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' onclick='searchdata();' "+
				"value=' �� ѯ '/>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	ttype = T("#ttype").value;
	_shopanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&type="+ttype
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	T("#ttype").value = ttype;
}


function detail(flag,value,id){
	var park =_shopanlysisT.GD(id,"name");
	var ttype = T("#ttype").value;
	var tip = "�̻�����ȯ��ӡ��¼";
	Twin({
		Id:"shop_detail_"+id,
		Title:tip+"  --> �̻���"+park,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='shop_detail_'"+id+" id='shop_detail_'"+id+" src='shopticketanlysis.do?action=detail&shop_id="+id+"&btime="+btime+"&etime="+etime+"&flag="+flag+"&ttype="+ttype+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

_shopanlysisT.C();
</script>
</body>
</html>
