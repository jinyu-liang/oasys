package com.fh.controller.system.zj;

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
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.service.system.zj.ZJManager;

/** 
 * 说明：主机信息
 * 创建人：ADMIN
 * 创建时间：2018-11-13
 */
@Controller
@RequestMapping(value="/zj")
public class ZJController extends BaseController {
	
	String menuUrl = "zj/list.do"; //菜单地址(权限用)
	@Resource(name="zjService")
	private ZJManager zjService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ZJ");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ZJ_ID", this.get32UUID());	//主键
		zjService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ZJ");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		zjService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ZJ");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		zjService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表ZJ");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		String HOST_USER=pd.getString("HOST_USER");
		if(null != HOST_USER && !"".equals(HOST_USER)){            //按照主机用户检索
			pd.put("HOST_USER", HOST_USER);
		}
		
		String ZJ_IP=pd.getString("ZJ_IP");
		if(null != ZJ_IP && !"".equals(ZJ_IP)){            //按照主机IP检索
			pd.put("ZJ_IP", ZJ_IP);
		}	
		
	//按照搜索框内容检索 
		String HOST_TYPE=pd.getString("HOST_TYPE");                    
		if (null !=HOST_TYPE && HOST_TYPE.equals("生产")) {     //检索主机类型  注意不要加入不等于非空字符串的条件 
			HOST_TYPE="0";	
			pd .put(HOST_TYPE, "HOST_TYPE");
		}
		if (null !=HOST_TYPE && HOST_TYPE.equals("测试")) {     //检索主机类型  注意不要加入不等于非空字符串的条件 
			HOST_TYPE="1";	
			pd .put(HOST_TYPE, "HOST_TYPE");
		}
		if (null !=HOST_TYPE && HOST_TYPE.equals("开发")) {     //检索主机类型  注意不要加入不等于非空字符串的条件 
			HOST_TYPE="2";	
			pd .put(HOST_TYPE, "HOST_TYPE");
		}
		
	//  所属系统部分	
		String HOST_SYS=pd.getString("HOST_SYS");
		if (null !=HOST_SYS && HOST_SYS.equals("CRM")) {     //检索所属系统
			HOST_SYS="0";	
			pd .put(HOST_SYS, "HOST_SYS");
		}
		if (null !=HOST_SYS && HOST_SYS.equals("BOSS")) {     
			HOST_SYS="1";	
			pd .put(HOST_SYS, "HOST_SYS");
		}
		if (null !=HOST_SYS && HOST_SYS.equals("ESOP")) {     
			HOST_SYS="2";	
			pd .put(HOST_SYS, "HOST_SYS");
		}
		if (null !=HOST_SYS && HOST_SYS.equals("客服")) {     
			HOST_SYS="3";	
			pd .put(HOST_SYS, "HOST_SYS");
		}
		if (null !=HOST_SYS && HOST_SYS.equals("iboss")) {     
			HOST_SYS="4";	
			pd .put(HOST_SYS, "HOST_SYS");
		}
		
		
		page.setPd(pd);
		System.out.println("pd");//打印pd的值
		List<PageData>	varList = zjService.list(page);	//列出ZJ列表
		mv.setViewName("system/zj/zj_list");
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
		mv.setViewName("system/zj/zj_edit");
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
		pd = zjService.findById(pd);	//根据ID读取
		mv.setViewName("system/zj/zj_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ZJ");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			zjService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出ZJ到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主机ip");	//1
		titles.add("主机用户");	//2
		titles.add("主机密码");	//3
		titles.add("主机类型");	//4
		titles.add("主机环境");	//5
		titles.add("主要用途");	//6
		titles.add("主机用户端口");	//7
		titles.add("账户用途描述");	//8
		titles.add("账户主要操作");	//9
		titles.add("主机型号");	//10
		titles.add("主机名称");	//11
		titles.add("主机配置");	//12
		titles.add("更新员工");	//13
		titles.add("更新时间");	//14
		titles.add("主机状态");	//15
		titles.add("所属系统");	//16
		dataMap.put("titles", titles);
		List<PageData> varOList = zjService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ZJ_IP"));	//1
			vpd.put("var2", varOList.get(i).getString("HOST_USER"));	//2
			vpd.put("var3", varOList.get(i).getString("HOST_PWD"));	//3
			vpd.put("var4", varOList.get(i).getString("HOST_TYPE"));	//4
			vpd.put("var5", varOList.get(i).getString("HOST_ATTR"));	//5
			vpd.put("var6", varOList.get(i).getString("HOST_DES"));	//6
			vpd.put("var7", varOList.get(i).getString("HOST_USER_PORT"));	//7
			vpd.put("var8", varOList.get(i).getString("HOST_USER_DES"));	//8
			vpd.put("var9", varOList.get(i).getString("HOST_USER_OPER"));	//9
			vpd.put("var10", varOList.get(i).getString("HOST_NOTE"));	//10
			vpd.put("var11", varOList.get(i).getString("HOST_NAME"));	//11
			vpd.put("var12", varOList.get(i).getString("HOST_CONFIG"));	//12
			vpd.put("var13", varOList.get(i).getString("UPDATE_STAFF_ID"));	//13
			vpd.put("var14", varOList.get(i).getString("UPDATE_TIME"));	//14
			vpd.put("var15", varOList.get(i).getString("HOST_STATUS"));	//15
			vpd.put("var16", varOList.get(i).getString("HOST_SYS"));	//16
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
