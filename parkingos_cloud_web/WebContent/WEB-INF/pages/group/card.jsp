<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��Ƭ����</title>
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
<div id="cardobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var cardstate = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Ѽ���"},
                 {"value_no":1,"value_name":"��ע��"},{"value_no":2,"value_name":"�Ѱ��û�"},
                 {"value_no":4,"value_name":"�Ѱ󶨳���"},{"value_no":3,"value_name":"�ѿ���"}];
var _mediaField = [
		{fieldcnname:"�����",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false,shide:true,hide:true,fhide:true},
		{fieldcnname:"��Ƭ����",fieldname:"card_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"card_number",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"nfc_uuid",fieldvalue:'',inputtype:"text",twidth:"180" ,height:"",issort:false},
		{fieldcnname:"�����ֻ���",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"carnumber",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"balance",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��Ƭ״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:cardstate, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����豸",fieldname:"device",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"reg_id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setcname(value,pid,'reg_id');
			}},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"������",fieldname:"activate_id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setcname(value,pid,'activate_id');
			}},
		{fieldcnname:"����ʱ��",fieldname:"activate_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"����",fieldname:"uid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setcname(value,pid,'uid');
			}},
		{fieldcnname:"��ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"ע����",fieldname:"cancel_id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true,shide:true,
			process:function(value,pid){
				return setcname(value,pid,'cancel_id');
			}},
		{fieldcnname:"ע��ʱ��",fieldname:"cancel_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true}
	];
	
var _edit=[
		{fieldcnname:"��Ƭ����",fieldname:"card_name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false}
	];
	
var _bind=[
   		{fieldcnname:"�ֻ���",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
   		{fieldcnname:"���ƺ�",fieldname:"carnumber",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false}
   	];
var _charge=[
   		{fieldcnname:"��ֵ���",fieldname:"money",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false}
    ];
var rules =[
    	{name:"carnumber",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
    ];
var _cardT = new TQTable({
	tabletitle:"��Ƭ����",
	ischeck:false,
	tablename:"card_tables",
	dataUrl:"card.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cardobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cardT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"card_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "card_search_f",
					formObj:tObj,
					formWinId:"card_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("card_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cardT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
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
	if(subauth[1])
	bts.push({name:"�༭",fun:function(id){
		var card_name = _cardT.GD(id,"card_name");
		Twin({Id:"card_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "card_edit_f",
					formObj:tObj,
					recordid:"cardsec_id",
					suburl:"card.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_edit}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("card_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("card_edit_"+id);
							_cardT.M();
						}else{
							T.loadTip(1,"�༭ʧ��!",2,o);
						}
					}
				});	
				T("#card_edit_f_card_name").value=card_name;
			}
		})
	}});
	if(subauth[2])
		bts.push({name:"��",fun:function(id){
			var carnumber = _cardT.GD(id,"carnumber");
			var mobile = _cardT.GD(id,"mobile");
			Twin({Id:"card_bind_"+id,Title:"��",Width:550,sysfunI:id,sysfun:function(id,tObj){
					Tform({
						formname: "card_bind_f",
						formObj:tObj,
						recordid:"cardsec_id",
						suburl:"card.do?action=bind&id="+id,
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_bind}],
							rules:rules
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ����",icon:"cancel.gif", onpress:function(){TwinC("card_bind_"+id);} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"�󶨳ɹ���",2,"");
								TwinC("card_bind_"+id);
								_cardT.M();
							}else{
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			})
			T("#card_bind_f_carnumber").value=carnumber;
			T("#card_bind_f_mobile").value=mobile;
		}});
	//if(subauth[6])
		bts.push({name:"���",fun:function(id){
		Tconfirm({Title:"���",Content:"ȷ�Ͻ����",OKFn:function(){
		T.A.sendData("card.do?action=unbind","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"�����ɹ���",2,"");
					_cardT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[3])
		bts.push({name:"��ֵ",fun:function(id){
			Twin({Id:"card_charge_"+id,Title:"��ֵ",Width:550,sysfunI:id,sysfun:function(id,tObj){
					Tform({
						formname: "card_charge_f",
						formObj:tObj,
						recordid:"cardsec_id",
						suburl:"card.do?action=charge&id="+id,
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_charge}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ����ֵ",icon:"cancel.gif", onpress:function(){TwinC("card_charge_"+id);} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ֵ�ɹ���",2,"");
								TwinC("card_charge_"+id);
								_cardT.M();
							}else{
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			})
		}});
	
	if(subauth[4])
	bts.push({name:"ע��",fun:function(id){
		Tconfirm({Title:"ע��",Content:"ȷ��ע����",OKFn:function(){
		T.A.sendData("card.do?action=return","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ע���ɹ���",2,"");
					_cardT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[5])
		bts.push({name:"ɾ��",fun:function(id){
			Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
			T.A.sendData("card.do?action=delete","post","id="+id,
				function deletebackfun(ret){
					if(ret=="1"){
						T.loadTip(1,"ɾ���ɹ���",2,"");
						_cardT.M();
					}if(ret=="-2"){
						T.loadTip(1,"����ע����Ƭ!",2,"");
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
	if(value&&value!='-1'&&value!=''){
		var url = "";
		if(colname == "reg_id" 
				|| colname == "uid" 
				|| colname == "cancel_id"
				|| colname == "activate_id"){
			url = "getdata.do?action=nickname&id="+value;
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
	//alert(value);
	if(value)
	_cardT.UCD(rowid,name,value);
}

_cardT.C();
</script>

</body>
</html>
