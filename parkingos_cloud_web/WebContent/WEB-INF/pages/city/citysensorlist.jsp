<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������</title>
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
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var btime="${btime}";
var etime="${etime}";
var site_state_start = "${site_state_start}";
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ռ��"}];
var fstateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"}];
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"60",issort:false,edit:false,shide:true,hide:true,fhide:true},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��λ��",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"150",height:"",issort:false},
		{fieldcnname:"���������",fieldname:"did",fieldvalue:'',inputtype:"text",twidth:"150",height:"",issort:false},
        {fieldcnname:"ռ��״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
        {fieldcnname:"������״̬",fieldname:"site_state",fieldvalue:'',inputtype:"select",noList:fstateList, twidth:"80" ,height:"",issort:false,
        	process:function(value,trId,colId){
				if(value == 0)
					return "<font color='red'>����</font>";
				else 
					return "����";
			}},
        
        {fieldcnname:"��ص�ѹ",fieldname:"battery",fieldvalue:'',inputtype:"number",twidth:"80",height:"",issort:false,edit:false},
        {fieldcnname:"���ݵ�ѹ",fieldname:"magnetism",fieldvalue:'',inputtype:"number",twidth:"80",height:"",issort:false,edit:false},
        {fieldcnname:"����ʱ��",fieldname:"beart_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,edit:false},
		{fieldcnname:"����ʱ��",fieldname:"operate_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"���ߴ���",fieldname:"fcount",fieldvalue:'',inputtype:"text",twidth:"80",height:"",issort:false,shide:true,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}}
	];
var back = "";
if("${from}" == "index"){
	back = "<a href='cityindex.do?authid=${index_authid}' class='sel_fee' style='float:right;margin-right:20px;'>����</a>";
}
var _citysensorT = new TQTable({
	tabletitle:"����������"+back,
	ischeck:false,
	tablename:"citysensor_tables",
	dataUrl:"citysensor.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	quikcsearch:coutomsearch(),
	param:"action=query&btime="+btime+"&etime="+etime+"&site_state_start="+site_state_start,
	tableObj:T("#citysensorobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function coutomsearch(){
	var html = "&nbsp;&nbsp;����ʱ�䣺<input id='coutom_btime' value='"+btime+"' class='Wdate' align='absmiddle' readonly style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' class='Wdate' align='absmiddle' readonly style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false});\"/>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;���ߴ�����<select id='fcount' name='fcount' style='width:130px'><option value=-1>ȫ��</option><option value=0>������</option></select>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	var fcount = T("#fcount").value;
	_citysensorT.C({
		cpage:1,
		tabletitle:"������� "+back,
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&fcount="+fcount
	});
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	T("#fcount").value=fcount;
}
function getAuthButtons(){
	var bts=[];
	
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_citysensorT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"sensor_search_w",Title:"����",Width:550,sysfun:function(tObj){
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
						btime = T("#coutom_btime").value;
						etime = T("#coutom_etime").value;
						var fcount = T("#fcount").value;
						_citysensorT.C({
							cpage:1,
							tabletitle:"�߼��������"+back,
							extparam:"&action=query&btime="+btime+"&etime="+etime+"&fcount="+fcount+"&"+Serializ(formName)
						})
						T("#coutom_btime").value=btime;
						T("#coutom_etime").value=etime;
						T("#fcount").value=fcount;
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
function viewdetail(value,id){
	var did =_citysensorT.GD(id,"did");
	var tip = "������������ʷ��¼";
	Twin({
		Id:"sensor_detail_"+id,
		Title:tip+"  --> ��������ţ�"+did,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='sensor_detail_'"+id+" id='sensor_detail_'"+id+" src='citysensor.do?action=detail&id="+id+"&btime="+btime+"&etime="+etime+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	});
}
_citysensorT.C();
</script>

</body>
</html>
