<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���������</title>
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
<style type="text/css">
.title1{
	width: 100%;
    margin: 0 auto;
    font-weight: bold;
    line-height: 25px;
    height: 40px;
    background: #EFEFEF;
    padding-top: 15px;
    border-bottom: 1px solid #ddd;
    font-size:16px !important;
}
.sel_fee{
	text-align: center;
    padding-top: 2px;
    padding-bottom: 2px;
    border-radius: 0px;
    background-color: #FFFFFF;
    outline: medium;
    border: 1px solid #5CCDBE;
    color: #5CCDBE;
    padding-left: 8px;
    padding-right: 8px;
}
.title1 a:hover{
	background:#5CCDBE;
	color:#FFFFFF;
}

.column{
	background:#5CCDBE;
	color:#FFFFFF;
}
a:link {
    color: #5CCDBE;
    text-decoration: none;
}
</style>
</head>
<body>
<!--������ʼ-->
<div class="top">
	<ul class="title1">
		<a href="sensorberth.do?action=sensorgraph" class="sel_fee" style="margin-left:10px;">ͼ��</a><a class="sel_fee column" style="margin-left:-1px;">�б�</a>
	</ul>
</div>

<!--��������-->
<div id="cityberthobj" style="width:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var sensor_states = [{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"��������"},{"value_no":"1","value_name":"�����쳣"}];
var states = [{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"����"},{"value_no":"1","value_name":"��ͣ"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false,shide:true,hide:true,fhide:true},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",twidth:"90",noList:parks,target:"berthsec_id",action:"getberthseg",height:"",issort:false},
		{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"120" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'berthsec_id');
			}},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"80" ,height:""},
		{fieldcnname:"���������",fieldname:"did",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������ѹ",fieldname:"battery",fieldvalue:'',inputtype:"text", twidth:"90" ,height:"",hide:true,shide:true},
		{fieldcnname:"������״̬",fieldname:"sensor_state",fieldvalue:'',inputtype:"select",noList:sensor_states, twidth:"90" ,height:"",hide:true,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>�����쳣</font>";
				else 
					return "��������";
			}},
		{fieldcnname:"�������ʱ��",fieldname:"heartbeat_time",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",hide:true,shide:true},
		{fieldcnname:"ռ��״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:states, twidth:"90" ,height:"",hide:true,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='#1BA39C'>��ͣ</font>";
				else 
					return "����";
			}},
		{fieldcnname:"����������볡ʱ��",fieldname:"sensor_in_time",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",shide:true},
		{fieldcnname:"POS����¼�볡ʱ��",fieldname:"order_in_time",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",edit:false,hide:true,shide:true},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false,hide:true,shide:true,issort:false}
	];
var rules =[
		{name:"berthsec_id",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _cityberthT = new TQTable({
	tabletitle:"",
	ischeck:false,
	tablename:"cityberth_tables",
	dataUrl:"sensorberth.do",
	iscookcol:false,
	isodbyserver:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityberthobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityberthT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"sensor_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "sensor_search_f",
					formObj:tObj,
					formWinId:"sensor_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensor_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityberthT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(bts.length>0)
		return bts;
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		var url = "";
		if(colname == "berthsec_id"){
			url = "cityberthseg.do?action=getberthseg&id="+value;
		}else if(colname == "dici_id"){
			url = "cityberth.do?action=getdici&id="+value;
		}
		T.A.C({
			url:url,
    		method:"GET",//POST or GET
    		param:"",//GETʱΪ��
    		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
    		dataType:"0",//0text,1xml,2obj
    		success:function(ret,tipObj,thirdParam){
    			if(ret){
					updateRow(pid,colname,ret);
    			}
				else
					updateRow(pid,colname,value);
			},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
    		failure:function(ret,tipObj,thirdParam){
				return false;
			},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
    		thirdParam:"",//�ص������еĵ���������
    		tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
    		waitTip:"���ڻ�ȡ����...",
    		noCover:true
		})
	}else{
		return "��"
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_cityberthT.UCD(rowid,name,value);
}

_cityberthT.C();
</script>
<script type="text/javascript">
var height = document.body.clientHeight;
document.getElementById("cityberthobj").style.height = (height - 40 - 15)+"px";
</script>
</body>
</html>
