<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���˻�</title>
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
<div id="accountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴,���,�༭,ɾ��
/*Ȩ��*/
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�ȴ����"},{"value_no":2,"value_name":"�����"},{"value_no":3,"value_name":"�ѵ���"},{"value_no":4,"value_name":"����ʧ��"}];
var sources = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"֧���������"},{"value_no":2,"value_name":"΢�ŷ����"},{"value_no":6,"value_name":"΢�ų�ֵ"},{"value_no":7,"value_name":"֧������ֵ"},{"value_no":8,"value_name":"����"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",issort:false,edit:false},
		{fieldcnname:"���",fieldname:"amount",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ֵ"},{"value_no":1,"value_name":"֧��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��Դ/ȥ��",fieldname:"utype",fieldvalue:'',inputtype:"select", noList:sources ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������������",fieldname:"online_orderid",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"orderid",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
							if(value == "-1"){
								return "";
							}else{
								return value;
							}
				}},
		{fieldcnname:"�������˺�",fieldname:"uin",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
								if(value == "-1"){
									return "";
								}else{
									return value;
								}
				}},
		{fieldcnname:"����״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:states, twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				return setname(value,states);
			}},
		{fieldcnname:"��¼����",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false}
	];
var rules =[{name:"account_name",requir:true}];
var _accountT = new TQTable({
	tabletitle:"���˻�",
	ischeck:false,
	tablename:"account_tables",
	dataUrl:"3placcount.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#accountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
//�鿴,���,�༭,ɾ��
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_accountT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"account_search_w",Title:"�����˻���ϸ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "account_search_f",
					formObj:tObj,
					formWinId:"account_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("account_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_accountT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
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

_accountT.C();
</script>

</body>
</html>
