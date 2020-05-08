package com.fh.controller.system.trainjoin;

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
import com.fh.service.system.trainjoin.TrainJoinManager;
import com.fh.service.system.trainscore.TrainScoreManager;
import com.fh.service.system.trainscores.TrainScoresManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 说明：培训签到
 * 创建人：zhangxuan5
 * 创建时间：2018-11-09
 */
@Controller
@RequestMapping(value="/trainjoin")
public class TrainJoinController extends BaseController {
	
	String menuUrl = "trainjoin/list.do"; //菜单地址(权限用)
	@Resource(name="trainjoinService")
	private TrainJoinManager trainjoinService;
	@Autowired
	private TrainScoreManager trainscoreService;
	@Autowired
	private TrainScoresManager trainscoresService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PLAN_ID", trainjoinService.findById(pd).get("PLAN_ID"));
		pd.put("TRAINSCORES_ID", this.get32UUID());	//主键
//		System.out.println("——————————————————————————————————————"+pd);
//		String grades="";
//		int score=0;
//		for(int i=1;i<100;i++) {
//			if(pd.get("REMARK"+i)!=null) {
//				grades=grades+pd.get("REMARK"+i)+",";
//				score+=Integer.parseInt((String) pd.get("REMARK"+i));
//			}
//		}
//		pd.put("SUMSCORE",pd.get("REMARK"));
		pd.put("REMARK",pd.get("SCORE"));
		if(pd.get("SCORE").equals(null) || pd.get("SCORE").equals("")) {
			pd.put("REMARK","未评");
		}
		trainscoresService.save(pd);//保存分数
		trainjoinService.edit(pd);//修改分数
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
		logBefore(logger, Jurisdiction.getUsername()+"删除TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		trainjoinService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
//		String grades="";
//		int score=0;
//		for(int i=1;i<100;i++) {
//			if(pd.get("REMARK"+i)!=null) {
//				grades=grades+pd.get("REMARK"+i)+",";
//				score+=Integer.parseInt((String) pd.get("REMARK"+i));
//			}
//		}
//		pd.put("SCORE", grades);
//		pd.put("SUMSCORE",score);
		pd.put("REMARK",pd.get("SCORE"));
		System.out.println("++++++++++++++++++++++++++++++++++++++++++"+pd.get("SCORE"));
		if(pd.get("SCORE").equals(null) || pd.get("SCORE").equals("")) {
			pd.put("REMARK","未评");
		}
		trainscoresService.edit2(pd);//修改分数
		System.out.println(pd);
		trainjoinService.edit(pd);//修改分数
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
//	审批通过
	@RequestMapping(value="/pass")
	public ModelAndView pass() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd=new PageData();
		pd = this.getPageData();
		pd.put("SIGN_TAG", "1");
		trainjoinService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表TrainJoin");
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
			List<PageData>	varList = trainjoinService.list(page);	//列出一级TrainJoin列表
			mv.setViewName("system/trainjoin/trainjoin_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("de9de2f006e145a29d52dfadda295353")) {
			page.setJoinId(user.getUSER_ID());
			List<PageData>	varList = trainjoinService.list3(page);	//列出三级TrainJoin列表
			mv.setViewName("system/trainjoin/trainjoin_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("68f8e4a39efe47c7bb869e9d15ab925d")) {
			page.setJoinId(user.getUSER_ID());
			List<PageData>	varList = trainjoinService.list(page);	//列出二级TrainJoin列表
			mv.setViewName("system/trainjoin/trainjoin_list");
			mv.addObject("varList", varList);
		}
		if(roleid.equals("1")) {
			List<PageData>	varList = trainjoinService.list(page);	//列出管理员TrainJoin列表
			mv.setViewName("system/trainjoin/trainjoin_list");
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
		mv.setViewName("system/trainjoin/trainjoin_edit");
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
		List<PageData> pd2 = new ArrayList<>();
		pd = this.getPageData();//这里是{TRAINJOIN_ID=""}
		pd = trainjoinService.findById(pd);
		pd2 = trainscoreService.findById(pd);	//打分表查询评分类型
		if(trainscoresService.findByTrainJoinId(pd)!=null) {
//			System.out.println(pd);
//			System.out.println(pd2);
//			System.out.println(trainscoresService.findByTrainJoinId(pd));
//			String[] scoreArray = trainscoresService.findByTrainJoinId(pd).get("SCORE").toString().split(",");//解析分数
//			for(int k=0;k<pd2.size();k++) {
//			pd2.get(k).put("TRAINSCORE_ID", Integer.parseInt(scoreArray[k]));//利用无关字段TRAINSCORE_ID存解析出来的值
//			}
			pd.put("pd2", pd2);
			pd.put("pd3", trainscoresService.findByTrainJoinId(pd));
			System.out.println(pd.toString());
			mv.setViewName("system/trainjoin/trainjoin_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
//			System.out.println(mv.toString());
		}
		else {
			System.out.println(pd);
			System.out.println("————————————————————————————————————————————————————————"+pd2);
			pd.put("pd2", pd2);
			mv.setViewName("system/trainjoin/trainjoin_edit");
			mv.addObject("msg", "save");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			trainjoinService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**批量审批
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/passAll")
	@ResponseBody
	public Object passAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量通过TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限（同delete）
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
//			trainjoinService.deleteAll(ArrayDATA_IDS);
			trainjoinService.passAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出TrainJoin到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("培训ID");	//1
		titles.add("培训名");	//2
		titles.add("用户ID");	//3
		titles.add("用户名");	//4
		titles.add("报名时间");	//5
		titles.add("培训打分");	//6
		titles.add("报名状态");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = trainjoinService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PLAN_ID"));	//1
			vpd.put("var2", varOList.get(i).getString("PLAN_NAME"));	//2
			vpd.put("var3", varOList.get(i).getString("USER_ID"));	//3
			vpd.put("var4", varOList.get(i).getString("USER_NAME"));	//4
			vpd.put("var5", varOList.get(i).getString("CREATTIME"));	//5
			vpd.put("var6", varOList.get(i).get("REMARK").toString());	//6
			vpd.put("var7", varOList.get(i).get("SIGN_TAG").toString());	//7
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
