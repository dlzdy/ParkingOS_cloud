<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>POS������</title>
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
</head>
<body>
<div id="cityposobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];s
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var groups = eval(T.A.sendData("getdata.do?action=getcitygroups&cityid=${cityid}"));
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"�ֻ��ͺ�",fieldname:"mode",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"comid",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setcname(value,pid);
			}},
		{fieldcnname:"ͣ����",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա�˻�",fieldname:"uid",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա����",fieldname:"nickname",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"�豸����",fieldname:"device_code",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����Ƿ���֤",fieldname:"device_auth",fieldvalue:'',inputtype:"select",twidth:"100",noList:[{"value_no":"0","value_name":"δ��֤"},{"value_no":"1","value_name":"����֤"}],height:"",issort:false},
		{fieldcnname:"��֤��",fieldname:"auth_user",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��֤����",fieldname:"auth_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false}
		];
var _cityposT = new TQTable({
	tabletitle:"POS������",
	ischeck:false,
	tablename:"citypos_tables",
	dataUrl:"citypos.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityposobj"),
	fit:[true,true,true],
	tableitems:_mediaField, 
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	/*bts.push({dname:"���POS��",icon:"edit_add.png",onpress:function(Obj){
				T.each(_cityposT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"citypos_add",Title:"���POS��",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"citypos.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("citypos_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("citypos_add");
								_cityposT.M();
							}else if(ret=="-1"){
								T.loadTip(1,"��ѡ����Ӫ���ţ�",2,"");
							}else {
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			});
		}});*/
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityposT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"pos_search_w",Title:"����POS��",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "pos_search_f",
					formObj:tObj,
					formWinId:"pos_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("pos_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityposT.C({
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
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_cityposT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityposT.GD(id)[j]
		});
		Twin({Id:"citypos_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "citypos_edit_f",
					formObj:tObj,
					recordid:"citypos_id",
					suburl:"citypos.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_cityposT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("citypos_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("citypos_edit_"+id);
							_cityposT.M()
						}else if(ret=="-1"){
							T.loadTip(1,"��ѡ����Ӫ���ţ�",2,"");
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	/*if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("citypos.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_cityposT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	bts.push({name:"������֤",fun:function(id){
			var devicCode = _cityposT.GD(id,"device_code");
			if(devicCode==''){
				T.loadTip(1,"k",2,"");
			}
			
			Twin({Id:"device_auth_edit_"+id,Title:"������֤",Width:550,sysfunI:id,sysfun:function(id,tObj){
					Tform({
						formname: "device_auth_edit_f",
						formObj:tObj,
						recordid:"mobilemanage_id",
						suburl:"citypos.do?action=deviceauth&id="+id,
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:[{fieldcnname:"�����Ƿ���֤",fieldname:"device_auth",fieldvalue:'',inputtype:"select",twidth:"100",noList:[{"value_no":"0","value_name":"δ��֤"},{"value_no":"1","value_name":"����֤"}],height:"",issort:false},
							                            		]}],
							rules:rules
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("device_auth_edit_"+id);} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"�༭�ɹ���",2,"");
								TwinC("device_auth_edit_"+id);
								_cityposT.M()
							}else{
								T.loadTip(1,ret,2,o)
							}
						}
					});	
				}
			})
		}});*/
	if(bts.length <= 0){return false;}
	return bts;
}

var cachedgroup = [];
function setcname(value,rowid){
	var group = cachedgroup["'"+value+"'"];
	var groupid = '';
	if(!group&&parseInt(value)>1000){
		group = eval(T.A.sendData("getdata.do?action=getgroupidbyparkid&parkid="+value));
		cachedgroup["'"+value+"'"]=group;
	}
	
	if(groups&&group){
		groupid=group[0].groupid;
		for(var i=0;i<groups.length;i++){
			var gid  = groups[i].value_no;
			if(gid==groupid){
				return groups[i].value_name;
			}
		}
		return "";
	}else {
		return value;
	}
}

_cityposT.C();
</script>

</body>
</html>
