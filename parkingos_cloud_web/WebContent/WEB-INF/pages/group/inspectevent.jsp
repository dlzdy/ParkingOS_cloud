<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Ѳ���¼����</title>
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
	<script src="js/jquery.js" type="text/javascript"></script>
</head>
<body>
<div id="cityinspecteventobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var groupid = "${groupid}";
var berthseglist = eval(T.A.sendData("getdata.do?action=getberthsegbygroupid&groupid="+groupid));
var tasktype = eval(T.A.sendData("getdata.do?action=gettasktype"));
var getinspects = eval(T.A.sendData("getdata.do?action=getinspectsbygroup&groupid="+groupid));
var subauth=[false,false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var states = [{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"������"},{"value_no":"1","value_name":"����ɹ�"},{"value_no":"2","value_name":"����ʧ��"}];
//var types = [{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"�����¼�"},{"value_no":"1","value_name":"�����¼�"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"80" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"130" ,height:"",issort:false},
		{fieldcnname:"���ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date",twidth:"130" ,height:"",issort:false},
		{fieldcnname:"�������",fieldname:"type",fieldvalue:'',inputtype:"cselect",noList:tasktype,target:"detailtype",action:"getdetailtype",twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"detailtype",fieldvalue:'',inputtype:"select",noList:[],twidth:"80" ,height:"",issort:false,
			process:function(value,pid){
				return setname(value,pid,'detailtype');
			}},
		{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"select",noList:berthseglist,twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��λ��",fieldname:"dici_id",fieldvalue:'',inputtype:"cselect", twidth:"120" ,height:"",
			process:function(value,pid){
				return setname(value,pid,'dici_id');
			}},
		{fieldcnname:"�շ�Ա���",fieldname:"uid",fieldvalue:'',inputtype:"text",noList:states, twidth:"80" ,height:"",
			process:function(value,pid){
				if(value==null||value==""||value<0) {
					return "��";
				}else{
					return value;
				}
			}},
		{fieldcnname:"Ѳ��Ա",fieldname:"inspectid",fieldvalue:'',inputtype:"select",noList:getinspects,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:""},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
		{fieldcnname:"�鿴ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,edit:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴ͼƬ</a>";
		}},
	];
