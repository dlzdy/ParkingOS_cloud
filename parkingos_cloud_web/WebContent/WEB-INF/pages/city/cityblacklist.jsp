<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������</title>
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
<div id="cityblacksobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var role=${role};
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
		/*{fieldcnname:"�˺�",fieldname:"uin",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},*/
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���к�",fieldname:"black_uuid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"��Ư��"}] ,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�½�����",fieldname:"ctime",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�޸�����",fieldname:"utime",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ԭ��",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false}
	];
var _cityblacksT = new TQTable({
	tabletitle:"����������",
	ischeck:false,
	tablename:"cityblacks_tables",
	dataUrl:"cityblack.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityblacksobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityblacksT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"cityblacks_search_w",Title:"����������",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "cityblacks_search_f",
					formObj:tObj,
					formWinId:"cityblacks_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cityblacks_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityblacksT.C({
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
	bts.push({name:"",
		rule:function(id){
			var state =_cityblacksT.GD(id,"state");
			if(state==1){
				this.name="��ԭ";
			}else{
				this.name="Ư��";
			}
			return true;
		},
		fun:function(id){
		var state =_cityblacksT.GD(id,"state");
		var vname = _cityblacksT.GD(id,"mobile");
		var uin = _cityblacksT.GD(id,"uin");
		var type = "Ư��";
		if(state==1){
			type = "��ԭ";
		}
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> "+vname+"��",
			OKFn:function(){
			T.A.sendData("blackuser.do?action=edit&id="+id+"&state="+state+"&uin="+uin,"GET","",
				function(ret){
					if(ret=="1"){
						T.loadTip(1,type+"�ɹ���",2,"");
						_cityblacksT.C();
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_cityblacksT.C();
</script>

</body>
</html>
