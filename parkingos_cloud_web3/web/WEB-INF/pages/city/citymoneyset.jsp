<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����趨</title>
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
<div id="moneysetobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"mtype",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"ͣ����"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"֧����",fieldname:"giveto",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��˾�˻�"},{"value_no":2,"value_name":"��Ӫ�����˻�"}],twidth:"200" ,height:"",issort:false}
	];
var _moneysetT = new TQTable({
	tabletitle:"�շ��趨",
	ischeck:false,
	tablename:"moneyset_tables",
	dataUrl:"citymoneyset.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#moneysetobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bus = [];
	if(subauth[1])
	bus.push({dname:"����趨",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"mset_add",Title:"����趨",Width:550,sysfun:function(tObj){
				Tform({
					formname: "mset_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"citymoneyset.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("mset_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("mset_add");
							_moneysetT.M();
						}else if(ret=='-2'){
							T.loadTip(1,"�����ظ��趨 ��",2,"");
						}else {
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		});
	}});
	if(subauth[0])
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		/* T.each(_msetT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); */
		Twin({Id:"mset_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "mset_search_f",
					formObj:tObj,
					formWinId:"mset_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("mset_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_moneysetT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						});
					}
				});	
			}
		});
	
	}});
	return bus;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_moneysetT.tc.tableitems,function(o,j){
			o.fieldvalue = _moneysetT.GD(id)[j];
		});
		Twin({Id:"mset_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "mset_edit_f",
					formObj:tObj,
					recordid:"mset_id",
					suburl:"citymoneyset.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_moneysetT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("mset_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("mset_edit_"+id);
							_moneysetT.M();
						}else if(ret=='-2'){
							T.loadTip(1,"�����ظ��趨��",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		});
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("citymoneyset.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_moneysetT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}});
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_moneysetT.C();
</script>

</body>
</html>
