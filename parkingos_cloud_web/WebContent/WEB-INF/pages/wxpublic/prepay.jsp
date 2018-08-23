<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>��ǰ����</title>
<script src="js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/prepay.css?v=2">
<style type="text/css">
.error {
	color: red;
	font-size: 15px;
	margin-top:5%;
}
.noorder{
	text-align:center;
	color:red;
	margin-top:55%;
}
.wx_pay{
	border-radius:5px;
	width:96%;
	margin-left:2%;
	height:40px;
	margin-top:5%;
	font-size:15px;
	background-color:#04BE02;
	color:white;
}
</style>
<script type="text/javascript">
			//ÿ�����һ��class
			function addClass(currNode, newClass){
		        var oldClass;
		        oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
		        if(oldClass !== null) {
				   newClass = oldClass+" "+newClass; 
				}
				currNode.className = newClass; //IE ��FF��֧��
    		}
			
			//ÿ���Ƴ�һ��class
			function removeClass(currNode, curClass){
				var oldClass,newClass1 = "";
		        oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
		        if(oldClass !== null) {
				   oldClass = oldClass.split(" ");
				   for(var i=0;i<oldClass.length;i++){
					   if(oldClass[i] != curClass){
						   if(newClass1 == ""){
							   newClass1 += oldClass[i]
						   }else{
							   newClass1 += " " + oldClass[i];
						   }
					   }
				   }
				}
				currNode.className = newClass1; //IE ��FF��֧��
			}
			
			//����Ƿ������ǰclass
			function hasClass(currNode, curClass){
				var oldClass;
				oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
				if(oldClass !== null){
					oldClass = oldClass.split(" ");
					for(var i=0;i<oldClass.length;i++){
					   if(oldClass[i] == curClass){
						   return true;
					   }
				   }
				}
				return false;
			}
</script>
</head>
<body>
	<!-- �ҵĳ���[[ -->
		<dl class="my-lpn hide">
			<dt class="title">�ҵĳ��ƺ���</dt>
			<dd class="lpn">${carnumber}<a class="change-btn" href="wxpfast.do?action=toaddcnum&codeid=${codeid}&openid=${openid}">�޸�</a></dd>
		</dl>
		<!-- �ҵĳ���]] -->
	<section class="main">
		<form method="post" action="wxpfast.do?action=beginprepay" role="form" id="prepayform" class="confirm">
			<fieldset>
			<div class="info-area">	
				<dl class="totle" style="border-bottom:0px">
					<dt class="totle-title">Ԥ��ͣ����</dt>
					<dd class="totle-num" style="color:#04BE02;">��<span id="aftertotal">${aftertotal}</span></dd>
					<ul class="nfc">
						<li class="list1"></li>
						<li class="list2"><a href=""><span>Ԥ����ɺ��ٽ������շ�Ա���㣬���ۿ�</span></a></li>
					</ul>
					<div class="sweepcom hide" style="border-bottom: 1px solid #E0E0E0;"></div>
				</dl>
				
				<ul class="info-list" style="padding-top:1px;">
					<li class="list"><span class="list-title">��Ԥ�����</span><span class="list-content">${pretotal}Ԫ</span></li>
					<li class="list"><span class="list-title">�볡ʱ��</span><span class="list-content">${starttime}</span></li>
					<li class="list"><span class="list-title">��ͣʱ��</span><span class="list-content" id="parktime">${parktime}</span></li>
					<li class="list freetime hide"><span class="list-title">����ʱ��</span><span class="list-content">${descp}</span></li>
					<li class="list"><span class="list-title carnumber hide">���ƺ���</span><span class="list-content">${carnumber}</span></li>
				</ul>
				
				<ul class="info-list hide">
					<li class="list"><input name="openid" value="${openid}" /></li>
					<li class="list"><input name="orderid" value="${orderid}"></li>
				</ul>
			</div>
			<div class="leave" style="text-align:center;margin-top:20px;">
				���뵽���ڽɷѻ��У�<select name="delaytime"
					style="width:95px;height:25px;padding-top:3px;font-size:17px;padding-left:6px;color:#04BE02;"
					id="delaytime">
					<option value="0">0����</option>
					<option value="5">5����</option>
					<option value="10">10����</option>
					<option selected="selected" value="15">15����</option>
					<option value="30">30����</option>
					<option value="60">1Сʱ</option>
					<option value="120">2Сʱ</option>
					<option value="240">4Сʱ</option>
					<option value="360">6Сʱ</option>
					<option value="480">8Сʱ</option>
					<option value="600">10Сʱ</option>
					<option value="720">12Сʱ</option>
				</select>
			</div>
			<input type="button" id="wx_pay" onclick='payorder();' class="wx_pay" value="ȥԤ��">
			<div class="tips"></div>
			</fieldset>
		</form>
		<div style="text-align:center;" id="error" class="error"></div>
		<div class="wxpay-logo"></div>
	</section>
	<section class="noorder hide">
		<div>��ǰ�޶���</div>
	</section>
