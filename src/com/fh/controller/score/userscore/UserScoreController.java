package com.fh.controller.score.userscore;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.score.score.SCOREManager;
import com.fh.service.score.userscore.UserScoreManager;
import com.fh.service.score.userscorelog.UserScoreLogManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.util.impl.SequenceService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelRead;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;

/**
 * 说明：用户积分信息 创建人：admin 创建时间：2018-12-17
 */
@Controller
@RequestMapping(value = "/userscore")
public class UserScoreController extends BaseController {

	String menuUrl = "userscore/list.do"; // 菜单地址(权限用)
	@Resource(name = "user_scoreService")
	private UserScoreManager user_scoreService;
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "scoreService")
	private SCOREManager scoreService;
	@Resource(name = "sequenceService")
	SequenceService sequenceService;
	@Autowired
	private UserScoreLogManager user_score_logService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增USER_SCORE");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();

		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);

		PageData pd = new PageData();
		PageData userpd = new PageData();// 用户信息pd
		PageData scorepd = new PageData();// 积分信息pd
		PageData newInfo = new PageData();// 判断数据是否重复pd
		PageData logpd = new PageData();// 日志pd
		logpd.put("ID", "scorelog");
		pd = this.getPageData();
		System.out.println(pd);
		newInfo = user_scoreService.newInfo(pd);
		if (newInfo == null) { // 判断当前用户是否有信息如果有>0，在基础上添加，如果没有==0，新增一条信息
			userpd = userService.findById(pd);
			scorepd = scoreService.findById(pd);
			int addscore = Integer.parseInt(pd.get("SCORE_VALUE").toString());// 给予分数
			int actualscore = Integer.parseInt(scorepd.get("ACTUAL_VALUE").toString());// 剩余分数
			int addtimes=Integer.parseInt(scorepd.get("SCORE_TIMES").toString());
			System.out.println("cishucishucishu"+addtimes);
			if (actualscore - addscore >= 0) { // 判断剩余积分是否足够
				pd.put("USER_SCORE_ID", this.get32UUID()); // 主键
				pd.put("USER_NAME", userpd.get("NAME")); // 用户名
				pd.put("SCORE_NAME", scorepd.get("SCORE_NAME")); // 积分名
				pd.put("SCORE_IN_TIMES", "0"); // 被赠积分次数
				pd.put("SCORE_IN_SUM", "0"); // 被赠积分数
				pd.put("SCORE_OUT_TIMES", "0"); // 赠送积分次数
				pd.put("UPDATE_ID", user.getNAME()); // 更新人ID
				pd.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新日期
				user_scoreService.save(pd);// 保存用户信息
				scorepd.put("ACTUAL_VALUE", actualscore - addscore);
				scorepd.put("SCORE_TIMES", ++addtimes);
				scoreService.edit(scorepd); // 修改剩余分数
				logpd.put("USER_SCORE_LOG_ID", sequenceService.getLogID(logpd)); // 主键
				logpd.put("LOG_TYPE", "2"); // 日志类型0：sys_score新增 1：sys_score更新 10：user_score 赠送 out 11：user_score 给与
											// 2:user_score新增 3:user_score修改
				logpd.put("USER_ID", user.getUSER_ID()); // 更新人ID
				logpd.put("SCORE_VALUE", actualscore); // 当前积分
				logpd.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
				logpd.put("SCORE_IN_VALUE", addscore); // 赠送积分
				logpd.put("SCORE_OUT_ID", userpd.get("USER_ID")); // 被赠人
				logpd.put("SCORE_OUT_VALUE", addscore); // 被赠积分
				logpd.put("SCORE_ID", scorepd.get("SCORE_ID")); // 积分ID
				logpd.put("UPDATE_ID", user.getUSER_ID()); // 更新人名
				logpd.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
				user_score_logService.save(logpd);
				mv.addObject("msg", "success");
				mv.setViewName("save_result");
				return mv;
			} else {
				mv.setViewName("save_result");
				return mv;
			}
		} else {// 已有信息
			userpd = userService.findById(pd);
			scorepd = scoreService.findById(pd);
			int nowScore = Integer.parseInt(newInfo.get("SCORE_VALUE").toString());// 初始分数
			int addScore = Integer.parseInt(pd.get("SCORE_VALUE").toString());// 给予分数
			int actualscore = Integer.parseInt(scorepd.get("ACTUAL_VALUE").toString());// 剩余分数
			if (actualscore - addScore >= 0) { // 判断剩余积分是否足够
				newInfo.put("SCORE_VALUE", nowScore + addScore);
				newInfo.put("UPDATE_ID", user.getNAME()); // 更新人ID
				newInfo.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新日期
				user_scoreService.edit(newInfo);// 保存用户信息
				scorepd.put("ACTUAL_VALUE", actualscore - addScore);
				scoreService.edit(scorepd); // 修改剩余分数
				logpd.put("USER_SCORE_LOG_ID", sequenceService.getLogID(logpd)); // 主键
				logpd.put("LOG_TYPE", "3"); // 日志类型0：sys_score新增 1：sys_score更新 10：user_score 赠送 out 11：user_score 给与
											// 2:user_score新增 3:user_score修改
				logpd.put("USER_ID", user.getUSER_ID()); // 更新人ID
				logpd.put("SCORE_VALUE", actualscore); // 当前积分
				logpd.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
				logpd.put("SCORE_IN_VALUE", addScore); // 赠送积分
				logpd.put("SCORE_OUT_ID", userpd.get("USER_ID")); // 被赠人
				logpd.put("SCORE_OUT_VALUE", addScore); // 被赠积分
				logpd.put("SCORE_ID", scorepd.get("SCORE_ID")); // 积分ID
				logpd.put("UPDATE_ID", user.getUSER_ID()); // 更新人名
				logpd.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
				user_score_logService.save(logpd);
				mv.addObject("msg", "success");
				mv.setViewName("save_result");
				return mv;
			} else {
				mv.addObject("msg", "success");
				mv.setViewName("save_result");
				return mv;
			}
		}

	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除USER_SCORE");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		user_scoreService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 送分
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改USER_SCORE");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();

		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);
		String loginId = user.getUSER_ID();

		PageData pd = new PageData();
		PageData infopd = new PageData();// 当前条信息的pd
		PageData giveuserpd = new PageData();// 赠送人pd
		pd = this.getPageData();
		infopd = user_scoreService.findById(pd);// 当前条的积分信息
		giveuserpd.put("USER_ID", loginId);
		giveuserpd.put("SCORE_ID", infopd.getString("SCORE_ID"));
		giveuserpd = user_scoreService.findBydoubleId(giveuserpd);// 根据积分ID和用户ID查询登录用户当前积分的信息
		// user_scoreService.edit(pd);
		System.out.println(pd);
		System.out.println("Denglu用户信息" + giveuserpd);
		System.out.println("当前条用户信息" + infopd);
		int loginscore = Integer.parseInt(giveuserpd.get("SCORE_VALUE").toString());// 登录用户当前积分
		int acceptscore = Integer.parseInt(infopd.get("SCORE_VALUE").toString());// 被赠用户当前积分
		int loginouttimes = Integer.parseInt(giveuserpd.get("SCORE_OUT_TIMES").toString());// 登录用户赠送次数
		int acceptintimes = Integer.parseInt(infopd.get("SCORE_IN_TIMES").toString());// 被赠用户被赠次数
		int acceptinsum = Integer.parseInt(infopd.get("SCORE_IN_SUM").toString());// 被赠用户被赠积分总值
		int givescore = Integer.parseInt(pd.get("SCORE_VALUE").toString());
		if (giveuserpd != null && loginscore >= givescore) {
			giveuserpd.put("SCORE_OUT_TIMES", loginouttimes + 1);
			giveuserpd.put("SCORE_VALUE", loginscore - givescore);
			infopd.put("SCORE_IN_TIMES", acceptintimes + 1);
			infopd.put("SCORE_IN_SUM", acceptinsum + givescore);
			infopd.put("SCORE_VALUE", acceptscore);
//			infopd.put("SCORE_VALUE", acceptscore + givescore);
			user_scoreService.edit(giveuserpd);
			user_scoreService.edit(infopd);
			PageData givepdlog = new PageData();// 赠送日志pd
			givepdlog.put("ID", "scorelog");
			givepdlog.put("USER_SCORE_LOG_ID", sequenceService.getLogID(givepdlog)); // 主键
			givepdlog.put("LOG_TYPE", "10"); // 日志类型
			givepdlog.put("USER_ID", user.getUSER_ID()); // 更新人ID
			givepdlog.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
			givepdlog.put("SCORE_IN_VALUE", givescore);
			givepdlog.put("SCORE_OUT_VALUE", givescore);
			givepdlog.put("SCORE_OUT_ID", infopd.get("USER_ID")); // 被赠人
			givepdlog.put("SCORE_ID", infopd.get("SCORE_ID")); // 积分ID
			givepdlog.put("SCORE_VALUE", loginscore);// 当前积分值
			givepdlog.put("REMARK", pd.get("SCORE_REASON"));// 赠送原因
			givepdlog.put("UPDATE_ID", user.getUSER_ID()); // 更新人
			givepdlog.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
			PageData acceptpdlog = new PageData();// 被赠日志pd
			acceptpdlog.put("ID", "scorelog");
			acceptpdlog.put("USER_SCORE_LOG_ID", sequenceService.getLogID(acceptpdlog)); // 主键
			acceptpdlog.put("LOG_TYPE", "11"); // 日志类型
			acceptpdlog.put("USER_ID", infopd.get("USER_ID")); // 更新人ID
//			acceptpdlog.put("SCORE_IN_ID", ); // 赠送人
//			acceptpdlog.put("SCORE_IN_VALUE", givescore);
			acceptpdlog.put("SCORE_OUT_VALUE", givescore);
			acceptpdlog.put("SCORE_OUT_ID", infopd.get("USER_ID")); // 赠送人
			acceptpdlog.put("SCORE_ID", infopd.get("SCORE_ID")); // 积分ID
			acceptpdlog.put("SCORE_VALUE", acceptscore);// 当前积分值
			acceptpdlog.put("REMARK", pd.get("SCORE_REASON"));// 赠送原因
			acceptpdlog.put("UPDATE_ID", user.getUSER_ID()); // 被赠人
			acceptpdlog.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
			user_score_logService.save(givepdlog);
			user_score_logService.save(acceptpdlog);
		}
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
		System.out.println("传来的page"+page.toString());
		logBefore(logger, Jurisdiction.getUsername() + "列表USER_SCORE");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String amount = pd.getString("AMOUNT");
		String amount_s = null;
		String amount_e = null;
		if(null!=amount && amount.contains("-") && !"$0 - $20000".equals(amount)) {
			amount = amount.replaceAll(" ", "").replaceAll("\\$", "");
			amount_s = amount.split("-")[0];
			amount_e = amount.split("-")[1];
			pd.put("AMOUNT_S", amount_s);
			pd.put("AMOUNT_E", amount_e);
		}
		
		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);
		String loginId = user.getUSER_ID();

		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		PageData loginpd=new PageData();
		loginpd.put("USER_ID",loginId);
		System.out.println(loginpd);
		List<PageData> loginpd2=user_scoreService.findloginid(loginpd);
		System.out.println(loginpd2);
		page.setPd(pd);
		List<PageData> userList = userService.listAllUser(pd);	//列出用户列表
