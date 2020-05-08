package com.fh.controller.system.monologue;

import java.io.PrintWriter;
import java.util.*;

import javax.annotation.Resource;

import org.apache.poi.util.SystemOutLogger;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.service.system.monologue.MonologueManager;
import com.fh.service.system.sysparam.SysParamManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.entity.system.User;


/**
* @author liangjy@asiainfo.com
* 创建时间：2018年7月24日
* 类说明
*/
@Controller
@RequestMapping(value="monologue")
public class MonologueController extends BaseController{

	public MonologueController() {
		// TODO Auto-generated constructor stub
	}

	String menuUrl = "monologue/list.do"; //菜单地址(权限用)
	
	@Resource(name="monologueService")
	private MonologueManager monologueService;
	
	@Resource(name="sequenceService")
	SequenceService sequenceService;
	
	@Resource(name="userService")
	private UserManager userService;
	
	@Resource(name="sysparamService")
	private SysParamManager sysparamService;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYW = pd.getString("keyword");	//检索条件
		if(null != KEYW && !"".equals(KEYW)){
			pd.put("KEYW", KEYW.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = monologueService.list(page);	//列出Pictures列表
		mv.setViewName("system/monologue/monologue_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/show")
	public ModelAndView show(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYW = pd.getString("keyword");	//检索条件
		if(null != KEYW && !"".equals(KEYW)){
			pd.put("KEYW", KEYW.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = monologueService.show(page);	//列出Pictures列表
		mv.setViewName("system/monologue/monologue");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("msg","success");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/show1")
	@ResponseBody
	public Object show1(Page page) throws Exception{
		
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList = monologueService.show(page);	//列出Pictures列表
		map.put("result", "success");
//		map.put("list", varList);
		return AppUtil.returnObject(new PageData(), map);
	}
	

	/**新增
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增monologue");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		Session session = Jurisdiction.getSession();
		String anonymous = pd.getString("ANONYMOUS");
		if( null == anonymous) {
			pd.put("TAG_AUTHOR", ((User)session.getAttribute("sessionUser")).getUSERNAME());
		}
		pd.put("STATUS", "0");
		pd.put("TAG_ID", sequenceService.getById(pd));	//主键
		pd.put("START_DATE", Tools.date2Str(new Date())); //创建时间
		monologueService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**修改
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改信息");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		Session session = Jurisdiction.getSession();
		String anonymous = pd.getString("ANONYMOUS");
		if( null == anonymous) {
			pd.put("TAG_AUTHOR", ((User)session.getAttribute("sessionUser")).getUSERNAME());
		}else {
			pd.put("TAG_AUTHOR","");
		}
		
		String pstatus = pd.getString("PSTATUS");
		if( null == pstatus) {
			pd.put("STATUS", "1");
		}else {
			pd.put("STATUS", "0");
		}

		if(pd.getString("STATUS") != null && "1".equals(pd.getString("STATUS"))){
			pd.put("END_DATE", Tools.date2Str(new Date()));
		}else {
			pd.put("END_DATE","");
		}
		monologueService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**去新增页面
	 * @return
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd() throws Exception{
		logBefore(logger, "去新增monologue页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("msg", "save");
		try {
			pd.put("P_CODE", "800");
			List<PageData>	userList = sysparamService.findById(pd);	//列出用户列表
			mv.addObject("userList", userList);
			mv.setViewName("system/monologue/monologue_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	/**去修改页面
	 * @return
	 */
	@RequestMapping(value="/goEditU")
	public ModelAndView goEditU(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd.put("P_CODE", "800");
			List<PageData>	userList = sysparamService.findById(pd);	//列出用户列表
			pd = monologueService.findById(pd);		
			mv.addObject("userList", userList);
			mv.setViewName("system/monologue/monologue_edit");
			mv.addObject("msg", "editU");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}



	/**删除monologue
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteM")
        public void deleteM(PrintWriter out) throws Exception{
            if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
            logBefore(logger, "删除monologue");
            PageData pd = new PageData();
            pd = this.getPageData();
            monologueService.delete(pd);
            out.write("success");
            out.close();
        }

    /**批量删除monologue
     * @param
     * @throws Exception
     */

    @RequestMapping(value="/deleteAll")
    @ResponseBody
    public Object deleteAll() throws Exception{
        logBefore(logger, "批量删除monologue");
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String,Object> map1=new HashMap<>();
        List<PageData> pdList1 = new ArrayList<PageData>();

        String DATA_IDS = pd.getString("DATA_IDS");
        if (null!=DATA_IDS&&!"".equals(DATA_IDS)){
            String  ArrayDATA_IDS[]=DATA_IDS.split(",");
            monologueService.deleteAllM(ArrayDATA_IDS);
        }
        pdList1.add(pd);
        map1.put("list", pdList1);
        return AppUtil.returnObject(pd, map1);
    }
    
	/**去新增页面
	 * @return
	 */
	@RequestMapping(value="/goAddTop")
	public ModelAndView goAddTop(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表SysParam");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = sysparamService.list(page);	//列出SysParam列表
		mv.setViewName("system/monologue/sysparam_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**保存param
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveParam")
	public void saveParam(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增SysParam");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return ;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", "param");
		pd.put("LEN", 4);
		pd.put("P_VALUE", sequenceService.getLogID(pd));	//主键
		sysparamService.save(pd);
		out.write("success");
		out.close();
	}
	
	/**删除
	 * @param out
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteParam")
	@ResponseBody
	public Object deleteParam() throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		logBefore(logger, Jurisdiction.getUsername() + "删除SysParam");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			map.put("result", "error");
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		sysparamService.delete(pd);
		map.put("result", "sucess");
		return AppUtil.returnObject(pd, map);

	}

}
