<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��λ����</title>
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
<div id="cityberthobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false,shide:true,hide:true,fhide:true},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",twidth:"150",noList:parks,target:"berthsec_id",action:"getberthseg",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'berthsec_id');
			}},
		/* {fieldcnname:"������",fieldname:"dici_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setcname(value,pid,'dici_id');
			}}, */
		{fieldcnname:"���������",fieldname:"did",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",hide:true,shide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"����"},{"value_no":"1","value_name":"ռ��"}], twidth:"80" ,height:"",hide:true},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		/* {fieldcnname:"Ψһ���",fieldname:"uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false}, */
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true}
	];
	
var _edit=[
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true},
		/* {fieldcnname:"Ψһ���",fieldname:"uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false} */
	];
	
var _bath=[
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:parks,target:"berthsec_id",action:"getberthseg",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��",fieldname:"berthsec_id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"150" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setcname(value,pid,'berthsec_id');
			}},
		{fieldcnname:"��λ���",fieldname:"cid",fieldvalue:'',inputtype:"multi", twidth:"300" ,height:"100",issort:false},
		{fieldcnname:"��ʾ��",fieldname:"",fieldvalue:'֧�����ָ�ʽ��1��������䣬�磺A0001-A0200��2�������� ����Ӣ�Ķ��Ÿ������磺A0099,B0099,C3399��3��������ţ���A0033',inputtype:"textd", twidth:"400" ,height:"",issort:false}
	];
var rules =[
		{name:"comid",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		{name:"cid",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		];
var _cityberthT = new TQTable({
	tabletitle:"��λ����",
	ischeck:false,
	tablename:"cityberth_tables",
	dataUrl:"cityberth.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityberthobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityberthT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"sensor_search_w",Title:"������λ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "sensor_search_f",
					formObj:tObj,
					formWinId:"sensor_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensor_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_cityberthT.C({
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
	bts.push({dname:"��Ӳ�λ",icon:"edit_add.png",onpress:function(Obj){
				T.each(_cityberthT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"cityberth_add",Title:"��Ӳ�λ",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"cityberth.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}],
							rules:rules
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cityberth_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("cityberth_add");
								_cityberthT.M();
							}else if(ret=="-1"){
								T.loadTip(1,"��ѡ���������� ��",2,"");
							}else if(ret == "-2"){
								T.loadTip(1,"�ò�λ���Ѵ��� ��",2,"");
							}else if(ret == "-3"){
								T.loadTip(1,"��������Ų����� ��",2,"");
							}else if(ret == "-4"){
								T.loadTip(1,"�ó���������Ѻ�������λ�� ��",2,"");
							}else {
								T.loadTip(1,ret,2,o);
							}
						}
					});	
				}
			});
		}});
	if(subauth[4])
		bts.push({dname:"������Ӳ�λ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityberthT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		
		Twin({Id:"compark_add",Title:"��Ӳ�λ",Width:550,sysfun:function(tObj){
				Tform({
					formname: "compark_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"compark.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_bath}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("compark_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(parseInt(ret)>0){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("compark_add");
							_cityberthT.M();
						}else if(ret == "-2"){
							T.loadTip(1,"�˲�λ��ŷ�Χ�ڰ����Ѿ����ڵĲ�λ��ţ������µ�����Χ��",2,"");
						}else{
							T.loadTip(1,"���ʧ�ܣ�",2,o);
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
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		/* T.each(_cityberthT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityberthT.GD(id)[j];
		}); */
		var cid = _cityberthT.GD(id,"cid");
		var address = _cityberthT.GD(id,"address");
		var longitude = _cityberthT.GD(id,"longitude");
		var latitude = _cityberthT.GD(id,"latitude");
		Twin({Id:"cityberth_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "cityberth_edit_f",
					formObj:tObj,
					recordid:"cityberthsec_id",
					suburl:"cityberth.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_edit}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cityberth_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("cityberth_edit_"+id);
							_cityberthT.M();
						}else if(ret=="-1"){
								T.loadTip(1,"��ѡ���������� ��",2,"");
						}else if(ret=="-2"){
								T.loadTip(1,"�ò�λ����Ѵ��ڣ�",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
				T("#cityberth_edit_f_cid").value=cid;
				T("#cityberth_edit_f_address").value=address;
				T("#cityberth_edit_f_longitude").value=longitude;
				T("#cityberth_edit_f_latitude").value=latitude;
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("cityberth.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_cityberthT.M();
				}if(ret=="-2"){
					T.loadTip(1,"���Ƚ���ͳ������İ󶨣�",2,"");
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[5])
	bts.push({name:"�󶨳�����",fun:function(id){
		var comid = _cityberthT.GD(id,"comid");
		Twin({
			Id:"induce_detail_"+id,
			Title:"�󶨳�����  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"cityberth.do?action=tobindsensor&berthid="+id+"&comid="+comid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(subauth[6])
	bts.push({name:"��󳵼���",fun:function(id){
		Tconfirm({Title:"��󳵼���",Content:"ȷ�Ͻ�󳵼�����",OKFn:function(){
		T.A.sendData("cityberth.do?action=unbindsensor","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"���ɹ���",2,"");
					_cityberthT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		var url = "";
		if(colname == "berthsec_id"){
			url = "cityberthseg.do?action=getberthseg&id="+value;
		}else if(colname == "dici_id"){
			url = "cityberth.do?action=getdici&id="+value;
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
	_cityberthT.UCD(rowid,name,value);
}

_cityberthT.C();
</script>

</body>
</html>
