package com.fh.controller.system.activetask;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.WeekFields;
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
import com.fh.service.system.activetask.ACTIVETASKManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 说明：实际工作管理
 * 创建人：ADMIN
 * 创建时间：2018-12-11
 */
@Controller
@RequestMapping(value="/activetask")
public class ACTIVETASKController extends BaseController {
	
	String menuUrl = "activetask/list.do"; //菜单地址(权限用)
	@Resource(name="activetaskService")
	private ACTIVETASKManager activetaskService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ACTIVETASK");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ACTIVETASK_ID", this.get32UUID());	//主键
		//解析任务开始时间，计算周次
		String start = pd.get("START_DATE").toString();
		start.substring(0, 10);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Instant instant = sdf.parse(start.substring(0, 10)).toInstant();
		ZoneId zoneId = ZoneId.systemDefault();
		LocalDate ld = instant.atZone(zoneId).toLocalDate();
		WeekFields weekFields = WeekFields.of(DayOfWeek.MONDAY,4);
		ld.get(weekFields.weekBasedYear());
		pd.put("WEEK_NUM", ld.get(weekFields.weekOfWeekBasedYear()));
		//获取当前时间，得出更新时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		pd.put("UPDATE_TIME", df.format(new Date()));
		activetaskService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ACTIVETASK");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		activetaskService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ACTIVETASK");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//解析任务开始时间，计算周次
		String start = pd.get("START_DATE").toString();
		start.substring(0, 10);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Instant instant = sdf.parse(start.substring(0, 10)).toInstant();
		ZoneId zoneId = ZoneId.systemDefault();
		LocalDate ld = instant.atZone(zoneId).toLocalDate();
		WeekFields weekFields = WeekFields.of(DayOfWeek.MONDAY,4);
		ld.get(weekFields.weekBasedYear());
		pd.put("WEEK_NUM", ld.get(weekFields.weekOfWeekBasedYear()));
		//获取当前时间，得出更新时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		pd.put("UPDATE_TIME", df.format(new Date()));
		activetaskService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去查看详情页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/godetile")
    public ModelAndView godetile(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	pd = activetaskService.findById(pd);
            mv.setViewName("system/activetask/activetask_view");
    		mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表ACTIVETASK");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		System.out.println(user.toString());
		String keywords = user.getNAME();			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String startdata = pd.getString("startdata");           //开始时间条件
		if(null != startdata && !"".equals(startdata)){
			pd.put("startdata", startdata.trim());
		}
		String enddata = pd.getString("enddata");               //结束时间条件
		if(null != enddata && !"".equals(enddata)){
			pd.put("enddata", enddata.trim());
		}
		String type = pd.getString("type");				//类型条件
		if(null != type && !"".equals(type)){
			pd.put("type", type.trim());
		}
		//解析当前时间，计算周次
		LocalDate ld = LocalDate.now();;
		WeekFields weekFields = WeekFields.of(DayOfWeek.MONDAY,4);
		String week = String.valueOf(ld.get(weekFields.weekOfWeekBasedYear()));				//周数条件
		if (null != week && !"".equals(week)) {
			pd.put("week", week.trim());
		}
		//获取权限
		String roleid=user.getROLE_ID();
		page.setPd(pd);
		List<PageData>	varList = activetaskService.list(page);	//列出ACTIVETASK列表
		mv.setViewName("system/activetask/activetask_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/search")
	public ModelAndView search(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表ACTIVETASK");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String startdata = pd.getString("startdata");           //开始时间条件
		if(null != startdata && !"".equals(startdata)){
			pd.put("startdata", startdata.trim());
		}
		String enddata = pd.getString("enddata");               //结束时间条件
		if(null != enddata && !"".equals(enddata)){
			pd.put("enddata", enddata.trim());
		}
		String type = pd.getString("type");				//类型条件
		if(null != type && !"".equals(type)){
			pd.put("type", type.trim());
		}
		String week = pd.getString("week");				//周数条件
		if (null != week && !"".equals(week)) {
			//检索条件为0时检索全部
			if (week.equals("0")) {
				pd.put("week", "");
			} else {
			//其余条件检索指定周
				pd.put("week", week.trim());
			}
		}
		//获取权限
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		String roleid=user.getROLE_ID();
		page.setPd(pd);
		List<PageData>	varList = activetaskService.list(page);	//列出ACTIVETASK列表
		mv.setViewName("system/activetask/activetask_list");
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
		//获取登录人员信息，存入员工ID
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		pd.put("STAFF_ID", user.getUSER_ID());
		
		mv.setViewName("system/activetask/activetask_edit");
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
		pd = activetaskService.findById(pd);	//根据ID读取
		mv.setViewName("system/activetask/activetask_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ACTIVETASK");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			activetaskService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出ACTIVETASK到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("任务名称");	//1
		titles.add("任务类型");	//2
		titles.add("实际开始时间");	//3
		titles.add("实际结束时间");	//4
		titles.add("实际工作量");	//5
		titles.add("员工ID");	//6
		titles.add("移动负责人");	//7
		titles.add("周次");	//8
		titles.add("更新时间");	//9
		titles.add("备注");	//10
		dataMap.put("titles", titles);
		List<PageData> varOList = activetaskService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("TASK_NAME"));	//1
			vpd.put("var2", varOList.get(i).getString("TASK_TYPE"));	//2
			vpd.put("var3", varOList.get(i).getString("START_DATE"));	//3
			vpd.put("var4", varOList.get(i).getString("END_DATE"));	//4
			vpd.put("var5", varOList.get(i).getString("WORK_LOAD"));	//5
			vpd.put("var6", varOList.get(i).getString("STAFF_ID"));	//6
			vpd.put("var7", varOList.get(i).getString("IT_NAME"));	//7
			vpd.put("var8", varOList.get(i).getString("WEEK_NUM"));	//8
			vpd.put("var9", varOList.get(i).getString("UPDATE_TIME"));	//9
			vpd.put("var10", varOList.get(i).getString("REMARK"));	//10
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
