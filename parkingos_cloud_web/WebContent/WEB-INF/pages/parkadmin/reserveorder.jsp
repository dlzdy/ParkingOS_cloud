<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ԤԼ����</title>
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
<div id="reserveorderobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
/*Ȩ��*/
var issupperadmin=${supperadmin};
var isadmin = ${isadmin};
var authlist ="";
if((issupperadmin&&issupperadmin==1) || (isadmin&&isadmin==1))
	authlist="0,1,2";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"Ƿ��"},{"value_no":1,"value_name":"�Ѳ���"},{"value_no":2,"value_name":"δ�볡"},{"value_no":3,"value_name":"��ȡ��"}];
var payList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},
                {"value_no":2,"value_name":"����֧��"},{"value_no":3,"value_name":"����"},
                {"value_no":4,"value_name":"�ֽ�Ԥ֧��"},{"value_no":5,"value_name":"����"},
                {"value_no":6,"value_name":"�̼ҿ�"},{"value_no":7,"value_name":"��ѷ���"}];
var typeList= [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��λԤԼ"},{"value_no":1,"value_name":"���׮ԤԼ"}];
/*Ȩ��*/
var comid = ${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�������",fieldname:"order_id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�������",fieldname:"uin",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ԤԼʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"Ԥ�Ƶ���ʱ��",fieldname:"arrive_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"������ʱ��",fieldname:"limit_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"֧��ʱ��",fieldname:"prepaid_pay_time",fieldvalue:'',inputtype:"date", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", twidth:"100" ,noList:stateList,height:"",issort:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧������",fieldname:"pay_type",fieldvalue:'',inputtype:"select", twidth:"100" ,noList:payList,height:"",issort:false},
		{fieldcnname:"ԤԼ����",fieldname:"type",fieldvalue:'',inputtype:"select", twidth:"100" ,noList:typeList,height:"",issort:false},
	    {fieldcnname:"Ԥ�����",fieldname:"prepaid",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false}

	];
var _reserveorderT = new TQTable({
	tabletitle:"ԤԼ����",
	ischeck:false,
	tablename:"reserveorder_tables",
	dataUrl:"reserveorder.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#reserveorderobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
//�鿴,���,�༭,ɾ��
	var bts =[];
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_reserveorderT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"reserveorder_search_w",Title:"������λ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "reserveorder_search_f",
					formObj:tObj,
					formWinId:"reserveorder_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("planmember_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_reserveorderT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	return bts;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

_reserveorderT.C();
</script>

</body>
</html>
