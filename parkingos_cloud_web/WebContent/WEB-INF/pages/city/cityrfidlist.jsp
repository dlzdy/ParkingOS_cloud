<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ӱ�ǩ����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?075417" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>

<body>
<div id="cityrfidobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴,�༭,����_ͣ��,���,��ͨ���û�
var role=${role};
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"nickname",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"�豸����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"NFC"},{"value_no":1,"value_name":"���ӱ�ǩ"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�豸���",fieldname:"nfc_uuid",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�ֻ���",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false,shide:true},
		{fieldcnname:"���ƺ�",fieldname:"carnumber",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false,shide:true},
		{fieldcnname:"�˻����",fieldname:"balance",fieldvalue:'',inputtype:"number",twidth:"160" ,height:"",issort:false,shide:true},
		{fieldcnname:"ע��ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",issort:false,hide:true},
		{fieldcnname:"��ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",issort:false,hide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ͣ��"}] , twidth:"100" ,height:"",issort:false,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>ͣ��</font>";
				else 
					return "����";
			}}
	];
var _cityrfidT = new TQTable({
	tabletitle:"���ӱ�ǩ����",
	ischeck:false,
	tablename:"cityrfid_tables",
	dataUrl:"cityrfid.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityrfidobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
//�鿴,�༭,����_ͣ��,���,��ͨ���û�
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityrfidT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"cityrfid_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "cityrfid_search_f",
					formObj:tObj,
					formWinId:"cityrfid_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cityrfid_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityrfidT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"action=query&"+Serializ(formName)
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
	if(subauth[1])
	bts.push({name:"����/ͣ��",
		rule:function(id){
			var state =_cityrfidT.GD(id,"state");
			if(state==0){//״̬������
				this.name="ͣ��";
			}else
				this.name="����";
			return true
		 },
		fun:function(id){
		var id_this = id ;
		var state =_cityrfidT.GD(id,"state");
		var conmessage="����";
		if(state==0){//״̬������
			conmessage="ͣ��";
		}
		Tconfirm({Title:"ȷ��"+conmessage+"��",Content:"ȷ��"+conmessage+"��",OKFn:function(){T.A.sendData("nfcmanage.do?action=modify","post","selids="+id_this+"&state="+state,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,conmessage+"�ɹ���",2,"");
					_cityrfidT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_cityrfidT.C();
</script>

</body>
</html>
