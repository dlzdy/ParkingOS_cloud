<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�˻�����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
</head>
<body>
<script src="js/tq.js?08137" type="text/javascript">//����</script>
<script src="js/tq.public.js?08031" type="text/javascript">//����</script>
<script src="js/tq.window.js?008136" type="text/javascript">//����</script>
<script src="js/tq.form.js?08369" type="text/javascript">//��</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>

<div id="alllayout">
	<div style="width:100%;float:left;height:60px;border-bottom:1px solid #ccc" id="top"></div>
	<div style="width:100%;float:left;">
    	<div id="right" style="width:auto;border-left:1px solid #ccc;float:left"></div>
	</div>
</div>	
<div id="loadtip" style="display:none;"></div>
<div id="cover" style="display:none;"></div>
</body>
<script type="text/javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴,����,��������
/*Ȩ��*/
//ȡ�ֶ�
var Obj = document.getElementById("alllayout");
var topO = document.getElementById("top");
var rightO = document.getElementById("right");

rightO.style.width = T.gww()  + "px";
rightO.style.height = T.gwh() - 50 + "px";

T.bind(window,"resize",function(){
    rightO.style.width = T.gww() + "px";
    rightO.style.height = T.gwh() - 50 + "px"
})

var pursue=[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}];
var fields = [
		{fieldcnname:"���б��",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��γ��",fieldname:"gps",fieldvalue:'',inputtype:"showmap", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����λ��",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"newpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ȷ������",fieldname:"confirmpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�Ƿ����Ӫ����׷���ӵ�",fieldname:"is_group_pursue",fieldvalue:'',inputtype:"select",noList:pursue ,twidth:"100" ,height:"",issort:true},
		{fieldcnname:"ͬһ���ƿɷ��ڳ������ظ��볡",fieldname:"is_inpark_incity",fieldvalue:'',inputtype:"select",noList:pursue ,twidth:"100" ,height:"",issort:true}
	];
var info= eval('${info}');
var cityid = "";
for(var i=0;i<info.length;i++){
	if(info[i].name=="id"){
		cityid =info[i].value;
	}
}
var bHtml = "<div style='margin-top:20px;margin-buttom:20px;margin-left:29px;width:595px;overflow:hidden;'>�༭��Ϣ</div>";
topO.innerHTML=bHtml;

function getEditFields(){
	var e_f = [];
	for(var j=0;j<fields.length;j++){
		for(var i=0;i<info.length;i++){
			if(info[i].name==fields[j].fieldname){
				fields[j].fieldvalue=info[i].value;
				e_f.push(fields[j]);
				break;
			}
			if(fields[j].inputtype=='select')
				fields[j].width=200;
		}
	}
	return e_f;
}

function getFields(){
	var fs = getEditFields();
	var mfs = [
		{kindname:"�̻���Ϣ",kinditemts:fs.slice(0,4)},
		{kindname:"�ҵ��˻���Ϣ",kinditemts:fs.slice(4,9)},
		{kindname:"������Ϣ",kinditemts:fs.slice(9,11)}
		];
	return mfs;
}

var buttons=[false,false];
if(subauth[1])
	buttons=["����","����"];

var accountForm =
new TQForm({
	formname: "opconfirm",
	formObj:rightO,
	suburl:"cityinfo.do?action=edit&id="+cityid+"&uin=${uin}",
	method:"POST",
	dbuttonname:buttons,
	Callback:function(f,r,c,o){
		if(c=='1'){
			T.loadTip(1,"�޸ĳɹ���",3,null);
		}else if(c=='-2'){
			T.loadTip(1,"���볤��С��6λ�����������룡",3,null);
		}else if(c=='-3'){
			T.loadTip(1,"�����������벻һ�£����������룡",3,null);
		}else
			T.loadTip(1,"����ʧ�ܣ�",3,null);
	},
	formAttr:[{
		formitems:getFields()
	}]
});
accountForm.C();

function getTopButtons(){
	var bus = [];
	return bus;
}

var isfixed = T("#opconfirm_isfixed").value;
if(isfixed==1){
	T("#opconfirm_address").disabled=true;
	T("#opconfirm_address_showmap").disabled=true;
}

</script>


</html>
<script type="text/javascript">
T.maskTip(0,"","");//���ؽ���
</script>