<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����Ʋ�����־</title>
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
<div id="parklogsobj" style="width:100%;height:100%;margin:0px;"></div>
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
var operateType = [{value_no:-1,value_name:"ȫ��"},{value_no:0,value_name:"��¼"},{value_no:1,value_name:"�˳�"},{value_no:2,value_name:"���"}
	,{value_no:3,value_name:"�༭"},{value_no:4,value_name:"ɾ��"},{value_no:5,value_name:"����"},{value_no:6,value_name:"����"}];
var oType=eval(T.A.sendData("parklogs.do?action=getOtype"));
var role=${role};
var comid=${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��־���",fieldname:"log_id",fieldvalue:'',inputtype:"text",twidth:"80" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"operate_time",fieldvalue:'',inputtype:"date",twidth:"180" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"content",fieldvalue:'',inputtype:"text",twidth:"280" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"operate_user",fieldvalue:'',inputtype:"text",noList:operateType,twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false}
	];
var _parklogsT = new TQTable({
	tabletitle:"ϵͳ��־",
	ischeck:false,
	tablename:"parklogs_tables",
	dataUrl:"parklogs.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#parklogsobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
 	var bts=[];
 	/*if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parklogsT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parklogs_search_w",Title:"����������¼",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parklogs_search_f",
					formObj:tObj,
					formWinId:"parklogs_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parklogs_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_parklogsT.C({
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
		Twin({Id:"parklogs_export_w",Title:"����<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "parklogs_export_f",
					formObj:tObj,
					formWinId:"parklogs_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="parklogs.do?action=export&comid="+comid+"&"+Serializ(formName)
						TwinC("parklogs_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}});*/
	return bts;
}


function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}

_parklogsT.C();
</script>

</body>
</html>
