<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ֹ���</title>
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
<div id="withdrawobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var states=[{"value_no":0,"value_name":"�ȴ�����"},{"value_no":2,"value_name":"������"},{"value_no":3,"value_name":"��֧��"},{"value_no":4,"value_name":"����ʧ��"},{"value_no":5,"value_name":"�ӳٴ���"}];
var cityid = "${cityid}";
var groups = eval(T.A.sendData("getdata.do?action=getcitygroups&cityid="+cityid));
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"50" ,height:"",edit:false,issort:false},
		{fieldcnname:"��Ӫ���ű��",fieldname:"groupid",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
						if(value == "-1"){
							return "";
						}else{
							return value;
						}
				}},
		{fieldcnname:"��Ӫ��������",fieldname:"gname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,shide:true},
		{fieldcnname:"�������",fieldname:"comid",fieldvalue:'',inputtype:"number",twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
							if(value == "-1"){
								return "";
							}else{
								return value;
							}
				}},
		{fieldcnname:"��������",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,shide:true},
		{fieldcnname:"������",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,shide:true},
		{fieldcnname:"����",fieldname:"wtype",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"��������"},{"value_no":0,"value_name":"��˾����"},{"value_no":2,"value_name":"�Թ�����"}], twidth:"200" ,height:"",hide:true},
		{fieldcnname:"���ֽ��",fieldname:"amount",fieldvalue:'',inputtype:"number", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"��������",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:states, twidth:"200" ,height:"",issort:false}
	];
var editField=[{fieldcnname:"����״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:states, twidth:"200" ,height:"",issort:false}];
var _withdrawT = new TQTable({
	tabletitle:"���ֹ���",
	//ischeck:false,
	tablename:"withdraw_tables",
	dataUrl:"3plwithdraw.do",
	iscookcol:false,
	//checktype:"checkbox",
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#withdrawobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_withdrawT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"withdraw_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "withdraw_search_f",
					formObj:tObj,
					formWinId:"withdraw_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("withdraw_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_withdrawT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						});
					}
				});	
			}
		});
	
	}});
	if(subauth[2])
	bts.push({ dname:  "��������", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _withdrawT.GS();
		if(!sids){
			T.loadTip(1,"����ѡ��Ҫ���������",2,"");
			return ;
		}
		Twin({Id:"muli_edit_w",Title:"��������",Width:250,sysfun:function(tObj){
			Tform({
				formname: "muli_edit_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"3plwithdraw.do?action=multiedit&ids="+sids,
					method:"POST",
					Coltype:2,
					dbuttonname:["����"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:editField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("muli_edit_w");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"����ɹ���",2,"");
							TwinC("muli_edit_w");
							_withdrawT.M();
						}else{
							T.loadTip(1,"����ʧ�ܣ�",2,"");
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
	if(subauth[1])
	bts.push({name:"����",fun:function(id){
		T.each(_withdrawT.tc.tableitems,function(o,j){
			o.fieldvalue = _withdrawT.GD(id)[j];
		});
		Twin({Id:"account_edit_"+id,Title:"����",Width:300,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "account_edit_f",
					formObj:tObj,
					recordid:"account_id",
					suburl:"3plwithdraw.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					dbuttonname:["����"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:editField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("account_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("account_edit_"+id);
							_withdrawT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		});
	}
	});
	if(bts.length <= 0){return false;}
	return bts;
}

function setname(value, list){
	if(value != "" && value != "-1"){
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

_withdrawT.C();
</script>

</body>
</html>
