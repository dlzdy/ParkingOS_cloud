<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
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
<div id="channelobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
function getSelData(type){
	var cartypes = eval(T.A.sendData("organize.do?action=getdata&type="+type));
	return cartypes;
}
var orgTypes = getSelData('allorgtype');
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		/* {fieldcnname:"��֯����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:orgTypes,twidth:"100" ,height:"",issort:false}, */
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",issort:false,hide:true}
	];
var _channelT = new TQTable({
	tabletitle:"��������",
	ischeck:false,
	tablename:"channel_tables",
	dataUrl:"channel.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#channelobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
	bts.push({dname:"�������",icon:"edit_add.png",onpress:function(Obj){
				T.each(_channelT.tc.tableitems,function(o,j){
					o.fieldvalue ="";
				});
				Twin({Id:"channel_add",Title:"�������",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"channel.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("channel_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("channel_add");
								_channelT.M();
							}else if(ret=='-2'){
								T.loadTip(1,"�����ظ���� ��",2,"");
							}else {
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			});
		}});
	if(bts.length>0)
		return bts;
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_channelT.tc.tableitems,function(o,j){
			o.fieldvalue = _channelT.GD(id)[j]
		});
		Twin({Id:"channel_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "channel_edit_f",
					formObj:tObj,
					recordid:"channel_id",
					suburl:"channel.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_channelT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("channel_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("channel_edit_"+id);
							_channelT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("channel.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_channelT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[4])
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"channel.do?action=set&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	
	if(bts.length <= 0){return false;}
	return bts;
}


_channelT.C();
</script>

</body>
</html>
