<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="renderer" content="webkit">
<title>�澯����</title>
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
.sel_fee{
	text-align: center;
    /* padding-top: 0px; */
    /* padding-bottom: 0px; */
    border-radius: 0px;
    background-color: #FFFFFF;
    outline: medium;
    border: 1px solid #5CCDBE;
    color: #5CCDBE;
    padding-left: 8px;
    padding-right: 8px;
    font-size: 12px;
    height: 24px;
    margin-top: 3px;
    line-height: 24px;
}
a:hover{
	background:#5CCDBE;
	color:#FFFFFF;
}
</style>
</head>
<body>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<div id="alerteventobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var users = eval(T.A.sendData("getdata.do?action=getorgusers&cityid=${cityid}"));

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"��Դ",fieldname:"source",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�½�"},{"value_no":1,"value_name":"�����"},{"value_no":2,"value_name":"�ѷ���"},{"value_no":3,"value_name":"��ȡ��"}],twidth:"100",height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"һ��"},{"value_no":2,"value_name":"����"},{"value_no":3,"value_name":"����"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"content",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"handle_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"������",fieldname:"handle_user",fieldvalue:'',inputtype:"select",noList:users,twidth:"120" ,height:"",issort:false,hide:true}
	];
var back = "";
if("${from}" == "index"){
	back = "<a href='cityindex.do?authid=${index_authid}' class='sel_fee' style='float:right;margin-right:20px;'>����</a>";
}
var _alerteventT = new TQTable({
	tabletitle:"�澯����"+back,
	ischeck:false,
	tablename:"alertevent_tables",
	dataUrl:"alertevent.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#alerteventobj"),
	fit:[true,true,true],
	tableitems:_mediaField, 
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
		bts.push({dname:"��Ӹ澯�¼�",icon:"edit_add.png",onpress:function(Obj){
		T.each(_alerteventT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"alertevent_add",Title:"��Ӹ澯�¼�",Width:550,sysfun:function(tObj){
				Tform({
					formname: "alertevent_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"alertevent.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("alertevent_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("alertevent_add");
							_alerteventT.M();
						}else if(ret==0){
							T.loadTip(1,"���ʧ�ܣ����Ժ����ԣ�",2,"");
						}else{
							T.loadTip(1,"���ʧ�ܣ�",2,"");
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(subauth[2])
	bts.push({dname:"�����澯",icon:"edit_add.png",onpress:function(Obj){
				T.each(_alerteventT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"parkwithdraw_search_w",Title:"�����澯",Width:480,sysfun:function(tObj){
						 TSform ({
							formname: "parkwithdraw_export_f",
							formObj:tObj,
							formWinId:"parkwithdraw_export_w",
							formFunId:tObj,
							dbuttonname:["ȷ�ϵ���"],
							formAttr:[{
								formitems:[{kindname:"",kinditemts:_mediaField}]
							}],
							SubAction:
							function(callback,formName){
								T("#exportiframe").src="alertevent.do?action=export&fieldsstr=id__state__type__resoure__content__handle_time__handle_user"+Serializ(formName)
								TwinC("parkwithdraw_search_w");
								T.loadTip(1,"���ڵ��������Ժ�...",2,"");
							}
						});	
					}
				})
		}});
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_alerteventT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"pos_search_w",Title:"�����澯",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "pos_search_f",
					formObj:tObj,
					formWinId:"pos_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("pos_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_alerteventT.C({
							cpage:1,
							tabletitle:"�߼��������"+back,
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
	if(subauth[3])
	bts.push({name:"����",fun:function(id){
		Tconfirm({Title:"ȷ�Ϸ�����",Content:"ȷ�Ϸ�����",
			OKFn:function(){
				var state = _alerteventT.GD(id,"state");
				if(state==2){
					T.loadTip(1,"�Ѿ���������",2,"");
					return;
				}
				T.A.sendData("alertevent.do?action=send","post","id="+id,
				function deletebackfun(ret){
					if(ret=="1"){
						T.loadTip(1,"�Ѿ�������",2,"");
						_alerteventT.M()
					}else{
						T.loadTip(1,ret,2,"");
					}
				}
		)}})
	}});
	/*if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("alertevent.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_alerteventT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});*/
	
	if(bts.length <= 0){return false;}
	return bts;
}


_alerteventT.C();
</script>

</body>
</html>
