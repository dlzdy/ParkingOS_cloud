<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.chan/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Ա������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0818" type="text/javascript">//���</script>
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>
<body>
<div id="chanmemobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var issupperadmin=${supperadmin};
var isadmin = ${isadmin};
var authlist ="";
if(issupperadmin&&issupperadmin==1)
	authlist="0,1,2,3,4";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}

var chanid = ${chanid};
var adminroles=eval(T.A.sendData("chanmember.do?action=getrole&chanid="+chanid))
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��¼�˺�",fieldname:"strid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"role_id",fieldvalue:'',inputtype:"select",noList:adminroles ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false}
	];
var _addMemberField = [
	{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
	{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
	{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
	{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
	{fieldcnname:"��ɫ",fieldname:"role_id",fieldvalue:'',inputtype:"select",noList:adminroles ,twidth:"100" ,height:"",issort:false},
	{fieldcnname:"����ʱ��",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false}
];
var rules =[{name:"role_id",type:"",url:"",requir:true,warn:"",okmsg:""}];
/*var rules =[{name:"strid",type:"ajax",url:"chanmember.do?action=check&chanid="+chanid+"&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""},
			{name:"role_id",type:"",url:"",requir:true,warn:"",okmsg:""}];*/
var tabtip = "Ա������";
var _chanmemT = new TQTable({
	tabletitle:tabtip,
	ischeck:false,
	tablename:"chanmem_tables",
	dataUrl:"chanmember.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&chanid="+chanid,
	tableObj:T("#chanmemobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	bts.push({dname:"ע��Ա��",icon:"edit_add.png",onpress:function(Obj){
	T.each(_chanmemT.tc.tableitems,function(o,j){
		o.fieldvalue ="";
	});
	Twin({Id:"chanmem_add",Title:"���Ա��",Width:550,sysfun:function(tObj){
			Tform({
				formname: "chanmem_edit_f",
				formObj:tObj,
				recordid:"id",
				suburl:"chanmember.do?action=create&chanid="+chanid,
				method:"POST",
				formAttr:[{
					formitems:[{kindname:"",kinditemts:_addMemberField}],
					rules:rules
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("chanmem_add");} }
				],
				Callback:
				function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"��ӳɹ���",2,"");
						TwinC("chanmem_add");
						_chanmemT.M();
					}else{
						T.loadTip(1,ret,2,o);
					}
				}
			});	
		}
	})
	}});
	if(subauth[0])
	/* bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_chanmemT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"chanmem_search_w",Title:"����Ա��",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "chanmem_search_f",
					formObj:tObj,
					formWinId:"chanmem_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("chanmem_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_chanmemT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&chanid="+chanid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	}}); */
	return bts;
}
//�鿴,ע��,�༭,�����շ�,ɾ��,�޸�����
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_chanmemT.tc.tableitems,function(o,j){
			o.fieldvalue = _chanmemT.GD(id)[j]
		});
		Twin({Id:"chanmem_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "chanmem_edit_f",
					formObj:tObj,
					recordid:"chanmem_id",
					suburl:"chanmember.do?chanid="+chanid+"&action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_chanmemT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("chanmem_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("chanmem_edit_"+id);
							_chanmemT.M();
						}else{
							T.loadTip(1,"�༭ʧ�ܣ�",2,o)
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("chanmember.do?action=delete&chanid="+chanid,"post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_chanmemT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[4])
	bts.push({name:"�޸�����",fun:function(id){
		T.each(_chanmemT.tc.tableitems,function(o,j){
			o.fieldvalue = _chanmemT.GD(id)[j]
		});
		Twin({Id:"chanmem_pass_"+id,Title:"�޸�����",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "chanmem_pass_f",
					formObj:tObj,
					recordid:"chanmem_id",
					suburl:"chanmember.do?action=editpass&chanid="+chanid+"&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
							{fieldcnname:"������",fieldname:"newpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false},
							{fieldcnname:"ȷ������",fieldname:"confirmpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false}]}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���ɹ�",icon:"cancel.gif", onpress:function(){TwinC("chanmem_pass_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�޸ĳɹ���",2,"");
							TwinC("chanmem_pass_"+id);
							_chanmemT.M()
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
_chanmemT.C();
</script>

</body>
</html>
