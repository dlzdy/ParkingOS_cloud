<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�Խ�����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
<script src="js/monitor/test.js" type="text/javascript"></script>
<script src="js/jquery.js" type="text/javascript">//jquery</script>
<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
</head>
<style type="text/css">
	.back_btn{
		float:right; 
		height:20px;
		width:21px;
		margin-top:2px;
		margin-right:5px;
		text-align:center;
		line-height:20px;
		vertical-align:middle;
		background-position:-21px 0px;
		cursor:default;
	}
	.back_span{
		padding-left:3px;color:#c00;
		float:right;
	}
</style>
<body>

<div id="monitorobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false];
//var ownsubauth=authlist.split(",");
for(var i=0;i<6;i++){
	subauth[i]=true;
}
var parks = eval(T.A.sendData("monitor.do?action=qryParks"));
var monitors = eval(T.A.sendData("monitor.do?action=qryMonitors"));
var parkSign = '${loginSign}' == "park";
//���
var _addMonitorField = [
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"130" ,height:""},
		{fieldcnname:"�ֻ���",fieldname:"tele_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect", noList:parks,target:"monitor_id",action:"getMonitors",twidth:"100" ,height:"",hide:parkSign,fhide:parkSign},
		{fieldcnname:"����������",fieldname:"park_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"����������",fieldname:"group_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"�������",fieldname:"monitor_id",fieldvalue:'',inputtype:"cselect", noList:monitors,twidth:"130" ,height:""},
	];
//չʾ
var _showMonitorField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"130" ,height:""},
		{fieldcnname:"�ֻ���",fieldname:"tele_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect", noList:parks,target:"monitor_id",action:"getMonitors",twidth:"100" ,height:"",hide:parkSign,fhide:parkSign},
		{fieldcnname:"����������",fieldname:"park_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"����������",fieldname:"group_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"�������",fieldname:"monitor_id",fieldvalue:'',inputtype:"cselect", noList:monitors,twidth:"130" ,height:""},
	];
//��ѯ
var _qryMonitorField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"130" ,height:""},
		{fieldcnname:"�ֻ���",fieldname:"tele_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect", noList:parks,target:"monitor_id",action:"getMonitors",twidth:"100" ,height:"",shide:parkSign},
		{fieldcnname:"����������",fieldname:"park_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"����������",fieldname:"group_phone",fieldvalue:'',inputtype:"number", twidth:"130" ,height:""},
		{fieldcnname:"�������",fieldname:"monitor_id",fieldvalue:'',inputtype:"cselect", noList:monitors,twidth:"130" ,height:""},
	];	
var _phoneT = new TQTable({
	//tabletitle:"���������",
	ischeck:false,
	tablename:"monitor_tables",
	dataUrl:"monitor.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickqueryPhone",
	tableObj:T("#monitorobj"),
	fit:[true,true,true],
	tableitems:_showMonitorField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts = [];
	if(subauth[0]){
		bts.push({dname:"�½�",icon:"edit_add.png",onpress:function(Obj){
			T.each(_phoneT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			});
			Twin({Id:"monitorpingmarket_add",Title:"��Ӽ����",Width:550,sysfun:function(tObj){
					Tform({
						formname: "monitorpingmarket_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"monitor.do?action=createPhone",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_addMonitorField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("monitorpingmarket_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("monitorpingmarket_add");
								_phoneT.M();
							}else{
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			})
		
		}});
	}		
	if(subauth[1]){
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
			T.each(_phoneT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			});
			Twin({Id:"monitor_search_w",Title:"�����Խ�",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "monitor_search_f",
					formObj:tObj,
					formWinId:"monitor_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_qryMonitorField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("monitor_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_phoneT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=qryPhone&"+Serializ(formName)
						})
					}
				});	
			  }
			})
		}});
	}
	return bts;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_phoneT.tc.tableitems,function(o,j){
			o.fieldvalue = _phoneT.GD(id)[j]
		});
		Twin({Id:"monitor_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "monitor_edit_f",
					formObj:tObj,
					recordid:"monitor_id",
					suburl:"monitor.do?action=editPhone&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_phoneT.tc.tableitems}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("monitor_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("monitor_edit_"+id);
							_phoneT.M();
						}else{
							T.loadTip(1,"�༭ʧ�ܣ�",2,o)
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
		bts.push({name:"ɾ��",fun:function(id){
			var id_this = id ;
			Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("monitor.do?action=delPhone","post","selids="+id_this,
				function deletebackfun(ret){
					if(ret=="1"){
						T.loadTip(1,"ɾ���ɹ���",2,"");
						_phoneT.M()
					}else{
						T.loadTip(1,ret,2,"");
					}
				}
			)}})
		}});
	if(bts.length <= 0){return false;}
	return bts;
}
_phoneT.C();

/*$(function(){
	$("#monitor_tables_title_div").append("<div id=\"backDiv\" class=\"back_btn\" title=\"����\" style=\"background-position: -21px 0px;\" onclick=\"parent.document.getElementById(\'monitorManagerDiv\').style.visibility = \'hidden\'\"><img src='images/monitor/back.jpg' style='backgroud-color: #FFFFCC ' width='21px' height='20px'></img></div>");
});*/

</script>

</body>
</html>
