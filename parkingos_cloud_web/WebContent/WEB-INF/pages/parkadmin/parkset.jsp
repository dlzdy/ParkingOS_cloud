<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸�ͣ����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
</head>
<body>
<script src="js/tq.js?08137" type="text/javascript">//����</script>
<script src="js/tq.public.js?08031" type="text/javascript">//����</script>
<script src="js/tq.window.js?008136" type="text/javascript">//����</script>
<script src="js/tq.form.js?08301" type="text/javascript">//��</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>

<div id="alllayout">
	<div style="width:100%;float:left;height:45px;border-bottom:1px solid #ccc" id="top"></div>
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
/*Ȩ��*/
//ȡ�ֶ�
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}];
var etc_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var Obj = document.getElementById("alllayout");
var topO = document.getElementById("top");
var rightO = document.getElementById("right");
var type = '${type}';
var ishide=type==='set'?true:false;
rightO.style.width = T.gww()  + "px";
rightO.style.height = T.gwh() - 50 + "px";

T.bind(window,"resize",function(){
    rightO.style.width = T.gww() + "px";
    rightO.style.height = T.gwh() - 50 + "px"
})


var fields = [
		{fieldcnname:"�������",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
		{fieldcnname:"���ִ�С��",fieldname:"car_type",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ѽ��㶩��",fieldname:"passfree",fieldvalue:'',defaultValue:'����||0',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"������"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"HD���㰴ť",fieldname:"ishidehdbutton",fieldvalue:'',defaultValue:'��ʾ||0',inputtype:"select", noList:[{"value_no":0,"value_name":"��ʾ"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����Զ�֧��",fieldname:"isautopay",fieldvalue:'',defaultValue:'��ʾ||0',inputtype:"select", noList:[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����������",fieldname:"full_set",fieldvalue:'',defaultValue:'�ɽ�||0',inputtype:"select", noList:[{"value_no":0,"value_name":"�ɽ�"},{"value_no":1,"value_name":"��ֹ"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�볡����",fieldname:"leave_set",fieldvalue:'',defaultValue:'Ĭ������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"Ĭ������"},{"value_no":1,"value_name":"ʶ���̧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʶ��ʡ��",fieldname:"firstprovince",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false}, 
		{fieldcnname:"���¿���",fieldname:"entry_set",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"��ֹ����"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�¿��ڶ�����",fieldname:"entry_month2_set",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"��ֹ����"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�Ƿ������շѽ��",fieldname:"ishdmoney",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false}
	];
var comid="";
var company_name = 0;
var total=0;
var cominfo= eval('${cominfo}');
for(var i=0;i<cominfo.length;i++){
		if(cominfo[i].name=="id"){
			comid =cominfo[i].value;
		}
		if(cominfo[i].name=="company_name"){
			company_name =cominfo[i].value;
		}
}
var bHtml = "<div style='margin-top:13px;margin-buttom:20px;margin-left:19px;width:595px;overflow:hidden;font-size:18px;color:red'>";
	bHtml += company_name;
	bHtml += "</div>";
topO.innerHTML=bHtml;

function getEditFields(){
	var e_f = [];
	for(var j=0;j<fields.length;j++){
		for(var i=0;i<cominfo.length;i++){
			if(cominfo[i].name==fields[j].fieldname){
				fields[j].fieldvalue=cominfo[i].value;
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
		{kindname:"������Ϣ",kinditemts:fs}
		//{kindname:"�˻���Ϣ",kinditemts:fs.slice(21)}
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
	suburl:"parkinfo.do?action=parkset&id="+comid,
	method:"POST",
	dbuttonname:buttons,
	//dbbuttons:[true,false],
	//buttons:getTopButtons(),
	Callback:function(f,r,c,o){
		if(c=='1'){
			T.loadTip(1,"�޸ĳɹ���",3,null);
		}else
			T.loadTip(1,"����ʧ�ܣ�",3,null);
	},
	formAttr:[{
		formitems:getFields()
	}]
});
accountForm.C();

</script>


</html>
<script type="text/javascript">
T.maskTip(0,"","");//���ؽ���
</script>