</body>
<script type="text/javascript">
	function getprice(){
		var delaytime = document.getElementById("delaytime").value;
		jQuery.ajax({
			type : "post",
			url : "wxpfast.do",
			data : {
				'orderid' : '${orderid}',
				'shopticketid' : '${shopticketid}',
				'curtime' : '${curtime}',
				'delaytime' : delaytime,
				'action' : 'getprice'
			},
			async : false,
			success : function(result) {
				if(result == "-1"){//������
					document.getElementById("error").innerHTML = "��ȡͣ����ʧ��";
				}
				var jsonData = eval("(" + result + ")");
				var aftertotal = jsonData.aftertotal;//�ܽ��
				var parktime = jsonData.parktime;//��ͣʱ��
				document.getElementById("aftertotal").innerHTML = aftertotal;
				document.getElementById("parktime").innerHTML = parktime;
				if(parseFloat(aftertotal) <= 0){//ͣ����0Ԫ
					$(".wx_pay").addClass("hide");
					document.getElementById("error").innerHTML = delaytime+"����֮���볡���";
					return false;
				}else{
					$(".wx_pay").removeClass("hide");
					removeClass(document.getElementById("wx_pay"),"wait");
					document.getElementById("error").innerHTML = "";
				}
			}
		});
	}
	
	$("#delaytime").bind("change", function(){
		getprice();
	});
	//***********������ҳ���ʱ�����delaytime����15���ӣ���������***************//
	var delaytime = document.getElementById("delaytime").value;
	delaytime = parseInt(delaytime);
	document.getElementById("delaytime").value = 15;
	if(delaytime != 15){//ҳ�淵��ʱ���»�ȡ15���ӵļ۸�
		getprice();
	}
	//*******************************end*****************************//
	//*****************************����״̬��ʼ��************************//
	var orderid = "${orderid}";
	var carnumber="${carnumber}";
	var aftertotal = "${aftertotal}";
	var prestate = "${prestate}";
	var swpcomflag = "${swpcomflag}";
	var shopticketid = "${shopticketid}";
	
	if(orderid == "-1"){
		$(".main").addClass("hide");
		$(".noorder").removeClass("hide");
	}
	if(prestate == "1"){
		$(".wx_pay").addClass("hide");
		$(".leave").addClass("hide");
		$(".nfc").addClass("hide");
		$(".sweepcom").removeClass("hide");
		document.getElementById("error").innerHTML = "����Ԥ֧�����������ٴ�Ԥ֧��";
	}
	
	if(swpcomflag == "1"){
		$(".my-lpn").removeClass("hide");
		$(".nfc").addClass("hide");
		$(".sweepcom").removeClass("hide");
	}
	
	if(parseFloat(aftertotal) <= 0){
		$(".wx_pay").addClass("hide");
		document.getElementById("error").innerHTML = "15����֮���볡���";
	}
	
	if(carnumber != ""){
		$(".carnumber").removeClass("hide");
	}
	
	if(shopticketid != "" && shopticketid != "-1"){
		$(".freetime").removeClass("hide");
	}
	
	function payorder(){
		$("#prepayform")[0].submit();
	}
	//*****************************end************************//
</script>
</html>
