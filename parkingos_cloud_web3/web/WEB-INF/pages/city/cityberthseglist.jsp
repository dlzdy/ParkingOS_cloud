<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��λ�ι���</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
	<script src="js/jquery.js" type="text/javascript">//���</script>
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
<div id="cityberthsegobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var parks = eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number",twidth:"80" ,height:"",edit:false,issort:false},
		{fieldcnname:"Ψһ��ʶ",fieldname:"uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,fhide:true,hide:true,shide:true},
		{fieldcnname:"��λ������",fieldname:"berthsec_name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��uuid",fieldname:"park_uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,fhide:true,hide:true,shide:true},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"berthnum",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,shide:true},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true,fhide:true,shide:true},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true}
	];
var _edit=[
		{fieldcnname:"Ψһ��ʶ",fieldname:"uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,fhide:true,hide:true},
		{fieldcnname:"��λ������",fieldname:"berthsec_name",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"������λ��uuid",fieldname:"park_uuid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,fhide:true,hide:true},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,hide:true}
	];
var rules =[
		{name:"berthsec_name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		{name:"comid",requir:true}
		];
var _cityberthsegT = new TQTable({
	tabletitle:"��λ�ι���",
	ischeck:false,
	tablename:"cityberthseg_tables",
	dataUrl:"cityberthseg.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#cityberthsegobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_cityberthsegT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		}); 
		Twin({Id:"sensor_search_w",Title:"������λ��",Width:550,sysfun:function(tObj){
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
						_cityberthsegT.C({
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
	bts.push({dname:"��Ӳ�λ��",icon:"edit_add.png",onpress:function(Obj){
				T.each(_cityberthsegT.tc.tableitems,function(o,j){
					o.fieldvalue = "";
				});
				Twin({Id:"cityberthseg_add",Title:"��Ӳ�λ��",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"cityberthseg.do?action=create",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}],
							rules:rules
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cityberthseg_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("cityberthseg_add");
								_cityberthsegT.M();
							}else if(ret=="-1"){
								T.loadTip(1,"��ѡ�񳵳� ��",2,"");
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
		/*T.each(_cityberthsegT.tc.tableitems,function(o,j){
			o.fieldvalue = _cityberthsegT.GD(id)[j];
		});*/
		var uuid = _cityberthsegT.GD(id,"uuid");
		var berthsec_name = _cityberthsegT.GD(id,"berthsec_name");
		var park_uuid = _cityberthsegT.GD(id,"park_uuid");
		var address = _cityberthsegT.GD(id,"address");
		var longitude = _cityberthsegT.GD(id,"longitude");
		var latitude = _cityberthsegT.GD(id,"latitude");
		Twin({Id:"cityberthseg_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "cityberthseg_edit_f",
					formObj:tObj,
					recordid:"cityberthseg_id",
					suburl:"cityberthseg.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_edit}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cityberthseg_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("cityberthseg_edit_"+id);
							_cityberthsegT.M();
						}else if(ret=="-1"){
							T.loadTip(1,"��ѡ�񳵳� ��",2,"");
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
				T("#cityberthseg_edit_f_uuid").value=uuid;
				T("#cityberthseg_edit_f_berthsec_name").value=berthsec_name;
				T("#cityberthseg_edit_f_park_uuid").value=park_uuid;
				T("#cityberthseg_edit_f_address").value=address;
				T("#cityberthseg_edit_f_longitude").value=longitude;
				T("#cityberthseg_edit_f_latitude").value=latitude;
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("cityberthseg.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_cityberthsegT.M();
				}if(ret=="-2"){
					T.loadTip(1,"���Ƚ���󶨵Ĳ�λ��",2,"");
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[4])
	bts.push({name:"�󶨲�λ",fun:function(id){
		var comid = _cityberthsegT.GD(id,"comid");
		Twin({
			Id:"induce_detail_"+id,
			Title:"�󶨲�λ &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"cityberthseg.do?action=tounbindberth&berthsegid="+id+"&comid="+comid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
	}});
	if(subauth[5])
		bts.push({name:"���λ",fun:function(id){
			var comid = _cityberthsegT.GD(id,"comid");
			Twin({
				Id:"induce_detail_"+id,
				Title:"���λ &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
				Content:"<iframe src=\"cityberthseg.do?action=tobindberth&berthsegid="+id+"&comid="+comid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
				Width:T.gww()-100,
				Height:T.gwh()-50
			})
		}});
		bts.push({name:"ǩ��",fun:function(id){
			T.A.sendData("cityberthseg.do?","post","action=queryworker&id="+id,
					function deletebackfun(ret){
						var arr = ret.split("_");
						if(arr.length==2){
							var uid = arr[0];
							var nickname = arr[1];
						}
						Tconfirm({Title:"ȷ��ǩ����",Content:"ȷ��ǩ���𣿵�ǰ�ϰ��շ�Ա:"+nickname,OKFn:function(){
							T.A.sendData("cityberthseg.do?action=workout","post","id="+id+"&uid="+uid,
									function deletebackfun(ret){
										if(ret=="1") {
											T.loadTip(1, "ǩ�˳ɹ���", 2, "");
											_cityberthsegT.M();
										}else if(ret=="-1"){
											T.loadTip(1,"û�������ϰ���շ�Ա",2,"");
										}else{
											T.loadTip(1,"ǩ��ʧ��",2,"");
										}
									}
							)}})
					}
			)
		}});
	if(bts.length <= 0){return false;}
	return bts;
}


_cityberthsegT.C();
</script>

</body>
</html>
