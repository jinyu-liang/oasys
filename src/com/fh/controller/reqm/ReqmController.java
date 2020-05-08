package com.fh.controller.reqm;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.dao.DynamicDataSource;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.reqm.ReqPlusManager;
import com.fh.service.reqm.ReqmManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.sysparam.SysParamManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.ecache.EHCacheUtils;

import net.sf.ehcache.Cache;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年4月29日
* 类说明
*/
@Controller
@RequestMapping(value="/reqm")
public class ReqmController extends BaseController{
	
	String menuUrl = "reqm/reqmlist.do"; //菜单地址(权限用)
	@Resource(name="reqmservice")
	private ReqmManager reqmservice; 
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="sysparamService")
	private SysParamManager sysparamService;
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="reqplusservice")
	private ReqPlusManager reqplusservice; 
	
	/**
	 * 主需求列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/reqmlist")
	public ModelAndView demandlist(Page page, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String[] sches = request.getParameterValues("sches");

		pd.put("SCHES", null == sches? new String[] {"02","04","07","08","09"}:sches);
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		pd.put("STAFF_NAME", user.getNAME());

		page.setPd(pd);
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		List<PageData>	reqList = reqmservice.datalistPage(page);	//列出需求列表
		for (PageData pageData : reqList) {
			markRed(pageData);
		}

		DynamicDataSource.clearDbType(); //切换数据源

		mv.addObject("user", user);
		mv.addObject("userlist", userlist());
		mv.addObject("reqlist", reqList);
		mv.addObject("reqstatlist", reqstatlist());
		mv.addObject("reqstatrolelist", reqstatrolelist());
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("reqm/req_list");
		
		return mv;
		
	}

	/**
	 * 主需求列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dolist")
	public ModelAndView dolist(Page page, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String[] sches = request.getParameterValues("sches");
		String sche = StringUtils.join(sches, ",");
		pd.put("SCHE", sche);
		pd.put("SCHES", sches);

		List<Map<String, String>> list = reqstatlist();

		list.stream().forEach(item->{
			if(null != sche && sche.contains(item.get("P_VALUE"))) {
				item.put("RSRV_STR1", "1");
			}else{
				item.put("RSRV_STR1", "0");
			}
		});
		
		page.setPd(pd);
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		List<PageData>	reqList = reqmservice.datalistPage(page);	//列出需求列表
		for (PageData pageData : reqList) {
			markRed(pageData);
		}

		DynamicDataSource.clearDbType(); //切换数据源
		
		mv.addObject("userlist", userlist());
		mv.addObject("reqlist", reqList);
		mv.addObject("reqstatlist", list);
		mv.addObject("reqstatrolelist", reqstatrolelist());
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("reqm/req_list");
		
		return mv;
		
	}
	

	
	/**
	 * 跳转到主需求更新
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editReqInfo")
	public ModelAndView editReqInfo(Page page, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String redId = pd.getString("REQ_ID");
		if(null == redId || "".equals(redId)) {
			mv.addObject("msg", "save");
			pd.put("REQ_SDPID", "TJYD-REQ-"+Tools.getSysTime1()+"-");
		}else {
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqmservice.findById(pd);	//列出需求列表
			pd.putAll(reqList.get(0));
			DynamicDataSource.clearDbType(); //切换数据源
			mv.addObject("reqlist", reqList);
			mv.addObject("msg", "edit");
		}
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		mv.addObject("user", user);
		mv.addObject("userlist", userlist());
		mv.addObject("reqstatrolelist", reqstatrolelist()); //需求类别
		mv.addObject("reqstatlist", reqstatlist()); //需求状态
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("reqm/req_edit");
		
		return mv;
		
	}
	
	/**保存需求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增add");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		List<PageData> list = reqmservice.findById(pd);
		if(null == list || list.size() <=0 ){	//判断需求是否存在
			pd.put("ACCEPT_DATE", Tools.getSysDate());
			pd.put("ANALYSIS_FINISH_DATE", Tools.getSysDate());
			pd.put("REQ_STATE", "02");
			pd.put("PAY_TAG", "0");
			pd.put("LOAD_STATE","1");
			reqmservice.save(pd); 					//执行保存
			mv.addObject("msgcode","success");
			mv.addObject("msg","操作成功！");
		}else{
			mv.addObject("msgcode","error");
			mv.addObject("msg","主需求（"+pd.getString("REQ_TITLE")+"）已经存在！");
		}
		DynamicDataSource.clearDbType(); //切换数据源
		mv.addObject("menuid","reqedit");
		mv.setViewName("save_result_one");
		return mv;
	}
	
	/**更新需求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"更新edit");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		boolean flag = false;

		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源

		if(StringUtils.isNotEmpty(pd.getString("H_REQ_STAT"))) {
			pd.put("REQ_STATE", pd.getString("H_REQ_STAT"));
			pd.put("UPDATE_STAFF", user.getNAME());
			reqmservice.editStats(pd);
		}else {
			pd.put("UPDATE_STAFF", user.getNAME());
			String state = pd.getString("REQ_STATE");
			//需求上线
			if("09".equals(state)||"10".equals(state)) {
				List<PageData> list = reqplusservice.findBySdpId2(pd);
				if(null == list || list.size()<1) {
					mv.addObject("msgcode","error");
					mv.addObject("msg","操作失败！请分配子需求给开发人员！");
					mv.addObject("menuid","reqedit");
					flag = true;
				}else {
					for (int i = 0; i < list.size(); i++) {
						PageData pageData = list.get(i);
						String plusstate = pageData.getString("REQ_STATE_PLUS");
						if("09".equals(state) && ("07".equals(plusstate) || "08".equals(plusstate))) {
							mv.addObject("msg","操作失败！开发人员（"+list.get(i).getString("CODE_STAFF")+"）未走到上线节点");
							mv.addObject("msgcode","error");
							mv.addObject("menuid","reqedit");
							flag = true;
							break;
						}
						if("10".equals(state) && ("07".equals(plusstate) || "08".equals(plusstate) || "09".equals(plusstate))) {
							mv.addObject("msg","操作失败！开发人员（"+list.get(i).getString("CODE_STAFF")+"）未走到关闭节点");
							mv.addObject("msgcode","error");
							mv.addObject("menuid","reqedit");
							flag = true;
							break;
						}
					}
				}
			}
			
		}
		if(!flag) {
			reqmservice.edit(pd);
			mv.addObject("msgcode","success");
			mv.addObject("msg","操作成功！");
			mv.addObject("menuid","reqedit");
		}
		
		DynamicDataSource.clearDbType(); //切换数据源
		mv.setViewName("save_result_one");
		return mv;
		
		
//		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
//		List<PageData> list = reqmservice.findById(pd);
//		if(null == list || list.size() <=0 ){	//判断需求是否存在
//			pd.put("ACCEPT_DATE", Tools.getSysDate());
//			pd.put("ANALYSIS_FINISH_DATE", Tools.getSysDate());
//			
//			pd.put("PAY_TAG", "0");
//			pd.put("LOAD_STATE","1");
//			reqmservice.save(pd); 					//执行保存
//			mv.addObject("msg","success");
//		}else{
//			mv.addObject("msg","failed");
//		}
//		DynamicDataSource.clearDbType(); //切换数据源
//		mv.setViewName("save_result_one");
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
	 * 需求状态
	 */
	public List reqstatlist() throws Exception {
		PageData pd = new PageData();
		pd.put("P_CODE", "600");
		pd.put("STATUS", "1");
		List<PageData> sysList = null;
		
		
		Cache cache= EHCacheUtils.cacheManager.getCache("sysCache");
		if( null != cache && null != cache.get("reqstatlist")) {
			sysList = (List<PageData>) cache.get("reqstatlist").getObjectValue();
		}else {
			sysList = sysparamService.findById(pd);	
			Cache sysCache = EHCacheUtils.initCache("sysCache", 60, 30);
	        EHCacheUtils.put(sysCache, "reqstatlist", sysList);
		}

		return sysList;
	}

	/*
	 * 需求类别
	 */
	public List reqstatrolelist() throws Exception {
		PageData pd = new PageData();
		pd.put("P_CODE", "601");
		List<PageData>	sysList = null;	

		Cache cache= EHCacheUtils.cacheManager.getCache("sysCache");
		if( null != cache && null != cache.get("reqstatrolelist")) {
			sysList = (List<PageData>) cache.get("reqstatrolelist").getObjectValue();
		}else {
			sysList =  sysparamService.findById(pd);	
			Cache sysCache = EHCacheUtils.initCache("sysCache", 60, 30);
	        EHCacheUtils.put(sysCache, "reqstatrolelist", sysList);
		}
	
		return sysList;
		
	}
	
	private void markRed(Map info) throws Exception {
		int redOrNotAnalysis = 0;
		int redOrNotdevelop = 0;
		int redOrNotonline = 0;
		String redOrNotAnalysisCss = "";
		String redOrNotdevelopCss = "";
		String redOrNotonlineCss = "";
		String analysis_finish_date = (String) info.get("ANALYSIS_FINISH_DATE");
		String develop_finish_date = (String) info.get("DEVELOP_FINISH_DATE");
		String online_date = (String) info.get("ONLINE_DATE");

		if ((!("10".equals(info.get("REQ_STATE")))) && (!("11".equals(info.get("REQ_STATE"))))
				&& (!("12".equals(info.get("REQ_STATE"))))
				&& (!("13".equals(info.get("REQ_STATE"))))
				&& (!("08".equals(info.get("REQ_STATE"))))
				&& (!("09".equals(info.get("REQ_STATE"))))) {
			if (null != analysis_finish_date && analysis_finish_date.length() != 0) {
				redOrNotAnalysis = (isLessThan(analysis_finish_date, -12)) ? 1 : 0;
				if (redOrNotAnalysis != 1)
					redOrNotAnalysis = (isLessThan(analysis_finish_date, 48)) ? 2 : 0;
			}

			if (null != develop_finish_date && develop_finish_date.length() != 0) {
				redOrNotdevelop = (isLessThan(develop_finish_date, -12)) ? 1 : 0;
				if (redOrNotdevelop != 1)
					redOrNotdevelop = (isLessThan(develop_finish_date, 48)) ? 2 : 0;

			}

			if (null != online_date && online_date.length() != 0) {
				redOrNotonline = (isLessThan(online_date, -12)) ? 1 : 0;
				if (redOrNotonline != 1)
					redOrNotonline = (isLessThan(online_date, 48)) ? 2 : 0;

			}

		}

		if(redOrNotAnalysis == 1) {
			redOrNotAnalysisCss = "center alert alert-danger";
		}else if(redOrNotAnalysis == 2) {
			redOrNotAnalysisCss = "center alert alert-warning";
		}
		if(redOrNotdevelop == 1) {
			redOrNotdevelopCss = "center alert alert-danger";
		}else if(redOrNotdevelop == 2) {
			redOrNotdevelopCss = "center alert alert-warning";
		}
		if(redOrNotonline == 1) {
			redOrNotonlineCss = "center alert alert-danger";
		}else if(redOrNotonline == 2) {
			redOrNotonlineCss = "center alert alert-warning";
		}
		
		
		info.put("redOrNotAnalysisCss", redOrNotAnalysisCss);
		info.put("redOrNotdevelopCss", redOrNotdevelopCss);
		info.put("redOrNotonlineCss", redOrNotonlineCss);
	}

	private boolean isLessThan(String acceptTime, int hours) throws Exception {
		Timestamp now = Tools.getCurrentTime();
		Timestamp accTime = Tools.encodeTimestamp(acceptTime);
		return (accTime.getTime() - now.getTime() <= hours * 3600 * 1000);
	}

	
	/**首页需求总情况
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listReqm")
	@ResponseBody
	public Object listReqm() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData> list = reqmservice.listReqm(pd);
			DynamicDataSource.clearDbType(); //切换数据源
			if(null != list && list.size()>0) {
				errInfo = "success";
				map.put("list", list);
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
	
	
	/**首页个人需求情况
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listOnlyReqm")
	@ResponseBody
	public Object listOnlyReqm() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			Page page = new Page();
			pd = this.getPageData();
			pd.put("SCHES", new String[] {"02","04","07","08","09"});
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			pd.put("STAFF_NAME", user.getNAME());

			page.setPd(pd);
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqmservice.datalistPage(page);	//列出需求列表
			DynamicDataSource.clearDbType(); //切换数据源

			if(null != reqList && reqList.size()>0) {
				errInfo = "success";
				map.put("num", reqList.size());
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
	
	
	/**首页个人子需求情况
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listOnlyReqplus")
	@ResponseBody
	public Object listOnlyReqplus() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			Page page = new Page();
			pd = this.getPageData();
			pd.put("SCHES", new String[] {"07","08","09"});
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			pd.put("CODE_STAFF", user.getNAME());

			page.setPd(pd);
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqplusservice.datalistPage(page);	//列出需求列表
			DynamicDataSource.clearDbType(); //切换数据源

			if(null != reqList && reqList.size()>0) {
				errInfo = "success";
				map.put("num", reqList.size());
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
	
	
	
	/**首页个人子需求总量
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listReqplusSum")
	@ResponseBody
	public Object listReqplusSum() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			pd.put("CODE_STAFF", user.getNAME());

			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqplusservice.findByStaffSum(pd);	//列出需求列表
			DynamicDataSource.clearDbType(); //切换数据源

			if(null != reqList && reqList.size()>0) {
				errInfo = "success";
				map.put("num", reqList.get(0).get("NUM"));
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
	
	/**首页个人子需求总量
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listReqplusSum6")
	@ResponseBody
	public Object listReqplusSum6() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			pd.put("CODE_STAFF", user.getNAME());

			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqplusservice.findByStaffSum6(pd);	//列出需求列表
			DynamicDataSource.clearDbType(); //切换数据源

			if(null != reqList && reqList.size()>0) {
				errInfo = "success";
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
	
	
	/**子需求明细
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/plus")
	@ResponseBody
	public Object plus() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqplusservice.findBySdpId(pd);
			DynamicDataSource.clearDbType(); //切换数据源

			if(null != reqList && reqList.size()>0) {
				errInfo = "success";
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
	
}
