package com.fh.controller.system.useraby;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
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
import com.fh.entity.system.User;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.ecache.EHCacheUtils;

import net.sf.ehcache.Cache;

import com.fh.util.Jurisdiction;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.useraby.UserAbyManager;

/** 
 * 说明：能力评估表
 * 创建人：admin
 * 创建时间：2020-04-17
 */
@Controller
@RequestMapping(value="/useraby")
public class UserAbyController extends BaseController {
	
	String menuUrl = "useraby/list.do"; //菜单地址(权限用)
	@Resource(name="userabyService")
	private UserAbyManager userabyService;
	
	@Resource(name="userService")
	private UserManager userService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增UserAby");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", this.get32UUID());	//主键
		pd.put("COMMUNICATION", "");	//沟通协调能力
		pd.put("INNOVATION", "");	//创新能力
		userabyService.save(pd);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除UserAby");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		userabyService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改UserAby");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		userabyService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表UserAby");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = userabyService.list(page);	//列出UserAby列表
		mv.setViewName("system/useraby/useraby_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/useraby/useraby_edit");
		mv.addObject("userlist", userlist());
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = userabyService.findById(pd);	//根据ID读取
		mv.setViewName("system/useraby/useraby_edit");
		mv.addObject("userlist", userlist());
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除UserAby");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			userabyService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出UserAby到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户id");	//1
		titles.add("业务能力");	//2
		titles.add("技术能力");	//3
		titles.add("沟通协调能力");	//4
		titles.add("创新能力");	//5
		titles.add("学习能力");	//6
		titles.add("备注");	//7
		titles.add("更新时间");	//8
		titles.add("更新人");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = userabyService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USER_ID"));	//1
			vpd.put("var2", varOList.get(i).getString("BUSINESS"));	//2
			vpd.put("var3", varOList.get(i).getString("TECHNICAL"));	//3
			vpd.put("var4", varOList.get(i).getString("COMMUNICATION"));	//4
			vpd.put("var5", varOList.get(i).getString("INNOVATION"));	//5
			vpd.put("var6", varOList.get(i).getString("LEARN"));	//6
			vpd.put("var7", varOList.get(i).getString("REMARK"));	//7
			vpd.put("var8", varOList.get(i).getString("UPDATE_DATE"));	//8
			vpd.put("var9", varOList.get(i).getString("UPDATE_ID"));	//9
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
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
	
	/**首页个人技能
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getUserskill")
	@ResponseBody
	public Object getUserskill() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			pd.put("USER_ID", user.getUSER_ID());

			Map	userskill = userabyService.findByIdSkill(pd);	//列出需求列表

			if(MapUtils.isNotEmpty(userskill)) {
				errInfo = "success";
				map.putAll(userskill);
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
	
	/**首页个人技能
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getUserskillInfos")
	@ResponseBody
	public Object getUserskillInfos() throws Exception{
		Map map = new HashMap();
		String errInfo = "error";
		String msg = "操作失败!";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			pd.put("USER_ID", user.getUSER_ID());

			List<PageData>	userskills = userabyService.findByIdSkillInfos(pd);	//列出需求列表

			if(userskills != null && userskills.size()>0) {
				errInfo = "success";
				map.put("list", userskills);
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
