<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>LED������</title>
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
<div id="cityledobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var moveMode = [{"value_no":0,"value_name":"����Ӧ"},{"value_no":1,"value_name":"���������ƶ�"},{"value_no":2,"value_name":"���������ƶ�"},{"value_no":3,"value_name":"���������ƶ�"},{"value_no":4,"value_name":"���������ƶ�"},{"value_no":5,"value_name":"��������չ��"},{"value_no":6,"value_name":"��������չ��"},{"value_no":7,"value_name":"��������չ��"},{"value_no":8,"value_name":"��������չ��"},{"value_no":9,"value_name":"������ʾ"},{"value_no":10,"value_name":"���м�������չ��"},{"value_no":11,"value_name":"���������м�չ��"},{"value_no":12,"value_name":"���м�������չ��"},{"value_no":13,"value_name":"���������м�չ��"},{"value_no":14,"value_name":"��˸"},{"value_no":15,"value_name":"�Ұ�Ҷ"}];
var moveSpeed = [{"value_no":0,"value_name":"0"},{"value_no":1,"value_name":"1"},{"value_no":2,"value_name":"2"},{"value_no":3,"value_name":"3"},{"value_no":4,"value_name":"4"},{"value_no":5,"value_name":"5"},{"value_no":6,"value_name":"6"},{"value_no":7,"value_name":"7"},{"value_no":8,"value_name":"8"}];
var dwellTime = [{"value_no":0,"value_name":"0s"},{"value_no":1,"value_name":"1s"},{"value_no":2,"value_name":"2s"},{"value_no":3,"value_name":"3s"},{"value_no":4,"value_name":"4s"},{"value_no":5,"value_name":"5s"}];
var cityledColor = [{"value_no":0,"value_name":"����ɫ"},{"value_no":1,"value_name":"˫��ɫ"}];
var showColor = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"},{"value_no":2,"value_name":"��"}];
var typeFace = [{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"����"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����"},{"value_no":5,"value_name":"����"}];
var typeSize = [{"value_no":0,"value_name":"12��12"},{"value_no":1,"value_name":"16��16"},{"value_no":2,"value_name":"24��24"},{"value_no":3,"value_name":"32��32"},{"value_no":4,"value_name":"48��48"},{"value_no":5,"value_name":"64��64"},{"value_no":6,"value_name":"80��80"},{"value_no":7,"value_name":"96��96"}];
var _field = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false,edit:false,fhide:true},
		{fieldcnname:"ip��ַ",fieldname:"cityledip",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�˿ں�",fieldname:"cityledport",fieldvalue:'',defaultValue:'8888',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ز�UID",fieldname:"cityleduid",fieldvalue:'',defaultValue:'41',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ƶ���ʽ",fieldname:"movemode",fieldvalue:'',defaultValue:'������ʾ||9',inputtype:"select",noList:moveMode,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ƶ��ٶ�",fieldname:"movespeed",fieldvalue:'',defaultValue:'1||1',inputtype:"select",noList:moveSpeed,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"ͣ��ʱ��",fieldname:"dwelltime",fieldvalue:'',defaultValue:'1s||1',inputtype:"select",noList:dwellTime,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��ʾ����ɫ",fieldname:"cityledcolor",fieldvalue:'',defaultValue:'˫��ɫ||1',inputtype:"select",noList:cityledColor,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"showcolor",fieldvalue:'',defaultValue:'��||0',inputtype:"select",noList:showColor,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"typeface",fieldvalue:'',defaultValue:'����||1',inputtype:"select",noList:typeFace,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"�ֺ�",fieldname:"typesize",fieldvalue:'',defaultValue:'16��16||1',inputtype:"select",noList:typeSize,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"�ز�����",fieldname:"matercont",fieldvalue:'',defaultValue:'ͣ����',inputtype:"text",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��",fieldname:"width",fieldvalue:'',defaultValue:'64',inputtype:"text",twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��",fieldname:"height",fieldvalue:'',defaultValue:'32',inputtype:"text",twidth:"50" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��ͨ��"},{"value_no":1,"value_name":"��λ��"}],twidth:"80" ,height:"",issort:false},
		{fieldcnname:"ת���˿�",fieldname:"rsport",fieldvalue:'',defaultValue:'rs232-2||2',inputtype:"select",noList:[{"value_no":1,"value_name":"rs232-1"},{"value_no":2,"value_name":"rs232-2"},{"value_no":3,"value_name":"rs485"}],twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,target:"worksite_id",action:"getworksite",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������վ",fieldname:"worksite_id",fieldvalue:'',inputtype:"cselect",noList:[],target:"passid",action:"getpass",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'worksite_id');
			}
		},
		{fieldcnname:"����ͨ��",fieldname:"passid",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"160" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'passid');
			}
		}
		];
var rules =[{name:"passid",requir:true}];
var _cityledT = new TQTable({
	tabletitle:"LED������",
	ischeck:false,
	tablename:"cityled_tables",
	dataUrl:"cityled.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityledobj"),
	fit:[true,true,true],
	tableitems:_field,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts = [];
	if(subauth[1])
	bts.push({dname:"���led��",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityledT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"cityled_add",Title:"���led��",Width:550,sysfun:function(tObj){
				Tform({
					formname: "cityled_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"cityled.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_field}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cityled_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("cityled_add");
							_cityledT.M();
						}else if(ret==0){
							T.loadTip(1,"���ʧ�ܣ����Ժ����ԣ�",2,"");
						}else{
							T.loadTip(1,"���ʧ�ܣ�",2,"");
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_cityledT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityledT.GD(id)[j]
		});
		Twin({Id:"cityled_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "cityled_edit_f",
					formObj:tObj,
					recordid:"cityled_id",
					suburl:"cityled.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_cityledT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cityled_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("cityled_edit_"+id);
							_cityledT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("cityled.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_cityledT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function setcname(value,pid,colname){
	var url = "";
	if(colname == "worksite_id"){
		url = "citypass.do?action=getworksitename&id="+value;
	}else if(colname == "passid"){
		url = "parkcamera.do?action=getname&passid="+value;
	}
	if(value&&value!='-1'&&value!=''){
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
	//alert(value);
	if(value)
	_cityledT.UCD(rowid,name,value);
}

_cityledT.C();
</script>

</body>
</html>
