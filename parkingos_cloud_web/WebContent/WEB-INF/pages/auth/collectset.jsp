<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�շ�����</title>
<script type="text/javascript" src="js/tq.js"></script>
<body>
<div style="widtd:400px; margin-top:30px;margin-left:80px;line-height:26px;">
	<form motded ="post" action="adminrole.do">
		<input type="hidden" name="action" value="collectset"/>
		<input type="hidden" name="role_id" value=""/>
		<input type="hidden" name="roleid" value="${roleid}"/>
		<table>
		<tr> <td><b>������������</b></td> <td></td></tr>
		<tr> <td>�볡��������:</td> <td><input name="photoset1"/></td></tr>
		<tr> <td>������������:</td> <td><input name="photoset2"/></td></tr>
		<tr> <td>δ�ɷ���������:</td> <td><input name="photoset3"/></td></tr>
		<tr> <td>�Ƿ����Ԥ��:</td> <td>
			<select name="isprepay" style='width:173px' onchange="prepayset(this.value)" > 
				<option value="0">��</option> 
				<option value="1" selected=true>��</option>
			 </select></td></tr>
		<tr> <td><b>Ԥ�ս��ѡ��(��λ:Ԫ)</b></td> <td></td></tr>
		<tr> <td>ѡ��1:</td> <td><input name="prepayset1"/></td></tr>
		<tr> <td>ѡ��2:</td> <td><input name="prepayset2"/></td></tr>
		<tr> <td>ѡ��3:</td> <td><input name="prepayset3"/></td></tr>
		<tr> <td><b>���볡��ӡ��Ϣ</b></td> <td></td></tr>
		<tr> <td>�볡��ӡβ��Ϣ:</td> <td><input name="print_sign1" /></td></tr>
		<tr> <td>������ӡβ��Ϣ:</td> <td><input name="print_sign2" /></td></tr>
		<tr> <td>�볡��ӡͷ��Ϣ:</td> <td><input name="print_sign3" /></td></tr>
		<tr> <td>������ӡͷ��Ϣ:</td> <td><input name="print_sign4" /></td></tr>
		<tr> <td>�Ƿ���Ը���Ԥ�ս��:</td> <td>
			<select name="change_prepay" style='width:173px' > 
				<option value="0">��</option> 
				<option value="1" selected=true>��</option> 
			</select></td></tr>
		<tr> <td>�Ƿ���ʾ��λ:</td> <td>
			<select name="view_plot" style='width:173px' > 
				<option value="0">��</option> 
				<option value="1" selected=true> ��</option>
		     </select></td></tr>
		<tr> <td>�Ƿ������շѻ���:</td> <td>
			<select name="hidedetail" style='width:173px' > 
				<option value="0">��</option> 
				<option value="1" selected=true> ��</option>
		     </select></td></tr>
		<tr> <td>�鿴��������:</td> <td><input name="collpwd" type="password" /></td></tr>
		<tr> <td>ǩ���Ƿ���Ҫ����:</td> <td>
			<select name="signout_valid" style='width:173px' > 
				<option value="0" selected=true>��</option> 
				<option value="1"> ��</option>
		     </select></td></tr>
		<tr> <td>ǩ������:</td> <td><input name="signpwd" type="password" /></td></tr>
		<tr> <td><b>��������</b></td> <td></td></tr>
	     <tr> <td>ȡ������ʱ����ΪPOS��¼�붩��ʱ��:</td> <td>
		<select name="is_sensortime" style='width:173px' > 
			<option value="0">��</option> 
			<option value="1" selected=true> ��</option>
	     </select></td></tr>
	     <tr> <td>�շѻ����Ƿ���ʾ��Ƭ����:</td> <td>
		<select name="is_show_card" style='width:173px' > 
			<option value="0">��</option> 
			<option value="1" selected=true> ��</option>
	     </select></td></tr>
	    <tr> <td>������㶩���Ƿ��ӡСƱ:</td> <td>
		<select name="print_order_place2" style='width:173px' > 
			<option value="0">��</option> 
			<option value="1" selected=true> ��</option>
	     </select></td></tr>
	     <tr> <td>ͬһ�����ڲ�ͬ�����ظ��볡:</td> <td>
		<select name="is_duplicate_order" style='width:173px' > 
			<option value="0"> ��</option>
			<option value="1" selected=true>��</option> 
	     </select></td></tr>
	     <tr> <td>СƱ�Ƿ��ӡ�շ�Ա����:</td> <td>
		<select name="is_print_name" style='width:173px' > 
			<option value="0"> ��</option>
			<option value="1" selected=true>��</option> 
	     </select></td></tr>
		<tr> <td><input type="submit" value=" �� �� "/></td> <td></td></tr>
		</table>
	</form>
</div>
</body>
<script type="text/javascript">
var data = ${data};
var form = document.forms[0];
if(data.photoset){
	form.photoset1.value=data.photoset[0]||0;
	form.photoset2.value=data.photoset[1]||0;
	form.photoset3.value=data.photoset[2]||0;
}else{
	form.photoset1.value="1";
	form.photoset2.value="1";
	form.photoset3.value="1";
}
if(data.prepayset){
	form.prepayset1.value=data.prepayset[0]||0;
	form.prepayset2.value=data.prepayset[1]||0;
	form.prepayset3.value=data.prepayset[2]||0;
}else{
 	form.prepayset1.value="5";
	form.prepayset2.value="10";
	form.prepayset3.value="15";
}
if(data.print_sign){
	var ps = data.print_sign;
	form.print_sign1.value=ps[0]||"";
	form.print_sign2.value=ps[1]||"";
	form.print_sign3.value=ps[2]||"";
	form.print_sign4.value=ps[3]||"";
}else{
	form.print_sign1.value="��ӭ����";
	form.print_sign2.value="��ӭ�ٴι���";
	form.print_sign3.value="��ӭ����";
	form.print_sign4.value="��ӭ�ٴι���";
}
if(data.change_prepay){
	var options = form.change_prepay.options;
	if(data.change_prepay=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.view_plot){
	var options = form.view_plot.options;
	if(data.view_plot=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.hidedetail){
	var options = form.hidedetail.options;
	if(data.hidedetail=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.signout_valid){
	var options = form.signout_valid.options;
	if(data.signout_valid=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.is_sensortime){
	var options = form.is_sensortime.options;
	if(data.is_sensortime=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.is_show_card){
	var options = form.is_show_card.options;
	if(data.is_show_card=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.print_order_place2){
	var options = form.print_order_place2.options;
	if(data.print_order_place2=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.is_duplicate_order){
	var options = form.is_duplicate_order.options;
	if(data.is_duplicate_order=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.is_print_name){
	var options = form.is_print_name.options;
	if(data.is_print_name=='1')
		options[1].selected=true;
	else {
		options[0].selected=true;
	}
}
if(data.password){
	form.collpwd.value=data.password;
}
if(data.signout_password){
	form.signpwd.value=data.signout_password;
}
if(data.isprepay){
	var options = form.isprepay.options;
	if(data.isprepay=='1')
		options[1].selected=true;
	else {
		form.prepayset1.disabled=true;
		form.prepayset2.disabled=true;
		form.prepayset3.disabled=true;
		options[0].selected=true;
	}
}
form.role_id.value=data.role_id;
function prepayset(value){
	if(value==0){
		form.prepayset1.disabled=true;
		form.prepayset2.disabled=true;
		form.prepayset3.disabled=true;
	}else{
		form.prepayset1.disabled=false;
		form.prepayset2.disabled=false;
		form.prepayset3.disabled=false;
	}
}
</script>
</html>