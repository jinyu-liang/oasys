package com.fh.controller.reqm;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
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
import com.fh.service.reqm.ReqmManager;
import com.fh.service.reqm.ReqPlusManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.sysparam.SysParamManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;
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
@RequestMapping(value="/reqplus")
public class ReqPlusController  extends BaseController {

	String menuUrl = "reqplus/pluslist.do"; //菜单地址(权限用)
	@Resource(name="reqmservice")
	private ReqmManager reqmservice; 
	@Resource(name="reqplusservice")
	private ReqPlusManager reqplusservice; 
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="sysparamService")
	private SysParamManager sysparamService;
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="sequenceService")
    SequenceService sequenceService;
	
	/**
	 * 主需求列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pluslist")
	public ModelAndView demandlist(Page page, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		pd.put("STAFF_NAME", user.getNAME());
		
		String req_id_sdp = pd.getString("REQ_SDPID");
		if(null == req_id_sdp || "".equals(req_id_sdp)) {
			pd.put("SCHES",new String[] {"07","08","09"});
			
			pd.put("CODE_STAFF", user.getNAME());
			mv.addObject("user", user);
		}
		page.setPd(pd);
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		List<PageData>	plusList = reqplusservice.datalistPage(page);	//列出需求列表
		for (PageData pageData : plusList) {
			markRed(pageData);
		}

		DynamicDataSource.clearDbType(); //切换数据源
		
		mv.addObject("userlist", userlist());
		mv.addObject("plusList", plusList);
		mv.addObject("reqstatlist", reqstatlist());
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("reqm/reqplus_list");
		
		return mv;
		
	}
	
	/**
	 * 主需求列表1
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dolist")
	public ModelAndView dolist(Page page, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		pd.put("STAFF_NAME", user.getNAME());
		
		String[] sches = request.getParameterValues("sches");
		pd.put("SCHES", sches);
		
		String sche = StringUtils.join(sches, ",");
		pd.put("SCHE", sche);
		
		String[] TONGJI_STATUS = request.getParameterValues("status");
		pd.put("TONGJI_STATUS", TONGJI_STATUS);
		
		String TONGJI_STATU = StringUtils.join(TONGJI_STATUS, ",");
		pd.put("TONGJI_STATU", TONGJI_STATU);
		
		List<Map<String, String>> list = reqstatlist();

		for (Map<String, String> map : list) {
			if(null != sche && sche.contains(map.get("P_VALUE"))) {
				map.put("RSRV_STR3", "1");
			}else{
				map.put("RSRV_STR3", "0");
			}
		}
		
		page.setPd(pd);
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		List<PageData>	plusList = reqplusservice.datalistPage(page);	//列出需求列表
		for (PageData pageData : plusList) {
			markRed(pageData);
		}

		DynamicDataSource.clearDbType(); //切换数据源
		
		
		mv.addObject("userlist", userlist());
		mv.addObject("plusList", plusList);
		mv.addObject("reqstatlist", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("reqm/reqplus_list");
		return mv;
		
	}
	
	
	/**
	 * 更新列表详情
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editReqPlusInfo")
	public ModelAndView editReqPlusInfo(Page page, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); 
		
		pd.put("TONGJIMAX", "100");
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		List<PageData>	plusList = reqplusservice.findBySdpIdSum(pd);	//列出需求列表
		if(null != plusList && plusList.size() > 0) {
			PageData m = plusList.get(0);
			pd.put("TONGJIMAX", (100-Integer.valueOf(m.get("TONGJISUM").toString()))+"");
		}
		DynamicDataSource.clearDbType(); //切换数据源
		
		String sdpredId = pd.getString("REQ_SDPIDPLUS"); //子需求编码为空则新增子需求
		List  userlist = userlist();
		if(null == sdpredId || "".equals(sdpredId)) {
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqmservice.findById(pd);	//列出需求列表
			if(null != reqList && reqList.size()>0) {
				pd.put("REQ_SDPID", reqList.get(0).getString("REQ_SDPID"));
				pd.put("REQ_TITLE", reqList.get(0).getString("REQ_TITLE"));
				pd.put("REQ_NOTE",  reqList.get(0).getString("REQ_NOTE"));
				pd.put("REQ_STATE_PLUS",  "07");
			}
			DynamicDataSource.clearDbType(); //切换数据源
			mv.addObject("reqlist", reqList);
			mv.addObject("msg", "save");
			
			if(user.getUSERNAME().equals("linb") || user.getUSERNAME().equals("admin")) {
				pd.put("TONGJI_STATUS", "1");
				userlist = userlistleader();
			}
			
		}else {
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			List<PageData>	reqList = reqplusservice.findById(pd);	//列出需求列表
			pd.putAll(reqList.get(0));
			DynamicDataSource.clearDbType(); //切换数据源
			mv.addObject("reqlist", reqList);
			mv.addObject("msg", "edit");
			if(user.getUSERNAME().equals("linb") || user.getUSERNAME().equals("admin")) {
				pd.put("TONGJI_STATUS", "1");
			}else {
				pd.put("TONGJI_STATUS", "0");
			}
		}
		
		mv.addObject("userlist", userlist);
		mv.addObject("reqstatlist", reqstatlist()); //需求状态
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("reqm/reqplus_edit");
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
		
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源

		pd.put("UPDATE_STAFF", user.getNAME());

		reqplusservice.edit(pd);
		
		DynamicDataSource.clearDbType(); //切换数据源
		mv.addObject("msgcode","success");
		mv.addObject("msg","操作成功！");
		mv.addObject("menuid","reqplus_edit");
		
		mv.setViewName("save_result_one");
		return mv;
	}
	
	/**删除需求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername());
		
		
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		String msg = "操作成功!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
			reqplusservice.del(pd);
			DynamicDataSource.clearDbType(); //切换数据源
		} catch(Exception e){
			logger.error(e.toString(), e);
			errInfo = "error";
			errInfo = "操作失败!";
		}
		
		map.put("msgcode", errInfo);				//返回结果
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**保存子需求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增子需求");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		
		pd.put("UPDATE_STAFF", user.getNAME());
		pd.put("UPDATE_TIME", Tools.getSysDate());
		pd.put("IN_DATE", Tools.getSysDate());
		pd.put("MOD_ID", "crm");
		
		pd.put("ID", "TestSeq");
		pd.put("LEN", "6");
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_MYSQL); //切换数据源
		String seq = sequenceService.getLenId(pd);
		pd.put("REQ_SDPIDPLUS", pd.getString("REQ_SDPID")+"-"+seq);
		
		if(user.getUSERNAME().equals("linb") || user.getUSERNAME().equals("admin")) {
			pd.put("TONGJI_STATUS", "1");
		}else {
			pd.put("TONGJI_STATUS", "0");
		}
		
		DynamicDataSource.setDbType(DynamicDataSource.DATASOURCE_ORSQL); //切换数据源
		PageData reqpd = new PageData();
		reqpd.put("REQ_SDPID", pd.get("REQ_SDPID"));
		reqpd.put("CODE_STAFF", pd.get("CODE_STAFF"));
		List<PageData>	plusList = reqplusservice.findBySdpId(reqpd);	//列出需求列表
		if(null == plusList || plusList.size()==0) {
			reqpd.put("CODE_STAFF", user.getNAME());
			List<PageData>	plusList2 = reqplusservice.findBySdpId(reqpd);
			if(plusList2.size() > 0) {
				pd.put("TONGJI",plusList2.get(0).get("TONGJI"));
				pd.put("TONGJI_TAG",plusList2.get(0).get("TONGJI_TAG"));
			}
			reqplusservice.save(pd);
			mv.addObject("msgcode","success");
			mv.addObject("msg","操作成功！");
		}else {
			mv.addObject("msgcode","error");
			mv.addObject("msg","开发人员："+pd.get("CODE_STAFF")+",子需求（"+pd.getString("REQ_TITLE")+"）已经存在！");
		}
		
		
		DynamicDataSource.clearDbType(); //切换数据源
		
		mv.addObject("menuid","reqplus_edit");
		mv.setViewName("save_result_one");
		return mv;
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
	 * 用户列表
	 * 
	 */
	public List userlistleader() throws Exception {
		
		List<PageData> userlist = null;
		PageData pd = new PageData();
		Cache cache= EHCacheUtils.cacheManager.getCache("sysCache");
		if( null != cache && null != cache.get("userlistleader")) {
			userlist = (List<PageData>) cache.get("userlistleader").getObjectValue();
		}else {
			pd.put("P_CODE", "200");
			userlist = sysparamService.findById(pd);	
			userlist.stream().forEach(item->{
				item.put("NAME", item.getString("P_NAME"));
			});
			Cache sysCache = EHCacheUtils.initCache("sysCache", 60, 30);
	        EHCacheUtils.put(sysCache, "userlistleader", userlist);
		}
		
		return userlist;
	}
	
	/*
	 * 需求状态
	 */
	public List reqstatlist() throws Exception {
		PageData pd = new PageData();
		pd.put("P_CODE", "600");
		List<PageData> sysList = null;
		
		
		Cache cache= EHCacheUtils.cacheManager.getCache("sysCache");
		if( null != cache && null != cache.get("sysList")) {
			sysList = (List<PageData>) cache.get("sysList").getObjectValue();
		}else {
			sysList = sysparamService.findById(pd);	
			Predicate<Map> predicate = (s) -> (null == s.get("RSRV_STR2")||!s.get("RSRV_STR2").equals("1"));
			sysList.removeIf(predicate);
			Cache sysCache = EHCacheUtils.initCache("sysCache", 60, 30);
	        EHCacheUtils.put(sysCache, "sysList", sysList);
		}

//		for (Map<String,String> map: sysList) {
//			if(map.get("RSRV_SRT2") == null || map.get("RSRV_SRT2") =="") {
//				map.remove(map);
//			}
//		}
		return sysList;
	}


	private void markRed(Map info) throws Exception {
		int redOrNot=0;
		String redOrNotCss = "";
		String finishTime=(String) info.get("FINISH_DATE");
		
		//
		if("10".equals((String) info.get("REQ_STATE_PLUS")) 
			|| "11".equals((String) info.get("REQ_STATE_PLUS"))
			|| "12".equals((String) info.get("REQ_STATE_PLUS")))//关闭、取消的需求不处理
		{
			redOrNot = 0;
		}
		else if (null == finishTime || finishTime.equals(null) || finishTime.equals(""))
		{
			redOrNot=1;
		}else{
			redOrNot = (isLessThan(finishTime, -12)) ? 1 : 0;
			if (redOrNot != 1)
				redOrNot = (isLessThan(finishTime, 48)) ? 2 : 0;
		}
		
		if(redOrNot == 1) {
			redOrNotCss = "center alert alert-danger";
		}else if(redOrNot == 2) {
			redOrNotCss = "center alert alert-warning";
		}
		info.put("redOrNotCss", redOrNotCss);

	}
	
	private boolean isLessThan(String acceptTime, int hours) throws Exception {
		Timestamp now = Tools.getCurrentTime();
		Timestamp accTime = Tools.encodeTimestamp(acceptTime);
		return (accTime.getTime() - now.getTime() <= hours * 3600 * 1000);
	}
	
}
