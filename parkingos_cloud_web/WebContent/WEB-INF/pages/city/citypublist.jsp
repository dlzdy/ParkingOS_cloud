<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ϣ����</title>
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
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField=[
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"������Ϣ����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false,fhide:true,hide:true},
		{fieldcnname:"������¼",fieldname:"hcount",fieldvalue:'',inputtype:"number", twidth:"150" ,height:"",edit:false,shide:true,hide:true,
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
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"200" ,height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,shide:true,fhide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,shide:true,fhide:true},
		];
	
var _induceT = new TQTable({
	tabletitle:"������Ϣ����",
	ischeck:false,
	tablename:"induce_tables",
	dataUrl:"publish.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#induceobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
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
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(subauth[2])
	bts.push({ dname: "������Ϣ", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _induceT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ�񷢲���Ϣ",2,"");
			return;
		}
		Twin({Id:"send_message_w",Title:"������Ϣ",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"publish.do?action=bathpublish",
				method:"POST",
				Coltype:2,
				dbuttonname:["������Ϣ"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"�յ������",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false},
					{fieldcnname:"��Ϣ����",fieldname:"message",fieldvalue:'',inputtype:"multi",height:"100",issort:false},
					{fieldcnname:"��Ϣ��Чʱ��",fieldname:"begin_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false},
					{fieldcnname:"��Ϣ����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"�����ɹ���",2,"");
						TwinC("send_message_w");
						_induceT.M();
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
	if(bts.length <= 0){return false;}
	return bts;
}

function viewdetail(type,value,id){
	var induce_id =_induceT.GD(id,"id");
	var name = _induceT.GD(id,"name");
	var tip = "������Ϣ��"+name;
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
