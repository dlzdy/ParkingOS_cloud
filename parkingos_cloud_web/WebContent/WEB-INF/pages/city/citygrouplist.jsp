<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���Ź���</title>
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
<div id="citygroupobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var supperadmin = "${supperadmin}";
var channels = eval(T.A.sendData("getdata.do?action=getchans"));
var cities = eval(T.A.sendData("getdata.do?action=cities"));
var _parentField=[
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"chanid",fieldvalue:'',inputtype:"select",noList:channels,twidth:"100" ,height:"",issort:false,edit:false,
			process:function(value,pid){
					return setname(value,channels);
				}},
		{fieldcnname:"��������",fieldname:"cityid",fieldvalue:'',inputtype:"select",noList:cities,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"ͣ����"},{"value_no":1,"value_name":"���׮"},{"value_no":2,"value_name":"���г�"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����̱��",fieldname:"serverid",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true}
	];

var _childField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"ͣ����"},{"value_no":1,"value_name":"���׮"},{"value_no":2,"value_name":"���г�"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����̱��",fieldname:"serverid",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true}
	];
var _mediaField = _childField;
if(supperadmin == "1"){
	_mediaField = _parentField;
}
var _edit=[
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"ͣ����"},{"value_no":1,"value_name":"���׮"},{"value_no":2,"value_name":"���г�"}], twidth:"100" ,height:"",issort:false}
	];
var _citygroupT = new TQTable({
	tabletitle:"���Ź���",
	ischeck:false,
	tablename:"citygroup_tables",
	dataUrl:"citygroup.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#citygroupobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	bts.push({dname:"��Ӽ���",icon:"edit_add.png",onpress:function(Obj){
				T.each(_citygroupT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"citygroup_add",Title:"��Ӽ���",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"citygroup.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("citygroup_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("citygroup_add");
								_citygroupT.M();
							}else if(ret=='-2'){
								T.loadTip(1,"�����ظ���� ��",2,"");
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
		T.each(_citygroupT.tc.tableitems,function(o,j){
			o.fieldvalue = _citygroupT.GD(id)[j]
		});
		Twin({Id:"citygroup_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "citygroup_edit_f",
					formObj:tObj,
					recordid:"citygroup_id",
					suburl:"citygroup.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_citygroupT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("citygroup_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("citygroup_edit_"+id);
							_citygroupT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("citygroup.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_citygroupT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	if(subauth[4])
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"citygroup.do?action=set&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
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

_citygroupT.C();
</script>

</body>
</html>
