<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��վ����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
<style type="text/css">
.title1{
	width: 100%;
    margin: 0 auto;
    font-weight: bold;
    line-height: 25px;
    height: 40px;
    background: #EFEFEF;
    padding-top: 15px;
    border-bottom: 1px solid #ddd;
    font-size:16px !important;
}
.sel_fee{
	text-align: center;
    padding-top: 2px;
    padding-bottom: 2px;
    border-radius: 0px;
    background-color: #FFFFFF;
    outline: medium;
    border: 1px solid #5CCDBE;
    color: #5CCDBE;
    padding-left: 8px;
    padding-right: 8px;
}
.title1 a:hover{
	background:#5CCDBE;
	color:#FFFFFF;
}

.column{
	background:#5CCDBE;
	color:#FFFFFF;
}
a:link {
    color: #5CCDBE;
    text-decoration: none;
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
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

<div class="top">
	<ul class="title1">
		<a href="transmittermonitor.do" class="sel_fee" style="margin-left:10px;" id="map">��ͼ</a><a class="sel_fee column" style="margin-left:-1px;">�б�</a>
	</ul>
</div>
<div id="citytransmitterobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
   $(function(){
        
        	$("#table").css('background','#5ccdbe').css('color','#fff');
        });
/*Ȩ��*/
/* var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
} */
var site_state_start = "${site_state_start}";
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"}];
//var groups = eval(T.A.sendData("getdata.do?action=getcitygroups&cityid=${cityid}"));
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"60",issort:false,edit:false,hide:true},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��վ���",fieldname:"uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��վ����",fieldname:"name",fieldvalue:'',inputtype:"text" ,height:"",issort:false},
		{fieldcnname:"��վ��ѹ",fieldname:"voltage",fieldvalue:'',inputtype:"number" ,height:"",issort:false,
			process:function(value,pid){
				if(value=='0.00') return "-";
				else return value;
			}},
      //  {fieldcnname:"��ѹ����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date" ,height:"",issort:false,edit:false,hide:true},
        {fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text",height:"",issort:false,fhide:true,hide:true,shide:true},
        {fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text",height:"",issort:false,fhide:true,hide:true,shide:true},
        {fieldcnname:"��վ״̬",fieldname:"site_state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false,
        	process:function(value,trId,colId){
				if(value == 0)
					return "<font color='red'>����</font>";
				else 
					return "����";
			}},
        {fieldcnname:"����ʱ��",fieldname:"heartbeat",fieldvalue:'',inputtype:"date" ,height:"",issort:false,hide:true,edit:false},
        {fieldcnname:"��վ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",height:"",issort:false,shide:true},
        {fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date" ,height:"",issort:false,edit:false,hide:true},
        {fieldcnname:"���ߴ���",fieldname:"fcount",fieldvalue:'',inputtype:"text",twidth:"80",height:"",issort:false,shide:true,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}}
	]; 
var back = "";
if("${from}" == "index"){
	back = "<a href='cityindex.do?authid=${index_authid}' class='sel_fee' style='float:right;margin-right:20px;'>����</a>";
} 
var _citytransmitterT = new TQTable({
	tabletitle:"��վ����"+back,
	ischeck:false,
	tablename:"citytransmitter_tables",
	dataUrl:"citytransmitter.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&site_state_start="+site_state_start,
	tableObj:T("#citytransmitterobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	//if(subauth[1])
	bts.push({dname:"��ӻ�վ",icon:"edit_add.png",onpress:function(Obj){
				T.each(_citytransmitterT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"transmitter_add",Title:"��ӻ�վ",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"citytransmitter.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("transmitter_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("transmitter_add");
								_citytransmitterT.M();
							}else if(ret == "-2"){
								T.loadTip(1,"��վ����ظ���!",2,o);
							}else {
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			});
		}});
		//if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
			T.each(_citytransmitterT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			}); 
			Twin({Id:"transmitter_search_w",Title:"������վ",Width:550,sysfun:function(tObj){
					TSform ({
						formname: "transmitter_search_f",
						formObj:tObj,
						formWinId:"transmitter_search_w",
						formFunId:tObj,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("site_search_w");} }
						],
						SubAction:
						function(callback,formName){
							_citytransmitterT.C({
								cpage:1,
								tabletitle:"�߼��������"+back,
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
	//if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_citytransmitterT.tc.tableitems,function(o,j){
			o.fieldvalue = _citytransmitterT.GD(id)[j]
		});
		Twin({Id:"citytransmitter_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "citytransmitter_edit_f",
					formObj:tObj,
					recordid:"citytransmitter_id",
					suburl:"citytransmitter.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_citytransmitterT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("citytransmitter_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("citytransmitter_edit_"+id);
							_citytransmitterT.M();
						}else if(ret == "-2"){
							T.loadTip(1,"��վ����ظ���!",2,o);
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	//if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("citytransmitter.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_citytransmitterT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function viewdetail(value,id){
	var uuid =_citytransmitterT.GD(id,"uuid");
	var tip = "��վ������ʷ��¼";
	Twin({
		Id:"site_detail_"+id,
		Title:tip+"  --> ��վ��ţ�"+uuid,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='site_detail_'"+id+" id='site_detail_'"+id+" src='citytransmitter.do?action=detail&id="+id+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	});
}
_citytransmitterT.C();

</script>
<script type="text/javascript">
var height = document.body.clientHeight;
document.getElementById("citytransmitterobj").style.height = (height - 40 - 15)+"px";
</script>
</body>
</html>