//		List<PageData> scoreList = scoreService.list(page);	//列出SCORE列表
		List<PageData> scoreList = scoreService.listAll(pd);	//列出SCORE列表
		List<PageData> varList = user_scoreService.list(page); // 列出USER_SCORE列表
//		List<PageData> varList = user_scoreService.listAll(pd); // 列出列表
		
		
//		List<String> cangive=new ArrayList<String>();
//		for (int i = 0; i < varList.size(); i++) {
//			if (varList.get(i).get("USER_ID").equals(loginId)) {
//				varList.get(i).put("own", "yes");
//				cangive.add(varList.get(i).get("SCORE_ID").toString());
//			} else
//				varList.get(i).put("own", "no");
//		}
//		for(int k=0;k<cangive.size();k++) {
//			String scoreid=cangive.get(k);
//			for(int j=0;j<varList.size();j++) {
//				if(varList.get(j).get("SCORE_ID").toString().equals(scoreid)) {
//					varList.get(j).put("cangive", "yes");
//				}
//			}
//		}
		
		
//		varList2.clear();
//		for(int l=(page.getCurrentPage()-1)*10-1;l<page.getShowCount();l++) {
//			varList2.add(varList.get(l));
//		}
		mv.setViewName("score/userscore/userscorelist");
		mv.addObject("loginpd", loginpd2);
		mv.addObject("userList", userList);
		mv.addObject("scoreList", scoreList);
		mv.addObject("loginId", loginId);//登录人id
