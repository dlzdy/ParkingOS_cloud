<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ɫ����</title>
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
<div id="functionobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var orglist = eval(T.A.sendData("getdata.do?action=getorg"));
var _mediaField = [
		{fieldcnname:"��ɫ���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"��ɫ����",fieldname:"role_name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������֯",fieldname:"oid",fieldvalue:'',inputtype:"select",noList:orglist,twidth:"100" ,height:"",issort:false,edit:false/* hide:true, edit:false*/},
		{fieldcnname:"��ע",fieldname:"resume",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false}
	];

var _functionT = new TQTable({
	tabletitle:"��ɫ����",
	ischeck:false,
	tablename:"function_tables",
	dataUrl:"orgrole.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&oid=${oid}",
	tableObj:T("#functionobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	bts.push({dname:"��ӽ�ɫ",icon:"edit_add.png",onpress:function(Obj){
				Twin({Id:"function_add",Title:"��ӽ�ɫ",Width:550,sysfun:function(tObj){
					Tform({
						formname: "parking_edit_f",
						formObj:tObj,
						recordid:"id",
						suburl:"orgrole.do?action=create&oid=${oid}",
						method:"POST",
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("function_add");} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"��ӳɹ���",2,"");
								TwinC("function_add");
								_functionT.M();
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
	bts.push({name:"�༭",fun:function(id){
		T.each(_functionT.tc.tableitems,function(o,j){
			o.fieldvalue = _functionT.GD(id)[j]
		});
		Twin({Id:"function_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "function_edit_f",
					formObj:tObj,
					recordid:"function_id",
					suburl:"orgrole.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_functionT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("function_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("function_edit_"+id);
							_functionT.M();
						}else if(ret=="-2"){
							T.loadTip(1,"����Ա��ɫ���ܱ༭��",2,"");
						}else{
							T.loadTip(1,"�༭ʧ��!",2,o);
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){
		T.A.sendData("orgrole.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_functionT.M()
				}else if(ret=="-2"){
					T.loadTip(1,"����Ա��ɫ����ɾ����",2,"");
				}else if(ret=="-3"){
					T.loadTip(1,"�ý�ɫ����ʹ���У�����ɾ����",2,"");
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}}
	);
	
	if(bts.length <= 0){return false;}
	return bts;
}


_functionT.C();
</script>

</body>
</html>
