package com.fh.controller.system.teambuilding;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.system.teambuilding.TeamBuildingManager;
import com.fh.service.system.teambuildingjoin.TeamBuildingJoinManager;
import com.fh.service.system.teambuildingscore.TeamBuildingScoreManager;
import com.fh.service.system.teambuildingscoretype.TeamBuildingScoreTypeManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 说明：团队建设
 * 创建人：ADMIN
 * 创建时间：2018-11-27
 */
@Controller
@RequestMapping(value="/teambuilding")
public class TeamBuildingController extends BaseController {
	
	String menuUrl = "teambuilding/list.do"; //菜单地址(权限用)
	@Resource(name="teambuildingService")
	private TeamBuildingManager teambuildingService;
	
	@Resource(name="teambuildingjoinService")
	private TeamBuildingJoinManager teambuildingjoinService;
	
	@Resource(name="teambuildingscoretypeService")
	private TeamBuildingScoreTypeManager teambuildingscoretypeService;
	
	@Resource(name="teambuildingscoreService")
	private TeamBuildingScoreManager teambuildingscoreService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增TeamBuilding");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String uuid=this.get32UUID();
		pd.put("TEAMBUILDING_ID", uuid);	//主键
		teambuildingService.save(pd);
		for(int i=0;i<100;i++) {	
			if(pd.get("SCORE"+i)!=null) {
				PageData add=new PageData();
				add.put("TEAMBUILDINGSCORETYPE_ID", this.get32UUID());
				add.put("BUILDING_ID", uuid);
				add.put("SCORETYPE", (String) pd.get("SCORE"+i));
				teambuildingscoretypeService.save(add);
			}
		}
		PageData add=new PageData();
		add.put("TEAMBUILDINGSCORETYPE_ID", this.get32UUID());
		add.put("BUILDING_ID", uuid);
		add.put("SCORETYPE", "其他");
		teambuildingscoretypeService.save(add);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/*
	 * 团建报名
	 * 
	 */
	@RequestMapping(value="/join")
	public ModelAndView join(String id) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNowStr = sdf.format(date);
		pd.put("TEAMBUILDINGJOIN_ID", this.get32UUID());	//主键
		pd.put("BUILDING_ID", id);	//建设ID
		pd.put("USER_ID", user.getUSER_ID());	//用户id
		pd.put("JOINDATE", dateNowStr);	//报名时间
		teambuildingjoinService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		
		PageData pd2 = new PageData();
		pd2 = this.getPageData();
		pd2.put("USER_NAME",user.getUSERNAME());
		
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除TeamBuilding");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		teambuildingService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改TeamBuilding");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		teambuildingService.edit(pd);
		if(pd.get("SCORE1")!=null) {
			teambuildingscoretypeService.deleteByBuildingID(pd);
			teambuildingscoreService.deleteByBuildingID(pd);
		}
		for(int i=0;i<100;i++) {	
			if(pd.get("SCORE"+i)!=null) {
				PageData add=new PageData();
				add.put("TEAMBUILDINGSCORETYPE_ID", this.get32UUID());
				add.put("BUILDING_ID", pd.get("TEAMBUILDING_ID"));
				add.put("SCORETYPE", (String) pd.get("SCORE"+i));
				teambuildingscoretypeService.save(add);
			}
		}
		PageData add=new PageData();
		add.put("TEAMBUILDINGSCORETYPE_ID", this.get32UUID());
		add.put("BUILDING_ID", pd.get("TEAMBUILDING_ID"));
		add.put("SCORETYPE", "其他");
		teambuildingscoretypeService.save(add);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表TeamBuilding");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		page.setIsJoin(user.getUSER_ID());
		
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		String starttime = pd.getString("starttime"); // 关键词检索条件
		String endtime = pd.getString("endtime"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if (null != starttime && !"".equals(starttime)) {
			pd.put("starttime", starttime.trim());
		}
		if (null != endtime && !"".equals(endtime)) {
			pd.put("endtime", endtime.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = teambuildingService.list(page);	//列出TeamBuilding列表
		for (int i = 0; i < varList.size(); i++) {
			String start = (String) varList.get(i).get("STARTTIME");
			String end = (String) varList.get(i).get("ENDTIME");
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String dateNowStr = sdf.format(date);
			Date now = sdf.parse(dateNowStr);
			Date st = sdf.parse(start);
			Date en = sdf.parse(end);
			if(now.before(st)) {
				varList.get(i).put("STATUS", 0);
			}
			if(now.after(st)&&now.before(en)) {
				varList.get(i).put("STATUS", 1);
			}
			if(now.after(en)) {
				varList.get(i).put("STATUS", 2);
			}
			if(now.equals(st) || now.equals(en)) {
				varList.get(i).put("STATUS", 1);
			}
		}
		mv.setViewName("system/teambuilding/teambuilding_list");
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
		mv.setViewName("system/teambuilding/teambuilding_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**去详情页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goDetail")
	public ModelAndView goDetail()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData pd3 = new PageData();
		pd = this.getPageData();
		List<PageData> pd2 = new ArrayList<>();
		System.out.println(pd);//{TEAMBUILDING_ID=dfec40460af74c51a09dafde73087040}
		pd2 = teambuildingscoreService.detail(pd);
		pd3 = teambuildingService.findById(pd);
		System.out.println(pd2);
		pd.put("pd2", pd2);
		pd.put("pd3", pd3);
		mv.setViewName("system/teambuilding/teambuilding_widget");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**获取
	 * @param
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/goDetail2")
	public Object goDetail2()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> pd2 = new ArrayList<>();
		pd2 = teambuildingscoreService.detail(pd);
		System.out.println("!!!!!!!!!!!!!!"+pd2);
		pd.put("pd2", pd2);
		return pd2;
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
		pd = teambuildingService.findById(pd);	//根据ID读取
		mv.setViewName("system/teambuilding/teambuilding_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除TeamBuilding");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			teambuildingService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出TeamBuilding到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("建设名");	//1
		titles.add("建设描述");	//2
		titles.add("开始时间");	//3
		titles.add("结束时间");	//4
		titles.add("状态");	//5
		titles.add("评价");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = teambuildingService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("BULIDING_NAME"));	//1
			vpd.put("var2", varOList.get(i).getString("BUILDING_DESCRIE"));	//2
			vpd.put("var3", varOList.get(i).getString("STARTTIME"));	//3
			vpd.put("var4", varOList.get(i).getString("ENDTIME"));	//4
			vpd.put("var5", varOList.get(i).get("STATUS").toString());	//5
			vpd.put("var6", varOList.get(i).getString("REMARK"));	//6
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
}
