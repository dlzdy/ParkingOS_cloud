<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������������־</title>
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
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>
<body>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<div id="sensorlogobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var issupperadmin=${supperadmin};
var authlist ="";
if(issupperadmin&&issupperadmin==1)
	authlist="0,1";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/
var users = eval(T.A.sendData("getdata.do?action=getuserbyuin"));
var operateType = [{value_no:-2,value_name:"ȫ��"},{value_no:-1,value_name:"δ֪"},{value_no:0,value_name:"����"},{value_no:1,value_name:"ռ��"}];
var oType=eval(T.A.sendData("sensorlog.do?action=getOtype"));
var role=${role};
var comid=${comid};
var _mediaField = [
		{fieldcnname:"���������",fieldname:"sensornumber",fieldvalue:'',inputtype:"text",twidth:"" ,height:"",issort:false},
		{fieldcnname:"��վ���",fieldname:"transmitternumber",fieldvalue:'',inputtype:"text",twidth:"" ,height:"",issort:false},
		{fieldcnname:"���ݵ�ѹ",fieldname:"magnetism",fieldvalue:'',inputtype:"number",twidth:"" ,height:"",issort:false,
			process:function(value,pid){
				if(value=='0') return "-";
				else return value;
			}},
		{fieldcnname:"��ص�ѹ",fieldname:"battery",fieldvalue:'',inputtype:"number",twidth:"" ,height:"",issort:false,
				process:function(value,pid){
					if(value=='0') return "-";
					else return value;
				}},
		{fieldcnname:"״̬",fieldname:"parkstatus",fieldvalue:'',inputtype:"select",noList:operateType,twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"ctime",fieldvalue:'',inputtype:"date",twidth:"" ,height:"",issort:false}
	];
var _sensorlogT = new TQTable({
	tabletitle:"������������־",
	ischeck:false,
	tablename:"sensorlog_tables",
	dataUrl:"sensorlog.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#sensorlogobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
 	var bts=[];
 	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_sensorlogT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"sensorlog_search_w",Title:"����������¼",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "sensorlog_search_f",
					formObj:tObj,
					formWinId:"sensorlog_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensorlog_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_sensorlogT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
		bts.push({dname:"������־",icon:"toxls.gif",onpress:function(Obj){
		Twin({Id:"sensorlog_export_w",Title:"����<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "sensorlog_export_f",
					formObj:tObj,
					formWinId:"sensorlog_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="sensorlog.do?action=export&comid="+comid+"&"+Serializ(formName)
						TwinC("sensorlog_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}});
	return bts;
}


function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}

_sensorlogT.C();
</script>

</body>
</html>
