<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>׷���������</title>
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
   	<style type="text/css">

   
		.search {
	height: 40px;
	margin: 25px 5px 10px 5px;
	
}
		.qiehua {
	float: left;
	margin-left: 0px;
}
		.qiehua a {
	display:block;
	height: 24px;
    padding:5px line-height:24px;
	color: #5ccdbe;
	letter-spacing: 0.2em;
	width: 60px;
	text-align: center;
	font-size: 16px;
	float: left;
	margin-left: 0px;
	background: #fff;
	border: #5ccdbe 1px solid;
}
	</style>

</head>
<body onload='addgroups()'>
<div class="search">
        <div class="qiehua">
        <a  href=""  id="table">�б�</a>
        <a href="paymentanlysis.do?action=echarts" id="icon"  >ͼ��</a>
        </div>
        <form action="" method="get">
          <div class="an">
            
          </div>
          <!--������ť-->
          <div class="kuan2">
           
          </div>
          <!--������-->
        </form>
</div >
<div id="paymentanlysisobj" style="width:100%;height:100%;margin:0px;"></div>

<script type="text/javascript" >
      $(function(){
        
        	$("#table").css('background','#5ccdbe').css('color','#fff');
        });
        
var btime="${btime}";
var groups = eval(T.A.sendData("getdata.do?action=getgroups&cityid=${cityid}"));

//var etime="${etime}";
var _mediaField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"ͣ����",fieldname:"company_name",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"��δ�ɽ��",fieldname:"nopayment",inputtype:"number", twidth:"200",issort:false},
		{fieldcnname:"��׷�ɽ��",fieldname:"payment",inputtype:"number", twidth:"200",issort:false},
		{fieldcnname:"׷��ռ��(%)",fieldname:"percent",inputtype:"number", twidth:"200",issort:false}
		];
var _paymentanlysisT = new TQTable({
	tabletitle:"׷���������",
	ischeck:false,
	tablename:"paymentanlysis_tables",
	dataUrl:"paymentanlysis.do",
	iscookcol:false,  
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#paymentanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "&nbsp;&nbsp; ��ֹʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������ţ�&nbsp;&nbsp;<select style='width:130px' id='groups'></select>&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}
function addgroups(){
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
	var groupid = T("#groups").value;
	//data=eval(T.A.sendData("parkingturnover.do?action=echart&groupid="+groupid+"s&btime="+btime+"&etime="+etime));
	_paymentanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&groupid="+groupid
	});
	T("#coutom_btime").value=btime;
	addgroups();
	T("#groups").value = groupid;
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_paymentanlysisT.C();

</script>
</body>
</html>
