package com.zld.struts.admin;

import com.zld.AjaxUtil;
import com.zld.service.DataBaseService;
import com.zld.utils.JsonUtil;
import com.zld.utils.RequestUtil;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * 提现公司帐户
 * @author Administrator
 *
 */
public class ComAccountManageAction extends Action{

	@Autowired
	private DataBaseService daService;

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
								 HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String action = RequestUtil.processParams(request, "action");
		Long operater = (Long)request.getSession().getAttribute("loginuin");
		Long comid = RequestUtil.getLong(request, "comid", -1L);
		Long groupid = RequestUtil.getLong(request, "groupid", -1L);
		Long cityid = RequestUtil.getLong(request, "cityid", -1L);
		Integer type = RequestUtil.getInteger(request, "type", 0);//账户类型 0:公司，1个人 2对公
		if(operater == null){
			response.sendRedirect("login.do");
			return null;
		}

		if(action.equals("")){
			request.setAttribute("comid", comid);
			request.setAttribute("groupid", groupid);
			request.setAttribute("cityid", cityid);
			request.setAttribute("type", type);
			return mapping.findForward("list");
		}else if(action.equals("query")){
			List<Object> params = new ArrayList<Object>();
			String sql = "select * from com_account_tb where type=? ";
			params.add(type);
			if(comid > 0){
				sql += " and comid=? ";
				params.add(comid);
			}else if(groupid > 0){
				sql += " and groupid=? ";
				params.add(groupid);
			}else if(cityid > 0){
				sql += " and cityid=? ";
				params.add(cityid);
			}
			String fieldsstr = RequestUtil.processParams(request, "fieldsstr");
			//System.out.println(sqlInfo);
			List<Map<String, Object>> list = daService.getAllMap(sql+" order by id desc", params);
			int count =0;
			if(list!=null)
				count = list.size();
			String json = JsonUtil.Map2Json(list,1,count, fieldsstr,"id");
			AjaxUtil.ajaxOutput(response, json);
			return null;
		}else if(action.equals("create")){//添加帐号
			List<Object> pList = new ArrayList<Object>();
			if(comid > -1){
				pList.add(comid);
			}
			if(groupid > -1){
				pList.add(groupid);
			}
			if(cityid > -1){
				pList.add(cityid);
			}
			if(pList.size() != 1){
				AjaxUtil.ajaxOutput(response, "-1");
				return null;
			}
			String name =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "name"));
			Long uin =RequestUtil.getLong(request, "uin",-1L);
			String card_number =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "card_number"));
			String mobile =RequestUtil.processParams(request, "mobile");
			String bank_name =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "bank_name"));
			String area =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "area"));
			String bank_point =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "bank_pint"));
			String note =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "note"));
			String city =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "city"));
			String pay_type =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "pay_type"));
			String pay_date =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "pay_date"));
			String use =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "use"));
			String bank_no =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "bank_no"));
			Integer atype = RequestUtil.getInteger(request, "atype", 0);
			int result = 0;
			if(!card_number.equals("")&&!mobile.equals("")&&!bank_name.equals("")){
				result = daService.update("insert into com_account_tb (comid,uin,name,card_number,mobile,bank_name," +
								"note,atype,area,bank_pint,type,state,city,pay_type,pay_date,use,bank_no,groupid,cityid)" +
								" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
						new Object[]{comid,uin,name,card_number,mobile,bank_name,note,atype,area,bank_point,type,0,city,pay_type,pay_date,use,bank_no,groupid,cityid});
			}
			AjaxUtil.ajaxOutput(response, result+"");
		}else if(action.equals("edit")){//编辑帐号
			Long id = RequestUtil.getLong(request, "id", -1L);
			String name =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "name"));
			String card_number =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "card_number"));
			String mobile =RequestUtil.processParams(request, "mobile");
			String bank_name =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "bank_name"));
			String area =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "area"));
			String bank_point =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "bank_pint"));
			String note =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "note"));
			String city =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "city"));
			String pay_type =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "pay_type"));
			String pay_date =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "pay_date"));
			String use =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "use"));
			String bank_no =AjaxUtil.decodeUTF8(RequestUtil.processParams(request, "bank_no"));
			Integer atype = RequestUtil.getInteger(request, "atype", 0);
			Integer state = RequestUtil.getInteger(request, "state", 0);
			int result = 0;
			if(!card_number.equals("")&&!mobile.equals("")&&!bank_name.equals("")){
				result = daService.update("update com_account_tb set name=?,card_number=?,mobile=?,bank_name=?," +
								"note=?,atype=?,area=?,bank_pint=?,state=?,city=?,pay_type=?,pay_date=?,use=?,bank_no=? where id=? " ,
						new Object[]{name,card_number,mobile,bank_name,note,atype,area,bank_point,state,city,pay_type,pay_date,use,bank_no,id});
			}
			AjaxUtil.ajaxOutput(response, result+"");
		}
		else if(action.equals("editstate")){
			Integer state = RequestUtil.getInteger(request, "state", 0);
			Long id = RequestUtil.getLong(request, "id", -1L);
			state = state==0?1:0;
			int result = 0;
			if(id!=-1)
				result = daService.update("update com_account_tb set state =? where id=?", new Object[]{state,id});
			AjaxUtil.ajaxOutput(response, ""+result);
		}
		return null;
	}

}