//		mv.addObject("varList", varList2);
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
		PageData userpd = new PageData();
		PageData scorepd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		scorepd.put("now", df.format(new Date()));
		List<PageData> userpdl = userService.findIdName(userpd);// 获取user下拉列表
		List<PageData> scorepdl = scoreService.findIdName(scorepd);// 获取score下拉列表
		pd.put("userpd", userpdl);
		pd.put("scorepd", scorepdl);
		System.out.println(pd);
		mv.setViewName("score/userscore/userscoreedit");
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
		pd = user_scoreService.findById(pd); // 根据ID读取
		mv.setViewName("score/userscore/givescoreedit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData scorepd = new PageData();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		scorepd.put("now", df.format(new Date()));
		List<PageData> scorepdl = scoreService.findIdName(scorepd);// 获取score下拉列表
		pd.put("scorepd", scorepdl);
		mv.setViewName("score/userscore/uploadexcel");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUploadExcelOwn")
	public ModelAndView goUploadExcelOwn(String userscoreid) throws Exception {
		ModelAndView mv = this.getModelAndView();
		System.out.println(userscoreid);
		mv.setViewName("score/userscore/uploadexcelown");
		mv.addObject("USER_SCORE_ID", userscoreid);
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除USER_SCORE");
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
			user_scoreService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 下载模版
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "UserScore.xls",
				"UserScore.xls");
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出USER_SCORE到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户ID"); // 1
		titles.add("积分ID"); // 2
		titles.add("积分数量"); // 3
		titles.add("被赠积分次数"); // 4
		titles.add("赠送积分次数"); // 5
		titles.add("备注"); // 6
		titles.add("更新人ID"); // 7
		titles.add("更新日期"); // 8
		dataMap.put("titles", titles);
		List<PageData> varOList = user_scoreService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USER_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("SCORE_ID")); // 2
			vpd.put("var3", varOList.get(i).get("SCORE_VALUE").toString()); // 3
			vpd.put("var4", varOList.get(i).get("SCORE_IN_TIMES").toString()); // 4
			vpd.put("var5", varOList.get(i).get("SCORE_OUT_TIMES").toString()); // 5
			vpd.put("var6", varOList.get(i).getString("REMARK")); // 6
			vpd.put("var7", varOList.get(i).getString("UPDATE_ID")); // 7
			vpd.put("var8", varOList.get(i).getString("UPDATE_DATE")); // 8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	/**
	 * 从EXCEL导入到数据库
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readExcel")
	public ModelAndView readExcel(@RequestParam(value = "excel", required = false) MultipartFile file,
			@RequestParam String SCORE_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		boolean flag = false;
		String msginfo = "操作成功!";
		PageData pd = new PageData();
		PageData scorepd = new PageData();
		System.out.println(SCORE_ID);
		scorepd.put("SCORE_ID", SCORE_ID);
		scorepd = scoreService.findById(scorepd);// 要送分的积分信息
		
		String start_date = scorepd.get("START_DATE").toString();
		String end_date = scorepd.get("END_DATE").toString();
		
		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);
		
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
//			String fileName = FileUpload.fileUp(file, filePath, "UserScore.xls"); // 执行上传
			String fileName = fileUp(file, filePath, "UserScore"); // 执行上传
