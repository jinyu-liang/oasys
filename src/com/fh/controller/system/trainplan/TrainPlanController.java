package com.fh.controller.system.trainplan;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.SignData;
import com.fh.entity.system.User;
import com.fh.service.system.trainjoin.TrainJoinManager;
import com.fh.service.system.trainplan.TrainPlanManager;
import com.fh.service.system.trainscore.TrainScoreManager;
import com.fh.service.system.trainscores.TrainScoresManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

/**
 * 说明：培训计划 
 * 创建人：zhangxuan5 
 * 创建时间：2018-11-07
 */
@Controller
@RequestMapping(value = "/trainplan")
public class TrainPlanController extends BaseController {

	String menuUrl = "trainplan/list.do"; // 菜单地址(权限用)
	@Resource(name = "trainplanService")
	private TrainPlanManager trainplanService;
	@Autowired
	private TrainJoinManager trainjoinService;
	@Autowired
	private TrainScoreManager trainscoreService;
	@Autowired
	private TrainScoresManager trainscoresService;
	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save", method = RequestMethod.POST)
	public ModelAndView save(@RequestParam("PLAN_FILE") MultipartFile file,
			@RequestParam("PICTURE1") MultipartFile pic1,
			@RequestParam("PICTURE2") MultipartFile pic2,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增TrainPlan");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		
		
		
		List<String> list = upfile(file,this.get32UUID());
		List<String> list1 = upfile(pic1,this.get32UUID());
		List<String> list2 = upfile(pic2,this.get32UUID());

		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String uuid=this.get32UUID();
		pd.put("TRAINPLAN_ID", uuid); // 主键
		pd.put("STATUS", ""); // 状态
		pd.put("JOINUSER", "无人参加"); // 参加人
		pd.put("REALTRAINTIME", "0");
		pd.put("REWARD", "暂无");

		pd.put("SCORE",  request.getParameter("SCORE"));
		pd.put("PLAN_NAME",  request.getParameter("PLAN_NAME"));
		pd.put("PLAN_DESCRIE",  request.getParameter("PLAN_DESCRIE"));
		pd.put("STARTTIME",  request.getParameter("STARTTIME"));
		pd.put("ENDTIME",  request.getParameter("ENDTIME"));
		pd.put("REMARK",  request.getParameter("REMARK"));
		pd.put("LETURE",  request.getParameter("LETURE"));
		pd.put("PLANPLACE",  request.getParameter("PLANPLACE"));
		pd.put("PLANTRAINTIME",  request.getParameter("PLANTRAINTIME"));
		pd.put("PLANFILEID",  list.get(0)+list.get(1));
		pd.put("PLANFILENAME",  list.get(2));
		pd.put("PICTUREID1",  list1.get(0)+list1.get(1));
		pd.put("PICTURENAME1",  list1.get(2));
		pd.put("PICTUREID2",  list2.get(0)+list2.get(1));
		pd.put("PICTURENAME2",  list2.get(2));

		trainplanService.save(pd);
		PageData add1=new PageData();
		add1.put("TRAINSCORE_ID", this.get32UUID());
		add1.put("TRAIN_ID", uuid);
		add1.put("SCORE_TYPE", "其他");
		trainscoreService.save(add1);
		for(int i=1;i<100;i++) {	
			if(pd.get("SCORE"+i)!=null) {
				PageData add=new PageData();
				add.put("TRAINSCORE_ID", this.get32UUID());
				add.put("TRAIN_ID", uuid);
				add.put("SCORE_TYPE", (String) pd.get("SCORE"+i));
				trainscoreService.save(add);
			}
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除TrainPlan");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		trainplanService.delete(pd);
		trainjoinService.deletecascade(pd);//级联删除
		trainscoreService.delete(pd);//级联删除
		trainscoresService.delete(pd);//级联删除
		out.write("success");
		out.close();
	}
	
	// 打开饼图
	@RequestMapping(value = "/piechart")
	public ModelAndView pieChart() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/trainplan/trainplan_chart");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	// ajax查询饼图数据
	@ResponseBody
	@RequestMapping(value = "/piechart2")
	public PageData pieChart2() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd);
		List<PageData> pd2 = trainplanService.pie(pd);
		pd.put("pd2", pd2);
		return pd;
	}
	
	// 打开饼图
	@RequestMapping(value = "/piechart3")
	public ModelAndView pieChart3() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/trainplan/trainplan_chart_all");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	// ajax查询饼图数据
	@ResponseBody
	@RequestMapping(value = "/piechart4")
	public PageData pieChart4() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> pd2 = trainplanService.pie2(pd);
		pd.put("pd2", pd2);
		return pd;
	}
			
	/*
	 * 培训报名
	 * 
	 */
	@RequestMapping(value="/signin")
	public ModelAndView signIn(SignData sign) throws Exception{
		
		logBefore(logger, Jurisdiction.getUsername()+"新增TrainJoin");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNowStr = sdf.format(date);
		Date now = sdf.parse(dateNowStr);
		System.out.println(now);
		pd.put("TRAINJOIN_ID", this.get32UUID());	//主键
		pd.put("PLAN_ID", sign.getId());	//培训ID
		pd.put("PLAN_NAME", sign.getName());	//培训名
		pd.put("USER_ID", user.getUSER_ID());	//用户id
		pd.put("USER_NAME", user.getUSERNAME());	//报名用户
		pd.put("REMARK", "未评");	//评分
		pd.put("CREATTIME", dateNowStr);	//报名时间
		pd.put("SIGN_TAG", "0");	//报名状态
		trainjoinService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		
		PageData pd2 = new PageData();
		pd2 = this.getPageData();
		pd2.put("USER_NAME",user.getUSERNAME());
		
		return mv;
	}
	

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改TrainPlan");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

