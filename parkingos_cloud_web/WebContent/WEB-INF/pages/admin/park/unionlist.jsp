<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?033434" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="unionparksobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
function getMarketers (){
	var markets = eval(T.A.sendData("getdata.do?action=markets"));
	return markets;
}
function getBizcircles(){
	var bizs = eval(T.A.sendData("parking.do?action=getbizs"));
	return bizs;
}
var role=${role};
var marketers=getMarketers();
var bizcircles = getBizcircles();
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var etc_states=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var etc_add_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"},{"value_no":4,"value_name":"Pos������"}]

var isfixed = false;
if(role==7)
	isfixed=true;
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"40" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"ͣ�����绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"�ϴ�ʱ��",fieldname:"upload_union_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"�ϴ�״̬",fieldname:"union_state",fieldvalue:'',defaultValue:'ȫ��||-1',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"���ϴ���ʹ��"},{"value_no":2,"value_name":"���ϴ�δ���"},{"value_no":3,"value_name":"���ϴ�������"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_totalparking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false}
		];

var _unionparksT = new TQTable({
	tabletitle:"���ϴ���������ͣ����",
	ischeck:false,
	tablename:"unionparks_tables",
	dataUrl:"parking.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=queryunionpark",
	tableObj:T("#unionparksobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bus = [];
	if(role!=6&&role!=8)
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_unionparksT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
			if(o.fieldname=='strid'||o.fieldname=='nickname'||o.fieldname=='cmobile')
				o.shide=true;
		});
		Twin({Id:"unionparks_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "unionparks_search_f",
					formObj:tObj,
					formWinId:"unionparks_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("unionparks_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_unionparksT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	
	bus.push({dname:"����ͣ��������",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do";
	}});
	
	bus.push({dname:"�ϴ�����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=uploadparks";
	}});
	
	return bus;
}
function getAuthIsoperateButtons(){
	var bts = [];
	/*if(role!=6&&role!=8)
	bts.push({name:"�༭",fun:function(id){
		var fixed = _unionparksT.GD(id,"union_state");
		Twin({Id:"unionparks_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "unionparks_edit_f",
					formObj:tObj,
					recordid:"unionparks_id",
					suburl:"parking.do?action=modify&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[		
						  {fieldcnname:"�ϴ�״̬",fieldname:"union_state",fieldvalue:fixed,inputtype:"select", noList:[{"value_no":1,"value_name":"���ϴ���ʹ��"},{"value_no":2,"value_name":"���ϴ�δ���"},{"value_no":3,"value_name":"���ϴ�������"}]}
						]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("unionparks_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("unionparks_edit_"+id);
							_unionparksT.M()
						}else if(ret=="-1"){
							T.loadTip(1,"��γ���ظ���",2,o);
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
		if(fixed=='1'&&role!=7){//�Ѷ�λ�������޸ľ�γ��
			T("#unionparks_edit_f_address").disabled=true;
			T("#unionparks_edit_f_address_showmap").disabled=true;
		}
	}});*/
	if(bts.length <= 0){return false;}
	return bts;
}
_unionparksT.C();
</script>

</body>
</html>
