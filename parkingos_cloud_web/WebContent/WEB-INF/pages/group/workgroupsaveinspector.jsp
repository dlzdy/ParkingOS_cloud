<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���沴λ��</title>
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
<div id="savinspectorobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">

/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var work_group_id = "${work_group_id}";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",hide:true},
		{fieldcnname:"Ѳ��Ա����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false}
		
	];
var _savinspectorT = new TQTable({
	tabletitle:"����Ѳ��Ա",
	//ischeck:false,
	tablename:"savinspector_tables",
	dataUrl:"workgroupmanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=queryallinspector",
	tableObj:T("#savinspectorobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bts =[];
	bts.push({ dname:  "����", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _savinspectorT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ��Ѳ��Ա",2,"");
			return;
		}
		Twin({Id:"send_message_w",Title:"����Ѳ��Ա",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"workgroupmanage.do?action=insertinspector&work_group_id="+work_group_id,
				method:"POST",
				Coltype:2,
				dbuttonname:["����"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"Ѳ��Ա���",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"����ɹ���",2,"");
						TwinC("send_message_w");
						_savinspectorT.C();
						window.parent._workgroupinspectorT.C();
					}else{
						T.loadTip(1,"����ʧ�ܣ�",2,o);
						TwinC("send_message_w");
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
_savinspectorT.C();
window.parent._savinspectorT.M();
</script>

</body>
</html>
