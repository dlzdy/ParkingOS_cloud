<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�շ�Ա��־</title>
<link href="css/zTreeStyle1.css" rel="stylesheet" type="text/css">
<link href="css/demo.css" rel="stylesheet" type="text/css">
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
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="js/echarts/echarts.js"></script>
<style type="text/css">
	body{
		overflow:auto 
	}
</style>

</head>
<body>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<div id="employeelogsobj" style="width:100%;height:100%;margin:0px;"></div>

<script type="text/javascript" >   
var btime="${btime}";
var etime="${etime}";
var parks =eval(T.A.sendData("getdata.do?action=getparksbygroup&id=${groupid}"));
var users=eval(T.A.sendData("getdata.do?action=getcollectbygroupid&groupid=${groupid}"));
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ǩ��"},{"value_no":1,"value_name":"ǩ��"}];
var logon_state = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"�ٵ�"}];
var logoff_state = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"number",twidth:"100" ,issort:false,fhide:true},
		{fieldcnname:"�շ�Ա",fieldname:"nickname",inputtype:"select",noList:users, twidth:"100" ,issort:false},
		{fieldcnname:"�˺�",fieldname:"uid",inputtype:"number", twidth:"200",issort:false},
		{fieldcnname:"ͣ����",fieldname:"comid",inputtype:"select",noList:parks, twidth:"100",issort:false},
		{fieldcnname:"��λ������",fieldname:"berthsec_name",inputtype:"text", twidth:"100",issort:false,shide:true},
		{fieldcnname:"״̬",fieldname:"state",inputtype:"select",noList:states, twidth:"50" ,issort:false},
		{fieldcnname:"ǩ������",fieldname:"start_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"ǩ��״̬",fieldname:"logon_state",inputtype:"select",noList:logon_state, twidth:"80" ,issort:false,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>�ٵ�</font>";
				else 
					return "����";
			}},
		{fieldcnname:"ǩ������",fieldname:"end_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"ǩ��״̬",fieldname:"logoff_state",inputtype:"select",noList:logoff_state, twidth:"80" ,issort:false,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>����</font>";
				else 
					return "����";
			}},
		{fieldcnname:"�豸���",fieldname:"device_code",inputtype:"text", twidth:"100",issort:false}
		];
var _exportField = [
		{fieldcnname:"�˺�",fieldname:"uid",inputtype:"number", twidth:"200",issort:false},
		{fieldcnname:"ǩ������",fieldname:"start_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"ǩ������",fieldname:"end_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"�豸���",fieldname:"device_code",inputtype:"text", twidth:"100",issort:false}
		];
var _employeelogsT = new TQTable({
	tabletitle:"�շ�Ա��־",
	ischeck:false,
	tablename:"employeelogs_tables",
	dataUrl:"employeelogs.do",
	iscookcol:false,  
	buttons:getAuthButtons(),
	//quikcsearch:coutomsearch(),
	param:"action=query&btime=${btime}&etime=${etime}",
	tableObj:T("#employeelogsobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_employeelogsT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"account_search_w",Title:"�����˻���ϸ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "account_search_f",
					formObj:tObj,
					formWinId:"account_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("account_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_employeelogsT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						});
					}
				});	
			}
		});
	
	}});
		bts.push({dname:"��������",icon:"toxls.gif",onpress:function(Obj){
			Twin({Id:"parklogs_export_w",Title:"��������<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
					 TSform ({
						formname: "parklogs_export_f",
						formObj:tObj,
						formWinId:"parklogs_export_w",
						formFunId:tObj,
						dbuttonname:["ȷ�ϵ���"],
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_exportField}],
						}],
						SubAction:
						function(callback,formName){
							T("#exportiframe").src="employeelogs.do?action=export&fieldsstr=uid__start_time__end_time__device_code&"+Serializ(formName)
							TwinC("parklogs_export_w");
							T.loadTip(1,"���ڵ��������Ժ�...",2,"");
						}
					});	
				}
			})
		}});
		return bts;
}
function coutomsearch(){
	 var html = "&nbsp;&nbsp; ǩ�����ڣ�<input id='coutom_btime' value='"+btime+"' style='width:120px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;-&nbsp; <input id='coutom_etime' value='"+etime+"' style='width:120px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				//"&nbsp;&nbsp;<input 
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html; 
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_employeelogsT.C();

</script>
</body>
</html>
