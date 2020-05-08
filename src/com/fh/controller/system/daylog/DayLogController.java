package com.fh.controller.system.daylog;

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
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.system.daylog.DayLogManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;

/** 
 * 说明：日报管理
 * 创建人：ADMIN
 * 创建时间：2018-11-20
 */
@Controller
@RequestMapping(value="/daylog")
public class DayLogController extends BaseController {
	
	public DayLogController() {
		// TODO Auto-generated constructor stub
	}
	
	String menuUrl = "daylog/list.do"; //菜单地址(权限用)
	@Resource(name="daylogService")
	private DayLogManager daylogService;
	
	@Resource(name="sequenceService")
	SequenceService sequenceService;
	
	@Resource(name="userService")
	private UserManager userService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增DayLog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		pd.put("DAYLOG_ID", this.get32UUID());	//主键
		pd.put("DAYLOG_ID", sequenceService.getById(pd));	//主键
		pd.put("DATE", Tools.date3Str(new Date())); //创建时间
		daylogService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除DayLog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		daylogService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改DayLog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DATE", Tools.date3Str(new Date())); //创建时间
		daylogService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表DayLog");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");	//关键词检索条件
		String startdate = pd.getString("STARTDATE");
		String enddate = pd.getString("ENDDATE");
		if(null != startdate && !"".equals(startdate)){
			pd.put("startdate", startdate.trim());
		}
		if(null != enddate && !"".equals(enddate)){
			pd.put("enddate", enddate.trim());
		}
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		String roleid=user.getROLE_ID();
		page.setPd(pd);
		if(roleid.equals("3264c8e83d0248bb9e3ea6195b4c0216")) {
			List<PageData>	varList = daylogService.list(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/daylog/daylog_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("de9de2f006e145a29d52dfadda295353")) {
			page.setJoinId(user.getUSER_ID());
			List<PageData>	varList = daylogService.list3(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/daylog/daylog_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("68f8e4a39efe47c7bb869e9d15ab925d")) {
			page.setJoinId(user.getUSER_ID());
			List<PageData>	varList = daylogService.list(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/daylog/daylog_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("1")) {
			List<PageData>	varList = daylogService.list(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/daylog/daylog_list");
			mv.addObject("varList", varList);
		}
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
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		PageData pd2 = new PageData();
		pd2.put("NAME", user.getNAME());
		pd2.put("USER_ID", user.getUSER_ID());
		pd.put("pd2", pd2);
		mv.setViewName("system/daylog/daylog_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
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
        PageData pd2 = new PageData();
        pd = this.getPageData();
        pd2 = this.getPageData();
        try {
            List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
            pd=daylogService.findById(pd);
            pd2=userService.findById(pd);
            mv.addObject("userList", userList);
            mv.setViewName("system/daylog/daylog_view");
    		mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.addObject("pd2", pd2);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
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
		pd = daylogService.findById(pd);	//根据ID读取
		PageData pd2 = new PageData();
		pd2 = userService.findById(pd);
		pd.put("pd2", pd2);
		mv.setViewName("system/daylog/daylog_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除DayLog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			daylogService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出DayLog到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户ID");	//1
		titles.add("日志内容");	//2
		titles.add("日期");	//3
		titles.add("日志标题");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = daylogService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USER_ID"));	//1
			vpd.put("var2", varOList.get(i).getString("LOG_NAME"));	//2
			vpd.put("var3", varOList.get(i).getString("DATE"));	//3
			vpd.put("var4", varOList.get(i).getString("LOG_TITLE"));	//4
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
