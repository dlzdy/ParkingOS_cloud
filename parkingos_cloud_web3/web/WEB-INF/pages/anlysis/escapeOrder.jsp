<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ӵ�</title>
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
<div id="accountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var statsid="${statsid}";
var btime="${btime}";
var etime="${etime}";
var seltype="${seltype}";
var from="${from}";
/*Ȩ��*/
var type = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},
            {"value_no":1,"value_name":"֧��"}];
var charge_type = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ͣ����"},
            {"value_no":3,"value_name":"Ԥ��ͣ����"},{"value_no":4,"value_name":"Ԥ�������˿�"},
            {"value_no":5,"value_name":"Ԥ�����㲹��"},{"value_no":2,"value_name":"׷��ͣ����"}];

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"80" ,height:"",edit:false,issort:false,shide:true,fhide:true},
		{fieldcnname:"�˺�",fieldname:"uid",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"��Ŀ����",fieldname:"type",fieldvalue:'',inputtype:"select", noList:type ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������ʽ",fieldname:"source",fieldvalue:'',inputtype:"select", noList:charge_type,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"amount",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"orderid",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
						if(value == "-1"){
							return "";
						}else{
							return value;
						}
				}},
		{fieldcnname:"��¼����",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false}
	];

var _accountT = new TQTable({
	tabletitle:"�ӵ�",
	ischeck:false,
	tablename:"account_tables",
	dataUrl:"statsaccount.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&from="+from+"&seltype="+seltype+"&statsid="+statsid+"&btime="+btime+"&etime="+etime,
	tableObj:T("#accountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_accountT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"account_search_w",Title:"�����շ���ϸ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "account_search_f",
					formObj:tObj,
					formWinId:"account_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("account_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_accountT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&from="+from+"&seltype="+seltype+"&statsid="+statsid+"&btime="+btime+"&etime="+etime+"&"+Serializ(formName)
						});
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
	
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		var url = "";
		if(colname == "uid"){
			url = "getdata.do?action=nickname&id="+value;
		}
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
		_accountT.UCD(rowid,name,value);
}

function setname(value, list){
	if(value != "" && value != "-1"){
		for(var i=0; i<list.length;i++){
			var o = list[i];
			var key = o.value_no;
			var v = o.value_name;
			if(value == key){
				return v;
			}
		}
	}else{
		return "";
	}
}

_accountT.C();
</script>

</body>
</html>
