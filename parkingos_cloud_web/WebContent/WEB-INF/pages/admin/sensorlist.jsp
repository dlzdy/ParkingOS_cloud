<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������</title>
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
<body onload="initSelect()">
<div id="sensormanageobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
var stateList = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ռ��"}];
var parks =[];// eval(T.A.sendData("cityberthseg.do?action=getcityparks"));
var citys = eval(T.A.sendData("getdata.do?action=getallcitygroups"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"60",dici_tbissort:false,edit:false},
		{fieldcnname:"���������̻�",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,"city");
				
			}},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,"group");
				
			}},
		{fieldcnname:"��������",fieldname:"comid",fieldvalue:'',inputtype:"select",noList:parks,twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,"park");
				
			}},
        {fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:stateList, twidth:"60" ,height:"",issort:false},
        {fieldcnname:"���������",fieldname:"did",fieldvalue:'',inputtype:"text",twidth:"150",height:"",issort:false},
        {fieldcnname:"��ص�ѹ",fieldname:"battery",fieldvalue:'',inputtype:"number",twidth:"80",height:"",issort:false,edit:false},
        {fieldcnname:"���ݵ�ѹ",fieldname:"magnetism",fieldvalue:'',inputtype:"number",twidth:"80",height:"",issort:false,edit:false},
        {fieldcnname:"����ʱ��",fieldname:"beart_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,edit:false},
		{fieldcnname:"����ʱ��",fieldname:"operate_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false,hide:true},
		{fieldcnname:"X0",fieldname:"x0",fieldvalue:'',inputtype:"text",twidth:"80" ,height:"",issort:false,edit:false,hide:true,shide:true},
   		{fieldcnname:"Y0",fieldname:"y0",fieldvalue:'',inputtype:"text",twidth:"80" ,height:"",issort:false,edit:false,hide:true,shide:true},
   		{fieldcnname:"Z0",fieldname:"z0",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false,edit:false,hide:true,shide:true},
   		{fieldcnname:"(�체)����",fieldname:"rate",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false,edit:false,hide:true,shide:true,
   			process:function(value,pid){
				if(value == "-1"){
					return "";
				}
				return value;
			}
   		}
	];
var _sensormanageT = new TQTable({
	tabletitle:"����������",
	ischeck:'checkbox',
	tablename:"sensormanage_tables",
	dataUrl:"sensormanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#sensormanageobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
var cityslist = [];
if(citys){
	for(var i=0;i<citys.length;i++){
		var cid = citys[i];
		cityslist.push({"value_no":cid.cid,"value_name":cid.cname});
	}
}
function getAuthButtons(){
	var bts=[];
	if(subauth[0])
	bts.push({dname:"�󶨳�����",icon:"edit_add.png",onpress:function(Obj){
		var sids = _sensormanageT.GS();
		if(sids==''){
			T.loadTip(1,"����ѡ�����ݣ�",2,"");
			return ;
		}
		Twin({Id:"sensormanage_search_w",Title:"�󶨳�����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "sensormanage_search_f",
					formObj:tObj,
					formWinId:"sensormanage_search_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϰ�"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
						 {fieldcnname:"�����̻�",fieldname:"city",inputtype:"cselect",noList:cityslist,target:"group",action:"getcitygroups"},
						 {fieldcnname:"����",fieldname:"group",inputtype:"cselect",noList:[],target:"park",action:"getparkbygroupid"},
						 {fieldcnname:"�󶨵�ͣ����",fieldname:"park",inputtype:"cselect",noList:[]}]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("sensormanage_search_w");} }
					],
					SubAction:
					function(callback,formName){
						Tconfirm({Title:"ȷ�ϰ���",Content:"ȷ�ϰ���",OKFn:function(){
							T.A.sendData("sensormanage.do?action=bindsensor","post","ids="+sids+"&"+Serializ(formName),
							function deletebackfun(ret){
								if(ret=="1"){
									T.loadTip(1,"�󶨳ɹ���",2,"");
									TwinC("sensormanage_search_w");
									_sensormanageT.M();
								}else{
									T.loadTip(1,ret,2,"");
								}
							}
						)}})
					}
				});	
			}
		})
	
	}});
	bts.push({dname:"ȡ����",icon:"edit_add.png",onpress:function(Obj){
		var sids = _sensormanageT.GS();
		if(sids==''){
			T.loadTip(1,"����ѡ�����ݣ�",2,"");
			return ;
		}
		Tconfirm({Title:"ȷ��ȡ������",Content:"ȷ��ȡ������",OKFn:function(){
			T.A.sendData("sensormanage.do?action=cancalbind","post","ids="+sids,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ȡ���󶨳ɹ���",2,"");
					_sensormanageT.M();
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}});
	
	}});
	if(bts.length>0)
		return bts;
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[1])
	bts.push({name:"��ʼ���ش�",fun:function(id){
		Tconfirm({Title:"��ʼ���ش�",Content:"ȷ�ϳ�ʼ���ش���",OKFn:function(){
		T.A.sendData("sensormanage.do?action=intixyz","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"�����ɹ���",2,"");
					_sensormanageT.M();
				}else if(ret == "-2"){
					T.loadTip(1,"ֻ���체�������������������TB��ͷ���ɳ�ʼ��!",2,"");
				}else{
					T.loadTip(1,"����ʧ��!",2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}


function coutomsearch(){
	var html = "&nbsp;&nbsp; ���У�<select id='city' style='width:159px' onChange='changegroup(this.value)'/> </select> "+
				"&nbsp;&nbsp;���ţ�<select id='group' style='width:159px' onChange='changepark(this.value)'/> </select>"+
				"&nbsp;&nbsp;������<select id='park' style='width:159px' /> </select>"+
				"&nbsp;&nbsp;�شţ�<input id ='dici'/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>";
	return html;
}

function initSelect(){
	var cityselect = document.getElementById('city');
	cityselect.options.add(new Option("��ѡ��", "-1"));
	if(citys){
		for(var i=0;i<citys.length;i++){
			var cid = citys[i];
			var varItem = new Option(cid.cname, cid.cid);      
			cityselect.options.add(varItem);  
		}
	}
}
function changegroup(value){
	var groupselect = document.getElementById('group');
	for(var i=groupselect.options.length-1;i>=0;i--)
		groupselect.options.remove(i);
	var parkselect = document.getElementById('park');
	for(var i=parkselect.options.length-1;i>=0;i--)
		parkselect.options.remove(i);
	groupselect.options.add(new Option("��ѡ��", "-1"));
	for(var i=0;i<citys.length;i++){
		var cid = citys[i].cid;
		if(cid==value){
			var groups = citys[i].groups;
			for(var j=0;j<groups.length;j++){
				var _group = groups[j];
				var varItem = new Option(_group.gname, _group.gid);
				groupselect.options.add(varItem);  
			}
			break;
		}
	}
}
function changepark(value){
	var parkselect = document.getElementById('park');
	for(var i=parkselect.options.length-1;i>=0;i--)
		parkselect.options.remove(i);
	var parks = eval(T.A.sendData("getdata.do?action=getparkbygroupid&groupid="+value));
	
	for(var i=0;i<parks.length;i++){
		var varItem = new Option(parks[i].value_name, parks[i].value_no);
		parkselect.options.add(varItem);  
	}
	
}
function searchdata(type){
	var city = T("#city").value;
	var group = T("#group").value;
	var park = T("#park").value;
	var dici = T("#dici").value;
	//data=eval(T.A.sendData("parkingturnover.do?action=echarts&btime="+btime+"&etime="+etime));
	_sensormanageT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&city="+city+"&group="+group+"&park="+park+"&dici="+dici,
	});
	T("#dici").value=dici;
	initSelect();
}

var cachedgroup = [];
function setcname(value,rowid,type){
	var group = cachedgroup["'"+value+"'"];
	var groupid = '';
	if(!group&&parseInt(value)>1000){
		group = eval(T.A.sendData("getdata.do?action=getgroupidbyparkid&parkid="+value));
		cachedgroup["'"+value+"'"]=group;
	}
	
	if(citys&&group){
		if(type=='park'){
			return group[0].parkname;
		}else if(type=='group'){
			groupid=group[0].groupid;
			for(var i=0;i<citys.length;i++){
				var cid = citys[i];
				var groups = citys[i].groups;
				for(var j=0;j<groups.length;j++){
					var _group = groups[j];
					var gid = _group.gid;
					if(gid==groupid){
						return _group.gname;
					}
				}
			}
		}else if(type=='city'){
			groupid=group[0].groupid;
			for(var i=0;i<citys.length;i++){
				var cid = citys[i];
				var groups = citys[i].groups;
				for(var j=0;j<groups.length;j++){
					var _group = groups[j];
					var gid = _group.gid;
					if(gid==groupid){
						return citys[i].cname;
					}
				}
			}
		}
	}else {
		return value;
	}
	//_sensormanageT.UCD(pid,name,value);	
}
_sensormanageT.C();
</script>

</body>
</html>
