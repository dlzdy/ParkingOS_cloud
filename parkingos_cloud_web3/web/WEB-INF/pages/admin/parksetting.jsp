<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="renderer" content="webkit">
<title>��������</title>
<link href="favicon.ico" mce_href="favicon.ico" rel="icon">
<link href="css/common.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/tq.js"></script>

<head>
</head>

<body id="bg">

<!--���˵���ʼ-->
<div class="container">
<div class="leftsidebar_box">
  <div class="leftmenu" id="leftdiv">
  </div>
</div>
<!--���˵�����--> 

<!--���ݿ�ʼ-->
<div class="main">
    <div class="out">
    	<iframe id="contentiframe" name="framePage" style="width: 100%;" frameborder="0" scrolling="auto" style="margin:0px;padding:0px;"></iframe>
    </div>
</div>
<!--���ݽ���--> 

<script type="text/javascript" src="js/jquery.js"></script> 
<script type="text/javascript">
var isIE = function(){
	var w = navigator.userAgent.toLowerCase();
	var ieMode = document.documentMode;
	return (/msie/.test(w) && !/opera/.test(w))?(!window.XMLHttpRequest?6:(ieMode?ieMode:7)):false
	//return document.documentMode == 10 ?10:((s =navigator.userAgent.toLowerCase().match(/msie ([\d.]+)/))?  parseInt(s[1]) : false);
};
function gwh(_h) {
	var h,_h=_h?_h:0;
	if (window.innerHeight) {
		h = window.innerHeight;
	}else{
		h = document.documentElement.offsetHeight || document.body.clientHeight || 0;
	};
	if(isIE&&isIE<9)
	{
		h -= 3
	}
	h = h<_h?_h:h;
	return parseInt(h);
}
var iframe = document.getElementById("contentiframe");
iframe.style.height	= gwh() + "px";
</script>
<script type="text/javascript">
$(".leftsidebar_box dt");
$(".leftsidebar_box dt img").attr("src","images/left/select_xl01.png");
$(function(){
	$(".leftsidebar_box dd").hide();
	$(".leftsidebar_box dt").click(function(){
		$(".leftsidebar_box dt").css({"background-color":"#999"})
		$(this).css({"background-color": "#5ccdbe"});
		$(this).parent().find('dd').removeClass("menu_chioce");
		$(".leftsidebar_box dt img").attr("src","images/left/select_xl01.png");
		$(this).parent().find('img').attr("src","images/left/select_xl.png");
		$(".menu_chioce").slideUp(); 
		$(this).parent().find('dd').slideToggle();
		$(this).parent().find('dd').addClass("menu_chioce");
	});
})
</script>

<script type="text/javascript">
var parkid=${parkid};
var authmenu =[{nname:'Ա������',auth_id:1,url:'member.do?action=adminlist&comid='+parkid},
				{nname:'�շѼ۸�',auth_id:1,url:'price.do?comid='+parkid},
				{nname:'���²�Ʒ',auth_id:1,url:'package.do?comid='+parkid},
				{nname:'�շ��趨',auth_id:1,url:'mset.do?comid='+parkid},
				{nname:'��λ����',auth_id:1,url:'compark.do?comid='+parkid},
				{nname:'�շ�Ա����ʾ�趨',auth_id:1,url:'parksetting.do?action=parkclientset&id='+parkid},
				{nname:'���͹���',auth_id:1,url:'cartype.do?comid='+parkid},
				{nname:'���ԭ�����',auth_id:1,url:'freereasons.do?comid='+parkid},
				{nname:'�����˻�',auth_id:2,url:'',
					subauth:[{nname:'��˾�˻�',pid:2,url:'comaccount.do?comid='+parkid+'&type=0'},
							 {nname:'�Թ��˻�',pid:2,url:'comaccount.do?comid='+parkid+'&type=2'},
							 {nname:'�����˻�',pid:2,url:'useraccount.do?comid='+parkid}
							 ]},
				{nname:'����ʶ������',auth_id:3,url:'',
					subauth:[{nname:'����վ����',pid:3,url:'worksite.do?comid='+parkid},
							 {nname:'ͨ������',pid:3,url:'passedit.do?comid='+parkid},
							 {nname:'Ibeacon����',pid:3,url:'ibeacon.do?parkid='+parkid},
							 {nname:'����ͷ����',pid:3,url:'camera.do?comid='+parkid},
							 {nname:'LED������',pid:3,url:'led.do?comid='+parkid},
							 {nname:'ʶ�����',pid:3,url:'provincesett.do?comid='+parkid}
							 ]}
				
				];
var getobj=function(id){return document.getElementById(id)};
	for(var i=0;i<authmenu.length;i++){
		var ld = getobj('leftdiv');
		var dl = document.createElement("dl");
		dl.className='xitong';
		var dt = document.createElement("dt");
		var subauths = authmenu[i].subauth;
		if(subauths&&subauths.length>0){
			dt.innerHTML=authmenu[i].nname+'<img src="images/left/select_xl01.png"></img>';
			dl.appendChild(dt);
			for(var j=0;j<subauths.length;j++){
				var surl = subauths[j].url;
				var dd = document.createElement("dd");
				dd.innerHTML='<a href="#" onclick="GotoUrl(\''+surl+'\')">'+subauths[j].nname+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>';
				dl.appendChild(dd);
			}
		}else{
			var murl = authmenu[i].url;
			var url = murl;
			if(murl.indexOf('?')!=-1)
				url = murl;
			dt.innerHTML='<a href="#" onclick="GotoUrl(\''+url+'\')">'+authmenu[i].nname+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>';
			dl.appendChild(dt);
		}
		ld.appendChild(dl);
	}

function GotoUrl(url){
	document.getElementById("contentiframe").setAttribute('src',url);
}
GotoUrl('member.do?action=adminlist&comid='+parkid);
</script>	
</body>
</html>
