<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�յ�������</title>
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
<div id="induceobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"}];
var _mediaField=[
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"�յ�������",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"Ӳ�����",fieldname:"did",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�յ���״̬",fieldname:"induce_state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"80" ,height:"",issort:false,edit:false,hide:true,shide:true,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>����</font>";
				else 
					return "����";
			}},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false,fhide:true,hide:true},
		{fieldcnname:"������¼",fieldname:"hcount",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",edit:false,shide:true,hide:true,
			process:function(value,cid,id){
					return "<a href=# onclick=\"viewdetail('h','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
				}},
		{fieldcnname:"��Ϣ",fieldname:"ad",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false,shide:true,hide:true},
		{fieldcnname:"��Ϣ��Чʱ��",fieldname:"begin_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true,shide:true},
		{fieldcnname:"��Ϣ����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true,shide:true},
		{fieldcnname:"��Ϣ����ʱ��",fieldname:"publish_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true,shide:true},
		{fieldcnname:"����״̬",fieldname:"isactive",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�ѷ���"}] , twidth:"100" ,height:"",issort:false,hide:true,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>�ѷ���</font>";
				else 
					return "δ����";
			}},
		{fieldcnname:"�������ʱ��",fieldname:"heartbeat_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"200" ,height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,shide:true,fhide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,shide:true,fhide:true},
		{fieldcnname:"�յ�������ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"�յ����޸�ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"�յ���������",fieldname:"creator_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,hide:true,shide:true},
		{fieldcnname:"�յ����޸���",fieldname:"update_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,hide:true,shide:true}
	];
	
var _ad = [
		{fieldcnname:"��Ϣ",fieldname:"ad",fieldvalue:'',inputtype:"multi",twidth:"150" ,height:"100",issort:false},
		{fieldcnname:"��Ϣ��Чʱ��",fieldname:"begin_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��Ϣ����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false}
	];
	
var _induceT = new TQTable({
	tabletitle:"�յ�������",
//	ischeck:false,
	tablename:"induce_tables",
	dataUrl:"inducel2.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&type=${type}",
	tableObj:T("#induceobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	bts.push({dname:"����յ���",icon:"edit_add.png",onpress:function(Obj){
				T.each(_induceT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"induce_add",Title:"����յ���",Width:550,sysfun:function(tObj){
					Tform({
						formname: "induce_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"inducel2.do?action=create&type=${type}",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("induce_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("induce_add");
								_induceT.M();
							}if(ret=="-2"){
								T.loadTip(1,"Ӳ������ظ��ˣ�",2,"");
							}else {
								T.loadTip(1,ret,7,o);
							}
						}
					});	
				}
			});
		}});
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_induceT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"induce_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "induce_search_f",
					formObj:tObj,
					formWinId:"induce_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("induce_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_induceT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&type=${type}&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(subauth[7])
	bts.push({ dname: "��������", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _induceT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ���յ���",2,"");
			return;
		}
		Twin({Id:"send_message_w",Title:"��������",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"inducel2.do?action=bathpublish",
				method:"POST",
				Coltype:2,
				dbuttonname:["��������"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"�յ������",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"�����ɹ���",2,"");
						TwinC("send_message_w");
						_induceT.M();
					}else if(ret == "-2"){
						T.loadTip(1,"������ѡ��һ��δ�������յ���!",2,o);
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
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_induceT.tc.tableitems,function(o,j){
			o.fieldvalue = _induceT.GD(id)[j];
		});
		Twin({Id:"induce_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "induce_edit_f",
					formObj:tObj,
					recordid:"induce_id",
					suburl:"inducel2.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_induceT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("induce_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("induce_edit_"+id);
							_induceT.M();
						}if(ret=="-2"){
							T.loadTip(1,"Ӳ������ظ��ˣ�",2,"");
						}else{
							T.loadTip(1,ret,7,o);
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("inducel2.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_induceT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(false)
	bts.push({name:"�󶨳���",fun:function(id){
		Twin({
			Id:"induce_detail_"+id,
			Title:"�󶨳���  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"inducel2.do?action=parkdetail&induce_id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(subauth[5])
	bts.push({name:"�༭��Ϣ",fun:function(id){
		var induce_id = _induceT.GD(id,"id");
		var ad = _induceT.GD(id,"ad");
		var begin_time = _induceT.GD(id,"begin_time");
		var end_time = _induceT.GD(id,"end_time");
		Twin({Id:"induce_ad_"+id,Title:"�༭��Ϣ",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "induce_ad_f",
					formObj:tObj,
					recordid:"induce_id",
					suburl:"inducel2.do?action=editad&induce_id="+induce_id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_ad}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("induce_ad_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("induce_ad_"+id);
							_induceT.M();
						}else{
							T.loadTip(1,ret,7,o)
						}
					}
				});	
				T("#induce_ad_f_ad").value=ad;
				T("#induce_ad_f_begin_time").value=begin_time;
				T("#induce_ad_f_end_time").value=end_time;
			}
		})
	}});
	if(subauth[6])
	bts.push({name:"��ʾ����",fun:function(id){
		Twin({
			Id:"induce_detail_"+id,
			Title:"��ʾ����  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"inducemodule.do?induce_id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(subauth[7])
	bts.push({name:"����",
		rule:function(id){
			var isactive =_induceT.GD(id,"isactive");
			if(isactive==0){//״̬������
				this.name="����";
				return true;
			}else{
				return false;
			}
		 },
		fun:function(id){
			var id_this = id ;
			var isactive =_induceT.GD(id,"isactive");
			var conmessage="�ѷ���";
			if(isactive==0){//״̬������
				conmessage="����";
				
				Tconfirm({Title:"ȷ��"+conmessage+"��",Content:"ȷ��"+conmessage+"��",OKFn:function(){T.A.sendData("inducel2.do?action=publish","post","induce_id="+id_this,
					function deletebackfun(ret){
						if(ret=="1"){
							T.loadTip(1,conmessage+"�ɹ���",2,"");
							_induceT.M();
						}else{
							T.loadTip(1,ret,2,"");
						}
					}
				)}});
			}
	}});
	if(bts.length <= 0){return false;}
	return bts;
}

function viewdetail(type,value,id){
	var induce_id =_induceT.GD(id,"id");
	var name = _induceT.GD(id,"name");
	var tip = "�յ�����"+name;
	var url = "";
	if(type == "h"){
		url = "inducel2.do?action=hisdetail&induce_id="+induce_id;
	}
	Twin({
		Id:"induce_detail_"+id,
		Title:tip,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='induce_detail_'"+id+" id='induce_detail_'"+id+" src='"+url+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function setname(value, list){
	if(value != "-1"){
		for(var i=0; i<list.length;i++){
			var o = list[i];
			var key = o.value_no;
			var v = o.value_name;
			if(value == key){
				return v;
			}
		}
	}else{
		return "";
	}
}

_induceT.C();
</script>

</body>
</html>
