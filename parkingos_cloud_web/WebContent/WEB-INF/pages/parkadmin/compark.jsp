<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��λ����</title>
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
<div id="comparkobj" style="width:100%;height:100%;margin:0px;"></div>
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
/*Ȩ��*/
var comid = ${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ռ��"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ά ���",fieldname:"qid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�شű�� ",fieldname:"did",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�볡ʱ��",fieldname:"enter_time",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"������� ",fieldname:"order_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false}
		
	];
var _comparkT = new TQTable({
	tabletitle:"��λ����",
	ischeck:false,
	tablename:"compark_tables",
	dataUrl:"compark.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#comparkobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
//�鿴,���,�༭,ɾ��
	var bts =[];
	if(subauth[1])
		bts.push({dname:"��ӳ�λ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_comparkT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"compark_add",Title:"��ӳ�λ",Width:550,sysfun:function(tObj){
				Tform({
					formname: "compark_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"compark.do?action=create&comid="+comid,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
							{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"multi", twidth:"300" ,height:"100",issort:false},
							{fieldcnname:"��ʾ��",fieldname:"",fieldvalue:'֧�����ָ�ʽ��1��������䣬�磺A0001-A0200��2�������� ����Ӣ�Ķ��Ÿ������磺A0099,B0099,C3399��3��������ţ���A0033',inputtype:"textd", twidth:"400" ,height:"",issort:false}
						]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("compark_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(parseInt(ret)>0){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("compark_add");
							_comparkT.M();
						}else{
							T.loadTip(1,"���ʧ�ܣ�",2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_comparkT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"compark_search_w",Title:"������λ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "compark_search_f",
					formObj:tObj,
					formWinId:"compark_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("compark_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_comparkT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	return bts;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_comparkT.tc.tableitems,function(o,j){
			o.fieldvalue = _comparkT.GD(id)[j]
		});
		Twin({Id:"compark_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "compark_edit_f",
					formObj:tObj,
					recordid:"compark_id",
					suburl:"compark.do?comid="+comid+"&action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_comparkT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("compark_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("compark_edit_"+id);
							_comparkT.M();
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("compark.do?action=delete","post","ids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_comparkT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	if(bts.length <= 0){return false;}
	return bts;
}
_comparkT.C();
</script>

</body>
</html>
