package com.fh.controller.system.teambuildingjoin;

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
import com.fh.service.system.teambuildingjoin.TeamBuildingJoinManager;
import com.fh.service.system.teambuildingscore.TeamBuildingScoreManager;
import com.fh.service.system.teambuildingscoretype.TeamBuildingScoreTypeManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 说明：团队建设维护
 * 创建人：ADMIN
 * 创建时间：2018-11-27
 */
@Controller
@RequestMapping(value="/teambuildingjoin")
public class TeamBuildingJoinController extends BaseController {
	
	String menuUrl = "teambuildingjoin/list.do"; //菜单地址(权限用)
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
		logBefore(logger, Jurisdiction.getUsername()+"新增TeamBuildingJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
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
		logBefore(logger, Jurisdiction.getUsername()+"删除TeamBuildingJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		teambuildingjoinService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改TeamBuildingJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(teambuildingscoreService.findByJoinId(pd)!=null) {
			pd.put("TEAMBUILDINGSCORE_ID",teambuildingscoreService.findById2(pd).get("TEAMBUILDINGSCORE_ID"));
			pd.put("SCORE", pd.get("SCORETYPE"));
			teambuildingscoreService.edit(pd);
		}else {
			pd.put("TEAMBUILDINGSCORE_ID", this.get32UUID());
			pd.put("BUILDING_ID", teambuildingjoinService.findById2(pd).get("BUILDING_ID"));
			pd.put("BUILDINGJOIN_ID", pd.get("TEAMBUILDINGJOIN_ID"));
			pd.put("SCORE", pd.get("SCORETYPE"));
			teambuildingscoreService.save(pd);
		}
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
		logBefore(logger, Jurisdiction.getUsername()+"列表TeamBuildingJoin");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		String roleid=user.getROLE_ID();
		page.setPd(pd);
		if(roleid.equals("3264c8e83d0248bb9e3ea6195b4c0216")) {
			List<PageData>	varList = teambuildingjoinService.list(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/teambuildingjoin/teambuildingjoin_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("de9de2f006e145a29d52dfadda295353")) {
			page.setJoinId(user.getUSER_ID());
			List<PageData>	varList = teambuildingjoinService.list3(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/teambuildingjoin/teambuildingjoin_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("68f8e4a39efe47c7bb869e9d15ab925d")) {
			page.setJoinId(user.getUSER_ID());
			List<PageData>	varList = teambuildingjoinService.list(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/teambuildingjoin/teambuildingjoin_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("1")) {
			List<PageData>	varList = teambuildingjoinService.list(page);	//列出TeamBuildingJoin列表
			mv.setViewName("system/teambuildingjoin/teambuildingjoin_list");
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
		mv.setViewName("system/teambuildingjoin/teambuildingjoin_edit");
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
		PageData pd3 = new PageData();
		List<PageData> pd2 = new ArrayList<>();
		pd = this.getPageData();//这里是{TEAMBUILDINGJOIN_ID=""}
		System.out.println(pd);
		//{TEAMBUILDINGJOIN_ID=4722741a815444dabfae3cf5b914adb2}
		pd2 = teambuildingscoretypeService.findById(pd);
		System.out.println(pd2);
		//[{SCORETYPE=打分类型3, BUILDING_ID=0c174063d47b43c4be36ddfa71e27547, TEAMBUILDINGSCORETYPE_ID=3d14fec2dcab4fb39dc9e8a2511fccb4}, {SCORETYPE=打分类型1, BUILDING_ID=0c174063d47b43c4be36ddfa71e27547, TEAMBUILDINGSCORETYPE_ID=94bd12b5321f41edac6368462258fbf3}, {SCORETYPE=打分类型2, BUILDING_ID=0c174063d47b43c4be36ddfa71e27547, TEAMBUILDINGSCORETYPE_ID=da70183062db4231a8e19a7c98708baf}]
		System.out.println(teambuildingscoreService.findByJoinId(pd));
		pd3 = teambuildingscoreService.findByJoinId(pd);
		if(teambuildingscoreService.findByJoinId(pd)!=null) {
			pd.put("pd3", pd3);
			pd.put("pd2", pd2);
			mv.setViewName("system/teambuildingjoin/teambuildingjoin_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		}else {
			pd.put("pd2", pd2);
			mv.setViewName("system/teambuildingjoin/teambuildingjoin_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		}
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除TeamBuildingJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			teambuildingjoinService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出TeamBuildingJoin到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("建设ID");	//1
		titles.add("用户ID");	//2
		titles.add("报名时间");	//3
		dataMap.put("titles", titles);
		List<PageData> varOList = teambuildingjoinService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("BUILDING_ID"));	//1
			vpd.put("var2", varOList.get(i).getString("USER_ID"));	//2
			vpd.put("var3", varOList.get(i).getString("JOINDATE"));	//3
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
