<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>̧�˼�¼</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?08555" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/jquery.js" type="text/javascript"></script>
</head>

<body>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<div id="liftrodobj" style="width:100%;height:100%;margin:0px;"></div>
<form action="" method="post" id="choosecom"></form>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var users =eval(T.A.sendData("getdata.do?action=getuser&id=${comid}")); 
var allpass =eval(T.A.sendData("getdata.do?action=getcompass&id=${comid}"));
var subauth=[false,false];
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
var groupid = "${groupid}";
var liftreason=eval('${liftreason}');
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"̧�˱��",fieldname:"liftrod_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ʱ��",fieldname:"ctime",fieldvalue:'',defaultValue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"uin",fieldvalue:'',inputtype:"select",noList:users, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ͨ��",fieldname:"out_channel_id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"̧��ԭ��",fieldname:"reason",fieldvalue:'',defaultValue:'',inputtype:"select",noList:liftreason, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"resume",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		
		/*{fieldcnname:"ͼƬ",fieldname:"img",fieldvalue:'',inputtype:"text", twidth:"145" ,issort:false,
			process:function(value,cid,liftrod_id){
				return setPic(value,cid);
			}
		}*/
		{fieldcnname:"�鿴̧��ͼƬ",fieldname:"url",inputtype:"text", twidth:"100",issort:false
			,process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴̧��ͼƬ</a>";
			}},
	];
var _liftrodT = new TQTable({
	tabletitle:"̧�˼�¼",
	ischeck:false,
	tablename:"liftrod_tables",
	dataUrl:"liftrod.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	isidentifier:false,
	param:"action=query&comid="+comid,
	tableObj:T("#liftrodobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	//tHeight:100,
	rpage:20,
	isoperate:getAuthIsoperateButtons()
});
function coutomsearch(){
	var html = "";
	if(groupid != ""){
		html = "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='companys' onchange='searchdata();' ></select></div>";
	}
	return html;
}

function searchdata(){
	comid = T("#companys").value;
	T("#choosecom").action="liftrod.do?comid="+comid+"&authid=${authid}&r"+Math.random();
	T("#choosecom").submit(); 
}
function getAuthButtons(){
	var bts=[];
	
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_liftrodT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"liftrod_search_w",Title:"����̧�˼�¼",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "liftrod_search_f",
					formObj:tObj,
					formWinId:"liftrod_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("liftrod_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_liftrodT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
						addcoms();
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
		bts.push({dname:"����",icon:"toxls.gif",onpress:function(Obj){
		Twin({Id:"liftrod_export_w",Title:"����<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "liftrod_export_f",
					formObj:tObj,
					formWinId:"liftrod_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="liftrod.do?action=exportExcel&comid="+comid+"&rp="+2147483647+"&fieldsstr="+"id__uin__ctime__reason__resume&"+Serializ(formName)
						TwinC("liftrod_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}});
	
	
	return bts;
}
//"�鿴,���,�༭,ɾ��,�༭�����۸�"
function getAuthIsoperateButtons(){
	var bts = [];
	return false;
}
/*չʾ̧��ͼƬ�ķ���*/
function viewdetail(type,value,id){
	var liftrodId =_liftrodT.GD(id,"liftrod_id");
	var tip = "̧�˼�¼ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		/*�޸�ͼƬע��ԭ�������߼�*/
		/* Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>" */
		Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='liftrod.do?action=getliftrodpic&liftrodid="+liftrodId+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
	})
}
_liftrodT.C();

function addcoms(){
	if(groupid != ""){
		var childs = eval(T.A.sendData("getdata.do?action=getcoms&groupid=${groupid}"));
		jQuery("#companys").empty();
		for(var i=0;i<childs.length;i++){
			var child = childs[i];
			var id = child.value_no;
			var name = child.value_name;
			jQuery("#companys").append("<option value='"+id+"'>"+name+"</option>"); 
		}
		T("#companys").value = comid;
	}
}
if(groupid != ""){//���Ź���Ա��¼����ʾ�����б�
	addcoms();
}

var getobj=function(id){return document.getElementById(id)};

function viewpic(name){
	var url = 'viewpic.html?name='+name+'&db=lift_rod_pics'+'&r='+Math.random();
	Twin({Id:"carstops_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
function setPic(img,id){
	//getobj("liftrod_tables_img_"+id+"_td").style.height='100px';
	//getobj("liftrod_tables_img_"+id+"_td").style.verticalAlign='top';
	alert(img);
	if(img&&img!=''){
		var url = "liftrod.do?action=liftpicnew&filename="+img
		return "<a href='#' onclick='viewpic(\""+img+"\")'><img src='"+url+"' style='width:140px;height:100px;border:0px;vertical-align:top'></a>"
	}else
		return "";
}
</script>

</body>
</html>
