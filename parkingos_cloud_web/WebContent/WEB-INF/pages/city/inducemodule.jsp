<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ʾ�������</title>
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
<div id="moduleobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var induce_id = "${induce_id}";
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField=[
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"50" ,height:"",edit:false,issort:false,hide:true,shide:true,fhide:true},
		{fieldcnname:"��ʾ��������",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"�󶨵ĳ�������",fieldname:"pcount",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false,hide:true,edit:false,shide:true},
		{fieldcnname:"�������",fieldname:"sort",fieldvalue:'',inputtype:"text",noList:parks,twidth:"80" ,height:"",issort:false}
	];
	
var _moduleT = new TQTable({
	tabletitle:"��ʾ�������",
	ischeck:false,
	tablename:"module_tables",
	dataUrl:"inducemodule.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&induce_id="+induce_id,
	tableObj:T("#moduleobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	bts.push({dname:"�����ʾ����",icon:"edit_add.png",onpress:function(Obj){
				T.each(_moduleT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"module_add",Title:"�����ʾ����",Width:550,sysfun:function(tObj){
					Tform({
						formname: "module_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"inducemodule.do?action=create&induce_id="+induce_id,
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("module_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("module_add");
								_moduleT.M();
							}else {
								T.loadTip(1,ret,7,o);
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
	bts.push({name:"����",fun:function(id){
		T.each(_moduleT.tc.tableitems,function(o,j){
			o.fieldvalue = _moduleT.GD(id)[j];
		});
		Twin({Id:"module_edit_"+id,Title:"�������<span style='color:red;'>(����д�������֣�����ԽС���յ�������ʾԽ��ǰ)</span>",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "module_edit_f",
					formObj:tObj,
					recordid:"module_id",
					suburl:"inducemodule.do?action=editmodulesort&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("module_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("module_edit_"+id);
							_moduleT.M();
						}else if(ret=="-1"){
							T.loadTip(1,"�༭ʧ�� ��",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"�༭",fun:function(id){
		T.each(_moduleT.tc.tableitems,function(o,j){
			o.fieldvalue = _moduleT.GD(id)[j];
		});
		Twin({Id:"module_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "module_edit_f",
					formObj:tObj,
					recordid:"module_id",
					suburl:"inducemodule.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("module_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("module_edit_"+id);
							_moduleT.M();
						}else if(ret=="-1"){
							T.loadTip(1,"�༭ʧ�� ��",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("inducemodule.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_moduleT.M();
				}else if(ret=="-2"){
					T.loadTip(1,"���Ƚ�󳵳���",2,"");
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	bts.push({name:"��ͣ����",fun:function(id){
		var moduleid = _moduleT.GD(id,"id");
		Twin({
			Id:"module_detail_"+moduleid,
			Title:"��ͣ���� &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"inducemodule.do?action=tounbindpark&moduleid="+moduleid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	bts.push({name:"���ͣ����",fun:function(id){
		var moduleid = _moduleT.GD(id,"id");
		Twin({
			Id:"module_detail_"+id,
			Title:"���ͣ���� &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"inducemodule.do?action=tobindpark&moduleid="+moduleid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
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

_moduleT.C();
</script>

</body>
</html>
