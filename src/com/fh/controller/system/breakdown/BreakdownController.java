package com.fh.controller.system.breakdown;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.breakdown.BreakdownManager;
import com.fh.service.system.subsys.impl.SubsysService;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.util.*;

/**
 * @author  fengjj3@asiainfo.com
 * 创建时间：2018年9月5日
 * 类说明
 */


@Controller
@RequestMapping(value="/breakdown")
public class BreakdownController extends BaseController {
    public BreakdownController() {
        // TODO Auto-generated constructor stub
    }



    String menuUrl = "breakdown/list.do"; //菜单地址(权限用)

    @Resource(name="breakdownService")
    private BreakdownManager breakdownService;

    @Resource(name="sequenceService")
    SequenceService sequenceService;

    @Resource(name="SubsysService")
    private SubsysService subsysService;

    @Resource(name="userService")
    private UserManager userService;

    /**故障处理表单查询
     * @param pd
     * @return
     * @throws Exception
     */

    @RequestMapping(value="/list")
    public ModelAndView list(Page page) throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"列表breakdown");
        ModelAndView mv = this.getModelAndView();
        PageData pd=new PageData();
        pd=this.getPageData();
        String startTime=pd.getString("startTime");
        String endTime=pd.getString("endTime");
        if (startTime!=null&&!"".equals(startTime)){
            pd.put("startTime",startTime+" 00:00:00");
        }
        if (endTime!=null&&!"".equals(endTime)){
            pd.put("endTime",endTime+" 00:00:00");
        }
        List<PageData>	subsysList = subsysService.listAllsubsys(pd);	//列出子系统列表
        List<PageData>	userList = userService.listAllUser(pd);	//列出用户列表
        page.setPd(pd);
        List<PageData> allList=breakdownService.selectAllbkPage(page);//列出故障表单列表
        mv.addObject("userList", userList);
        mv.addObject("subsysList", subsysList);
        mv.addObject("allList",allList);
        mv.addObject("pd",pd);
        mv.setViewName("system/breakdown/breakdown_list");
        mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
        return mv;
    }

    /**去新增故障管理页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/goAddB")
    public ModelAndView goAddB() throws Exception{
        logBefore(logger, "去新增breakdown页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("msg","save");
        try {
            List<PageData>	subsysList = subsysService.listAllsubsys(pd);	//列出子系统列表
            List<PageData>	userList = userService.listAllUser(pd);	//列出用户列表

            mv.addObject("userList", userList);
            mv.addObject("subsysList", subsysList);

            mv.setViewName("system/breakdown/breakdown_edit");
            mv.addObject("msg", "saveB");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**新增鼓掌管理
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/saveB")
    public ModelAndView saveB() throws Exception{
        logBefore(logger, "新增breakdown");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("BK_ID", sequenceService.getById(pd));	//主键

        breakdownService.saveB(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }


    /**去修改故障管理页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/goEditB")
    public ModelAndView goEditB(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            List<PageData> subsysList =subsysService.listAllsubsys(pd);;	//列出子系统列表
            List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
            pd=breakdownService.findbyIdB(pd);

            mv.addObject("userList", userList);
            mv.addObject("subsysList", subsysList);
            mv.setViewName("system/breakdown/breakdown_edit");
            mv.addObject("msg", "editB");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**去查看故障管理页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/gochaB")
    public ModelAndView gochaB(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            List<PageData> subsysList =subsysService.listAllsubsys(pd);;	//列出子系统列表
            List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
            pd=breakdownService.findbyIdB(pd);

            mv.addObject("userList", userList);
            mv.addObject("subsysList", subsysList);
            mv.setViewName("system/breakdown/breakdown_view");
            mv.addObject("msg", "chaB");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**修改故障管理操作
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/editB")
    public ModelAndView editB() throws Exception{
        logBefore(logger, "修改breakdown");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "editB")){return null;} //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        breakdownService.editB(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }

    /**删除breakdown操作
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/deleteB")
    public void deleteB(PrintWriter out) throws Exception{
         if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return ;} //校验权限
        logBefore(logger, "删除breakdown");
        PageData pd = new PageData();
        pd = this.getPageData();
        breakdownService.deleteB(pd);
        out.write("success");
        out.close();
    }

    /**批量删除breakdown
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
            breakdownService.deleteAllB(ArrayDATA_IDS);
        }
        pdList1.add(pd);
        map1.put("list", pdList1);
        return AppUtil.returnObject(pd, map1);
    }
}
