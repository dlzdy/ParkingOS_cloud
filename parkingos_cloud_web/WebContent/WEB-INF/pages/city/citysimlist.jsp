<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>SIM������</title>
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
<div id="citysimobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var cityid = "${cityid}";
var groups = eval(T.A.sendData("getdata.do?action=getcitygroups&cityid="+cityid));
var _parentField = [//�����̻���¼��ʾ 
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"PIN",fieldname:"pin",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ���",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�״γ�ֵ��",fieldname:"money",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ײ͵���ʱ��",fieldname:"limit_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������Ӫ����",fieldname:"groupid",fieldvalue:'',inputtype:"select",noList:groups,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���豸����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"δ��"},{"value_no":1,"value_name":"POS��"},{"value_no":2,"value_name":"��վ"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���豸���",fieldname:"device_id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
					if(value == "-1"){
						return "";
					}else{
						return value;
					}
				}},
		{fieldcnname:"����ʱ��",fieldname:"allot_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true},
		{fieldcnname:"���ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true},
		{fieldcnname:"�����",fieldname:"nickname",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,hide:true}
	];
	
var _childField = [//��Ӫ���ŵ�¼��ʾ
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"PIN",fieldname:"pin",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ���",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�״γ�ֵ��",fieldname:"money",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ײ͵���ʱ��",fieldname:"limit_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���豸����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"δ��"},{"value_no":1,"value_name":"POS��"},{"value_no":2,"value_name":"��վ"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���豸���",fieldname:"device_id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
					if(value == "-1"){
						return "";
					}else{
						return value;
					}
				}},
		{fieldcnname:"����ʱ��",fieldname:"allot_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true},
		{fieldcnname:"���ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true},
		{fieldcnname:"�����",fieldname:"nickname",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,hide:true}
	];
var _mediaField = _childField;//Ĭ����ʾ��Ӫ���ŵ�����
if(cityid != "-1"){//�����̻���¼
	_mediaField = _parentField;
}
var _citysimT = new TQTable({
	tabletitle:"SIM������",
	ischeck:false,
	tablename:"citysim_tables",
	dataUrl:"citysim.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#citysimobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	bts.push({dname:"���SIM��",icon:"edit_add.png",onpress:function(Obj){
				T.each(_citysimT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"citysim_add",Title:"���SIM��",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"citysim.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("citysim_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("citysim_add");
								_citysimT.M();
							}else if(ret=="-1"){
								T.loadTip(1,"��ѡ����Ӫ���ţ�",2,"");
							}else if(ret=="-2"){
								T.loadTip(1,"��ѡ��󶨵��豸���ͣ�",2,"");
							}else {
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			});
		}});
	if(bts.length>0)
		return bts;
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_citysimT.tc.tableitems,function(o,j){
			o.fieldvalue = _citysimT.GD(id)[j]
		});
		Twin({Id:"citysim_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "citysim_edit_f",
					formObj:tObj,
					recordid:"citysim_id",
					suburl:"citysim.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_citysimT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("citysim_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("citysim_edit_"+id);
							_citysimT.M()
						}else if(ret=="-1"){
							T.loadTip(1,"��ѡ����Ӫ���ţ�",2,"");
						}else if(ret=="-2"){
							T.loadTip(1,"��ѡ��󶨵��豸���ͣ�",2,"");
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("citysim.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_citysimT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	if(bts.length <= 0){return false;}
	return bts;
}


_citysimT.C();
</script>

</body>
</html>
