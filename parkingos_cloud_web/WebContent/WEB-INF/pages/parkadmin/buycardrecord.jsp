<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�¿����Ѽ�¼</title>
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
<div id="buycardobj" style="width:100%;height:100%;margin:0px;"></div>
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
//var liftreason=eval('${liftreason}');
var cityid="${cityid}";

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"������ˮ��",fieldname:"trade_no",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�¿����",fieldname:"card_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�¿�����ʱ��",fieldname:"pay_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"Ӧ�ս��",fieldname:"amount_receivable",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ʵ�ս��",fieldname:"amount_pay",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"collector",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ɷ�����",fieldname:"pay_type",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"�û����",fieldname:"user_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"��������",fieldname:"buy_month",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��Ч��",fieldname:"limit_time",fieldvalue:'',inputtype:"date", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"resume",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false}
	];
var _buycardT = new TQTable({
	tabletitle:"�¿����Ѽ�¼",
	ischeck:false,
	tablename:"buycard_tables",
	dataUrl:"buycardrecord.do",
	iscookcol:false,
	//dbuttons:false,
	quikcsearch:coutomsearch(),
	buttons:getAuthButtons(),
	//searchitem:true,
	isidentifier:false,
	param:"action=query&comid="+comid,
	tableObj:T("#buycardobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	tHeight:100,
	rpage:20,
	isoperate:getAuthIsoperateButtons()
});
function coutomsearch(){
	var html = "";
	if(groupid != ""){
		html = "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='companys' onchange='searchdata();' ></select></div>";
	}
    if(cityid != ""){
        html += "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;��������:&nbsp;&nbsp;<select id='groups' onchange='searchgroupdata();'></select></div>";
        html += "<div style='vertical-align:middle;margin-top:5px;float:left;'>&nbsp;&nbsp;&nbsp;&nbsp;����:&nbsp;&nbsp;<select id='newCompanys' onchange='searchCompanydata();' ></select></div>";
    }

    html += "&nbsp;&nbsp;<span id='total_money'></span>";
	return html;
}

function searchgroupdata(){
	groupid = T("#groups").value;
    _buycardT.C({
        cpage:1,
        tabletitle:"�߼��������",
        extparam:"&groupid="+groupid+"&action=query"
    })
    addgroups();
    addCitycoms();
}

function searchCompanydata(){
    comid = T("#newCompanys").value;
    _buycardT.C({
        cpage:1,
        tabletitle:"�߼��������",
        extparam:"&comid="+comid+"&action=query"
    })
    addgroups();
    addCitycoms();
}

function searchdata(){
    comid = T("#companys").value;
    T("#choosecom").action="buycardrecord.do?comid="+comid+"&authid=${authid}&r"+Math.random();
    T("#choosecom").submit();
}
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_buycardT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"buycard_search_w",Title:"�¿����Ѽ�¼",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "buycard_search_f",
					formObj:tObj,
					formWinId:"buycard_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("buycard_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_buycardT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
                        addgroups();
                        addCitycoms();
					}
				});	
			}
		})
	
	}});
	if(subauth[1])
		bts.push({dname:"����",icon:"toxls.gif",onpress:function(Obj){
		Twin({Id:"buycard_export_w",Title:"����<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "buycard_export_f",
					formObj:tObj,
					formWinId:"buycard_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="buycardrecord.do?action=exportExcel&comid="+comid
						+"&rp="+2147483647+"&fieldsstr="+"id__trade_no__card_id__pay_time__amount_receivable__amount_pay__collector__pay_type__car_number__user_id__limit_time__resume&"+Serializ(formName)
						TwinC("buycard_export_w");
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
_buycardT.C();

function addcoms(){
	if(groupid != ""){
		var childs = eval(T.A.sendData("getdata.do?action=getcoms&groupid=${groupid}"));
		jQuery("#companys").empty();
        jQuery("#companys").append("<option value='-1' selected >��ѡ��</option>");
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


function addgroups(){
    if(cityid != ""){
        var childs = eval(T.A.sendData("getdata.do?action=getgroups&cityid=${cityid}"));
        jQuery("#groups").empty();
        for(var i=0;i<childs.length;i++){
            var child = childs[i];
            var id = child.value_no;
            var name = child.value_name;
            jQuery("#groups").append("<option value='"+id+"'>"+name+"</option>");
        }
        T("#groups").value = groupid;
    }
}
function addCitycoms(){
    if(cityid != ""){
        var childs = eval(T.A.sendData("getdata.do?action=getcoms&cityid=${cityid}"));
        jQuery("#newCompanys").empty();
        jQuery("#newCompanys").append("<option value='-1' selected>��ѡ��</option>");
        for(var i=0;i<childs.length;i++){
            var child = childs[i];
            var id = child.value_no;
            var name = child.value_name;
            jQuery("#newCompanys").append("<option value='"+id+"'>"+name+"</option>");
        }
        if(comid){
            T("#newCompanys").value = comid;
        };
    }
}

if(cityid != ""){//���Ź���Ա��¼����ʾ�����б�
    groupid=-1;
    comid=-1;
    addgroups();
    addCitycoms();
}


var getobj=function(id){return document.getElementById(id)};
</script>

</body>
</html>
