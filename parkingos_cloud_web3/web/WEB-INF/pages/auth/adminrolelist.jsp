<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ɫ����</title>
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
<div id="adminroleobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var func = [{"value_no":-1,"value_name":"��"},{"value_no":1,"value_name":"�շѹ���"},
            {"value_no":2,"value_name":"Ѳ�鹦��"},{"value_no":3,"value_name":"��������"}];
//�鿴,���,�༭,ɾ��,�༭Ȩ��
/*Ȩ��*/
var _mediaField = [
		{fieldcnname:"��ɫ���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"role_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"func",fieldvalue:'',fieldvalue:'',inputtype:"select",noList:func,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"resume",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false}
	];
var tabtip = "��ɫ����";
var _adminroleT = new TQTable({
	tabletitle:tabtip,
	ischeck:false,
	tablename:"adminrole_tables",
	dataUrl:"adminrole.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#adminroleobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	if(subauth[1])
	return [
		{dname:"��ӽ�ɫ",icon:"edit_add.png",onpress:function(Obj){
				T.each(_adminroleT.tc.tableitems,function(o,j){
					o.fieldvalue ="";
				});
				Twin({Id:"cartype_add",Title:"��ӽ�ɫ",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"adminrole.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cartype_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("cartype_add");
								_adminroleT.M();
							}else if(ret == "-2"){
								T.loadTip(1,"����ֻ��ѡ��һ��!",2,"");
							}else {
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			});
		}}
	]
	return false;
}
//�鿴,���,�༭,ɾ��,�༭Ȩ��
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_adminroleT.tc.tableitems,function(o,j){
			o.fieldvalue = _adminroleT.GD(id)[j]
		});
		Twin({Id:"cartype_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "cartype_edit_f",
					formObj:tObj,
					recordid:"cartype_id",
					suburl:"adminrole.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_adminroleT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cartype_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("cartype_edit_"+id);
							_adminroleT.M()
						}else if(ret == "-2"){
							T.loadTip(1,"����ֻ��ѡ��һ��!",2,"");
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push(
	{name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("adminrole.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_adminroleT.M()
				}else if(ret=="-1"){
					T.loadTip(1,"�ý�ɫ����ʹ���У�����ɾ����",2,"");
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[4])
	bts.push(
	{name:"�༭Ȩ��",
		fun:function(id){
			Twin({
				Id:"edit_role"+id,
				Title:"Ȩ������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
				Content:"<iframe src=\"adminrole.do?action=editrole&roleid="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
				Width:T.gww()-300,
				Height:T.gwh()-200
			})
			
		}});
	bts.push(
	{name:"�շ�����",
		fun:function(id){
			Twin({
				Id:"collector_set"+id,
				Title:"�շ�����  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
				Content:"<iframe src=\"adminrole.do?action=precollectset&roleid="+id+"\" style=\"width:100%;height:100%;over-flow:auto\" frameborder=\"0\"></iframe>",
				Width:T.gww()/2,
				Height:T.gwh()/2+100
			})
			
		}});
		bts.push(
			{name:"�ϰ�ʱ��",
				fun:function(id){
					Twin({
						Id:"collector_set"+id,
						Title:"�ϰ�ʱ��  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
						Content:"<iframe src=\"worktime.do?role_id="+id+"\" style=\"width:100%;height:100%;over-flow:auto\" frameborder=\"0\"></iframe>",
						Width:T.gww()-100,
						Height:T.gwh()-50
					});	
		}});
	if(bts.length <= 0){return false;}
	return bts;
}


_adminroleT.C();
</script>

</body>
</html>
