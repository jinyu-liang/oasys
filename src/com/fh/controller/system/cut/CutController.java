package com.fh.controller.system.cut;


import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.system.cut.CutManager;
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

@Controller
@RequestMapping(value="/cut")
public class CutController extends BaseController {
    public CutController(){

    }

    String menuUrl = "cut/list.do"; //菜单地址(权限用)

    @Resource(name="cutService")
    private CutManager cutService;

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
        String KEYW = pd.getString("CUT_TITLE");	//检索条件
        if(null != KEYW && !"".equals(KEYW)){
            pd.put("CUT_TITLE", KEYW.trim());
        }
        String startTime=pd.getString("startTime");
        String endTime=pd.getString("endTime");
        if (startTime!=null&&!"".equals(startTime)){
            pd.put("startTime",startTime+" 00:00:00");
        }
        if (endTime!=null&&!"".equals(endTime)){
            pd.put("endTime",endTime+" 00:00:00");
        }
        List<PageData>	userList = userService.listAllUser(pd);	//列出用户列表
        page.setPd(pd);
        List<PageData> allCutList=cutService.selectAllcutPage(page);//列出故障表单列表

        mv.setViewName("system/cut/cut_list");
       mv.addObject("userList", userList);
        mv.addObject("allCutList",allCutList);
        mv.addObject("pd", pd);
        mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
        return mv;
    }
    /**去新增切割页面
     * @return
     */
    @RequestMapping(value="/goAdd")
    public ModelAndView goAdd() throws Exception{
        logBefore(logger, "去新增cut页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        pd.put("msg", "save");
        try {
            List<PageData>	userList = userService.listAllUser(pd);	//列出用户列表
            mv.addObject("userList", userList);
            mv.setViewName("system/cut/cut_edit");
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
        logBefore(logger, "新增cut");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("CUT_ID", sequenceService.getById(pd));	//主键
        pd.put("CUT_REPORT_BUILD_TIME", Tools.date2Str(new Date())); //创建时间
        pd.put("CUT_REPORT_RESP_P",Jurisdiction.getUsername());//获取当前操作用户
        cutService.saveC(pd);

        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }
    /**去修改切割页面
     * @return
     */
    @RequestMapping(value="/goEditC")
    public ModelAndView goEditU(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
            pd = cutService.findbyIdC(pd);
            mv.addObject("userList", userList);
            mv.setViewName("system/cut/cut_edit");
            mv.addObject("msg", "editC");
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

    @RequestMapping(value = "/editC")
    public ModelAndView editC() throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "editC")){return null;} //校验权限
        logBefore(logger, Jurisdiction.getUsername()+"修改信息");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        cutService.editC(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;

    }

    /**删除切割操作
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/deleteC")
    public void deleteB(PrintWriter out) throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
        logBefore(logger, "删除breakdown");
        PageData pd = new PageData();
        pd = this.getPageData();
        cutService.deleteC(pd);
        out.write("success");
        out.close();
    }

    /**批量删除切割操作
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
            cutService.deleteAllC(ArrayDATA_IDS);
        }
        pdList1.add(pd);
        map1.put("list", pdList1);
        return AppUtil.returnObject(pd, map1);
    }


}
