<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>δ�ɹ���</title>
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
<body onload='addgroups()'>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<div id="parkescapeobj" style="width:100%;height:100%;margin:0px;"></div>
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
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�Ѵ���"}];
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var cityid = '${cityid}';
var btime="${btime}";
var etime="${etime}";
var groups = [];
var ishiddlegroup = true;
if(cityid!=''){
	groups = eval(T.A.sendData("getdata.do?action=getgroups&cityid=${cityid}"));
	ishiddlegroup = false;
}
/*Ȩ��*/
var comid = ${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false,fhide:true,hide:true,shide:true},
		{fieldcnname:"��������",fieldname:"groupid",fieldvalue:'',inputtype:"cselect",noList:groups,target:"comid",action:"getparks",twidth:"150" ,height:"",issort:false,shide:ishiddlegroup,fhide:ishiddlegroup},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,target:"berthseg_id",action:"getberthseg",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��",fieldname:"berthseg_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'berthseg_id');
			}},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"��������ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false,shide:true},
		{fieldcnname:"׷��ʱ��",fieldname:"pursue_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�������",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
					if(value == "-1"){
						return "δע��";
					}else{
						return value;
					}
				}},
		{fieldcnname:"�������",fieldname:"order_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�������",fieldname:"total",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"Ԥ�����",fieldname:"prepay",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				if(value <= 0){
					return "";
				}else{
					return value;
				}
			}},
		{fieldcnname:"Ƿ�ѽ��",fieldname:"overdue",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"׷����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�鿴����ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,shide:true,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
			}}
	];
var _parkescapeT = new TQTable({
	tabletitle:"δ����ϸ",
	//ischeck:false,
	tablename:"parkescape_tables",
	dataUrl:"parkescape.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid+"&btime="+btime+"&etime="+etime,
	tableObj:T("#parkescapeobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
//�鿴,���,�༭,ɾ��
	var bts =[];
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkescapeT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parkescape_search_w",Title:"����δ����ϸ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parkescape_search_f",
					formObj:tObj,
					formWinId:"parkescape_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parkescape_search_w");} }
					],
					SubAction:
					function(callback,formName){
						btime =  T("#coutom_btime").value;
						etime =  T("#coutom_etime").value;
						var groupid = '';
						if(!ishiddlegroup)
							groupid = T("#groups").value;
						_parkescapeT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&group_start="+groupid+"&btime="+btime+"&etime="+etime+"&"+Serializ(formName)
						});
						T("#coutom_btime").value=btime;
						T("#coutom_etime").value=etime;
						addgroups();
						if(!ishiddlegroup)
							T("#groups").value = groupid;
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
		bts.push({dname:"0Ԫ׷��",icon:"toxls.gif",onpress:function(Obj){
		var sids = _parkescapeT.GS();
		var state=_parkescapeT.GSByField("state");
        var statestr=state.replace(/,/,"");
		if(statestr.indexOf("1")>-1){ 
		   	T.loadTip(1,"��ѡ���������Ѿ�����ģ�",2,"");
			return;
		}
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ�񶩵�",2,"");
			return;
		}
		Tconfirm({Title:"ȷ��׷����?",Content:"ȷ��׷����ѡ������?",OKFn:function(){
			T.A.sendData("parkescape.do?action=recover","post","ids="+sids,
				function complete(ret){
					T.loadTip(1,"׷�ɳɹ���",2,"");
					_parkescapeT.C();
				}
			)}
		})
	}});
	bts.push({dname:"����δ����ϸ",icon:"toxls.gif",onpress:function(Obj){
		Twin({Id:"order_export_w",Title:"����δ����ϸ<font style='color:red;'>�����û�����ã�Ĭ����󵥴ε���6����!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "order_export_f",
					formObj:tObj,
					formWinId:"order_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
					}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="parkescape.do?action=exportExcel&fieldsstr=id__groupid__comid__berthseg_id__cid__create_time__end_time__pursue_time__car_number__uin__order_id__total__prepay__overdue__act_total__state__nickname__id"+Serializ(formName)
						TwinC("order_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})}});
	return bts;
}
function coutomsearch(){
	var html = "&nbsp;&nbsp;&nbsp;&nbsp;�ӵ�ʱ�䣺&nbsp;&nbsp;<input id='coutom_btime' class='Wdate' align='absmiddle' readonly value='"+btime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"/>"
	+" - <input id='coutom_etime' class='Wdate' align='absmiddle' readonly value='"+etime+"' style='width:150px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false});\"/>";
	if(!ishiddlegroup)
		html+="&nbsp;&nbsp;&nbsp;&nbsp;�������ţ�&nbsp;&nbsp;<select style='width:130px' id='groups'></select>";
	html += "&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}
function addgroups(){
	if(ishiddlegroup)
		return;
	var childs = groups;
	var groupselect = document.getElementById("groups");
	for(var i=0;i<childs.length;i++){
		var child = childs[i];
		var id = child.value_no;
		var name = child.value_name;
		groupselect.options.add(new Option(name, id));
	}
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	var groupid = '';
	if(!ishiddlegroup)
		groupid = T("#groups").value;
	_parkescapeT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&groupid_start="+groupid+"&btime="+btime+"&etime="+etime
	});
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	addgroups();
	if(!ishiddlegroup)
		T("#groups").value = groupid;
}
function viewdetail(value,id){
	var car_number =_parkescapeT.GD(id,"car_number");
	
	var comid = _parkescapeT.GD(id,"comid");
	var orderid = _parkescapeT.GD(id,"order_id");
	var tip = "����ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip+"  --> ���ƣ�"+car_number,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=escarpics&orderid="+orderid+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
	})
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	var url = "";
	if(colname == "uid"){
		url = "cityorder.do?action=getcollname&id="+value;
	}else if(colname == "freereasons"){
		url = "cityorder.do?action=getfreereason&id="+value;
	}else if(colname == "in_passid" || colname == "out_passid"){
		url = "cityorder.do?action=getpassname&id="+value;
	}else if(colname == "berthseg_id"){
		url = "cityberthseg.do?action=getberthseg&id="+value;
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
		_parkescapeT.UCD(rowid,name,value);
}

_parkescapeT.C();
</script>

</body>
</html>
