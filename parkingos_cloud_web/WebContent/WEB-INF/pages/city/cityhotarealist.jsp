<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ȵ��������</title>
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
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<div id="hotareamanageobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
//�鿴,���,�༭,ɾ��,����
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var users = eval(T.A.sendData("getdata.do?action=getorgusers&cityid=${cityid}"));

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ",fieldname:"adress",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"reason",fieldvalue:'',inputtype:"text",twidth:"100",height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�½�"},{"value_no":1,"value_name":"ɾ��"}],twidth:"100",height:"",issort:false},
		{fieldcnname:"�½�����",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"������",fieldname:"create_user",fieldvalue:'',inputtype:"select",noList:users,twidth:"120" ,height:"",issort:false,hide:true}
	];
var _hotareamanageT = new TQTable({
	tabletitle:"�ȵ��������",
	ischeck:false,
	tablename:"hotareamanage_tables",
	dataUrl:"hotareamanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#hotareamanageobj"),
	fit:[true,true,true],
	tableitems:_mediaField, 
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_hotareamanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"pos_search_w",Title:"�����ȵ����",Width:550,sysfun:function(tObj){
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
						_hotareamanageT.C({
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
		bts.push({dname:"����ȵ����",icon:"edit_add.png",onpress:function(Obj){
		T.each(_hotareamanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"hotareamanage_add",Title:"�������ͷ",Width:550,sysfun:function(tObj){
				Tform({
					formname: "hotareamanage_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"hotareamanage.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("hotareamanage_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("hotareamanage_add");
							_hotareamanageT.M();
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
	if(subauth[4])
	bts.push({dname:"�����ȵ����",icon:"edit_add.png",onpress:function(Obj){
				T.each(_hotareamanageT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"hotarea_search_w",Title:"�����ȵ����",Width:480,sysfun:function(tObj){
						 TSform ({
							formname: "hotarea_export_f",
							formObj:tObj,
							formWinId:"hotarea_export_w",
							formFunId:tObj,
							dbuttonname:["ȷ�ϵ���"],
							formAttr:[{
								formitems:[{kindname:"",kinditemts:_mediaField}]
							}],
							SubAction:
							function(callback,formName){
								T("#exportiframe").src="hotareamanage.do?action=export&fieldsstr=id__state__name__adress__reason__create_time__create_user"+Serializ(formName)
								TwinC("hotarea_search_w");
								T.loadTip(1,"���ڵ��������Ժ�...",2,"");
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
	if(subauth[5])
	bts.push({name:"�󶨳���",fun:function(id){
		Twin({
			Id:"hotareamanage_detail_"+id,
			Title:"�󶨳���  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"hotareamanage.do?action=parkdetail&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_hotareamanageT.tc.tableitems,function(o,j){
			o.fieldvalue = _hotareamanageT.GD(id)[j]
		});
		Twin({Id:"hotareamanage_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "hotareamanage_edit_f",
					formObj:tObj,
					recordid:"hotareamanage_id",
					suburl:"hotareamanage.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_hotareamanageT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("hotareamanage_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("hotareamanage_edit_"+id);
							_hotareamanageT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("hotareamanage.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_hotareamanageT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}


_hotareamanageT.C();
</script>

</body>
</html>
