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
<body>
<div class="search">
        <div class="qiehua">
        <a  href=""  id="table">�б�</a>
        <a href="berthtimeanlysis.do?action=echarts" id="icon"  >ͼ��</a>
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
<div id="berthtimeanlysisobj" style="width:100%;height:100%;margin:0px;"></div>

<script type="text/javascript" >
      $(function(){
        
        	$("#table").css('background','#5ccdbe').css('color','#fff');
        });
        
var btime="${btime}";
//var etime="${etime}";
var _mediaField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"ͣ����",fieldname:"company_name",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"�ܿ�ͣʱ��(h)",fieldname:"total_time",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"ͣ��ʱ��(h)",fieldname:"stay_time",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"��λƽ��ͣ��ʱ��(h)",fieldname:"berthavghour",inputtype:"number", twidth:"200",issort:false},
		{fieldcnname:"����ƽ��ͣ��ʱ��(h)",fieldname:"caravghour",inputtype:"number", twidth:"200",issort:false},
		{fieldcnname:"ͣ��ռ��(%)",fieldname:"percent",inputtype:"number", twidth:"100",issort:false}
		];
var _berthtimeanlysisT = new TQTable({
	tabletitle:"ͣ��ʱ������",
	ischeck:false,
	tablename:"berthtimeanlysis_tables",
	dataUrl:"berthtimeanlysis.do",
	iscookcol:false,  
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#berthtimeanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "&nbsp;&nbsp; ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}

function searchdata(){
    
	btime = T("#coutom_btime").value;

	//data=eval(T.A.sendData("parkingturnover.do?action=echarts&btime="+btime+"&etime="+etime));
	_berthtimeanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime,
	});
	T("#coutom_btime").value=btime;

   
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_berthtimeanlysisT.C();

</script>
</body>
</html>
