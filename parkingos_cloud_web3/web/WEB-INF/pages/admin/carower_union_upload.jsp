<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ͻ�����11</title>
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
<div id="carowerobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var union_id = '${unionId}';
var server_id = '${serverId}';
var union_key='${unionKey}'
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴 ��֤ ���Ͷ��� ��˳���
var role=${role};
function getbonustypes (){
	var bonustypes = eval(T.A.sendData("getdata.do?action=getbonustypes"));
	return bonustypes;
}
var bonustypes =getbonustypes();
var _mediaField = [
               	{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",hide:true},
        		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
        		{fieldcnname:"����",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"160" ,height:"",issort:false},
        		{fieldcnname:"ע������",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
        		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false,shide:true}
        	];
var _carowerT = new TQTable({
	tabletitle:"ѡ���Ա�ϴ�������",
	//ischeck:false,
	tablename:"carower_tables",
	dataUrl:"carower.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	isidentifier:false,
	//searchitem:true,
	param:"action=queryunionupload",
	tableObj:T("#carowerobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});


function getAuthButtons(){
	var bts =[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carowerT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carower_search_w",Title:"�����ͻ�",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "carower_search_f",
					formObj:tObj,
					formWinId:"carower_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carower_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_carowerT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	bts.push({ dname:  "�ϴ�������ƽ̨", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _carowerT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ���Ա",2,"");
			return;
		}
		Twin({Id:"send_message_w",Title:"ͬ��������ƽ̨",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"carower.do?action=uploadcarowertounion",
				method:"POST",
				Coltype:2,
				dbuttonname:["ȷ���ϴ�"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"��Ա ���",fieldname:"seleids",fieldvalue:sids,inputtype:"multi"},
					{fieldcnname:"���� ƽ̨���",fieldname:"server_id",fieldvalue:union_id,inputtype:"text",edit:false},
					{fieldcnname:"�����̱��",fieldname:"server_id",fieldvalue:server_id,inputtype:"text",edit:false},
					{fieldcnname:"ǩ��KEY",fieldname:"union_key",fieldvalue:union_key,inputtype:"text",edit:false}
					]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ��ͬ��������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret!==''){
						T.loadTip(1,ret,2,"");
						TwinC("send_message_w");
						_carowerT.C();
					}else{
						T.loadTip(1,"ͬ��������ʧ��",2,o);
					}
				}
			});	
			}
		})
		
	}})
	bts.push({dname:"���ز�����Ա����",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?action=unioncarowner&authid=${authid}";
	}});
	if(bts.length>0)
		return bts;
	else 
		return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}
_carowerT.C();
</script>

</body>
</html>
