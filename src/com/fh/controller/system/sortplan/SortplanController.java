package com.fh.controller.system.sortplan;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.system.sortplan.SortplanManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;
import org.apache.taglibs.standard.lang.jstl.NullLiteral;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import javax.annotation.Resource;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import static org.apache.log4j.spi.Configurator.NULL;

@Controller
@RequestMapping(value="sortplan")
public class SortplanController extends BaseController {
    public SortplanController(){

    }
    String menuUrl = "sortplan/list.do";

    @Resource(name="sortplanService")
    private SortplanManager sortplanManager;

    @Resource(name="userService")
    private UserManager userService;

    @Resource(name="sequenceService")
    SequenceService sequenceService;

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
        List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
        page.setPd(pd);
       String username=Jurisdiction.getUsername();
        pd.put("TL_USERNAME",username);//获取当前操作用户
        pd.put("TL_TIME",Tools.date3Str(new Date()));
        List<PageData> allsortplanList=sortplanManager.listAll(page);//列出故障表单列表
        mv.setViewName("system/sortplan/sortplan_list");
        mv.addObject("userList", userList);
        mv.addObject("allsortplanList",allsortplanList);
        mv.addObject("pd", pd);
        mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
        return mv;
    }
    /**去新增培训计划页面
     * @return
     */
    @RequestMapping(value="/goAddS")
    public ModelAndView goAdd() throws Exception{
        logBefore(logger, "去新增页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        pd.put("msg", "save");
        try {
            List<PageData>	userList = userService.listAllUser(pd);	//列出用户列表
            mv.addObject("userList", userList);
            mv.setViewName("system/sortplan/sortplan_edit");
            mv.addObject("msg", "save");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }



    /**新增切割页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/save")
    public ModelAndView save() throws Exception{
        logBefore(logger, "新增sortplan");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        sortplanManager.saveS(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }
    /**去修改切割页面
     * @return
     */
    @RequestMapping(value="/goEditS")
    public ModelAndView goEditU(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
            pd = sortplanManager.findByIdS(pd);
            mv.addObject("userList", userList);
            mv.setViewName("system/sortplan/sortplan_edit");
            mv.addObject("msg", "editsS");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**去查看页面
     * @return
     */
    @RequestMapping(value="/gochaS")
    public ModelAndView gochaS(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
            pd = sortplanManager.findByIdS(pd);
            mv.addObject("userList", userList);
            mv.setViewName("system/sortplan/sortplan_view");
            mv.addObject("msg", "chaS");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**修改切割操作
     * @param
     * @throws Exception
     */

    @RequestMapping(value = "/editsS")
    public ModelAndView editsS() throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "editS")){return null;} //校验权限
        logBefore(logger, Jurisdiction.getUsername()+"修改信息");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        sortplanManager.editS(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;

    }


    /**删除切割操作
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/deleteS")
    public void deleteB(PrintWriter out) throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
        logBefore(logger, "删除sortplan");
        PageData pd = new PageData();
        pd = this.getPageData();
        sortplanManager.deleteS(pd);
        out.write("success");
        out.close();
    }
    /** 签到操作
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/signin")
    public void signin(PrintWriter out) throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return;} //校验权限
        logBefore(logger, "signin签到");
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("TL_SP_ID",pd.getString("SP_ID"));
        pd.put("TL_TIME",Tools.date3Str(new Date()));
        pd.put("TL_USERNAME",Jurisdiction.getUsername());//获取当前操作用户

        sortplanManager.savesingin(pd);
        out.write("success");
        out.close();
    }






//    /**批量删除切割操作
//     * @param
//     * @throws Exception
//     */
//
//    @RequestMapping(value="/deleteAll")
//    @ResponseBody
//    public Object deleteAll() throws Exception{
//        logBefore(logger, "批量删除monologue");
//        PageData pd = new PageData();
//        pd = this.getPageData();
//        Map<String,Object> map1=new HashMap<>();
//        List<PageData> pdList1 = new ArrayList<PageData>();
//
//        String DATA_IDS = pd.getString("DATA_IDS");
//        if (null!=DATA_IDS&&!"".equals(DATA_IDS)){
//            String  ArrayDATA_IDS[]=DATA_IDS.split(",");
//            cutService.deleteAllC(ArrayDATA_IDS);
//        }
//        pdList1.add(pd);
//        map1.put("list", pdList1);
//        return AppUtil.returnObject(pd, map1);
//    }




}
