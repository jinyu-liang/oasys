package com.fh.controller.system.hotelinfo;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.support.SimpleTransactionStatus;
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
import com.fh.service.system.hotelinfo.HotelInfoManager;
import com.fh.service.system.util.SequenceManager;
import com.fh.service.system.util.impl.SequenceService;

/** 
 * 说明：住宿信息
 * 创建人：Fankialin
 * 创建时间：2018-12-06
 */
@Controller
@RequestMapping(value="/hotelinfo")
public class HotelInfoController extends BaseController {
	
	String menuUrl = "hotelinfo/list.do"; //菜单地址(权限用)
	@Resource(name="hotelinfoService")
	private HotelInfoManager hotelinfoService;
	
	@Resource(name = "sequenceService")
	SequenceService sequenceService;
	
	/*@Autowired
	private SequenceManager*/ 
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增HotelInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		pd = this.getPageData();
//		pd.setOrderByClause("`START_DATE` DESC");
		pd.put("ID", "scorelog");
		pd.put("TRADE_ID",sequenceService.getLogID(pd));	//主键
		//                get32UUID()
		hotelinfoService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/*
	private Object getLogID() {
		// TODO Auto-generated method stub        //define
		return null;
	}*/



	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除HotelInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		hotelinfoService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")     //@requestmapping  请求映射 msg是控制映射的一个值 前台的msg用来识别controller里走哪个方法，走哪个映射
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改HotelInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		hotelinfoService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表HotelInfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd.setOrderByClause("`START_DATE` DESC,`TRADE_ID` DESC");              //将数据按照开始时间的降序排列
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		
		String STATUS=pd.getString("STATUS");
		
		if (null !=STATUS && STATUS.equals("撤离")) {       //&& !""                   //做转义 默认前台STATUS无值传入空字符串（concle得知）
			STATUS="1";   		                                                       //所以在if的筛选条件中不要加！“” 会导致空指针错误     
			pd.put("STATUS",STATUS);                                                  //两个筛选语句直接定义STATUS字段非null就可以实现不同文字 不同条件的转意改变存入pagedata的pd的k和V.
		}
		
		if (null !=STATUS && STATUS.equals("在住")) {       //&& !""
			STATUS="0";   		                                                            
			pd.put("STATUS",STATUS);
		}
		
		
		

	     /*  {
			STATUS="1";
			pd.put("STSTUS",STATU  elseS);
		}*/
	/*		
		}	if (STATUS.equals("在住")) {
			STATUS="0";                                                             //数据库里的STATUS存的是  0   ，1
		    pd.put("STATUS",STATUS);                                                //前台录入的是在住或者撤离的字符串
				                                                                    //因此在此处做转意。
			}
			if (STATUS.equals("撤离")) {
				STATUS="1";
			    pd.put("STATUS",STATUS);
					
				}*/
			
			
		String EMPTY_BED_FLAG=pd.getString("EMPTY_BED_FLAG");
		if (EMPTY_BED_FLAG !=null &&EMPTY_BED_FLAG.equals("有")) {                   //是否有空床 传值 检索 
			EMPTY_BED_FLAG="0";
			pd.put("EMPTY_BED_FLAG",EMPTY_BED_FLAG);
		}
		
		
		if (EMPTY_BED_FLAG !=null &&EMPTY_BED_FLAG.equals("无")) {                   //是否有空床 传值 检索 
			EMPTY_BED_FLAG="1";
			pd.put("EMPTY_BED_FLAG",EMPTY_BED_FLAG);
		}
		
		String STAFF_NAME=pd.getString("STAFF_NAME");
		if (STAFF_NAME !=null &&STAFF_NAME !="") {                                   //员工姓名检索传值
			pd.put("STAFF_NAME",STAFF_NAME);
		}
		
		String STAFF_ID=pd.getString("STAFF_ID");
		if (STAFF_ID !=null &&STAFF_ID !="") {                                       //员工工号检索传值
			pd.put("STAFF_ID",STAFF_ID);
		}
		
		String START_DATE=pd.getString("START_DATE");
		if (START_DATE !=null &&START_DATE !="") {                  
			pd.put("START_DATE",START_DATE);                                          //开始日期检索传值
		}
		
		String END_DATE = pd.getString("END_DATE");
		if (END_DATE !=null &&END_DATE !="") {                                        //结束日期检索传值
			pd.put("END_DATE",END_DATE);
		}
		
		
		
