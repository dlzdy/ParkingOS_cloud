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
var subauth=[false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,target:"uin,pass_id",action:"getcollectors,getcompass",twidth:"100" ,height:"",issort:false},
        {fieldcnname:"̧�˱��",fieldname:"liftrod_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
        {fieldcnname:"�շ�Ա",fieldname:"uin",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'uin');
			}},
		{fieldcnname:"ʱ��",fieldname:"ctime",fieldvalue:'',defaultValue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"ͨ��",fieldname:"out_channel_id",fieldvalue:'',inputtype:"text",noList:[],action:"",twidth:"160" ,height:"",issort:false},
			/*process:function(value,pid){
				return setcname(value,pid,'pass_id');
			}},*/
		{fieldcnname:"̧��ԭ��",fieldname:"resume",fieldvalue:'',defaultValue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ͼƬ",fieldname:"img",fieldvalue:'',inputtype:"text", twidth:"145" ,issort:false,shide:true,
			process:function(value,cid,id){
                return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴̧��ͼƬ</a>";
			}
		}
	];
var _liftrodT = new TQTable({
	tabletitle:"̧�˼�¼",
	ischeck:false,
	tablename:"liftrod_tables",
	dataUrl:"citylift.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	isidentifier:false,
	param:"action=query",
	tableObj:T("#liftrodobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
//	tHeight:100,
	rpage:20,
	isoperate:getAuthIsoperateButtons()
});
function coutomsearch(){
	var html = "";
	return html;
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
							extparam:"&action=query&"+Serializ(formName)
						})
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
    var comid = _liftrodT.GD(id,"comid");
    var tip = "̧�˼�¼ͼƬ";
    Twin({
        Id:"carpics_detail_"+id,
        Title:"�鿴ͼƬ",
        Width:T.gww()-100,
        Height:T.gwh()-50,
        sysfunI:id,
        /*�޸�ͼƬע��ԭ�������߼�*/
        /* Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>" */
        Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='liftrod.do?action=getliftrodpic&liftrodid="+liftrodId+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
    })
}
function setcname(value,pid,colname){
	var url = "";
	if(colname == "uin"){
		url = "cityorder.do?action=getcollname&id="+value;
	}else if(colname == "pass_id"){
		url = "cityorder.do?action=getpassname&id="+value;
	}
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:url,
    		method:"GET",//POST or GET
    		param:"",//GETʱΪ��
    		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
    		dataType:"0",//0text,1xml,2obj
    		success:function(ret,tipObj,thirdParam){
    			if(ret){
					updateRow(pid,colname,ret);
    			}
				else
					updateRow(pid,colname,value);
			},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
    		failure:function(ret,tipObj,thirdParam){
				return false;
			},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
    		thirdParam:"",//�ص������еĵ���������
    		tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
    		waitTip:"���ڻ�ȡ����...",
    		noCover:true
		})
	}else{
		return "��"
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_liftrodT.UCD(rowid,name,value);
}

_liftrodT.C();

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
	if(img&&img!=''){
		var url = "liftrod.do?action=liftpic&filename="+img
		return "<a href='#' onclick='viewpic(\""+img+"\")'><img src='"+url+"' style='width:140px;height:100px;border:0px;vertical-align:top'></a>"
	}else
		return "";
}


</script>

</body>
</html>