//			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, "UserScore.xls", 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
			// 2:从第3行开始；0:从第A列开始；0:第0个sheet
			/* 存入数据库操作====================================== */
			pd.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
			pd.put("UPDATE_ID", user.getNAME()); // 最后登录时间
			pd.put("REMARK", ""); // 备注
			pd.put("SCORE_IN_TIMES", "0"); // 被赠次数
			pd.put("SCORE_OUT_TIMES", "0"); // 赠送次数
			pd.put("SCORE_IN_SUM", "0"); // 被赠积分数
			pd.put("SCORE_ID", SCORE_ID); // 积分ID
			pd.put("SCORE_NAME", scorepd.get("SCORE_NAME")); // 积分名
			System.out.println(listPd);
//			List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
//			pd.put("ROLE_ID", roleList.get(0).getROLE_ID());		//设置角色ID为随便第一个
			int sum = 0;
			String acceptInfo="";
			for (int i = 0; i < listPd.size(); i++) {
				if(null != listPd.get(i).get("var2") && !"".equals(listPd.get(i).get("var2"))) {
					sum += Integer.parseInt(listPd.get(i).get("var2").toString());// 要赠送的总积分
					acceptInfo+=listPd.get(i).get("var1").toString()+",";
				}else {
					listPd.remove(i);
				}
				
			}    
			System.out.println(listPd);
