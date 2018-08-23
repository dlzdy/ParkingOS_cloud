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
<title>���복��</title>
<script src="js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/prepay.css?v=3">
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
select{
-webkit-appearance: none;
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

.hide{
	display:none;
}
</style>

</head>
<body>

	<section class="main">
		<!-- ���복�ƺ�[[ -->
		<form method="post" action="wxpfast.do?action=sweepcom" role="form" class="form lpn-form" id="carnumberform">
			<fieldset>
				
				<div class="input-area">
					<dl class="form-line">
						<dt class="label">���ƺ���</dt>
						<dd class="element lpn-element">
							<input class="text" type="text" name="carnumber" id="carnumber" placeholder="�����복�ƺ�" maxlength="7">
						</dd>
					</dl>

					<dl class="form-line">
						<dt class="label">���ó��ƺ�</dt>
						<dd class="element lpn-element">
							<div id="switch-bg" class="switch-bg switch-on"><!-- ���class="switch-on"����ʾ������״̬ -->
								<a class="switch-btn"><!-- ���ذ�ť --></a>
								<input type="text" name="addtype" id="addtype" value="0" class="hide">
							</div>
						</dd>
					</dl>
				</div>

				<div class="form-tips">������˳��ƺţ��´���������</div>
				<input type="button" id="wx_pay" onclick='check();' class="wx_pay" value="ȥԤ��">
				<input type="text" name="openid" value="${openid}" class="hide">
				<input type="text" name="codeid" value="${codeid}" class="hide">
			</fieldset>
		</form>
		<!-- ���복�ƺ�]] -->
		<div style="text-align:center;" id="error" class="error"></div>
		<div class="wxpay-logo"></div>
	</section>
<script type="text/javascript">
	$(".switch-btn").bind("click",function(){
		var onoff = document.getElementById("switch-bg");
		var addtype = document.getElementById("addtype");
		if(hasClass(onoff,"switch-on")){
			removeClass(onoff,"switch-on");
			addClass(onoff,"switch-off");
			$(".form-tips").addClass("hide");
			addtype.value = 1;
		}else if(hasClass(onoff,"switch-off")){
			removeClass(onoff,"switch-off");
			addClass(onoff,"switch-on");
			$(".form-tips").removeClass("hide");
			addtype.value = 0;
		}
	});

	function check(){
		var carnumber = document.getElementById("carnumber").value;
		var addtype = document.getElementById("addtype").value;
		carnumber = carnumber.toUpperCase();
		var city = carnumber.charAt(0);
		var array = new Array( "��", "��", "��", "��", "��", "³",
					"��", "��", "ԥ", "��", "��", "��", "��", "��", "��", "��", "��", "��",
					"��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��",
					"��", "��", "��", "ʹ", "��", "��", "��", "��", "��", "��","��", "��", "��", "��", "WJ", "��", "��", "��","ˮ", "��", "��", "ͨ" );  
		var m = /^[A-Z]{1}[A-Z_0-9]{5}$/;
		carnumber_char = carnumber.substr(1);
		if(array.toString().indexOf(city) > -1){
			if(city == "ʹ"){
				m = /^[A-Z_0-9]{6}$/;
			}
			if(!carnumber_char.match(m)){
				document.getElementById("error").innerHTML = "���ƺŲ���ȷ";
				return false;
			}
		}else{
			document.getElementById("error").innerHTML = "���ƺŲ���ȷ";
			return false;
		}
		carnumber = encodeURI(carnumber);
		if(addtype == "0"){
			addcnum(carnumber);
		}else{
			$("#carnumberform")[0].submit();
		}
	} 
	
	function addcnum(carnumber){
		jQuery.ajax({
			type:"post",
			url:"wxpfast.do",
			data:{
				'action':'addcnum',
				'carnumber':carnumber,
				'openid':'${openid}',
				 'r' : Math.random()
			},
		    async:false,
		    success:function(result){
		    	if(result == "-1" || result=="-2" || result == "-3" || result == "-4"){
		    		var onoff = document.getElementById("switch-bg");
					removeClass(onoff,"switch-on");
					addClass(onoff,"switch-off");
					$(".form-tips").addClass("hide");
					document.getElementById("addtype").value = 1;
					var error = "";
					if(result == "-1"){
						error = "�ó��ƺ��ѱ�ע��,�Ѹ�Ϊ�ǳ��ó��ƺ�";
					}else if(result == "-2"){
						error = "����ע��ó���";
					}else if(result == "-3"){
						error = "���ע��3������,�Ѹ�Ϊ�ǳ��ó��ƺ�";
					}else if(result == "-4"){
						error = "ע�ᳵ��ʧ��,�Ѹ�Ϊ�ǳ��ó��ƺ�";
					}
					document.getElementById("error").innerHTML = error;
		    	}else{
		    		$("#carnumberform")[0].submit();
		    	}
		      }
		}); 
	}
</script>
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
</body>
</html>
