<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ֹ���</title>
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
<div id="withdrawobj" style="width:100%;height:100%;margin:0px;"></div>
<form action="" method="post" id="choosecom"></form>
<script language="javascript">
var comid = ${comid};
var groupid = "${groupid}";
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}

/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
//��ѯ����������
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/

var maxmoney = ${money};
var _mediaField = [
		{fieldcnname:"���ֽ��",fieldname:"amount",fieldvalue:'',inputtype:"number", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"140" ,height:"",hide:true,
			process:function(value,pid){
				return setcname(value,pid,'uin');
			}},
		{fieldcnname:"����",fieldname:"wtype",fieldvalue:'',inputtype:"select",noList:[{"value_no":1,"value_name":"��������"},{"value_no":0,"value_name":"��˾����"},{"value_no":2,"value_name":"�Թ�����"}], twidth:"140" ,height:"",hide:true},
		
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",hide:true},
		{fieldcnname:"��������",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"�ȴ�����"},{"value_no":2,"value_name":"������"},{"value_no":3,"value_name":"��֧��"}], twidth:"140" ,height:"",issort:false}
	];
var _withdrawT = new TQTable({
	tabletitle:"���ֹ���     �˻���"+maxmoney,
	ischeck:false,
	tablename:"withdraw_tables",
	dataUrl:"withdraw.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	quikcsearch:coutomsearch(),
	//searchitem:true,
	param:"action=quickquery&comid="+comid,
	tableObj:T("#withdrawobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function coutomsearch(){
	var html = "";
	if(groupid != ""){
		html = "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='companys' onchange='searchdata();' ></select></div>";
	}
	return html;
}

function searchdata(){
	comid = T("#companys").value;
	T("#choosecom").action="withdraw.do?comid="+comid+"&authid=${authid}&r"+Math.random();
	T("#choosecom").submit(); 
}
var _mField = [{fieldcnname:"��������(���:"+maxmoney+")",fieldname:"money",defaultValue:(parseInt(maxmoney)),inputtype:"number",width:200}];
//��ѯ����������
function getAuthButtons(){
	var bus = [];
	if(subauth[0])
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_withdrawT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"withdraw_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "withdraw_search_f",
					formObj:tObj,
					formWinId:"withdraw_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("withdraw_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_withdrawT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
						addcoms();
					}
				});	
			}
		})
	
	}});
	
	if(maxmoney>=100&&subauth[1])
	bus.push({dname:"��������",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"user_account_add",Title:"��������",Width:280,Height:190,sysfun:function(tObj){
				Tform({
					formname: "user_account_edit_f",
					formObj:tObj,
					recordid:"id",
					Coltype:2,
					nmCls:"r",
					//dbbuttons:[true,false],
					suburl:"parkinfo.do?action=withdraw&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("user_account_add");} }
					],
					Callback:function(f,r,c,o){
						if(c=='1'){
							T.loadTip(1,"��������ɹ���",3,null);
							TwinC("user_account_add");
							_withdrawT.M();
						}else if(c=='-1'){
							T.loadTip(1,"����δ��֧���˺ţ�����ϵ�����繫˾Ϊ�����˺ţ�",3,null);
							TwinC("user_account_add");
						}else
							T.loadTip(1,"����ʧ�ܣ�",3,null);
					}
				});	
			}
		})
	
	}});
	
	return bus
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}


function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"parkwithdraw.do?action=getusername&uin="+value,
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
		return ""
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}
/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_withdrawT.UCD(rowid,name,value);
}
_withdrawT.C();
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
		T("#companys").value = comid;
	}
}
if(groupid != ""){//���Ź���Ա��¼����ʾ�����б�
	addcoms();
}
</script>

</body>
</html>
