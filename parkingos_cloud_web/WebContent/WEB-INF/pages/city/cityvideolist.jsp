<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��Ƶ��ع���</title>
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
<div id="cityvideoobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var typeList = [{"value_no":0,"value_name":"·����"},{"value_no":1,"value_name":"���ͣ�������"}];
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"number", twidth:"60",issort:false,fhide:true,hide:true,edit:false},
		{fieldcnname:"�������",fieldname:"type",fieldvalue:'',inputtype:"select",noList:typeList,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��Ƶ����",fieldname:"video_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,hide:false,edit:true},
		{fieldcnname:"IP",fieldname:"ip",fieldvalue:'',inputtype:"text" ,height:"",issort:false},
		{fieldcnname:"�˿�",fieldname:"port",fieldvalue:'',inputtype:"text" ,height:"",issort:false,edit:true},
		{fieldcnname:"�豸ID",fieldname:"deviceid",fieldvalue:'',inputtype:"text" ,height:"",issort:false},
		{fieldcnname:"ͨ����",fieldname:"channelid",fieldvalue:'',inputtype:"text" ,height:"",issort:false,edit:true},
        {fieldcnname:"�û���",fieldname:"cusername",fieldvalue:'',inputtype:"text" ,height:"",issort:false,edit:true},
        {fieldcnname:"����",fieldname:"cpassword",fieldvalue:'',inputtype:"text",height:"",issort:false,fhide:true},
        {fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text",height:"",issort:false,fhide:false,edit:false,fhide:true,shide:true},
        {fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text" ,height:"",issort:false,edit:false,fhide:true,shide:true},
        {fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",height:"",issort:false,shide:true},
        {fieldcnname:"������",fieldname:"manufacture",fieldvalue:'',inputtype:"text" ,height:"",issort:false,edit:true}      
	]; 
	  
var _cityvideoT = new TQTable({
	tabletitle:"��Ƶ��ع���",
	ischeck:false,
	tablename:"citytransmitter_tables",
	dataUrl:"cityvideo.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#cityvideoobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityvideoT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"video_search_w",Title:"������Ƶ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "video_search_f",
					formObj:tObj,
					formWinId:"video_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensor_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityvideoT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
	bts.push({dname:"�����Ƶ���",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityvideoT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"videomanage_add",Title:"�����Ƶ���",Width:550,sysfun:function(tObj){
				Tform({
					formname: "videolist_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"cityvideo.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("videomanage_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("videomanage_add");
							_cityvideoT.M();
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
	if(bts.length>0)
		return bts;
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[1])
	bts.push({name:"�༭",fun:function(id){
		T.each(_cityvideoT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityvideoT.GD(id)[j]
		});
		Twin({Id:"citytransmitter_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "citytransmitter_edit_f",
					formObj:tObj,
					recordid:"citytransmitter_id",
					suburl:"cityvideo.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_cityvideoT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("citytransmitter_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("citytransmitter_edit_"+id);
							_cityvideoT.M()
						
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("cityvideo.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_cityvideoT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}



_cityvideoT.C();
</script>

</body>
</html>
