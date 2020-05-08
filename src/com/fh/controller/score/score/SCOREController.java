package com.fh.controller.score.score;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.fh.service.score.score.SCOREManager;
import com.fh.service.score.userscorelog.UserScoreLogManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 说明：积分信息
 * 创建人：admin
 * 创建时间：2018-12-17
 */
@Controller
@RequestMapping(value="/score")
public class SCOREController extends BaseController {
	
	String menuUrl = "score/list.do"; //菜单地址(权限用)
	@Resource(name="scoreService")
	private SCOREManager scoreService;
	@Autowired
	private UserScoreLogManager user_score_logService;
	@Resource(name = "sequenceService")
	SequenceService sequenceService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增SCORE");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		
		PageData pd = new PageData();
		PageData logpd = new PageData();
		pd = this.getPageData();
		pd.put("ID", "score");//生成流水号
		logpd.put("ID", "scorelog");//生成流水号
		String SCORE_ID=sequenceService.getLogID(pd);
		pd.put("SCORE_ID", SCORE_ID);	//主键
		pd.put("ACTUAL_VALUE", pd.get("SCORE_VALUE"));	//积分剩余总量
		
		String persent = null;
		int score = Integer.parseInt(pd.get("SCORE_VALUE").toString());
		int amount = Integer.parseInt(pd.get("PROJECT_AMOUNT").toString());
		if(score%amount==0) {
			persent = String.valueOf(score/amount);
		}else {
			persent = txfloat(score, amount);
		}
		pd.put("SCORE_PROPORTION", persent+":1");	//积分剩余总量
		pd.put("SCORE_TIMES", "0");	//积分赠送次数
		pd.put("IN_ID", user.getUSER_ID());	//录入人
		pd.put("IN_DATE", Tools.date2Str(new Date()));	//录入时间
/*		pd.put("UPDATE_ID", "无更新");	//更新人
		pd.put("UPDATE_DATE", "无更新");	//更新时间
*/		
		System.out.println(pd.get("REMARK"));
		scoreService.save(pd);
//		logpd.put("USER_SCORE_LOG_ID", this.get32UUID());	//主键
		logpd.put("USER_SCORE_LOG_ID", sequenceService.getLogID(logpd));	//主键
		logpd.put("LOG_TYPE","0");	//日志类型0：sys_score新增  1：sys_score更新  10：user_score 赠送 out  11：user_score 给与  01:user_score新增  00:user_score修改
		logpd.put("SCORE_VALUE", pd.get("SCORE_VALUE"));
		logpd.put("USER_ID",user.getUSER_ID());	//更新人ID
		logpd.put("REMARK",pd.get("REMARK"));	//更新人ID
		logpd.put("SCORE_ID", SCORE_ID);	//积分ID
		logpd.put("UPDATE_ID",user.getUSER_ID());	//更新人名
		logpd.put("UPDATE_DATE", Tools.date2Str(new Date()));	//更新时间
		user_score_logService.save(logpd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除SCORE");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		scoreService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改SCORE");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();

		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		PageData pd2 = new PageData();
		PageData logpd = new PageData();
		pd = this.getPageData();
		pd2 = scoreService.findById(pd);	//根据ID读取
		System.out.println("pd2"+pd2);
		logpd.put("ID", "scorelog");
		
		String persent = null;
		int score = Integer.parseInt(pd.get("SCORE_VALUE").toString());
		int amount = Integer.parseInt(pd.get("PROJECT_AMOUNT").toString());
		if(score%amount==0) {
			persent = String.valueOf(score/amount);
		}else {
			persent = txfloat(score, amount);
		}
		pd.put("SCORE_PROPORTION", persent+":1");	//积分剩余总量
		pd.put("ACTUAL_VALUE", pd2.get("ACTUAL_VALUE"));	//积分剩余总量
		pd.put("UPDATE_ID", user.getNAME());	//更新人
		pd.put("UPDATE_DATE", Tools.date2Str(new Date()));	//更新时间
		scoreService.edit(pd);
		logpd.put("USER_SCORE_LOG_ID", sequenceService.getLogID(logpd));	//主键
		logpd.put("LOG_TYPE", "1");	//日志类型
		logpd.put("USER_ID",user.getUSER_ID());	//更新人ID
		logpd.put("SCORE_ID", pd.get("SCORE_ID"));	//积分ID
		logpd.put("SCORE_VALUE",pd2.get("SCORE_VALUE"));//当前积分值
		logpd.put("UPDATE_ID", user.getUSER_ID());	//更新人
		logpd.put("UPDATE_DATE", Tools.date2Str(new Date()));	//更新时间
		logpd.put("REMARK", pd.get("REMARK"));
		user_score_logService.save(logpd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表SCORE");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		String startdate = pd.getString("startdate");				//关键词检索条件
		String enddate = pd.getString("enddate");				//关键词检索条件
		if(null != startdate && !"".equals(startdate)){
			pd.put("startdate", startdate.trim());
		}
		if(null != enddate && !"".equals(enddate)){
			pd.put("enddate", enddate.trim());
		}
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = scoreService.list(page);	//列出SCORE列表
		mv.setViewName("score/score/score_list");
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
		mv.setViewName("score/score/score_edit");
		mv.addObject("reason","新增原因：");
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
		pd = scoreService.findById(pd);	//根据ID读取
		mv.setViewName("score/score/score_edit");
		mv.addObject("reason","修改原因：");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除SCORE");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			scoreService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出SCORE到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("积分标题");	//1
		titles.add("积分原始总量");	//2
		titles.add("积分剩余总量");	//3
		titles.add("积分赠送次数");	//4
		titles.add("项目ID");	//5
		titles.add("项目名称");	//6
		titles.add("项目金额");	//7
		titles.add("积分与项目金额比例");	//8
		titles.add("备注");	//9
		titles.add("生效时间");	//10
		titles.add("失效时间");	//11
		titles.add("录入人");	//12
		titles.add("录入时间");	//13
		titles.add("更新人");	//14
		titles.add("更新时间");	//15
		dataMap.put("titles", titles);
		List<PageData> varOList = scoreService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SCORE_NAME"));	//1
			vpd.put("var2", varOList.get(i).get("SCORE_VALUE").toString());	//2
			vpd.put("var3", varOList.get(i).get("ACTUAL_VALUE").toString());	//3
			vpd.put("var4", varOList.get(i).get("SCORE_TIMES").toString());	//4
			vpd.put("var5", varOList.get(i).getString("PROJECT_ID"));	//5
			vpd.put("var6", varOList.get(i).getString("PROJECT_NAME"));	//6
			vpd.put("var7", varOList.get(i).get("PROJECT_AMOUNT").toString());	//7
			vpd.put("var8", varOList.get(i).getString("SCORE_PROPORTION"));	//8
			vpd.put("var9", varOList.get(i).getString("REMARK"));	//9
			vpd.put("var10", varOList.get(i).getString("START_DATE"));	//10
			vpd.put("var11", varOList.get(i).getString("END_DATE"));	//11
			vpd.put("var12", varOList.get(i).getString("IN_ID"));	//12
			vpd.put("var13", varOList.get(i).getString("IN_DATE"));	//13
			vpd.put("var14", varOList.get(i).getString("UPDATE_ID"));	//14
			vpd.put("var15", varOList.get(i).getString("UPDATE_DATE"));	//15
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
	
	public String txfloat(int a,int b) {	 
	    DecimalFormat df=new DecimalFormat("0.00");//设置保留位数
	    return df.format((float)a/b);
	}
	
}
