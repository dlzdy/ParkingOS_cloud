<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ϵͳ��̨LOGO����</title>
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
<div id="clogoobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false,hide:true,shide:true,fhide:true},
		{fieldcnname:"����",fieldname:"name",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"ϵͳ��̨LOGO",fieldname:"url_fir",inputtype:"date", twidth:"150" ,edit:false,hide:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>����鿴</a>";
				}else
					return value;
			}
		},
		{fieldcnname:"��ͤ��������LOGO",fieldname:"url_sec",inputtype:"date", twidth:"150" ,edit:false,hide:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>����鿴</a>";
				}else
					return value;
			}
		}
		
	];
function viewpic(name){
	var url = 'viewpic.html?name='+name+'&db=logo_pics';
	Twin({Id:"clogo_edit_pic",Title:"�鿴logo",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
var _clogoT = new TQTable({
	tabletitle:"logo����",
	ischeck:false,
	tablename:"clogo_tables",
	dataUrl:"cloudlogo.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=querycloud",
	tableObj:T("#clogoobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	bts.push({dname:"���LOGO",icon:"edit_add.png",onpress:function(Obj){
	T.each(_clogoT.tc.tableitems,function(o,j){
		o.fieldvalue ="";
	});
	Twin({Id:"_clogoT_add",Title:"���LOGO",Width:550,sysfun:function(tObj){
			Tform({
				formname: "_clogoT_edit_f",
				formObj:tObj,
				recordid:"id",
				suburl:"cloudlogo.do?action=create&type=${type}",
				method:"POST",
				formAttr:[{
					formitems:[{kindname:"",kinditemts:_mediaField}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("_clogoT_add");} }
				],
				Callback:
				function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"��ӳɹ���",2,"");
						TwinC("_clogoT_add");
						_clogoT.M();
					}else if(ret=="2"){
						T.loadTip(1,"�Ѵ��ڼ�¼�������ظ����",2,o);
					}else{
						T.loadTip(1,"���ʧ��",2,o);
					}
				}
			});	
		}
	})
	}});
	return bts;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�ϴ�ϵͳ��̨logo",fun:function(id){
		var url ="upload.html?url=cloudlogo&action=uploadpic&table=logo_pics&type=${type}&logotype=1&id="+id;
		Twin({Id:"clogo_edit_"+id,Title:"�ϴ�logo",Width:350,Height:200,sysfunI:id,
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				_clogoT.M();
			}
			})
	}});
	bts.push({name:"|	�ϴ���ͤ��������logo",fun:function(id){
		var url ="upload.html?url=cloudlogo&action=uploadpic&table=logo_pics&type=${type}&logotype=2&id="+id;
		Twin({Id:"clogo_edit_"+id,Title:"�ϴ�logo",Width:350,Height:200,sysfunI:id,
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				_clogoT.M();
			}
			})
	}});
	bts.push({name:"|	�༭",fun:function(id){
		T.each(_clogoT.tc.tableitems,function(o,j){
			o.fieldvalue = _clogoT.GD(id)[j]
		});
		Twin({Id:"_clogoT_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "_clogoT_edit_f",
					formObj:tObj,
					recordid:"_clogoT_id",
					suburl:"cloudlogo.do?&action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_clogoT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("_clogoT_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("_clogoT_edit_"+id);
							_clogoT.M();
						}else{
							T.loadTip(1,"�༭ʧ�ܣ�",2,o)
						}
					}
				});	
			}
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_clogoT.C();
</script>

</body>
</html>
