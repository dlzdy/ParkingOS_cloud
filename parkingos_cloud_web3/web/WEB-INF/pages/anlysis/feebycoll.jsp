<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�շ�Ա������ջ���</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?000817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?1020" type="text/javascript">//���</script>
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?000817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>
<body>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>

<div id="parkduranlayobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">

/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴,���,�༭,ɾ��
/*Ȩ��*/
var _mediaField =[
    {kindname:"",kinditemts: [
        {fieldcnname:"����",fieldname:"comname",inputtype:"text",twidth:"80",issort:false},//,shide:true }
    ]},
	  {kindname:"",kinditemts: [
        {fieldcnname:"�˺�",fieldname:"id",inputtype:"text",twidth:"80",issort:false }
       ]},
	  {kindname:"",kinditemts: [
		{fieldcnname:"����",fieldname:"nickname",inputtype:"text",twidth:"150",issort:false }
	  ]},
	  {kindname:"",kinditemts: [
		{fieldcnname:"��ע",fieldname:"resume",inputtype:"text",twidth:"150",issort:false }
	  ]},
      {kindname:"ͣ����-�ֽ�֧��",kinditemts: [
    	{fieldcnname:"��ͨ����",fieldname:"cashCustomFee",inputtype:"text",twidth:"80",issort:false,shide:true },
    	//{fieldcnname:"׷�ɶ���",fieldname:"cashPursueFee",inputtype:"text",twidth:"80",issort:false,shide:true },
    	{fieldcnname:"�ϼ�",fieldname:"cashTotalFee",inputtype:"text",twidth:"80",issort:false,
    		process:function(value,cid,id){
				return "<a href=# onclick=\"detail(0,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			},shide:true}
     ]},
     {kindname:"ͣ����-����֧��",kinditemts: [
		{fieldcnname:"��ͨ����",fieldname:"ePayCustomFee",inputtype:"text",twidth:"80",issort:false,shide:true },
		//{fieldcnname:"׷�ɶ���",fieldname:"ePayPursueFee",inputtype:"text",twidth:"80",issort:false,shide:true},
		{fieldcnname:"�ϼ�",fieldname:"ePayTotalFee",inputtype:"text",twidth:"80",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"detail(1,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			},shide:true}
	 ]},
	/*{kindname:"ͣ����-ˢ��֧��",kinditemts: [
   		{fieldcnname:"��ͨ����",fieldname:"cardCustomFee",inputtype:"text",twidth:"80",issort:false,shide:true },
		{fieldcnname:"׷�ɶ���",fieldname:"cardPursueFee",inputtype:"text",twidth:"80",issort:false,shide:true},
		{fieldcnname:"�ϼ�",fieldname:"cardTotalFee",inputtype:"text",twidth:"80",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"detail(6,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			},shide:true}
   	]},*/
   	{kindname:"ͣ����-�ϼ�",kinditemts: [
   		{fieldcnname:"ʵ��ͣ����",fieldname:"totalFee",inputtype:"text",twidth:"80",issort:false,shide:true},
   		//{fieldcnname:"δ��ͣ����",fieldname:"escapeFee",inputtype:"text",twidth:"80",issort:false,shide:true},
   		{fieldcnname:"Ӧ��ͣ����",fieldname:"allTotalFee",inputtype:"text",twidth:"80",issort:false,shide:true}
   	]}
   	/*{kindname:"��Ƭ",kinditemts: [
   		{fieldcnname:"�ۿ�����ֵ",fieldname:"cardActFee",inputtype:"text",twidth:"80",issort:false,
   			process:function(value,cid,id){
				return "<a href=# onclick=\"detail(8,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			},shide:true},
   		{fieldcnname:"��Ƭ��ֵ",fieldname:"cardChargeCashFee",inputtype:"text",twidth:"80",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"detail(9,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			},shide:true},
   		{fieldcnname:"ע������ֵ",fieldname:"cardReturnFee",inputtype:"text",twidth:"80",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"detail(10,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			},shide:true}
   	]}*/
  ];
var _parkduranlayT = new TQTable({
	tabletitle:"�շ�Ա������ջ���",
	ischeck:false,
	tablename:"parkduranlay_tables",
	dataUrl:"feebycoll.do",
	iscookcol:false,
	headrows:true,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#parkduranlayobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	//quikcsearch:coutomsearch(),
	isoperate:getAuthIsoperateButtons()
});
//�鿴,���,�༭,ɾ��
function getAuthButtons(){
	var bts=[];
	//if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
			T.each(_parkduranlayT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			}); 
			Twin({Id:"sensor_search_w",Title:"����",Width:550,sysfun:function(tObj){
					TSform ({
						formname: "sensor_search_f",
						formObj:tObj,
						formWinId:"sensor_search_w",
						formFunId:tObj,
						formAttr:[{
							formitems:_mediaField
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensor_search_w");} }
						],
						SubAction:
						function(callback,formName){
							_parkduranlayT.C({
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
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

function detail(type,value,id){
	var id =_parkduranlayT.GD(id, "id");
	var tip = "��Ŀ��ϸ";
	Twin({
		Id:"midpre_detail_"+id,
		Title:tip,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='midpre_detail_'"+id+" id='midpre_detail_'"+id+" src='statsaccount.do?&seltype=0&statsid="+id+"&from="+type+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		var url = "";
		if(colname == "berthsec_id"){
			url = "cityberthseg.do?action=getberthseg&id="+value;
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
		_parkduranlayT.UCD(rowid,name,value);
}

_parkduranlayT.C();
</script>

</body>
</html>