//			int actualsum = Integer.parseInt(scorepd.get("ACTUAL_VALUE").toString());
			
			PageData giveuserpd = new PageData();
			giveuserpd.put("SCORE_ID", SCORE_ID);// 赠送pd
			giveuserpd = scoreService.findById(giveuserpd);// 根据积分ID和用户ID查询登录用户当前积分的信息
			int givescore = Integer.parseInt(giveuserpd.get("ACTUAL_VALUE").toString());
			int scoretimes=Integer.parseInt(giveuserpd.get("SCORE_TIMES").toString());
			
			if (sum <= givescore) {
				for (int i = 0; i < listPd.size(); i++) {
					
					PageData userpd = new PageData();
					userpd.put("NUMBER", listPd.get(i).get("var0"));
					userpd = userService.findByUN(userpd);//excel表用户信息
					
					PageData newInfo = new PageData();
					newInfo.put("USER_ID", userpd.get("USER_ID"));
					newInfo.put("SCORE_ID", SCORE_ID);
					newInfo = user_scoreService.newInfo(newInfo);//是否已经有用户信息
					
					if(newInfo == null) {
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd"); // 考勤日期
						pd.put("USER_SCORE_ID", this.get32UUID()); // ID
						pd.put("SCORE_VALUE", listPd.get(i).get("var2"));
						pd.put("USER_ID", userpd.get("USER_ID"));
						pd.put("USER_NAME", userpd.get("NAME"));
						pd.put("START_DATE", sdf2.parse(start_date));
						pd.put("END_DATE", sdf2.parse(end_date));
						flag = true;
						user_scoreService.save(pd);
					}else {
						System.out.println("来了老弟"+newInfo);
						int nowScore = Integer.parseInt(newInfo.get("SCORE_VALUE").toString());// 初始分数
						int addScore = Integer.parseInt(listPd.get(i).get("var2").toString());// 给予分数
						int giveScoreTimes=Integer.parseInt(newInfo.get("SCORE_IN_TIMES").toString());//总和
						int giveScore=Integer.parseInt(newInfo.get("SCORE_IN_SUM").toString());//总和
						pd.put("USER_SCORE_ID", newInfo.get("USER_SCORE_ID"));
						pd.put("SCORE_IN_TIMES", giveScoreTimes++);
						pd.put("SCORE_IN_SUM", giveScore);
						pd.put("SCORE_VALUE", nowScore+addScore);
						pd.put("USER_ID", userpd.get("USER_ID"));
						pd.put("USER_NAME", userpd.get("NAME"));
						flag=true;
						user_scoreService.edit(pd); // 修改剩余分数
					}
					String actual_value="0";
					if(scorepd.get("ACTUAL_VALUE")!=null) {
						actual_value=scorepd.get("ACTUAL_VALUE").toString();
					}
					PageData acceptpdlog = new PageData();
					acceptpdlog.put("ID", "scorelog");
					acceptpdlog.put("USER_SCORE_LOG_ID", sequenceService.getLogID(acceptpdlog)); // 主键
					acceptpdlog.put("LOG_TYPE", "2"); // 日志类型
					acceptpdlog.put("USER_ID", user.getUSER_ID()); // 更新人ID
					acceptpdlog.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
					int inoutvalue=Integer.parseInt(listPd.get(i).get("var2").toString());
					acceptpdlog.put("SCORE_IN_VALUE", inoutvalue);
					acceptpdlog.put("SCORE_OUT_VALUE", inoutvalue);
					acceptpdlog.put("SCORE_OUT_ID", userpd.get("USER_ID")); // 被赠人
					acceptpdlog.put("SCORE_ID", SCORE_ID); // 积分ID
					acceptpdlog.put("SCORE_VALUE", actual_value);// 当前积分值
					acceptpdlog.put("UPDATE_ID", user.getUSER_ID()); // 更新人
					acceptpdlog.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
					user_score_logService.save(acceptpdlog);
				}
				//更新积分主表
				giveuserpd.put("ACTUAL_VALUE", givescore-sum);
				giveuserpd.put("SCORE_TIMES", scoretimes+listPd.size());
				scoreService.edit(giveuserpd);
					
//				PageData givepdlog = new PageData();// 赠送日志pd
//				givepdlog.put("ID", "scorelog");
////				givepdlog.put("USER_SCORE_LOG_ID", sequenceService.getLogID(givepdlog)); // 主键
//				givepdlog.put("USER_SCORE_LOG_ID", this.get32UUID()); // 主键
//				givepdlog.put("LOG_TYPE", "10"); // 日志类型
//				givepdlog.put("USER_ID", user.getUSER_ID()); // 更新人ID
//				givepdlog.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
//				givepdlog.put("SCORE_IN_VALUE", sum);
//				givepdlog.put("SCORE_OUT_VALUE", sum);
//				givepdlog.put("SCORE_OUT_ID", acceptInfo); // 被赠人
//				givepdlog.put("SCORE_ID", SCORE_ID); // 积分ID
//				givepdlog.put("SCORE_VALUE", scorepd.get("ACTUAL_VALUE"));// 当前积分值
//				givepdlog.put("UPDATE_ID", user.getUSER_ID()); // 更新人
//				givepdlog.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
//				user_score_logService.save(givepdlog);
			}
			
			
			
			/* 存入数据库操作====================================== */
			mv.addObject("msg", "success");
		}
		if (flag) {
			mv.addObject("msg", "success");
		} else {
			mv.addObject("msg", "failed");
		}
		mv.addObject("msginfo", msginfo);
		mv.setViewName("system/user/user_result");
		
		return mv;
	}
	/**
	 * 从EXCEL导入到数据库送分
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readExcelOwn")
	public ModelAndView readExcelOwn(@RequestParam(value = "excel", required = false) MultipartFile file,
			String USER_SCORE_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		boolean flag = false;
		String msginfo = "操作成功!";
		PageData pd = new PageData();
		PageData scorepd = new PageData();
		scorepd.put("SCORE_ID", USER_SCORE_ID);
		scorepd = scoreService.findById(scorepd);// 要送分的积分信息
		Session session = Jurisdiction.getSession(); // 获取session中的值
		User user = new User();
		user = (User) session.getAttribute(Const.SESSION_USER);
		
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
//			String fileName = FileUpload.fileUp(file, filePath, "UserScore.xls"); // 执行上传
			String fileName = fileUp(file, filePath, "UserScore"); // 执行上传
//			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, "UserScore.xls", 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
			// 2:从第3行开始；0:从第A列开始；0:第0个sheet
			/* 存入数据库操作====================================== */
			pd.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
			pd.put("UPDATE_ID", user.getNAME()); // 最后登录时间
			pd.put("REMARK", ""); // 备注
			pd.put("SCORE_IN_TIMES", "0"); // 被赠次数
			pd.put("SCORE_OUT_TIMES", "0"); // 赠送次数
			pd.put("SCORE_IN_SUM", "0"); // 被赠积分数
			pd.put("SCORE_ID", USER_SCORE_ID); // 积分ID
			pd.put("SCORE_NAME", scorepd.get("SCORE_NAME")); // 积分名
			System.out.println(listPd);
