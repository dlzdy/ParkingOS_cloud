<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�۸����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?0899" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>

<body>
<div id="priceobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var issupperadmin=${supperadmin};
var isadmin = ${isadmin};
var authlist ="";
if((issupperadmin&&issupperadmin==1) || (isadmin&&isadmin==1))
	authlist="0,1,2,3";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");

var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/
var role=${role};
var assist_unit=${assist_unit};
var assist_price=${assist_price};
var assist_id=${assist_id};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var comid = ${comid};
function getCarType(){
	var cartypes = eval(T.A.sendData("price.do?action=getcartypes&comid="+comid));
	return cartypes;
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false,edit:false},
		/*{fieldcnname:"����",fieldname:"pay_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ʱ��"},{"value_no":1,"value_name":"����"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ʼСʱ",fieldname:"b_time",fieldvalue:'',defaultValue:'7||7',inputtype:"hour", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��ʼ����",fieldname:"b_minute",fieldvalue:'',defaultValue:'0',inputtype:"minute", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����Сʱ",fieldname:"e_time",fieldvalue:'',defaultValue:'21||21',inputtype:"hour", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"e_minute",fieldvalue:'',defaultValue:'0',inputtype:"minute", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"ʱ�䵥λ(����)",fieldname:"unit",fieldvalue:'',defaultValue:'15',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"price",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���Ż�ʱ��",fieldname:"first_times",fieldvalue:'',defaultValue:'0||0',inputtype:"fminute", twidth:"50" ,height:"",issort:false},
		{fieldcnname:"���Żݼ۸�",fieldname:"fprice",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"24Сʱ�ⶥ��",fieldname:"total24",fieldvalue:'',inputtype:"text", twidth:"90" ,height:"",issort:false,
			process:function(value,pid){
				if(parseFloat(value)>0)
					return value;
				else
					return "�޷ⶥ";
			}
		}, 
		{fieldcnname:"��ͷ�Ʒ�ʱ��",fieldname:"countless",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',defaultValue:'��Ч||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"����"},{"value_no":0,"value_name":"��Ч"}] , twidth:"40" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�ɱ༭",fieldname:"isedit",fieldvalue:'',defaultValue:'��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"�ɱ༭"}] , twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�Ƿ��Ż�",fieldname:"is_sale",fieldvalue:'',defaultValue:'��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ʱ��",fieldname:"free_time",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�����ʱ���Ʒѷ�ʽ",fieldname:"fpay_type",fieldvalue:'',defaultValue:'�շ�||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�շ�"},{"value_no":1,"value_name":"���"}] , twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�ȫ�ռ�ʱ��",fieldname:"is_fulldaytime",fieldvalue:'',defaultValue:'��ȫ||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ȫ"},{"value_no":1,"value_name":"����ȫ"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ִ�С��",fieldname:"car_type",fieldvalue:'',defaultValue:'ͨ��||0',inputtype:"select", noList:getCarType() , twidth:"100" ,height:"",issort:false},*/
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false},
		{fieldcnname:"�޸�ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false},
		{fieldcnname:"��������",fieldname:"car_type_zh",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�۸����� ",fieldname:"describe",fieldvalue:'',inputtype:"multi", twidth:"240" ,height:"",edit:true}
	];
var _assistField = [
		//{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		//{fieldcnname:"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",fieldname:"id",fieldvalue:'',inputtype:"", twidth:"100" ,height:"",issort:false,edit:false},
		/*{fieldcnname:"�׼Ʒ�ʱ�������ӣ�",fieldname:"assist_unit",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ʱ���۸�",fieldname:"assist_price",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},*/
		{fieldcnname:"�۸����� ",fieldname:"describe",fieldvalue:'',inputtype:"text", twidth:"240" ,height:"",edit:true}
	];
var rules =[{name:"price",type:"",url:"",requir:true,warn:"",okmsg:""}];
var _priceT = new TQTable({
	tabletitle:"�۸����",
	ischeck:false,
	tablename:"price_tables",
	dataUrl:"price.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&comid="+comid,
	tableObj:T("#priceobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
		bts.push({dname:"��Ӽ۸�",icon:"edit_add.png",onpress:function(Obj){
		T.each(_priceT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"price_add",Title:"��Ӽ۸�",Width:550,sysfun:function(tObj){
				Tform({
					formname: "price_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"price.do?action=create&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("price_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("price_add");
							_priceT.M();
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
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_priceT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"price_search_w",Title:"�����۸�",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "price_search_f",
					formObj:tObj,
					formWinId:"price_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("price_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_priceT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	/*if(subauth[4])
		bts.push({dname:"�༭�۸�",icon:"edit_add.png",onpress:function(Obj){
		//$("#assist_unit").text() = assist_unit;
		//$("#assist_price").text() = assist_price;
		Twin({Id:"price_add",Title:"��Ӹ����۸�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",Width:550,sysfun:function(tObj){
				Tform({
					formname: "price_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"price.do?action=createassist&comid="+comid+"&assist_id="+assist_id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_assistField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("price_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						var r = ret;
						T.loadTip(1,r.split(",")[0],2,"");
						assist_unit = r.split(",")[1];
						assist_price = r.split(",")[2];
					}
				});	
			}
		})
		document.getElementById("price_edit_f_assist_unit").value=assist_unit;
		document.getElementById("price_edit_f_assist_price").value=assist_price;
	}});*/
	
	return bts;
}
//"�鿴,���,�༭,ɾ��,�༭�۸�"
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_priceT.tc.tableitems,function(o,j){
			o.fieldvalue = _priceT.GD(id)[j]
		});
		Twin({Id:"price_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "price_edit_f",
					formObj:tObj,
					recordid:"price_id",
					suburl:"price.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_priceT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("price_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("price_edit_"+id);
							_priceT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("price.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_priceT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_priceT.C();
</script>

</body>
</html>
