<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��������</title>
<link href="css/tq_old.css" rel="stylesheet" type="text/css">
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
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>
</head>
<body>
<body onload='addParktype()'>
<div id="parkingobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var etc_add_states=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"},{"value_no":4,"value_name":"Pos������"}]
var parktype=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����"},{"value_no":5,"value_name":"������"}];
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����"},{"value_no":2,"value_name":"δ���"}];
//*****************************************���е�¼��ʾ������*********************************************//
var cityid = "${cityid}";
var groups = eval(T.A.sendData("getdata.do?action=getcitygroups&cityid="+cityid));
var _parentField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"parking_type",fieldvalue:'',defaultValue:'����||0',inputtype:"select",noList:parktype ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������ʽ",fieldname:"etc",fieldvalue:'',defaultValue:'ͨ������||2',inputtype:"select",noList:etc_add_states, twidth:"80" ,height:"",issort:false,shide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������Ӫ����",fieldname:"groupid",fieldvalue:'',inputtype:"cselect",noList:groups,target:"areaid",action:"getareas",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"areaid",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'areaid');
			}},
		{fieldcnname:"��������",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"parking.do?action=localdata",edit:false,issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("parking.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"180" ,height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"ͣ�����绰",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true,issort:false,},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true,issort:false,},
		//��ӳ�����Կչʾ�б�
		{fieldcnname:"������Կ",fieldname:"ukey",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",edit:false}
		];
//*****************************************���ŵ�¼��ʾ������*********************************************//
var areas = eval(T.A.sendData("getdata.do?action=getareas&id=${groupid}"));
var _childField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"40" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"parking_type",fieldvalue:'',defaultValue:'����||0',inputtype:"select",noList:parktype ,twidth:"100" ,height:"",issort:true},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������ʽ",fieldname:"etc",fieldvalue:'',defaultValue:'ͨ������||2',inputtype:"select",noList:etc_add_states, twidth:"80" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"areaid",fieldvalue:'',inputtype:"select",noList:areas,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"parking.do?action=localdata",edit:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("parking.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"180" ,height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"ͣ�����绰",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		//��ӳ�����Կչʾ�б�
		{fieldcnname:"������Կ",fieldname:"ukey",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",edit:false}
		];
var _mediaField = _childField;
if(cityid != "-1"){
	_mediaField = _parentField;
}

var _edit=[
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"parking_type",fieldvalue:'',defaultValue:'����||0',inputtype:"select",noList:parktype ,twidth:"100" ,height:"",issort:true},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������ʽ",fieldname:"etc",fieldvalue:'',defaultValue:'ͨ������||2',inputtype:"select",noList:etc_add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"180" ,height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"ͣ�����绰",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"parking.do?action=localdata",edit:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("parking.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}}
		];
var rules =[
		{name:"company_name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _parkingT = new TQTable({
	tabletitle:"ͣ�����б�",
	ischeck:false,
	tablename:"parking_tables",
	dataUrl:"citypark.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#parkingobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "&nbsp;&nbsp;&nbsp;&nbsp;������ʽ��&nbsp;&nbsp;<select id='parktype' style='width:130px'></select>";
	html += "&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}

function searchdata(){
	var parktypeid = T("#parktype").value;
	_parkingT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&etc_start="+parktypeid
	});
	addParktype();
	T("#parktype").value = parktypeid;
}

function getAuthButtons(){
	var bus = [];
	if(subauth[1])
	bus.push({dname:"ע��ͣ����",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkingT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			});
		Twin({Id:"parking_add",Title:"���ͣ����",Width:550,sysfun:function(tObj){
				Tform({
					formname: "parking_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"citypark.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parking_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("parking_add");
							_parkingT.M();
						}else if(ret=="-1"){
							T.loadTip(1,"��ѡ����Ӫ���ţ�",2,"");
						}else if(ret=="-2"){
							T.loadTip(1,"���ע����λ��!",2,"");
						}else if(ret=="-3"){
							T.loadTip(1,"����λ�ó�ͻ�������±�ע!",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(subauth[0])
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		/* T.each(_parkingT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); */
		Twin({Id:"parking_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parking_search_f",
					formObj:tObj,
					formWinId:"parking_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parking_search_w");} }
					],
					SubAction:
					function(callback,formName){
						var parktypeid = T("#parktype").value;
						_parkingT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&etc_start="+parktypeid+"&"+Serializ(formName)
						});
						addParktype();
						T("#parktype").value = parktypeid;
					}
				});	
			}
		})
	
	}});
	return bus;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		var comid = _parkingT.GD(id,"id");
		var company_name = _parkingT.GD(id,"company_name");
		var parking_type = _parkingT.GD(id,"parking_type");
		var parking_total = _parkingT.GD(id,"parking_total");
		var etc = _parkingT.GD(id,"etc");
		var state = _parkingT.GD(id,"state");
		var address = _parkingT.GD(id,"address");
		var longitude = _parkingT.GD(id,"longitude");
		var latitude = _parkingT.GD(id,"latitude");
		var mobile = _parkingT.GD(id,"mobile");
		var city = _parkingT.GD(id,"city");
		Twin({Id:"parking_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "parking_edit_f",
					formObj:tObj,
					recordid:"parking_id",
					suburl:"citypark.do?action=edit&id="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_edit}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("parking_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("parking_edit_"+id);
							_parkingT.M();
						}else if(ret=="-1"){
							T.loadTip(1,"��ѡ����Ӫ���ţ�",2,"");
						}else if(ret=="-2"){
							T.loadTip(1,"���ע����λ��!",200,"");
						}else if(ret=="-3"){
							T.loadTip(1,"����λ�ó�ͻ�������±�ע!",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
				T("#parking_edit_f_company_name").value=company_name;
				T("#parking_edit_f_parking_type").value=parking_type;
				T("#parking_edit_f_parking_total").value=parking_total;
				T("#parking_edit_f_etc").value=etc;
				T("#parking_edit_f_state").value=state;
				T("#parking_edit_f_address").value=address;
				T("#parking_edit_f_mobile").value=mobile;
				T("#parking_edit_f_city").value=city;
				T("#parking_edit_f_longitude").value=longitude;
				T("#parking_edit_f_latitude").value=latitude;
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("citypark.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_parkingT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[4])
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"ͣ��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"citypark.do?action=set&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	bts.push({name:"�ϴ���Ƭ",fun:function(id){
		var url ="upload.html?url=citypark&action=uploadpic&id="+id;
		Twin({Id:"parkattendant_edit_"+id,Title:"�ϴ���Ƭ",Width:350,Height:200,sysfunI:id,
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				_parkingT.M();
			}
			})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"getdata.do?action=getarea&areaid="+value,
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
	_parkingT.UCD(rowid,name,value);
}

function addParktype(){
	var parktypesel = document.getElementById("parktype");
	for(var i=0;i<etc_add_states.length;i++){
		var child = etc_add_states[i];
		var id = child.value_no;
		var name = child.value_name;
		parktypesel.options.add(new Option(name, id));
	}
}

_parkingT.C();
</script>

</body>
</html>