//			List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
//			pd.put("ROLE_ID", roleList.get(0).getROLE_ID());		//设置角色ID为随便第一个
			int sum = 0;
			String acceptInfo="";
			for (int i = 0; i < listPd.size(); i++) {
				sum += Integer.parseInt(listPd.get(i).get("var2").toString());// 要赠送的总积分
				acceptInfo+=listPd.get(i).get("var1").toString()+",";
			}                          
//			int actualsum = Integer.parseInt(scorepd.get("ACTUAL_VALUE").toString());
			
			PageData giveuserpd = new PageData();
			giveuserpd.put("USER_ID", user.getUSER_ID());
			giveuserpd.put("SCORE_ID", USER_SCORE_ID);// 赠送人pd
			giveuserpd = user_scoreService.findBydoubleId(giveuserpd);// 根据积分ID和用户ID查询登录用户当前积分的信息
			int givescore = Integer.parseInt(giveuserpd.get("SCORE_VALUE").toString());
			
			if (sum <= givescore) {
				
				int loginouttimes = Integer.parseInt(giveuserpd.get("SCORE_OUT_TIMES").toString());// 登录用户赠送次数
				giveuserpd.put("SCORE_OUT_TIMES", loginouttimes + listPd.size());
				giveuserpd.put("SCORE_VALUE", givescore-sum);
				user_scoreService.edit(giveuserpd);//送分人信息修改
				
				for (int i = 0; i < listPd.size(); i++) {
					
					PageData userpd = new PageData();
					userpd.put("NUMBER", listPd.get(i).get("var0"));
					userpd = userService.findByUN(userpd);//excel表用户信息
					
					PageData newInfo = new PageData();
					newInfo.put("USER_ID", userpd.get("USER_ID"));
					newInfo.put("SCORE_ID", USER_SCORE_ID);
					newInfo = user_scoreService.newInfo(newInfo);//是否已经有用户信息
					
					if(newInfo == null) {
						pd.put("USER_SCORE_ID", this.get32UUID()); // ID
						pd.put("SCORE_IN_SUM", listPd.get(i).get("var2"));
						pd.put("SCORE_IN_TIMES", 1);
						pd.put("SCORE_VALUE", 0);
						pd.put("USER_ID", userpd.get("USER_ID"));
						pd.put("USER_NAME", userpd.get("NAME"));
						flag = true;
						user_scoreService.save(pd);
					}else {
						int nowScore = Integer.parseInt(newInfo.get("SCORE_VALUE").toString());// 初始分数
						int addScore = Integer.parseInt(listPd.get(i).get("var2").toString());// 给予分数
						int giveScoreTimes=Integer.parseInt(newInfo.get("SCORE_IN_TIMES").toString());//总和
						int giveScore=Integer.parseInt(newInfo.get("SCORE_IN_SUM").toString());//总和
						pd.put("USER_SCORE_ID", newInfo.get("USER_SCORE_ID"));
						pd.put("SCORE_IN_TIMES", giveScoreTimes+1);
						pd.put("SCORE_IN_SUM", giveScore+addScore);
						pd.put("SCORE_VALUE", nowScore);
						pd.put("USER_ID", userpd.get("USER_ID"));
						pd.put("USER_NAME", userpd.get("NAME"));
						flag=true;
						user_scoreService.edit(pd); // 修改剩余分数
					}
					String actual_value="0";
					if(scorepd.get("ACTUAL_VALUE")!=null) {
						actual_value=scorepd.get("ACTUAL_VALUE").toString();
					}
					PageData acceptpdlog = new PageData();
					acceptpdlog.put("ID", "scorelog");
					acceptpdlog.put("USER_SCORE_LOG_ID", sequenceService.getLogID(acceptpdlog)); // 主键
					acceptpdlog.put("LOG_TYPE", "11"); // 日志类型
					acceptpdlog.put("USER_ID", user.getUSER_ID()); // 更新人ID
					acceptpdlog.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
					acceptpdlog.put("SCORE_IN_VALUE", sum);
					acceptpdlog.put("SCORE_OUT_VALUE", sum);
					acceptpdlog.put("SCORE_OUT_ID", userpd.get("USER_ID")); // 被赠人
					acceptpdlog.put("SCORE_ID", USER_SCORE_ID); // 积分ID
					acceptpdlog.put("SCORE_VALUE", actual_value);// 当前积分值
					acceptpdlog.put("UPDATE_ID", user.getUSER_ID()); // 更新人
					acceptpdlog.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
					user_score_logService.save(acceptpdlog);
				}
					
				PageData givepdlog = new PageData();// 赠送日志pd
				givepdlog.put("ID", "scorelog");
				givepdlog.put("USER_SCORE_LOG_ID", sequenceService.getLogID(givepdlog)); // 主键
				givepdlog.put("LOG_TYPE", "10"); // 日志类型
				givepdlog.put("USER_ID", user.getUSER_ID()); // 更新人ID
				givepdlog.put("SCORE_IN_ID", user.getUSER_ID()); // 赠送人
				givepdlog.put("SCORE_IN_VALUE", sum);
				givepdlog.put("SCORE_OUT_VALUE", sum);
				givepdlog.put("SCORE_OUT_ID", acceptInfo); // 被赠人
				givepdlog.put("SCORE_ID", USER_SCORE_ID); // 积分ID
				givepdlog.put("SCORE_VALUE", scorepd.get("ACTUAL_VALUE"));// 当前积分值
				givepdlog.put("UPDATE_ID", user.getUSER_ID()); // 更新人
				givepdlog.put("UPDATE_DATE", Tools.date2Str(new Date())); // 更新时间
				user_score_logService.save(givepdlog);
			}
			
			
			
			/* 存入数据库操作====================================== */
			mv.addObject("msg", "success");
		}
		if (flag) {
			mv.addObject("msg", "success");
		} else {
			mv.addObject("msg", "failed");
		}
		mv.addObject("msginfo", msginfo);
		mv.setViewName("system/user/user_result");
		
		return mv;
	}
	
	/**
	 * @param file 			//文件对象
	 * @param filePath		//上传路径
	 * @param fileName		//文件名
	 * @return  文件名
	 */
	public static String fileUp(MultipartFile file, String filePath, String fileName){
		String extName = ""; // 扩展名格式：
		try {
			if (file.getOriginalFilename().lastIndexOf(".") >= 0){
				extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			}
			copyFile(file.getInputStream(), filePath, fileName+extName).replaceAll("-", "");
		} catch (IOException e) {
			System.out.println(e);
		}
		return fileName+extName;
	}
	
	
	
	/**
	 * 写文件到当前目录的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 */
	private static String copyFile(InputStream in, String dir, String realName)
			throws IOException {
		File file = new File(dir, realName);
		if (!file.exists()) {
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			file.createNewFile();
		}
		FileUtils.copyInputStreamToFile(in, file);
		return realName;
	}
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
