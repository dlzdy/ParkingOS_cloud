<%@ page language="java" contentType="text/html; charset=gb2312"
	pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>���Թ���</title>
<script src="js/jquery.js"></script>
<style>
body {
  font-family: "Microsoft Yahei", Arial, sans-serif;
  font-size: 14px;
  background: #fff;
  overflow-x:hidden;
}
.title{
	font-size: 15px;
	margin-bottom:5px;
	color:red;
}
.content{e
	margin-bottom:10px;
}
.textarea{
	background-color: #FFFCEC;
}
.module{
	border: 1px solid #DDDDDD; padding:5px; margin-bottom:10px;
}
.button {
	display: inline-block;
	position: relative;
	margin: 0px;
	padding: 0 20px;
	text-align: center;
	text-decoration: none;
	font: bold 12px/25px Arial, sans-serif;

	text-shadow: 1px 1px 1px rgba(255,255,255, .22);

	-webkit-border-radius: 30px;
	-moz-border-radius: 30px;
	border-radius: 30px;

	-webkit-box-shadow: 1px 1px 1px rgba(0,0,0, .29), inset 1px 1px 1px rgba(255,255,255, .44);
	-moz-box-shadow: 1px 1px 1px rgba(0,0,0, .29), inset 1px 1px 1px rgba(255,255,255, .44);
	box-shadow: 1px 1px 1px rgba(0,0,0, .29), inset 1px 1px 1px rgba(255,255,255, .44);

	-webkit-transition: all 0.15s ease;
	-moz-transition: all 0.15s ease;
	-o-transition: all 0.15s ease;
	-ms-transition: all 0.15s ease;
	transition: all 0.15s ease;
}
.green {
	color: #3e5706;
	background: #a5cd4e;
}
</style>
</head>
<body  style="text-align:center;">
<div>
	<div class="module">
	<div class="title">
			<span>�ֻ��ű���</span>
		</div>
		<div>
			<span>�ֻ��ţ�</span><input type="text" value="" maxlength="11" id="mobile" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>�������</span>
		</div>
		<div>
			<span style="margin-left:10px;">
				<select id="cache">
					<option value="0">��ȯ����</option>
					<option value="1">�������</option>
					<option value="2">���ͻ���</option>
					<option value="3">��������</option>
					<option value="4">������������������</option>
				</select>
			</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="clearcache()" value="���" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>���ղ����ܶ�</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="allowance()" value="�鿴" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>�鿴ÿ�ճ���ͣ��ȯ������(����)</span>
		</div>
		<div style="margin-top:10px;">
			<span>������ţ�</span><input type="text" value="" id="parkid" />
			<span style="margin-left:10px;"></span>
		</div>
		<div style="margin-top:10px;">
			<span style="margin-left:10px;">
				��ѯ���ݣ�<select id="ticketcache">
					<option value="0">���ոó���ͣ��ȯ������</option>
					<option value="1">���ոó���ͣ��ȯ��������</option>
				</select>
			</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="viewticketbypark()" value="�鿴" />
		</div>
		
		<div class="title" style="magrin-top:10px;">
			<span>����ÿ�ճ���ͣ��ȯ������(����)</span>
		</div>
		<div style="margin-top:10px;">
			<span>�������ޣ�</span><input type="text" value="" id="parklimit" />
			<span style="margin-left:10px;"></span>
		</div>
		<div style="margin-top:10px;">
			<span style="margin-left:10px;">
				�������ݣ�<select id="ticketlimit">
					<option value="0">����ó������ղ�����</option>
					<option value="1">���ý��ոó���ͣ��ȯ��������</option>
				</select>
			</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="setticketbypark()" value="����" />
		</div>
		
		<div class="title">
			<span>�鿴���г�����������</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="viewallparklimit()" value="�鿴" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>�鿴�Ƿ��ں�����</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="black()" value="�鿴" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>�Ӻ�������Ư��</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="towhite()" value="Ư��" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>�鿴�Ƿ���֤�û�</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="isauth()" value="�鿴" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>������֤�û�</span>
		</div>
		<div>
			<span style="margin-left:10px;">
				<select id="authcache">
					<option value="0">����Ϊ����֤�û�</option>
					<option value="1">����Ϊ��֤�û�</option>
				</select>
			</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="setauth()" value="����" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>����׵�</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="clearfirst()" value="���" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>������մ��ͼ�¼</span>
		</div>
		<div style="margin-top:10px;">
			<span>�շ�Ա��ţ�</span><input type="text" value="" id="parkerid" />
			<span style="margin-left:10px;"></span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="clearreward()" value="���" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>��ͣ��ȯ</span>
		</div>
		<div>
			<span>ȯ���:</span><input type="text" value="" id="begin" />--<input type="text" value="" id="end" />
			<select id="tickettype">
					<option value="0">��ͨȯ</option>
					<option value="1">ר��ȯ</option>
					<option value="2">����ȯ</option>
				</select>
		</div>
		<div style="margin-top:10px;">
			<span>������ţ�</span><input type="text" value="" id="comid" />
			<span style="margin-left:10px;"></span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="addticket()" value="���" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>���ͣ��ȯ</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="clearticket()" value="���" />
		</div>
	</div>
	<div class="module">
	<div class="title">
			<span>�����</span>
		</div>
		<div>
			<span>��</span><input type="text" value="" id="balance" />
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="addbalance()" value="ȷ��" />
		</div>
	</div>
	
	<div class="module">
	<div class="title">
			<span>�ӻ���</span>
		</div>
		<div>
			<span>���֣�</span><input type="text" value="" id="score" />
		</div>
		<div style="margin-top:10px;">
			<span>�շ�Ա��ţ�</span><input type="text" value="" id="uid" />
			<span style="margin-left:10px;"></span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="addscore()" value="ȷ��" />
		</div>
	</div>
	<div class="module">
		<div class="title">
			<span>�����΢�Ź��ںŵİ󶨹�ϵ</span>
		</div>
		<div style="margin-top:10px;text-align:center;">
			<input type="button" onclick="disbind()" value="���" />
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	var checkmobile = function(){
		var mobile = document.getElementById("mobile").value;
		var m = /^[1][3,4,5,7,8][0-9]{9}$/; 
		if(mobile == ""){
			alert("�������ֻ�����");
			return false;
		}
		if(mobile.length!=11||!mobile.match(m)){
			alert("�ֻ����벻��ȷ");
			return false;
		}
		return true;
	};

	var clearcache = function(){
		if(!checkmobile()){
			return false;
		}
		var type = document.getElementById("cache").value;
		var mobile = document.getElementById("mobile").value;
		cache(mobile,type);
	};

	function cache(mobile, type){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'clearcache',
				'mobile' : mobile,
				'type' : type,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("����ɹ�");
				}else if(result == "-5"){
					alert("û�л���");
				}else if(result == "-4"){
					alert("���ϲ�������������");
				}
			}
		});
	}
	
	var setauth = function(){
		if(!checkmobile()){
			return false;
		}
		var isauth = document.getElementById("authcache").value;
		var mobile = document.getElementById("mobile").value;
		setuserauth(mobile,isauth);
	};

	function setuserauth(mobile, isauth){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'setauth',
				'mobile' : mobile,
				'isauth' : isauth,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("���óɹ�");
				}
			}
		});
	}
	
	var allowance = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		viewallowance(mobile);
	};
	function viewallowance(mobile){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'allowance',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("�������޻���");
				}else{
					alert("���ղ������:"+result);
				}
			}
		});
	}
	
	var black = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		viewblack(mobile);
	};
	
	function viewblack(mobile){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'viewblack',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("���ֻ��Ų��ں�������");
				}else if(result == "1"){
					alert("���ֻ����ں�������");
				}
			}
		});
	}
	
	var setticketbypark = function(){
		if(!checkmobile()){
			return false;
		}
		var parkid = document.getElementById("parkid").value;
		var re = /^[1-9]+[0-9]*]*$/;
		if(parkid == ""){
			alert("�����복�����");
			return false;
		}
		if(!parkid.match(re)){
			alert("������Ų���ȷ");
			return false;
		}
		var ticketlimit = document.getElementById("ticketlimit").value;
		var mobile = document.getElementById("mobile").value;
		var parklimit = document.getElementById("parklimit").value;
		if(parklimit != "" && !parklimit.match(re)){
			alert("�������޲���ȷ");
			return false;
		}
		setbypark(mobile,parkid,parklimit,ticketlimit);
	};
	
	function setbypark(mobile,parkid,parklimit,type){
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'settbypark',
				'mobile' : mobile,
				'type' : type,
				'comid' : parkid,
				'parklimit' : parklimit,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("������Ų���ȷ");
				}else if(result == "-5"){
					alert("����ʧ�ܣ�û�а��������䲹���Ļ��棬��ʱ�����ܲ�����������Ʋ���");
				}else if(result == "-6"){
					alert("����ʧ�ܣ��������ݲ��ɲ���");
				}else if(result == "1"){
					alert("���óɹ�");
				}
			}
		});
	}
	
	var viewallparklimit = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		viewalllimit(mobile);
	};
	
	function viewalllimit(mobile){
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'viewallparklimit',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("�޻���");
				}else{
					alert(result);
				}
			}
		});
	}
	
	var viewticketbypark = function(){
		if(!checkmobile()){
			return false;
		}
		var parkid = document.getElementById("parkid").value;
		var re = /^[1-9]+[0-9]*]*$/;
		if(parkid == ""){
			alert("�����복�����");
			return false;
		}
		if(!parkid.match(re)){
			alert("������Ų���ȷ");
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		var ticketcache = document.getElementById("ticketcache").value;
		viewbypark(mobile,ticketcache,parkid);
	};
	
	function viewbypark(mobile,type,parkid){
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'viewtbypark',
				'mobile' : mobile,
				'type' : type,
				'comid' : parkid,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("������Ų���ȷ");
				}else if(result == "-5"){
					alert("û�а��������䲹���Ļ��棬��ʱ�����ܲ�����������Ʋ���");
				}else{
					if(type == "0"){
						alert("�ó�������ͣ��ȯ������ȣ�"+result);
					}else if(type == "1"){
						alert("�ó�������ͣ��ȯ�������ޣ�"+result);
					}
				}
			}
		});
	}
	
	var towhite = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		whiteblack(mobile);
	};
	
	function whiteblack(mobile){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'towhite',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("���ֻ��Ų��ں�������");
				}else if(result == "-5"){
					alert("Ư��ʧ��");
				}else if(result == "1"){
					alert("Ư�׳ɹ�");
				}
			}
		});
	}
	
	var isauth = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		checkauth(mobile);
	};
	
	function checkauth(mobile){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'checkauth',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("����֤�û�");
				}else if(result == "1"){
					alert("��֤�û�");
				}
			}
		});
	}
	
	var clearfirst = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		first(mobile);
	};
	
	function first(mobile){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'clearfirst',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("����ɹ�");
				}
			}
		});
	}
	
	var addticket = function(){
		if(!checkmobile()){
			return false;
		}
		var begin = document.getElementById("begin").value;
		var tickettype = document.getElementById("tickettype").value;
		var end = document.getElementById("end").value;
		var comid= document.getElementById("comid").value;
		var mobile = document.getElementById("mobile").value;
		var re = /^[1-9]+[0-9]*]*$/;
		if(begin == ""){
			alert("������ͣ��ȯ���");
			return false;
		}
		if(!begin.match(re)){
			alert("����ȷ");
			return false;
		}
		if(end != "" && !end.match(re)){
			alert("����ȷ");
			return false;
		}
		if(end != ""){
			if(parseInt(end) < parseInt(begin)){
				alert("����ȷ");
				return false;
			}
		}
		if(tickettype == "1"){
			if(comid == ""){
				alert("�����복�����");
				return false;
			}
			
			if(!comid.match(re)){
				alert("������Ų���ȷ");
				return false;
			}
		}
		ticket(mobile,begin,end,tickettype,comid);
	};
	
	function ticket(mobile,begin,end,type,comid){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'addticket',
				'mobile' : mobile,
				'begin' : begin,
				'end' : end,
				'type' : type,
				'comid' : comid,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("������ͣ��ȯ���");
				}else if(result == "-5"){
					alert("�����복�����");
				}else if(result == "-6"){
					alert("���ʧ��");
				}else if(result == "1"){
					alert("��ӳɹ�");
				}
			}
		});
	}
	
	var clearreward = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		var parkerid = document.getElementById("parkerid").value;
		reward(mobile,parkerid);
	};
	
	function reward(mobile,uid){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'clearreward',
				'mobile' : mobile,
				'uid' : uid,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "-4"){
					alert("�������շ�Ա�ʺ�");
				}else if(result == "1"){
					alert("����ɹ�");
				}
			}
		});
	}
	
	var clearticket = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		cticket(mobile);
	};
	
	function cticket(mobile){//
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'clearticket',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("����ɹ�");
				}
			}
		});
	}
	
	var addbalance = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		var balance = document.getElementById("balance").value;
		if(balance == ""){
			alert("��������");
			return false;
		}
		var re = /^[1-9]+[0-9]*]*$/;
		if(balance != "0" && !balance.match(re)){
			alert("����ȷ");
			return false;
		}
		
		addmoney(mobile, balance);
	};
	
	function addmoney(mobile, balance){
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'addbalance',
				'mobile' : mobile,
				'balance' : balance,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("���óɹ�");
				}
			}
		});
	}
	
	var addscore = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		var score = document.getElementById("score").value;
		var uid = document.getElementById("uid").value;
		if(score == ""){
			alert("���������");
			return false;
		}
		if(uid == ""){
			alert("�������շ�Ա�ʺ�");
			return false;
		}
		var re = /^[1-9]+[0-9]*]*$/;
		if(score != "0" && !score.match(re)){
			alert("���ֲ���ȷ");
			return false;
		}
		if(!uid.match(re)){
			alert("�շ�Ա�ʺŲ���ȷ");
			return false;
		}
		
		setscore(mobile, score, uid);
	};
	
	function setscore(mobile, score, uid){
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'addscore',
				'mobile' : mobile,
				'uid' : uid,
				'score' : score,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("���óɹ�");
				}
			}
		});
	}
	
	var disbind = function(){
		if(!checkmobile()){
			return false;
		}
		var mobile = document.getElementById("mobile").value;
		clearbind(mobile);
	};
	
	function clearbind(mobile){
		jQuery.ajax({
			type : "post",
			url : "testutil.do",
			data : {
				'action' : 'disbind',
				'mobile' : mobile,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				if(result == "-1"){
					alert("�������ֻ���");
				}else if(result == "-2"){
					alert("���ֻ��Ų��ڲ���������");
				}else if(result == "-3"){
					alert("���ֻ���û��ע��");
				}else if(result == "1"){
					alert("���ɹ�");
				}
			}
		});
	}
</script>
</html>
