<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ͻ�����</title>
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
</head>
<body>
<div id="carowerobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">

/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴 ��֤ ���Ͷ��� ��˳���
var role=${role};
function getbonustypes (){
	var bonustypes = eval(T.A.sendData("getdata.do?action=getbonustypes"));
	return bonustypes;
}
var bonustypes =getbonustypes();
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",hide:true},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"ע������",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"�����¼����",fieldname:"logon_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"ý����Դ",fieldname:"media",fieldvalue:'',inputtype:"select", noList:bonustypes ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"΢�Ź��ں�",fieldname:"wxp_openid",fieldvalue:'',inputtype:"text", twidth:"250" ,height:"",issort:false},
		{fieldcnname:"�ͻ���",fieldname:"client_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"Android"},{"value_no":1,"value_name":"Ios"}] ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�汾��",fieldname:"version",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true}
	];
var _carowerT = new TQTable({
	tabletitle:"��Ա����",
	//ischeck:false,
	tablename:"carower_tables",
	dataUrl:"citycarowner.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#carowerobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bts =[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carowerT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carower_search_w",Title:"�����ͻ�",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "carower_search_f",
					formObj:tObj,
					formWinId:"carower_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carower_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_carowerT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
	bts.push({ dname:  "���Ͷ���", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _carowerT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ���ֻ�",2,"");
			return;
		}
		Twin({Id:"send_message_w",Title:"���Ͷ���",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"carower.do?action=sendmesg",
				method:"POST",
				Coltype:2,
				dbuttonname:["����"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"�ͻ����",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false},
					{fieldcnname:"��������",fieldname:"message",fieldvalue:'',inputtype:"multi",height:"100",issort:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"���ͳɹ���",2,"");
						TwinC("send_message_w");
					}else{
						T.loadTip(1,"����ʧ��",2,o);
					}
				}
			});	
			}
		})
		
	}})
	
	if(bts.length>0)
		return bts;
	else 
		return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_carowerT.C();
</script>

</body>
</html>
