<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ײ͹���</title>
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
<div id="packageobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
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
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var comid = ${comid};
var coms= eval(T.A.sendData("getdata.do?action=getsubcoms&id="+comid));
var carTypes= eval(T.A.sendData("getdata.do?action=getcartype&id="+comid));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"p_name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:""},
		/*{fieldcnname:"����",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:coms, twidth:"200" ,height:""},
		{fieldcnname:"��ʼСʱ ",fieldname:"b_time",fieldvalue:'',inputtype:"hour",defaultValue:'8||8', twidth:"80" ,height:""},
		{fieldcnname:"��ʼ����",fieldname:"bmin",fieldvalue:'',inputtype:"pminute",defaultValue:'0||0', twidth:"80" ,height:""},
		{fieldcnname:"����Сʱ",fieldname:"e_time",fieldvalue:'',inputtype:"hour",defaultValue:'8||8', twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"emin",fieldvalue:'',inputtype:"pminute",defaultValue:'0||0', twidth:"80" ,height:""},
		{fieldcnname:"ʣ������",fieldname:"remain_number",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�۸�",fieldname:"price",fieldvalue:'',inputtype:"doub", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ԭ��",fieldname:"old_price",fieldvalue:'',inputtype:"doub", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��Ч����",fieldname:"limitday",fieldvalue:'',inputtype:"sdate", twidth:"150" ,height:"",issort:false},

		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��Ч"},{"value_no":1,"value_name":"��Ч"}] ,twidth:"100" ,height:"",issort:false},
		//,{"value_no":4,"value_name":"ָ��Сʱ���"},{"value_no":3,"value_name":"�����Ż�"}
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ȫ�����"},{"value_no":1,"value_name":"ҹ�����"},{"value_no":2,"value_name":"�ռ����"}] ,twidth:"100" ,height:"",issort:false},
	{fieldcnname:"��Ч��Χ",fieldname:"scope",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��������Ч"},{"value_no":1,"value_name":"���������ӳ�����Ч"}] ,twidth:"100" ,height:"",issort:false},
//	{fieldcnname:"����������",fieldname:"exclude_date",fieldvalue:'',inputtype:"text" ,twidth:"100" ,height:"",issort:false,edit:false}
	{fieldcnname:"����",fieldname:"describe",fieldvalue:'',inputtype:"multi", twidth:"200" ,height:"",issort:false}*/
	//{fieldcnname:"�Żݰٷֱ�(1-100)",fieldname:"favourable_precent",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"�����Żݰٷֱ�(1-100)",fieldname:"out_favourable_precent",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"���ʱ��(����)",fieldname:"free_minutes",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false}
		{fieldcnname:"�۸�",fieldname:"price",fieldvalue:'',inputtype:"doub", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false},
		{fieldcnname:"�޸�ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",edit:false},
		{fieldcnname:"��������",fieldname:"car_type_id",fieldvalue:'',inputtype:"select",noList:carTypes, twidth:"150" ,height:"",issort:false},
		{fieldcnname:"�¿����� ",fieldname:"describe",fieldvalue:'',inputtype:"multi", twidth:"240" ,height:"",edit:true},
		{fieldcnname:"�������� ",fieldname:"period",fieldvalue:'',inputtype:"select",noList:[{"value_no":"��","value_name":"��"},{"value_no":"��","value_name":"��"},{"value_no":"����","value_name":"����"},{"value_no":"��","value_name":"��"}], twidth:"140" ,height:"",edit:true}
	];
var rules =[
		{name:"remain_number",type:"number",url:"",requir:true,warn:"����������!",okmsg:""},
		{name:"b_time",type:"number",url:"",requir:true,warn:"����������!",okmsg:""},
		{name:"e_time",type:"number",url:"",requir:true,warn:"����������!",okmsg:""},
		{name:"price",type:"doub",url:"",requir:true,warn:"������۸�!",okmsg:""},
		{name:"limitday",type:"date",url:"",requir:true,warn:"��������Ч��!",okmsg:""}];
var _packageT = new TQTable({
	tabletitle:"�ײ͹���&nbsp;&nbsp;<font color='#a9a9a9'>����������ֻ����ʾ���ƶ������԰������ڣ�</font>",
	ischeck:false,
	tablename:"package_tables",
	dataUrl:"package.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&comid="+comid,
	tableObj:T("#packageobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
		bts.push({dname:"����ײ�",icon:"edit_add.png",onpress:function(Obj){
		T.each(_packageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"package_add",Title:"����ײ�",Width:550,sysfun:function(tObj){
				Tform({
					formname: "package_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"package.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("package_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("package_add");
							_packageT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_packageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"package_search_w",Title:"�����ײ�",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "package_search_f",
					formObj:tObj,
					formWinId:"package_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("package_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_packageT.C({
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
//"�鿴,���,�༭"
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_packageT.tc.tableitems,function(o,j){
			o.fieldvalue = _packageT.GD(id)[j]
		});
		Twin({Id:"package_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "package_edit_f",
					formObj:tObj,
					recordid:"package_id",
					suburl:"package.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_packageT.tc.tableitems}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("package_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("package_edit_"+id);
							_packageT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	 bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("package.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_packageT.M()
				}else {
					T.loadTip(1,ret,10,"");
				}
			}
		)}})
	}});
//	bts.push(
//			{name:"�ظ�",
//				fun:function(id){
//					Twin({
//						Id:"edit_role"+id,
//						Title:"�ر��շ�������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
//						Content:"<iframe src=\"package.do?action=week&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
//						Width:T.gww()-300,
//						Height:T.gwh()-200
//					})
//
//				}});
	if(bts.length <= 0){return false;}
	return bts;
}
_packageT.C();
</script>

</body>
</html>