		page.setPd(pd);
		System.out.print(pd); // 通过后台输出检查pd的值。
		List<PageData>	varList = hotelinfoService.list(page);	//列出HotelInfo列表
		mv.setViewName("system/hotelinfo/hotelinfo_list");
		//pd.setOrderByClause("`TRADE_ID` DESC");  // 将数据按照开始时间的降序排列
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
		mv.setViewName("system/hotelinfo/hotelinfo_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
/**去新增同住人页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddForTZ")
	public ModelAndView goAddForTZ()throws Exception{    //此方法相当于调用了edit方法
		ModelAndView mv = this.getModelAndView();        //此方法的思路 是在点击edit之后拿上一个舍友的信息 再把这条信息不需要的部分指控
		PageData pd = new PageData();                    //再pd里边留下需要的 置空不需要的 此处主键必须置空
		pd = this.getPageData();                            //因为我们最后保存的是一条新数据 是要有自己独立的主键。
		pd = hotelinfoService.findById(pd);	//根据ID读取     找到要修改的数据
		pd.put("STAFF_ID", "");                          // 置空工号 必须的操作  保存时调用save方法。
		pd.put("ROOMMATE", pd.get("STAFF_NAME"));        //此处操是将上一条数据的员工姓名放到新一条数据的同住人字段中去。
		pd.put("STAFF_NAME", "");                        //置空员工姓名
		pd.put("HOTEL_LIVE_NU", "");                     //置空在住人数
		pd.put("WORK_CONTENT", "");                      //置空工作描述
		pd.put("TRADE_ID", "");                          //置空主键   必须操作 保存时调用save方法 相当于完成新增 生成新的主键
		pd.put("END_DATE", "");                          //置空结束时间
		pd.put("EMPTY_BED_FLAG","");                     //置空是否有空床
		
		mv.setViewName("system/hotelinfo/hotelinfo_edit");          //edit页面view
		mv.addObject("msg", "save");                    //        通过edit页面的msg 保存新数据
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
		pd = hotelinfoService.findById(pd);	//根据ID读取
		mv.setViewName("system/hotelinfo/hotelinfo_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	
	

	/**去查看详情页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/golookinfo")
    public ModelAndView golookinfo() throws Exception{    //定义查看页面的方法
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        
        pd = this.getPageData();
        
        
            
           pd=hotelinfoService.findById(pd);   //通过id   findbyid()
           
            
            mv.setViewName("system/hotelinfo/hotelinfo_look");   
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除HotelInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			hotelinfoService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出HotelInfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("工号");	//1
		titles.add("姓名");	//2
		titles.add("住宿地");	//3
		titles.add("酒店详细地址");	//4
		titles.add("住宿类型");	//5
		titles.add("日单价");	//6
		titles.add("房号");	//7
		titles.add("床位");	//8
		titles.add("在住人数");	//9
		titles.add("是否有空床");	//10
		titles.add("工作描述");	//11
		titles.add("住宿状态");	//12
		titles.add("indate");	//13
		titles.add("开始日期");	//14
		titles.add("结束日期");	//15
		titles.add("更新日期");	//16
		titles.add("更新员工");	//17
		titles.add("SRT1");	//18
		titles.add("STR2");	//19
		titles.add("STR3");	//20
		titles.add("STR4");	//21
		titles.add("DATE1");	//22
		titles.add("DATE2");	//23
		titles.add("同住人");	//24
		titles.add("住宿费用");	//25
		dataMap.put("titles", titles);
		List<PageData> varOList = hotelinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("STAFF_ID"));	//1
			vpd.put("var2", varOList.get(i).getString("STAFF_NAME"));	//2
			vpd.put("var3", varOList.get(i).getString("HOTEL_NAME"));	//3
			vpd.put("var4", varOList.get(i).getString("HOTEL_ADRESS"));	//4
			vpd.put("var5", varOList.get(i).getString("HOTEL_FLAG"));	//5
			vpd.put("var6", varOList.get(i).getString("HOTEL_DAY_PRICE"));	//6
			vpd.put("var7", varOList.get(i).getString("HOTEL_ROOM_NU"));	//7
			vpd.put("var8", varOList.get(i).getString("HOTEL_BED_FLAG"));	//8
			vpd.put("var9", varOList.get(i).getString("HOTEL_LIVE_NU"));	//9
			vpd.put("var10", varOList.get(i).getString("EMPTY_BED_FLAG"));	//10
			vpd.put("var11", varOList.get(i).getString("WORK_CONTENT"));	//11
			vpd.put("var12", varOList.get(i).getString("STATUS"));	//12
			vpd.put("var13", varOList.get(i).getString("IN_DATE"));	//13
			vpd.put("var14", varOList.get(i).getString("START_DATE"));	//14
			vpd.put("var15", varOList.get(i).getString("END_DATE"));	//15
			vpd.put("var16", varOList.get(i).getString("UPDATE_DATE"));	//16
			vpd.put("var17", varOList.get(i).getString("UPDATE_STAFF_ID"));	//17
			vpd.put("var18", varOList.get(i).getString("RSRV_STR1"));	//18
			vpd.put("var19", varOList.get(i).getString("RSRV_STR2"));	//19
			vpd.put("var20", varOList.get(i).getString("RSRV_STR3"));	//20
			vpd.put("var21", varOList.get(i).getString("RSRV_STR4"));	//21
			vpd.put("var22", varOList.get(i).getString("RSRV_DATE1"));	//22
			vpd.put("var23", varOList.get(i).getString("RSRV_DATE2"));	//23
			vpd.put("var24", varOList.get(i).getString("ROOMMATE"));	//24
			vpd.put("var25", varOList.get(i).getString("HOTEL_EXPENSE"));	//25
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
