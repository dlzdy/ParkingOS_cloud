<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�¿������¼</title>
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
<div id="vipuserobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<form action="" method="post" id="choosecom"></form>
<script language="javascript">
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
//"�鿴,ע��,�༭,�޸ĳ���,ɾ��,����"
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/

var comid = "${comid}";
var mobile = "${mobile}";
var pnames= eval(T.A.sendData("getdata.do?action=getpname&id="+comid));
var month_select = [];
for(var i=1;i<36;i++){
	month_select.push({"value_no":i,"value_name":i});
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:mobile,inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���²�Ʒ����",fieldname:"p_name",fieldvalue:'',inputtype:"select",noList:pnames, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:""},
		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"date",twidth:"140" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"e_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false},
		{fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
		{fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
		{fieldcnname:"����",fieldname:"months",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false,fhide:true,shide:true},
		{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
	];
var _addField = [
		{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:mobile,inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
		{fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"cselect",noList:pnames,target:"total",params:["months","p_name"],action:"getprodsum",twidth:"180" ,height:"",issort:false},
		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"cselect",noList:month_select,target:"total",params:["months","p_name"],action:"getprodsum", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,edit:false},
		{fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
		{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
	];
var _editField = [
         		{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
         		{fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"cselect",noList:pnames,target:"total",params:["months","p_name"],action:"getprodsum",twidth:"180" ,height:"",issort:false},
         		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"cselect",noList:month_select,target:"total",params:["months","p_name"],action:"getprodsum", twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,edit:false},
				{fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
         		{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
         	];
var _renewField = [
				{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
				{fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"cselect",noList:pnames,target:"total",params:["months","p_name"],action:"getprodsum",twidth:"180" ,height:"",issort:false},
         		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"cselect",noList:month_select,target:"total",params:["months","p_name"],action:"getprodsum", twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"Ӧ�ս��",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,edit:false},
				{fieldcnname:"ʵ�ս��",fieldname:"act_total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
         		{fieldcnname:"��λ���",fieldname:"p_lot",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
         	];
var rules =[{name:"p_name",type:"",url:"",requir:true,warn:"��ѡ���Ʒ",okmsg:""},
			{name:"b_time",type:"",url:"",requir:true,warn:"��ѡ��ʱ��",okmsg:""},
			{name:"mobile",type:"ajax",url:"vipuser.do?action=checkmobile&mobile=",requir:true,warn:"����д�û���ʵ�ֻ�����!",okmsg:""}
			];
var _vipuserT = new TQTable({
	tabletitle:"VIP��Ա����",
	ischeck:false,
	tablename:"vipuser_tables",
	dataUrl:"cityvip.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=vipdetail&comid="+comid+"&mobile="+mobile,
	tableObj:T("#vipuserobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html = "";
	return html;
}

//"�鿴,ע��,�༭,�޸ĳ���,ɾ��,����"
function getAuthButtons(){
	var authButs=[];
	authButs.push({dname:"�����¿� ",icon:"edit_add.png",onpress:function(Obj){
	T.each(_vipuserT.tc.tableitems,function(o,j){
		o.fieldvalue ="";
	});
	Twin({Id:"vipuser_add",Title:"�����¿�<font style='color:red;'></font>",Width:550,sysfun:function(tObj){
			Tform({
				formname: "vipuser_add_f",
				formObj:tObj,
				formWinId:"vipuser_add_w",
				formFunId:tObj,
				recordid:"id",
				Coltype:2,
				suburl:"cityvip.do?action=create&comid="+comid+"&mobile="+mobile,
				method:"POST",
				formAttr:[{
					formitems:[{kindname:"",kinditemts:_addField}],
					rules:rules
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_add");} }
				],
				Callback:
				function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"��ӳɹ���",2,"");
						TwinC("vipuser_add");
						_vipuserT.M();
						window.parent._cityvipT.M();
					}else if(ret==-1){
						T.loadTip(1,"���ʧ�ܣ�",2,"");
					}else if(ret==-2){
					 	T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
					}else 
						T.loadTip(2,ret,7,"");
				}
			});	
		}
	})}});
	return authButs;
}
//"ע��,�༭,�޸ĳ���,ɾ��,����"
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		var p_name = _vipuserT.GD(id,"p_name");
		var mobile = _vipuserT.GD(id,"mobile");
		var b_time = _vipuserT.GD(id,"b_time");
		var months = _vipuserT.GD(id,"months");
		var remark = _vipuserT.GD(id,"remark");
		var p_lot = _vipuserT.GD(id,"p_lot");
		var total = _vipuserT.GD(id,"total");
		var act_total = _vipuserT.GD(id,"act_total");
		Twin({Id:"vipuser_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "vipuser_edit_f",
					formObj:tObj,
					recordid:"vipuser_id",
					suburl:"vipuser.do?comid="+comid+"&action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_editField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("vipuser_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("vipuser_edit_"+id);
							_vipuserT.M();
							window.parent._cityvipT.M();
						}else if(ret==-1){
							T.loadTip(1,"�༭ʧ�ܣ�",2,"");
						}else if(ret==-2){
						 	T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
						}else 
							T.loadTip(2,ret,7,"");
					}
				});	
				T("#vipuser_edit_f_p_name").value=p_name;
				T("#vipuser_edit_f_mobile").value=mobile;
				T("#vipuser_edit_f_b_time").value=b_time;
				T("#vipuser_edit_f_months").value=months;
				T("#vipuser_edit_f_remark").value=remark;
				T("#vipuser_edit_f_p_lot").value=p_lot;
				T("#vipuser_edit_f_total").value=total;
				T("#vipuser_edit_f_act_total").value=act_total;
			}
		})
	}}); 
	
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("vipuser.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_vipuserT.M();
					window.parent._cityvipT.M();
				}else if(ret=="-1"){
					T.loadTip(1,"�˳����ѹ����������������²�Ʒ",2,"");
				}else if(ret=="-2"){
					T.loadTip(1,"�˳�������ɾ�����¿���ɾ��",2,"");
				}else if(ret=="-3"){
					T.loadTip(1,"ɾ������ʧ�ܣ��¿���ɾ��",2,"");
				}else {
					T.loadTip(1,ret,2,"");
				}
				_vipuserT.M();
			}
		)}})
	}});
	bts.push({name:"����",fun:function(id){
		var p_name = _vipuserT.GD(id,"p_name");
		var mobile = _vipuserT.GD(id,"mobile");
		var b_time = _vipuserT.GD(id,"e_time");
		var remark = _vipuserT.GD(id,"remark");
		var p_lot = _vipuserT.GD(id,"p_lot");
		var total = T.A.sendData("getdata.do?action=getprodsum&p_name="+p_name+"&months=1");
		Twin({Id:"vipuser_renew_"+id,Title:"�¿�����",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "vipuser_renew_f",
					formObj:tObj,
					recordid:"vipuser_id",
					suburl:"vipuser.do?comid="+comid+"&mobile="+mobile+"&action=renew",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_renewField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("vipuser_renew_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"���ѳɹ���",2,"");
							TwinC("vipuser_renew_"+id);
							_vipuserT.M();
							window.parent._cityvipT.M();
						}else if(ret==-1){
							T.loadTip(1,"����ʧ�ܣ�",2,"");
						}else if(ret==-2){
						 	T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
						}else 
							T.loadTip(2,ret,7,"");
					}
				});	
				T("#vipuser_renew_f_p_name").value=p_name;
				T("#vipuser_renew_f_mobile").value=mobile;
				T("#vipuser_renew_f_b_time").value=b_time;
				T("#vipuser_renew_f_remark").value=remark;
				T("#vipuser_renew_f_p_lot").value=p_lot;
				T("#vipuser_renew_f_total").value=total;
			}
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}

_vipuserT.C();
</script>

</body>
</html>
