<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�յ�����</title>
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
		<a href="cityinducedmonitor.do" class="sel_fee" style="margin-left:10px;" id="map">��ͼ</a><a class="sel_fee column" style="margin-left:-1px;">�б�</a>
	</ul>
</div>
<div id="cityinduceobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
  $(function(){
  	$("#table").css('background','#5ccdbe').css('color','#fff');
  });
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var induce_state_start = "${induce_state_start}";
var typeList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"һ���յ�"},{"value_no":1,"value_name":"�����յ�"},{"value_no":2,"value_name":"�������յ�"}];
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"}];
var groups = eval(T.A.sendData("getdata.do?action=getcitygroups&cityid=${cityid}"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"number", twidth:"60",issort:false,edit:false,hide:true},
		{fieldcnname:"�յ�����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"Ӳ�����",fieldname:"did",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text",height:"",issort:false,fhide:true,edit:false,hide:true,shide:true},
        {fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text",height:"",issort:false,fhide:true,edit:false,hide:true,shide:true},
        {fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date" ,height:"",issort:false,edit:false,hide:true},
        {fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date" ,height:"",issort:false,edit:false,hide:true},
        {fieldcnname:"�յ�����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:typeList, twidth:"120" ,height:"",issort:false,edit:false,hide:true},
        {fieldcnname:"�յ���״̬",fieldname:"induce_state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"80" ,height:"",issort:false,edit:false,hide:true,
        	process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>����</font>";
				else 
					return "����";
			}},
        {fieldcnname:"�յ���ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",height:"",issort:false},
        {fieldcnname:"�������ʱ��",fieldname:"heartbeat_time",fieldvalue:'',inputtype:"date" ,height:"",issort:false,edit:false,hide:true},
        {fieldcnname:"���ߴ���",fieldname:"fcount",fieldvalue:'',inputtype:"text",twidth:"80",height:"",issort:false,shide:true,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}}
	]; 
var back = "";
if("${from}" == "index"){
	back = "<a href='cityindex.do?authid=${index_authid}' class='sel_fee' style='float:right;margin-right:20px;'>����</a>";
}
var _cityinduceT = new TQTable({
	tabletitle:"ȫ���յ�"+back,
	ischeck:false,
	tablename:"cityinduce_tables",
	dataUrl:"cityinduce.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&induce_state_start="+induce_state_start,
	tableObj:T("#cityinduceobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	
		if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
			T.each(_cityinduceT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			}); 
			Twin({Id:"cityinduce_search_w",Title:"�����յ�",Width:550,sysfun:function(tObj){
					TSform ({
						formname: "cityinduce_search_f",
						formObj:tObj,
						formWinId:"cityinduce_search_w",
						formFunId:tObj,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cityinduce_search_w");} }
						],
						SubAction:
						function(callback,formName){
							_cityinduceT.C({
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
	if(subauth[1])
	bts.push({name:"�༭",fun:function(id){
		T.each(_cityinduceT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityinduceT.GD(id)[j]
		});
		Twin({Id:"cityinduce_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "cityinduce_edit_f",
					formObj:tObj,
					recordid:"cityinduce_id",
					suburl:"cityinduce.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_cityinduceT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cityinduce_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("cityinduce_edit_"+id);
							_cityinduceT.M();
						}if(ret=="-2"){
							T.loadTip(1,"Ӳ������ظ��ˣ�",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function viewdetail(value,id){
	var did =_cityinduceT.GD(id,"did");
	var tip = "�յ�������ʷ��¼";
	Twin({
		Id:"induce_detail_"+id,
		Title:tip+"  --> �յ���ţ�"+did,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='induce_detail_'"+id+" id='induce_detail_'"+id+" src='cityinduce.do?action=detail&id="+id+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	});
}
_cityinduceT.C();
</script>
<script type="text/javascript">
var height = document.body.clientHeight;
document.getElementById("cityinduceobj").style.height = (height - 40 - 15)+"px";
</script>
</body>
</html>
