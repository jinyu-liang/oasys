package com.fh.controller.score.userscorelog;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.score.userscorelog.UserScoreLogManager;
import com.fh.service.system.sysparam.SysParamManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 说明：积分管理日志
 * 创建人：admin
 * 创建时间：2018-12-17
 */
@Controller
@RequestMapping(value="/user_score_log")
public class UserScoreLogController extends BaseController {
	
	String menuUrl = "user_score_log/list.do"; //菜单地址(权限用)
	@Resource(name="user_score_logService")
	private UserScoreLogManager user_score_logService;
	@Resource(name="sysparamService")
	private SysParamManager sysparamService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增USER_SCORE_LOG");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_SCORE_LOG_ID", this.get32UUID());	//主键
		pd.put("LOG_TYPE", "1");	//日志类型
		pd.put("USER_ID", "0");	//用户ID
		pd.put("SCORE_ID", "0");	//积分ID
		pd.put("SCORE_VALUE", "0");	//当前积分值
		pd.put("SCORE_IN_ID", "0");	//赠送人ID
		pd.put("SCORE_OUT_ID", "0");	//被赠人ID
		pd.put("SCORE_OUT_VALUE", "0");	//被赠积分
		pd.put("REMARK", "");	//备注
		pd.put("UPDATE_ID", "0");	//更新人
		pd.put("UPDATE_DATE", Tools.date2Str(new Date()));	//更新时间
		user_score_logService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除USER_SCORE_LOG");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		user_score_logService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改USER_SCORE_LOG");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		user_score_logService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表USER_SCORE_LOG");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("updatedate");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		pd.put("P_CODE", "500");
		List<PageData>	sysList = sysparamService.findById(pd);	//列出用户列表
		mv.addObject("sysList", sysList);
		
		page.setPd(pd);
		List<PageData>	varList = user_score_logService.list(page);	//列出USER_SCORE_LOG列表
		mv.setViewName("score/userscorelog/userscoreloglist");
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
		mv.setViewName("score/userscorelog/userscore_logedit");
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
		pd = user_score_logService.findById(pd);	//根据ID读取
		mv.setViewName("score/userscorelog/userscorelogedit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除USER_SCORE_LOG");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			user_score_logService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出USER_SCORE_LOG到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("日志类型");	//1
		titles.add("用户ID");	//2
		titles.add("积分ID");	//3
		titles.add("当前积分值");	//4
		titles.add("赠送人ID");	//5
		titles.add("赠送积分");	//6
		titles.add("被赠人ID");	//7
		titles.add("被赠积分");	//8
		titles.add("备注");	//9
		titles.add("更新人");	//10
		titles.add("更新时间");	//11
		dataMap.put("titles", titles);
		List<PageData> varOList = user_score_logService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("LOG_TYPE").toString());	//1
			vpd.put("var2", varOList.get(i).getString("USER_ID"));	//2
			vpd.put("var3", varOList.get(i).getString("SCORE_ID"));	//3
			vpd.put("var4", varOList.get(i).get("SCORE_VALUE").toString());	//4
			vpd.put("var5", varOList.get(i).getString("SCORE_IN_ID"));	//5
			vpd.put("var6", varOList.get(i).get("SCORE_IN_VALUE").toString());	//6
			vpd.put("var7", varOList.get(i).getString("SCORE_OUT_ID"));	//7
			vpd.put("var8", varOList.get(i).get("SCORE_OUT_VALUE").toString());	//8
			vpd.put("var9", varOList.get(i).getString("REMARK"));	//9
			vpd.put("var10", varOList.get(i).getString("UPDATE_ID"));	//10
			vpd.put("var11", varOList.get(i).getString("UPDATE_DATE"));	//11
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