var _seachField = [
	{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"80" ,height:"",issort:false},
	{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"130" ,height:"",issort:false},
	{fieldcnname:"���ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date",twidth:"130" ,height:"",issort:false},
	{fieldcnname:"�������",fieldname:"type",fieldvalue:'',inputtype:"cselect",noList:tasktype,target:"detailtype",action:"getdetailtype",twidth:"80" ,height:"",issort:false},
	{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"select",noList:berthseglist,twidth:"150" ,height:"",issort:false},
	{fieldcnname:"�շ�Ա���",fieldname:"uid",fieldvalue:'',inputtype:"text",noList:states, twidth:"80" ,height:""},
	{fieldcnname:"Ѳ��Ա",fieldname:"inspectid",fieldvalue:'',inputtype:"select",noList:getinspects,twidth:"80" ,height:"",issort:false},
	{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:""},
];
var _addField = [
	{fieldcnname:"�������",fieldname:"type",fieldvalue:'',inputtype:"cselect",noList:tasktype,target:"detailtype",action:"getdetailtype",twidth:"80" ,height:"",issort:false},
	{fieldcnname:"��������",fieldname:"detailtype",fieldvalue:'',inputtype:"select",noList:[],twidth:"80" ,height:"",issort:false,
		process:function(value,pid){
			return setname(value,pid,'detailtype');

		}},
	{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"cselect",noList:berthseglist,target:"dici_id,inspectid",action:"getberth,getinspects",twidth:"120" ,height:"",issort:false},
	{fieldcnname:"��λ���",fieldname:"dici_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"80" ,height:"30",issort:false,
		process:function(value,pid){
			return setname(value,pid,'dici_id');
		}},
	//{fieldcnname:"�շ�Ա",fieldname:"uid",fieldvalue:'',inputtype:"text",noList:states, twidth:"80" ,height:""},
	{fieldcnname:"Ѳ��Ա",fieldname:"inspectid",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"80" ,height:"",issort:false,
		process:function(value,pid){
			return setcname(value,pid,'inspectid');
		}},
	{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
];
var rules =[
		{name:"inspecteventsec_id",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _cityinspecteventT = new TQTable({
	tabletitle:"Ѳ��Ա�¼�",
	ischeck:false,
	tablename:"cityinspectevent_tables",
	dataUrl:"inspectevent.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&groupid="+groupid,
	tableObj:T("#cityinspecteventobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	quikcsearch:coutomsearch(),
	isoperate:getAuthIsoperateButtons()
});
function coutomsearch(){
	var html=  "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp&nbsp;&nbsp;״̬ <select id ='state' name='state' style='width:120px;vertical-align:middle;' onchange=searchdata(this); >"+getSelectValue(states)+"</select></div>";
	return html;
}
function getSelectValue(valuse){
	var m = "";
	for(var a=0;a<valuse.length;a++){
		m +="<option value='"+valuse[a].value_no+"'>"+valuse[a].value_name+"</option>";
	}
	return m;
}
var stateValue="";
function searchdata(obj){
	var oid = obj.id;
	var value =obj.value;
	var extp = oid+"_start="+value;
	if(oid=='isclick'&&value=='0'){//�Զ�������˵�δ����Ķ���
		extp+='&state_start=1';
	}
	if(oid='uid'){
		stateValue=value;
	}
	_cityinspecteventT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&"+extp
	})
	setSelectValue();
//	addcoms();
}
function setSelectValue(){
	var uidSelect = T("#state");
	for(var i=0;i<uidSelect.options.length;i++){
		if(uidSelect.options[i].value==stateValue)
			uidSelect.options[i].selected = true;
	}
}
function addcoms(){
	if(groupid != ""){
		var childs = eval(T.A.sendData("getdata.do?action=getcoms&groupid=${groupid}"));
		jQuery("#companys").empty();
		for(var i=0;i<childs.length;i++){
			var child = childs[i];
			var id = child.value_no;
			var name = child.value_name;
			jQuery("#companys").append("<option value='"+id+"'>"+name+"</option>");
		}
	}
}
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityinspecteventT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"sensor_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "sensor_search_f",
					formObj:tObj,
					formWinId:"sensor_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_seachField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensor_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityinspecteventT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(subauth[0])
		bts.push({dname:"����Ѳ���¼�",icon:"edit_add.png",onpress:function(Obj){
			T.each(_cityinspecteventT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			});
			Twin({Id:"member_add",Title:"�����¼�",Width:700,sysfun:function(tObj){
				Tform({
					formname: "member_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"inspectevent.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addField}],
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("member_add");} }
					],
					Callback:
							function(f,rcd,ret,o){
								if(ret=="1"){
									T.loadTip(1,"��ӳɹ���",2,"");
									TwinC("member_add");
									_cityinspecteventT.M();
								}else{
									T.loadTip(1,ret,2,o);
								}
							}
				});
			}
			})

		}});

	if(bts.length>0)
		return bts;
	return false;
}


function viewdetail(type,value,id){
	var eventid =_cityinspecteventT.GD(id,"id");
	var tip = "ͼƬ";
	Twin({
		Id:"pics_detail_"+id,
		Title:tip+"  --> ��"+id,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='pics_detail_'"+id+" id='pics_detail_'"+id+" src='inspectevent.do?action=downinspectpic&eventid="+eventid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
	})
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}

function setname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		var type = _cityinspecteventT.GD(pid,"type");
		var url = "getdata.do?action=getdetailtypename&id="+type+"&value="+value;
//		alert(url);
//		if(colname == "berthsec_id"){
//			url = "cityberthseg.do?action=getberthseg&id="+value;
//		}else if(colname == "dici_id"){
//			url = "cityberth.do?action=getdici&id="+value;
//		}
		if(colname == "dici_id"){
			var url = "getdata.do?action=getcid&id="+value;
		}
		T.A.C({
			url:url,
    		method:"GET",//POST or GET
    		param:"",//GETʱΪ��
    		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
    		dataType:"0",//0text,1xml,2obj
    		success:function(ret,tipObj,thirdParam){
    			if(ret){
					updateRow(pid,colname,ret);
    			}
				else
					updateRow(pid,colname,value);
			},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
    		failure:function(ret,tipObj,thirdParam){
				return false;
			},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
    		thirdParam:"",//�ص������еĵ���������
    		tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
    		waitTip:"���ڻ�ȡ����...",
    		noCover:true
		})
	}else{
		return "��"
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
//	alert(value);
	if(value)
	_cityinspecteventT.UCD(rowid,name,value);
}

_cityinspecteventT.C();
</script>

</body>
</html>
