package com.fh.controller.system.operationapprove;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.service.system.operationapprove.OperationApproveManager;

/** 
 * 说明：日常紧急更新操作审批
 * 创建人：fankl
 * 创建时间：2018-11-15
 */
@Controller
@RequestMapping(value="/operationapprove")
public class OperationApproveController extends BaseController {
	
	String menuUrl = "operationapprove/list.do"; //菜单地址(权限用)
	@Resource(name="operationapproveService")
	private OperationApproveManager operationapproveService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增OperationApprove");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		pd.put("APPROVE_ID",this.get32UUID());	//主键               this.get32UUID()
		
		//pd.put("APPROVE_ID","");
		operationapproveService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除OperationApprove");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		operationapproveService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改OperationApprove");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		operationapproveService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表OperationApprove");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		
		String SUBMINT_DATE = pd.getString("SUBMINT_DATE");	//提交时间
		String UPDATE_DATE = pd.getString("UPDATE_DATE");		//更新时间
		if(SUBMINT_DATE != null && !"".equals(SUBMINT_DATE)){
			pd.put("SUBMINT_DATE", SUBMINT_DATE);
		}
		if(UPDATE_DATE != null && !"".equals(UPDATE_DATE)){
			pd.put("UPDATE_DATE", UPDATE_DATE);
		} 
		
		
		String APPROVE_STATE=pd.getString("APPROVE_STATE"); //根据页面下拉框检索局方审批状态
		if(APPROVE_STATE != null && !"".equals(APPROVE_STATE)){
			pd.put("APPROVE_STATE", APPROVE_STATE);
		}
		String ASI_APPROVE_STATE=pd.getString("ASI_APPROVE_STATE");   //亚信审批状态 
		if(ASI_APPROVE_STATE !=null && !"".equals(ASI_APPROVE_STATE)) {
			pd.put("ASI_APPROVE_STATE", ASI_APPROVE_STATE);
		}
		
		String SUBMITTER=pd.getString("SUBMITTER");                     
		if(SUBMITTER !=null && !"".equals(SUBMITTER)){             //存入提交人
		  pd.put("SUBMITTER", SUBMITTER);
	}
		String SUBMITID=pd.getString("SUBMITID");                     
		if(SUBMITID !=null && !"".equals(SUBMITID)){              //存入提交人ID
		  pd.put("SUBMITID", SUBMITID);
	}		
		
		page.setPd(pd);
		System.out.print(pd);      //  看保存出来的pd的值
		List<PageData>	varList = operationapproveService.list(page);	//列出OperationApprove列表
		mv.setViewName("system/operationapprove/operationapprove_list");
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
		mv.setViewName("system/operationapprove/operationapprove_edit");
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
		pd = operationapproveService.findById(pd);	//根据ID读取
		mv.setViewName("system/operationapprove/operationapprove_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	
	/*
	 *//**去查看详情页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/golook")
		public ModelAndView golook()throws Exception{             //Look()是查看页面的方法
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd = operationapproveService.findById(pd);	//根据ID读取
			mv.setViewName("system/operationapprove/operationapprove_look");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除OperationApprove");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			operationapproveService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出OperationApprove到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("流水号");	//1
		titles.add("提交人ID");	//2
		titles.add("提交人");	//3
		titles.add("提交时间");	//4
		titles.add("更新人");
		titles.add("更新时间");
		titles.add("问题描述");	//5
		titles.add("解决方案");	//6
		titles.add("风险评估");	//7
		titles.add("更新内容");	//8
		titles.add("更新步骤");	//9
		titles.add("验证方法");	//10
		titles.add("局方主管");	//11
		titles.add("局方经理");	//12
		titles.add("局方审批状态");	//13
		titles.add("局方审批意见");	//14
		titles.add("亚信主管");	//15
		titles.add("亚信经理");	//16
		titles.add("亚信审批状态");	//17
		titles.add("亚信审批意见");	//18
		dataMap.put("titles", titles);
		List<PageData> varOList = operationapproveService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("APPROVE_ID"));	//1
			vpd.put("var2", varOList.get(i).getString("SUBMITID"));	//2
			vpd.put("var3", varOList.get(i).getString("SUBMITTER"));	//3
			vpd.put("var4", varOList.get(i).getString("SUBMINT_DATE"));	//4
			vpd.put("var5", varOList.get(i).getString("UPDATE_PEOPLE"));//5
			vpd.put("var6", varOList.get(i).getString("UPDATE_DATE"));//6
			vpd.put("var7", varOList.get(i).getString("QUES_DESCRIBE"));	//7
			vpd.put("var8", varOList.get(i).getString("SOLUTION"));	//8
			vpd.put("var9", varOList.get(i).getString("RISK_ASSESS"));	//9
			vpd.put("var10", varOList.get(i).getString("UPDATE_CONTENT"));	//10
			vpd.put("var11", varOList.get(i).getString("UPDATE_STEP"));	//11
			vpd.put("var12", varOList.get(i).getString("TEST_METHOD"));	//12
			vpd.put("var13", varOList.get(i).getString("OFFICE_SUPERVISOR"));	//13
			vpd.put("var14", varOList.get(i).getString("OFFICE_MANAGER"));	//14
			vpd.put("var15", varOList.get(i).getString("APPROVE_STATE"));	//15
			vpd.put("var16", varOList.get(i).getString("APPROVE_SUGGES"));	//16
			vpd.put("var17", varOList.get(i).getString("ASI_OFFICE_SUPERVISOR"));	//17
			vpd.put("var18", varOList.get(i).getString("ASI_OFFICE_MANAGER"));	//18
			vpd.put("var19", varOList.get(i).getString("ASI_APPROVE_STATE"));	//19
			vpd.put("var20", varOList.get(i).getString("ASI_APPROVE_SUGGES"));	//20
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
