<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�󶨳�����</title>
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
<div id="citysensorobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
/* var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
} */
var comid = "${comid}";
var berthid = "${berthid}";
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ռ��"}];
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"60",issort:false,edit:false,shide:true,hide:true,fhide:true},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"150" ,height:"",issort:false,shide:true},
        {fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
        {fieldcnname:"����������ID",fieldname:"serid",fieldvalue:'',inputtype:"text",twidth:"150",height:"",issort:false},
        {fieldcnname:"���������",fieldname:"did",fieldvalue:'',inputtype:"text",twidth:"150",height:"",issort:false},
        {fieldcnname:"��ص�ѹ",fieldname:"battery",fieldvalue:'',inputtype:"text",twidth:"80",height:"",issort:false,edit:false},
        {fieldcnname:"���ݵ�ѹ",fieldname:"magnetism",fieldvalue:'',inputtype:"text",twidth:"80",height:"",issort:false,edit:false},
        {fieldcnname:"����ʱ��",fieldname:"beart_time",fieldvalue:'',inputtype:"date",height:"",issort:false,edit:false},
        {fieldcnname:"��ά��",fieldname:"code",fieldvalue:'',inputtype:"text",twidth:"150",height:"",issort:false,hide:true},
		{fieldcnname:"����ʱ��",fieldname:"operate_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true}
	];
var _citysensorT = new TQTable({
	tabletitle:"�󶨳�����",
	ischeck:true,
	checktype:"radio",
	tablename:"citysensor_tables",
	dataUrl:"cityberth.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=querysensor&comid="+comid,
	tableObj:T("#citysensorobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_citysensorT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"sensor_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "sensor_search_f",
					formObj:tObj,
					formWinId:"sensor_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensor_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_citysensorT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=querysensor&comid="+comid+"&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	
	bts.push({dname:"�󶨳�����", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _citysensorT.GS();
		if(!sids){
			T.loadTip(1,"����ѡ�񳵼���",2,"");
			return;
		}
		Tconfirm({Title:"�󶨳�����",Content:"ȷ�ϰ󶨸ó�������",OKFn:function(){
			T.A.sendData("cityberth.do?action=bindsensor&berthid="+berthid,"post","id="+sids,
				function deletebackfun(ret){
					if(ret=="1"){
						T.loadTip(1,"�󶨳ɹ���",5,"");
						_citysensorT.M();
						window.parent._cityberthT.M();
					}else if(ret=="-2"){
						T.loadTip(1,"�ó������ѱ�������λ�󶨣�",2,"");
					}else{
						T.loadTip(1,ret,2,"");
					}
				}
			)}})
		}})
	if(bts.length>0)
		return bts;
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}
_citysensorT.C();
</script>

</body>
</html>
