<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�̻�����</title>
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
<div id="shopmemberobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var shop_id = ${shop_id};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��¼�˺�",fieldname:"strid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"auth_flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":14,"value_name":"������"},{"value_no":15,"value_name":"������Ա"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false},
		{fieldcnname:"�����¼ʱ��",fieldname:"logon_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false}
	];
var _addMemberField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"auth_flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":14,"value_name":"������"},{"value_no":15,"value_name":"������Ա"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false},
		{fieldcnname:"�����¼ʱ��",fieldname:"logon_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false}
	];
var rules =[{name:"strid",type:"ajax",url:"member.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
var _shopmemberT = new TQTable({
	tabletitle:"Ա������",
	ischeck:false,
	tablename:"shopmember_tables",
	dataUrl:"shopmember.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&shop_id="+shop_id,
	tableObj:T("#shopmemberobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"ע��Ա��",icon:"edit_add.png",onpress:function(Obj){
		T.each(_shopmemberT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"shopmember_add",Title:"���Ա��",Width:550,sysfun:function(tObj){
				Tform({
					formname: "shopmember_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"shopmember.do?action=create&shop_id="+shop_id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addMemberField}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("shopmember_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("shopmember_add");
							_shopmemberT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_shopmemberT.tc.tableitems,function(o,j){
			o.fieldvalue = _shopmemberT.GD(id)[j]
		});
		Twin({Id:"shopmember_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "shopmember_edit_f",
					formObj:tObj,
					recordid:"shopmember_id",
					suburl:"shopmember.do?shop_id="+shop_id+"&action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_shopmemberT.tc.tableitems}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("shopmember_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("shopmember_edit_"+id);
							_shopmemberT.M();
						}else{
							T.loadTip(1,"�༭ʧ�ܣ�",2,o)
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("shopmember.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_shopmemberT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	bts.push({name:"�޸�����",fun:function(id){
		T.each(_shopmemberT.tc.tableitems,function(o,j){
			o.fieldvalue = _shopmemberT.GD(id)[j]
		});
		Twin({Id:"shopmember_pass_"+id,Title:"�޸�����",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "shopmember_pass_f",
					formObj:tObj,
					recordid:"shopmember_id",
					suburl:"shopmember.do?action=editpass&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
							{fieldcnname:"������",fieldname:"newpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false},
							{fieldcnname:"ȷ������",fieldname:"confirmpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false}]}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���ɹ�",icon:"cancel.gif", onpress:function(){TwinC("shopmember_pass_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�޸ĳɹ���",2,"");
							TwinC("shopmember_pass_"+id);
							_shopmemberT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_shopmemberT.C();
</script>

</body>
</html>
