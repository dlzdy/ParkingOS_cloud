<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�󶨳���</title>
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
<div id="bindcartypesetobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var issupperadmin=${supperadmin};
var isadmin = ${isadmin};
var authlist ="";
if((issupperadmin&&issupperadmin==1) || (isadmin&&isadmin==1))
	authlist="0,1,2,3,4";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/

var role=${role};
var comid=${comid};
var groupid=${groupid};
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
//function getCarType(){
//	var cartypes = eval(T.A.sendData("price.do?action=getcartypes&comid="+comid));
//	return cartypes;
//}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"car_number",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,target:"typeid",action:"getCarType",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"typeid",inputtype:"cselect", noList:[],twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'typeid');
			}},
		{fieldcnname:"�޸�ʱ��",fieldname:"update_time",inputtype:"date",twidth:"150" ,height:"",edit:false,issort:false}
];
var _bindcartypesetT = new TQTable({
	tabletitle:"�󶨳���",
	ischeck:false,
	tablename:"bindcartypeset_tables",
	dataUrl:"groupbindcartype.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&groupid="+groupid,
	tableObj:T("#bindcartypesetobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
 	var bts=[];
 	if(subauth[1])
 		bts.push({dname:"�󶨳���",icon:"edit_add.png",onpress:function(Obj){
			T.each(_bindcartypesetT.tc.tableitems,function(o,j){
				o.fieldvalue = "";
			});
			Twin({Id:"bindcartype_add",Title:"�󶨳���",Width:550,sysfun:function(tObj){
				Tform({
					formname: "parking_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"groupbindcartype.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("bindcartype_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("bindcartype_add");
							_bindcartypesetT.M();
						}else {
							T.loadTip(1,ret,2,o);
						}

					}
				});
			}
		})
	}});
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
			T.each(_bindcartypesetT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			});
			Twin({Id:"bindcartype_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "bindcartype_search_f",
					formObj:tObj,
					formWinId:"bindcartype_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("bindcartype_search_w");} }
					],
					SubAction:
							function(callback,formName){
								_bindcartypesetT.C({
									cpage:1,
									tabletitle:"�߼��������",
									extparam:"&action=query&"+Serializ(formName)
								})
							}
				});
			}
			})

		}});
	return bts;
}

//�鿴,���,�༭,ɾ��,�������ִ�С��
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
		bts.push({name:"�༭",fun:function(id){
		T.each(_bindcartypesetT.tc.tableitems,function(o,j){
			o.fieldvalue = _bindcartypesetT.GD(id)[j]
		});
		Twin({Id:"bindcartype_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "bindcartype_edit_f",
					formObj:tObj,
					recordid:"bindcartype_id",
					suburl:"groupbindcartype.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_bindcartypesetT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("bindcartype_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("bindcartype_edit_"+id);
							_bindcartypesetT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("groupbindcartype.do?action=delete&comid="+comid,"post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_bindcartypesetT.M()
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
		T.A.C({
			url:"cartype.do?action=getname&passid="+value,
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
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
		_bindcartypesetT.UCD(rowid,name,value);
}

_bindcartypesetT.C();
</script>

</body>
</html>
