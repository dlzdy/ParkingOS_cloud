<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������ͳ��</title>
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
<div id="localserverobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"60",issort:false,edit:false},
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"80",issort:false,edit:false},
		{fieldcnname:"��������",fieldname:"company_name",inputtype:"text", twidth:"200" ,issort:false,edit:false},
		{fieldcnname:"�������汾",fieldname:"version",inputtype:"text", twidth:"60" ,issort:false,edit:false},
		{fieldcnname:"cpuʹ����",fieldname:"cpu",inputtype:"text", twidth:"80",issort:false,edit:false},
		{fieldcnname:"�ڴ�ʹ����",fieldname:"memory",inputtype:"text", twidth:"80",issort:false,edit:false},
		{fieldcnname:"Ӳ��(G)",fieldname:"harddisk",inputtype:"text", twidth:"80",issort:false,edit:false},
		{fieldcnname:"״̬",fieldname:"create_time",inputtype:"text", twidth:"60",issort:false,edit:false,
			process:function(value,cid,id){
			var regEx = new RegExp("\\-","gi");
				if((new Date()).valueOf()-new Date(value.replace(regEx,"/")).valueOf()>300000){
					value = "�Ͽ�";
				}else{
					value = "����";
				}
				return value;
			}},
		//{fieldcnname:"��־",fieldname:"log",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ֶ�����",fieldname:"is_update",inputtype:"select",noList:[{"value_no":"0","value_name":"��������"},{"value_no":"1","value_name":"������"}], twidth:"100",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",inputtype:"text", twidth:"130",issort:false,edit:false},
		{fieldcnname:"����ʱ��",fieldname:"limit_time",inputtype:"sdate", twidth:"130",issort:false},
		{fieldcnname:"������Կ",fieldname:"secret",inputtype:"text", twidth:"140",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",inputtype:"text", twidth:"180",issort:false}
	];
var _searchField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"number", twidth:"80",issort:false,edit:false},
		{fieldcnname:"��������",fieldname:"company_name",inputtype:"text", twidth:"200" ,issort:false,edit:false},
		{fieldcnname:"�������汾",fieldname:"version",inputtype:"number", twidth:"60" ,issort:false,edit:false},
		{fieldcnname:"�ֶ�����",fieldname:"is_update",inputtype:"select",noList:[{"value_no":"0","value_name":"��������"},{"value_no":"1","value_name":"������"}], twidth:"100",issort:false},
	];
var _addField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"80",issort:false},
		{fieldcnname:"�ֶ�����",fieldname:"is_update",inputtype:"select",noList:[{"value_no":"0","value_name":"��������"},{"value_no":"1","value_name":"������"}], twidth:"100",issort:false},
		{fieldcnname:"������Կ",fieldname:"secret",inputtype:"text", twidth:"140",issort:false}
	];
var rules =[{name:"comid",type:"ajax",url:"localserver.do?action=checkcom&comid=",requir:true,warn:"����д�Լ������µĳ������,����һ������ֻ�����һ�����ط�������",okmsg:""}];
var _localserverT = new TQTable({
	tabletitle:"���ط�����",
	ischeck:false,
	tablename:"parkorderanlysis_tables",
	dataUrl:"localserver.do",
	iscookcol:false,
	buttons:false,
	//quikcsearch:coutomsearch(),
	param:"action=quickquery",
	tableObj:T("#localserverobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	buttons:getAuthButtons(),
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_localserverT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"order_search_w",Title:"��������",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "order_search_f",
					formObj:tObj,
					formWinId:"order_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_searchField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("order_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_localserverT.C({
							cpage:1,
							tabletitle:"�߼��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
							extparam:"&action=query&"+Serializ(formName)
						})
						//addcoms();
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
	bts.push({dname:"��ӱ��ط�����",icon:"edit_add.png",onpress:function(Obj){
		T.each(_localserverT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"member_add",Title:"��ӱ��ط�����",Width:550,sysfun:function(tObj){
				Tform({
					formname: "member_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"localserver.do?action=add",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("member_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("member_add");
							_localserverT.M();
						}if(ret=="-1"){
							T.loadTip(1,"���ʧ�ܣ������Ѵ���",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
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
		T.each(_localserverT.tc.tableitems,function(o,j){
			o.fieldvalue = _localserverT.GD(id)[j]
		});
		Twin({Id:"localserver_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "localserver_edit_f",
					formObj:tObj,
					recordid:"localserver_id",
					suburl:"localserver.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("localserver_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("localserver_edit_"+id);
							_localserverT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	/*bts.push({name:"����",
		rule:function(id){
			var state =_localserverT.GD(id,"is_update");
			if(state==1){
				this.name="��������";
			}else{
				this.name="��������";
			}
			return true;
		},
		fun:function(id){
		var state =_localserverT.GD(id,"is_update");
		if(state==1){
			state=0;
		}else if(state==0){
			state=1;
		}
		var comid =_localserverT.GD(id,"comid");
		var type = "����ó�������";
		if(state==1){
			type = "���øó�������";
		}
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> ��",
			OKFn:function(){
			T.A.sendData("localserver.do?action=editupdate&comid="+comid+"&isupdate="+state,"GET","",
				function(ret){
					if(ret=="1"){
						T.loadTip(1,type+"�ɹ���",2,"");
						_localserverT.C();
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}});*/
	if(bts.length <= 0){return false;}
	return bts;
	};
_localserverT.C();
</script>

</body>
</html>
