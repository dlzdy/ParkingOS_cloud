<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���͹���</title>
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
<div id="freereasonssetobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var issupperadmin=${supperadmin};
var authlist ="";
if(issupperadmin&&issupperadmin==1)
	authlist="0,1,2,3,4";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
/*Ȩ��*/


var role=${role};
var comid=${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"sort",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false}
	];
var _freereasonssetT = new TQTable({
	tabletitle:"���ԭ���趨",
	ischeck:false,
	tablename:"freereasons_tables",
	dataUrl:"freereasons.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#freereasonssetobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
 	var bts=[];
 	if(subauth[1])
 		bts.push({dname:"������ԭ��",icon:"edit_add.png",onpress:function(Obj){
 			T.each(_freereasonssetT.tc.tableitems,function(o,j){
			o.fieldvalue = "";
		});
		Tconfirm({
				Title:"��ʾ��Ϣ",
				Ttype:"alert",
				Content:"��ʾ��������ԭ����Ҫ���³�����HD���汾��1.2.5���ϲſ���ʹ�ã�",
				OKFn:function(){
					Twin({Id:"freereasons_add",Title:"������ԭ��",Width:550,sysfun:function(tObj){
						Tform({
							formname: "parking_edit_f",
							formObj:tObj,
							recordid:"id",
							suburl:"freereasons.do?action=create&comid="+comid,
							method:"POST",
							Coltype:2,
							formAttr:[{
								formitems:[{kindname:"",kinditemts:_mediaField}]
							}],
							buttons : [//����
								{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("freereasons_add");} }
							],
							subFun:checkSort,
							Callback:
							function(f,rcd,ret,o){
								if(ret=="1"){
									T.loadTip(1,"��ӳɹ���",2,"");
									TwinC("freereasons_add");
									_freereasonssetT.M();
								}else if(ret=='-2'){
									T.loadTip(1,"�����ظ���� ��",2,"");
								}else {
									T.loadTip(1,ret,2,o);
								}
							}
						});	
			}
		})
				}
			});
		
	}});
	
	return bts;
}

//�鿴,���,�༭,ɾ��,�������ִ�С��
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
		bts.push({name:"�༭",fun:function(id){
		T.each(_freereasonssetT.tc.tableitems,function(o,j){
			o.fieldvalue = _freereasonssetT.GD(id)[j]
		});
		Twin({Id:"freereasons_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "freereasons_edit_f",
					formObj:tObj,
					recordid:"freereasons_id",
					suburl:"freereasons.do?action=edit&comid="+comid+"&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_freereasonssetT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cartype_edit_"+id);} }
					],
					subFun:checkSort,
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("freereasons_edit_"+id);
							_freereasonssetT.M()
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
		//id = _freereasonssetT.GD(id)[1];
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("freereasons.do?action=delete&comid="+comid,"post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_freereasonssetT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	if(bts.length <= 0){return false;}
	return bts;
}
//������
var checkSort=function(formname){
	var val = T("#"+formname+"_sort").value;
	var cid =  T("#"+formname+"_id").value;
	var talbleData = _freereasonssetT.oGridData;
	if(talbleData){
		var rows =talbleData.rows; 
		//alert(rows);
		for (var i=0;i<rows.length;i++){
			var id = rows[i].id;
			var fval = _freereasonssetT.GD(id,"sort");
			//alert(val+"--->"+fval);
			if(cid==''){//�¼Ӽ�¼
				if(val==fval){
					alert('����ţ�'+val+'�Ѵ��ڣ�');
					return false;
				}
			}else{//�޸ļ�¼
				if(val==fval&&id!=cid){
					alert('����ţ�'+val+'�Ѵ��ڣ�');
					return false;
				}
			}
			
		}
	}
	return true;
}

_freereasonssetT.C();
</script>

</body>
</html>
