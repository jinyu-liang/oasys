package com.fh.controller.information.pictures;

import java.io.File;
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

import org.springframework.beans.propertyeditors.CustomDateEditor;
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
import com.fh.util.AppUtil;
import com.fh.util.DateUtil;
import com.fh.util.DelAllFile;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;
import com.fh.util.Watermark;
import com.fh.service.information.pictures.PicturesManager;

/** 
 * 类名称：图片管理
 * 创建人：liangjy@asiainfo.com
 * 创建时间：2015-03-21
 */
@Controller
@RequestMapping(value="/pictures")
public class PicturesController extends BaseController {
	
	String menuUrl = "pictures/list.do"; //菜单地址(权限用)
	@Resource(name="picturesService")
	private PicturesManager picturesService;
	
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
		List<PageData>	varList = picturesService.list(page);	//列出Pictures列表
		if(varList.size() >0) {
			String localfile = PathUtil.getTempPath()+ Const.FILEPATHIMG;
			for(int i=0;i<varList.size();i++){
				String name = varList.get(i).getString("NAME");
//				DelAllFile.delFolder(localfile + varList.get(i).getString("NAME")); //先删除图片
				File file = new File(localfile, name);
				if (!file.exists()) {
					String remotepath = varList.get(i).getString("PATH");
					if(!"".endsWith(remotepath)) {
						FileUpload.download(localfile + name,remotepath);
					}
				}
			}
		}

				
		mv.setViewName("information/pictures/pictures_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**新增
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save", method = RequestMethod.POST)
	@ResponseBody
	public Object save(@RequestParam(required=false) MultipartFile file,HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增图片");
		Map<String,String> map = new HashMap<String,String>();
		String  ffile = DateUtil.getDays(),fileName="";
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String title = request.getParameter("title");
		String remark = request.getParameter("remark");
		String masid = request.getParameter("masid");
		String name = this.get32UUID();
		String filePath = "";
		
		map.put("msg","error");

		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			if (null != file && !file.isEmpty()) {
//				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
				filePath = FileUpload.fileUp(file, "", name,Const.FILEPATHIMG);				//执行上传
			}
			String extName = ""; // 扩展名格式：
			if (file.getOriginalFilename().lastIndexOf(".") >= 0) {
				extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			}
			if(!"".equals(filePath)) {
				pd.put("PICTURES_ID", this.get32UUID());			//主键
				pd.put("TITLE", title);								//标题
				pd.put("NAME", name+extName);							//文件名
				pd.put("PATH", filePath);				//路径
				pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建时间
				pd.put("MASTER_ID", masid);							//附属与
				pd.put("BZ", remark);						//备注
//				Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
				picturesService.save(pd);
				map.put("msg","success");
			}
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/**删除
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除图片");
		PageData pd = new PageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){
			pd = this.getPageData();
			
			String path = pd.getString("PATH");
			String name = pd.getString("NAME");
			FileUpload.delete(path);
			DelAllFile.delFolder(PathUtil.getTempPath()+ Const.FILEPATHIMG + name); //删除图片
			picturesService.delete(pd);
		}
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param request
	 * @param file
	 * @param tpz
	 * @param PICTURES_ID
	 * @param TITLE
	 * @param MASTER_ID
	 * @param BZ
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="PICTURES_ID",required=false) String PICTURES_ID,
			@RequestParam(value="TITLE",required=false) String TITLE,
			@RequestParam(value="MASTER_ID",required=false) String MASTER_ID,
			@RequestParam(value="BZ",required=false) String BZ
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改图片");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("PICTURES_ID", PICTURES_ID);		//图片ID
			pd.put("TITLE", TITLE);					//标题
			pd.put("MASTER_ID", MASTER_ID);			//属于ID
			pd.put("BZ", BZ);						//备注
			if(null == tpz){tpz = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				
				String name = this.get32UUID();
				String filePath = "";
				
				if (null != file && !file.isEmpty()) {
					filePath = FileUpload.fileUp(file, "", name,Const.FILEPATHIMG);				//执行上传
				}
				String extName = ""; // 扩展名格式：
				if (file.getOriginalFilename().lastIndexOf(".") >= 0) {
					extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
				}
				
				pd.put("NAME", name+extName);			//文件名
				pd.put("PATH", filePath);				//路径
			}else{
				pd.put("PATH", tpz);
			}
			Watermark.setWatemark(PathUtil.getTempPath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
			picturesService.edit(pd);				//执行修改数据库
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去新增页面
	 * @return
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd() throws Exception{
		logBefore(logger, "去新增Pictures页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("information/pictures/pictures_add");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**去修改页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit() throws Exception{
		logBefore(logger, "去修改Pictures页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = picturesService.findById(pd);	//根据ID读取
		
		if(!"".equals(pd.getString("PATH"))) {
			String localfile = PathUtil.getTempPath()+ Const.FILEPATHIMG;
			String remotepath = pd.getString("PATH");
			String name = pd.getString("NAME");
			File file = new File(localfile, name);
			if (!file.exists()) {
				FileUpload.download(localfile + name,remotepath);
			}
			
		}
		
		
		mv.setViewName("information/pictures/pictures_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**批量删除
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, "批量删除Pictures");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){
			List<PageData> pdList = new ArrayList<PageData>();
			List<PageData> pathList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				pathList = picturesService.getAllById(ArrayDATA_IDS);
				for(int i=0;i<pathList.size();i++){
					FileUpload.delete(pathList.get(i).getString("PATH"));
					DelAllFile.delFolder(PathUtil.getTempPath()+ Const.FILEPATHIMG + pathList.get(i).getString("NAME")); //删除图片
				}
				picturesService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
			}
		return AppUtil.returnObject(pd, map);
	}
	
	/**删除图片
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deltp")
	public void deltp(PrintWriter out) throws Exception {
		logBefore(logger, "删除图片");
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String path = pd.getString("PATH");
		String name = pd.getString("NAME");
		FileUpload.delete(path); //删除远端图片
		DelAllFile.delFolder(PathUtil.getTempPath()+ Const.FILEPATHIMG + name); //删除图片
		
		if(path != null){
			picturesService.delTp(pd);  //删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
