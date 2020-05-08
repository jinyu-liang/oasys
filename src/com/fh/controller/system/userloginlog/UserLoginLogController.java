package com.fh.controller.system.userloginlog;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.dao.DynamicDataSource;
import com.fh.entity.Page;
import com.fh.entity.system.Group;
import com.fh.entity.system.SignData;
import com.fh.entity.system.User;
import com.fh.service.system.group.GroupManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.userloginlog.UserLoginLogManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.ecache.EHCacheUtils;

import net.sf.ehcache.Cache;

/**
 * 说明：登陆日志表 创建人：admin 创建时间：2018-12-11
 */
@Controller
@RequestMapping(value = "/userloginlog")
public class UserLoginLogController extends BaseController {

	String menuUrl = "userloginlog/list.do"; // 菜单地址(权限用)
	@Resource(name = "userloginlogService")
	private UserLoginLogManager user_login_logService;
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="groupService")
	private GroupManager groupService;

	

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除USER_LOGIN_LOG");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		user_login_logService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改USER_LOGIN_LOG");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		user_login_logService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	// 签退
	@RequestMapping(value = "/signout")
	public ModelAndView signout(SignData sign) throws Exception {

		logBefore(logger, Jurisdiction.getUsername() + "新增TrainJoin");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		System.out.println(sign.getName());
		pd.put("ID", sign.getId());// 签退ID
		PageData pd2 = user_login_logService.findById(pd);// 获取签到状态
		Date date = new Date(); // 当前时间
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 签退时间
		String dateNowStr = sdf.format(date); // 签退时间
		pd.put("OUTDATE", dateNowStr);// 签退时间
		pd.put("TYPE", pd2.get("LOG_TYPE").toString().substring(0, 2) + "->签退");// 修改签退状态
		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);
		String roleid = user.getUSER_ID();
		System.out.println(roleid);
		if (roleid.equals(sign.getName())) {
			user_login_logService.edit(pd);
		}
		
		
		PageData pdd = new PageData();
		pdd = this.getPageData();
		user = (User) session.getAttribute(Const.SESSION_USER);
		String myName = user.getNAME();
		pdd.put("MYNAME", myName);
		String keywords = pdd.getString("keywords"); // 关键词检索条件
		String starttime = pdd.getString("starttime"); // 关键词检索条件
		String endtime = pdd.getString("endtime"); // 关键词检索条件
		String LOG_TYPE = pdd.getString("LOG_TYPE"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if (null != starttime && !"".equals(starttime)) {
			pd.put("starttime", starttime.trim());
		}
		if (null != endtime && !"".equals(endtime)) {
			pd.put("endtime", endtime.trim());
		}
		if (null != LOG_TYPE && !"".equals(LOG_TYPE)) {
			pd.put("LOG_TYPE", LOG_TYPE.trim());
		}
		Page page=new Page();
		page.setPd(pdd);
		Calendar c = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00")); // 获取东八区时间
		Date timenow = c.getTime();
		List<PageData> varList = user_login_logService.list(page); // 列出列表
		for (int i = 0; i < varList.size(); i++) {
			String indate = (String) varList.get(i).get("IN_DATE");
			Calendar inc = Calendar.getInstance();
			SimpleDateFormat incs = new SimpleDateFormat("yyyy-MM-dd"); 
			Date ind = incs.parse(indate);
			inc.setTime(ind);
			inc.add(c.HOUR_OF_DAY,32);
			Date c11 = inc.getTime();
			if (c11.after(timenow) && varList.get(i).getString("USER_ID").equals(user.getUSER_ID())) {
				varList.get(i).put("show", 1); // 显示
			} else
				varList.get(i).put("show", 0); // 不显示
		}
		mv.setViewName("system/userloginlog/userloginloglist");
		mv.addObject("varList", varList);
		mv.addObject("pd", pdd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		System.out.println(mv);
		return mv;
		
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {

		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);
		
		if(!"1".equals(pd.get("FLAG"))) {
			String myName = user.getNAME();
			pd.put("USER_NAME", myName);
		}
		pd.put("FLAG", "1");

		String starttime = pd.getString("START_DATE"); 
		if (null == starttime || "".equals(starttime)) {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.MONTH, -1);
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			String dateNowStr = sdf.format(calendar.getTime()); 
			pd.put("START_DATE", dateNowStr);
		}

		page.setPd(pd);
		Calendar c = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00")); // 获取东八区时间
		Date timenow = c.getTime();
		List<PageData> varList = user_login_logService.list(page); // 列出列表
		for (int i = 0; i < varList.size(); i++) {
			String indate = (String) varList.get(i).get("IN_DATE");
			Calendar inc = Calendar.getInstance();
			SimpleDateFormat incs = new SimpleDateFormat("yyyy-MM-dd"); 
			Date ind = incs.parse(indate);
			inc.setTime(ind);
			inc.add(c.HOUR_OF_DAY,32);
			Date c11 = inc.getTime();
			if (c11.after(timenow) && varList.get(i).getString("USER_ID").equals(user.getUSER_ID())) {
				varList.get(i).put("show", 1); // 显示
			} else
				varList.get(i).put("show", 0); // 不显示
		}
		mv.setViewName("system/userloginlog/userloginloglist");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("userlist", userlist());
		mv.addObject("grouplist", grouplist());
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
	
	
	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/user_login_log/user_login_log_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = user_login_logService.findById(pd); // 根据ID读取
		mv.setViewName("system/user_login_log/user_login_log_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除USER_LOGIN_LOG");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			user_login_logService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出USER_LOGIN_LOG到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户ID"); // 1
		titles.add("用户名"); // 2
		titles.add("考勤类型"); // 3
		titles.add("登陆IP"); // 4
		titles.add("登录时间"); // 5
		titles.add("签退时间"); // 6
		titles.add("缺勤时长"); // 7
		titles.add("备注"); // 8
		titles.add("更新ID"); // 9
		titles.add("考勤日期"); // 10
		dataMap.put("titles", titles);
		List<PageData> varOList = user_login_logService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USER_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("USER_NAME")); // 2
			vpd.put("var3", varOList.get(i).getString("LOG_TYPE")); // 3
			vpd.put("var4", varOList.get(i).getString("LOG_IP")); // 4
			vpd.put("var5", varOList.get(i).getString("IN_DATE")); // 5
			vpd.put("var6", varOList.get(i).getString("OUT_DATE")); // 6
			vpd.put("var7", varOList.get(i).getString("ABS_TIMES")); // 7
			vpd.put("var8", varOList.get(i).getString("REMARK")); // 8
			vpd.put("var9", varOList.get(i).getString("UPDATE_ID")); // 9
			vpd.put("var10", varOList.get(i).getString("UPDATE_TIME")); // 10
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
	
	/*
	 * 用户列表
	 * 
	 */
	public List userlist() throws Exception {
		
		List<PageData> userlist = null;
		PageData pd = new PageData();
		Cache cache= EHCacheUtils.cacheManager.getCache("sysCache");
		if( null != cache && null != cache.get("userlist")) {
			userlist = (List<PageData>) cache.get("userlist").getObjectValue();
		}else {
			userlist = userService.listAllUser(pd);	//列出用户
			Cache sysCache = EHCacheUtils.initCache("sysCache", 60, 30);
	        EHCacheUtils.put(sysCache, "userlist", userlist);
		}
		
		return userlist;
	}
	
	/*
	 * 组列表
	 * 
	 */
	public List grouplist() throws Exception {
		
		List<Group> grouplist = null;
		PageData pd = new PageData();
		Cache cache= EHCacheUtils.cacheManager.getCache("groupCache");
		if( null != cache && null != cache.get("grouplist")) {
			grouplist = (List<Group>) cache.get("grouplist").getObjectValue();
		}else {
			grouplist =  groupService.listAllGroupsByPId(pd);//列出所有组
			Cache sysCache = EHCacheUtils.initCache("groupCache", 60, 30);
	        EHCacheUtils.put(sysCache, "grouplist", grouplist);
		}
		
		return grouplist;
	}
	
	
	/**子需求明细
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/userloginlog")
	@ResponseBody
	public Object userloginlog() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		StringBuffer sBuffer = new StringBuffer();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			List<PageData>	reqList = user_login_logService.countlog(pd);

			if(null != reqList && reqList.size()>0) {
				errInfo = "success";
				
				reqList.stream().forEach(item->{
					sBuffer.append(item.getString("LOG_TYPE")+"人数:"+item.get("LOG_NUM")+"人       ");
				});
				map.put("loginfo", sBuffer);
				map.put("list", reqList);
				msg = "操作成功!";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
			errInfo = "error";
		}
		
		map.put("msgcode", errInfo);				//返回结果
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	public static void main(String[] args) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		String dateNowStr = sdf.format(calendar.getTime()); 
		System.out.println(dateNowStr);
	}
}