//		String beginDateStr = pd.getString("STARTTIME");
//		String endDateStr = pd.getString("ENDTIME");
//		long times = DateUtil.getMinuteSub2(beginDateStr, endDateStr);
//		pd.put("PLANTRAINTIME",times);
//		
		trainplanService.edit(pd);
		System.out.println(pd);
		System.out.println(pd.get("SCORE0"));
		if(pd.get("SCORE1")!=null) {
//			trainjoinService.deletecascade(pd);//级联删除
			trainscoreService.delete(pd);//级联删除
			trainscoresService.delete(pd);//级联删除
		}
		PageData add1=new PageData();
		add1.put("TRAINSCORE_ID", this.get32UUID());
		add1.put("TRAIN_ID", pd.get("TRAINPLAN_ID"));
		add1.put("SCORE_TYPE", "其他");
		trainscoreService.save(add1);
		for(int i=1;i<100;i++) {	
			if(pd.get("SCORE"+i)!=null) {
				PageData add=new PageData();
				add.put("TRAINSCORE_ID", this.get32UUID());
				add.put("TRAIN_ID", pd.get("TRAINPLAN_ID"));
				add.put("SCORE_TYPE", (String) pd.get("SCORE"+i));
				trainscoreService.save(add);
			}
		}
		
//		String uuid=(String)pd.get("TRAINPLAN_ID");
//		for(int i=0;i<100;i++) {	
//			if(pd.get("SCORE"+i)!=null) {
//				PageData add=new PageData();
//				add.put("TRAINSCORE_ID", this.get32UUID());
//				add.put("TRAIN_ID", uuid);
//				add.put("SCORE_TYPE", (String) pd.get("SCORE"+i));
//				trainscoreService.save(add);
//			}
//		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表TrainPlan");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		String starttime = pd.getString("starttime"); // 关键词检索条件
		String endtime = pd.getString("endtime"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if (null != starttime && !"".equals(starttime)) {
			pd.put("starttime", starttime.trim());
		}
		if (null != endtime && !"".equals(endtime)) {
			pd.put("endtime", endtime.trim());
		}
		page.setPd(pd);
		List<PageData> varList = trainplanService.list(page); // 列出TrainPlan列表
		for (int i = 0; i < varList.size(); i++) {
			String start = (String) varList.get(i).get("STARTTIME");
			String end = (String) varList.get(i).get("ENDTIME");
			String name = (String) varList.get(i).get("PLANFILEID");
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String dateNowStr = sdf.format(date);
			Date now = sdf.parse(dateNowStr);
			Date st = sdf.parse(start);
			Date en = sdf.parse(end);
			if(now.before(st)) {
				varList.get(i).put("STATUS", "未开始");
			}
			if(now.after(st)&&now.before(en)) {
				varList.get(i).put("STATUS", "进行中");
			}
			if(now.after(en)) {
				varList.get(i).put("STATUS", "结束");
			}
			else
				varList.get(i).put("STATUS", "进行中");
			
			String localfile = PathUtil.getTempPath()+ Const.FILEPATHFILE;
			File file = new File(localfile, name);
			if (!file.exists()) {
				String remotepath = Const.REMOTEPATH+Const.FILEPATHFILE;
				if(!"".endsWith(remotepath)) {
					FileUpload.download(localfile + name,remotepath);
				}
			}
		}

		mv.setViewName("system/trainplan/trainplan_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
	
	
	/**
	 * 列表2
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list2")
	public ModelAndView list2(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表TrainPlan");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		
		Session session = Jurisdiction.getSession();        //获取session中的值
		User user = new User();
		user=(User) session.getAttribute(Const.SESSION_USER);
		page.setIsJoin(user.getUSER_ID());
		
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		String starttime = pd.getString("starttime"); // 关键词检索条件
		String endtime = pd.getString("endtime"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if (null != starttime && !"".equals(starttime)) {
			pd.put("starttime", starttime.trim());
		}
		if (null != endtime && !"".equals(endtime)) {
			pd.put("endtime", endtime.trim());
		}
		page.setPd(pd);
		List<PageData> varList = trainplanService.list2(page); // 列出TrainPlan列表
		for (int i = 0; i < varList.size(); i++) {
			String start =  varList.get(i).getString("STARTTIME1");
			String end =  varList.get(i).getString("ENDTIME1");
			String name = (String) varList.get(i).get("PLANFILEID");
			String pic1 = (String) varList.get(i).get("PICTUREID1");
			String pic2 = (String) varList.get(i).get("PICTUREID2");
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String dateNowStr = sdf.format(date);
			Date now = sdf.parse(dateNowStr);
			Date st = sdf.parse(start);
			Date en = sdf.parse(end);
			if(now.before(st)) {
				varList.get(i).put("STATUS", "未开始");
			}
			if(now.after(st)&&now.before(en)) {
				varList.get(i).put("STATUS", "进行中");
			}
			if(now.after(en)) {
				varList.get(i).put("STATUS", "结束");
			}
			if(now.equals(st) || now.equals(en)) {
				varList.get(i).put("STATUS", "进行中");
			}
			if(null != name && !"".equals(name)) {
				downFile(name);
			}
			if(null != pic1 && !"".equals(pic1)) {
				downFile(pic1);
			}
			if(null != pic2 && !"".equals(pic2)) {
				downFile(pic2);
			}
			
		}

		mv.setViewName("system/trainplan/trainplan_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
	
	/**
	 * 列表2
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/tutor")
	public ModelAndView tutor(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表TrainPlan");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		String starttime = pd.getString("starttime"); // 关键词检索条件
		String endtime = pd.getString("endtime"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if (null != starttime && !"".equals(starttime)) {
			pd.put("starttime", starttime.trim());
		}
		if (null != endtime && !"".equals(endtime)) {
			pd.put("endtime", endtime.trim());
		}
		page.setPd(pd);
		List<PageData> varList = trainplanService.tutorlist(page); // 列出TrainPlan列表
		mv.setViewName("system/trainplan/trainplan_tutor");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
	
	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/trainplan/trainplan_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = trainplanService.findById(pd); // 根据ID读取
		mv.setViewName("system/trainplan/trainplan_edit2");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}
	

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除TrainPlan");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			trainplanService.deleteAll(ArrayDATA_IDS);
			trainjoinService.deleteAllCascade(ArrayDATA_IDS);//级联删除
			trainscoreService.deleteAll(ArrayDATA_IDS);//级联删除
			trainscoresService.deleteAll(ArrayDATA_IDS);//级联删除
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出TrainPlan到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("培训名"); // 1
		titles.add("培训描述"); // 2
		titles.add("开始时间"); // 3
		titles.add("结束时间"); // 4
		titles.add("状态"); // 5
		titles.add("评价"); // 6
		titles.add("讲师"); // 7
		titles.add("计划培训时间"); // 8
		titles.add("培训地点"); // 9
		titles.add("实际培训时长"); // 10
		titles.add("培训奖励"); // 11
		titles.add("参加人"); // 12
		dataMap.put("titles", titles);
		List<PageData> varOList = trainplanService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PLAN_NAME")); // 1
			vpd.put("var2", varOList.get(i).getString("PLAN_DESCRIE")); // 2
			vpd.put("var3", varOList.get(i).getString("STARTTIME")); // 3
			vpd.put("var4", varOList.get(i).getString("ENDTIME")); // 4
			vpd.put("var5", varOList.get(i).getString("STATUS")); // 5
			vpd.put("var6", varOList.get(i).getString("REMARK")); // 6
			vpd.put("var7", varOList.get(i).getString("LETURE")); // 7
			vpd.put("var8", varOList.get(i).getString("PLANTRAINTIME")); // 8
			vpd.put("var9", varOList.get(i).getString("PLANPLACE")); // 9
			vpd.put("var10", varOList.get(i).getString("REALTRAINTIME")); // 10
			vpd.put("var11", varOList.get(i).getString("REWARD")); // 11
			vpd.put("var12", varOList.get(i).getString("JOINUSER")); // 12
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
	
	/**
	 * 详细信息
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/showPlanInfo")
	@ResponseBody
	public Object showPlanInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> list=trainplanService.showPlanInfo(pd);
		mv.setViewName("system/trainplan/trainplan_tutor_info");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
		
	}
	

	@RequestMapping("/download")  
	public ResponseEntity<byte[]> export(String fileName) throws IOException {  
		
	    HttpHeaders headers = new HttpHeaders(); 
	    String localfile = PathUtil.getTempPath()+ Const.FILEPATHFILE;
	    File file = new File(localfile, fileName);
	    
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);    
	    headers.setContentDispositionFormData("attachment", fileName);    
	   
	    return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);    
	}
	
	public void downFile(String name ) throws Exception {
		String localfile = PathUtil.getTempPath()+ Const.FILEPATHFILE;
		File file = new File(localfile, name);
		if (!file.exists()) {
			String remotepath = Const.REMOTEPATH+Const.FILEPATHFILE;
			if(!"".endsWith(remotepath)) {
				FileUpload.download(localfile + name,remotepath+ name);
			}
		}
	}
	
	public List<String> upfile(MultipartFile file,String fileId) {
		List<String> list = new ArrayList<String>();
		String filePath ="";
		if (null != file && !file.isEmpty()) {
			filePath = FileUpload.fileUp(file, "", fileId,Const.FILEPATHFILE);				//执行上传
		}
		String fileName = file.getOriginalFilename();
		
		String extName = ""; // 扩展名格式：
		if (file.getOriginalFilename().lastIndexOf(".") >= 0) {
			extName = fileName.substring(file.getOriginalFilename().lastIndexOf("."));
		}
		list.add(fileId);
		list.add(extName);
		list.add(fileName);
		return list;
	}
}
