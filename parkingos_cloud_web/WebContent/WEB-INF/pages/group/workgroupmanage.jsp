<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���������</title>
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
<div id="workgroupmanageobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var statelist = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"�շ�������",fieldname:"workgroup_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
	    {fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,edit:false,hide:true},
	    {fieldcnname:"�Ƿ����",fieldname:"is_active",fieldvalue:'',inputtype:"select",noList:statelist,twidth:"100" ,height:"",issort:false,hide:true}

	];
var _edit=[
		{fieldcnname:"�շ�������",fieldname:"workgroup_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
	    {fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true},
	    {fieldcnname:"�Ƿ����",fieldname:"is_active",fieldvalue:'',inputtype:"select",noList:statelist,twidth:"100" ,height:"",issort:false}
		
	];
/* var rules =[
		{name:"berthsec_name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		{name:"comid",requir:true}
		]; */

var _workgroupmanageT = new TQTable({
	tabletitle:"�շ������",
	ischeck:false,
	tablename:"workgroupmanage_tables",
	dataUrl:"workgroupmanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#workgroupmanageobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	bts.push({dname:"����շ���",icon:"edit_add.png",onpress:function(Obj){
				T.each(_workgroupmanageT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"workgroupmanage_add",Title:"����շ���",Width:550,sysfun:function(tObj){
					Tform({
						formname: "group_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"workgroupmanage.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}],
							
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("workgroupmanage_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("workgroupmanage_add");
								_workgroupmanageT.M();
							}else if(ret=="-1"){
								T.loadTip(1,"��ѡ�񳵳� ��",2,"");
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
		/*T.each(_cityberthsegT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityberthsegT.GD(id)[j];
		});*/
		
		var workgroup_name = _workgroupmanageT.GD(id,"workgroup_name");
		var is_active = _workgroupmanageT.GD(id,"is_active");
	
		
		Twin({Id:"workgroupmanage_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "workgroupmanage_edit_f",
					formObj:tObj,
					recordid:"workgroupmanage_id",
					suburl:"workgroupmanage.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_edit}],
					
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("workgroupmanage_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("workgroupmanage_edit_"+id);
							_workgroupmanageT.M()
						}else if(ret=="-1"){
								T.loadTip(1,"��ѡ�񳵳� ��",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			
				T("#workgroupmanage_edit_f_workgroup_name").value=workgroup_name;
				T("#workgroupmanage_edit_f_is_active").value=is_active;
				
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("workgroupmanage.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_workgroupmanageT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	if(subauth[4])
	bts.push({name:"�󶨲�λ��",fun:function(id){
		Twin({
			Id:"bethsec_detail_"+id,
			Title:"�󶨲�λ��  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"workgroupmanage.do?action=addberthsec&work_group_id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(subauth[4])
	bts.push({name:"���շ�Ա",fun:function(id){
		Twin({
			Id:"employee_detail_"+id,
			Title:"���շ�Ա  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"workgroupmanage.do?action=addemployee&work_group_id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
//	if(subauth[4])
//		bts.push({name:"��Ѳ��Ա",fun:function(id){
//			Twin({
//				Id:"inspector_detail_"+id,
//				Title:"��Ѳ��Ա  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
//				Content:"<iframe src=\"workgroupmanage.do?action=addinspector&work_group_id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
//				Width:T.gww()-100,
//				Height:T.gwh()-50
//			})
//		}});
	if(bts.length <= 0){return false;}
	return bts;
}

	
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_workgroupmanageT.UCD(rowid,name,value);
}
_workgroupmanageT.C();
</script>

</body>
</html>
