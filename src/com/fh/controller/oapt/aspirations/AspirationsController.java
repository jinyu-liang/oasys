package com.fh.controller.oapt.aspirations;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fh.entity.Page;
import com.fh.service.information.pictures.PicturesManager;
import com.fh.util.Const;
import com.fh.util.FileUpload;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

/** 
 * 类名称：图片展示
 * 创建人：liangjy@asiainfo.com
 * 创建时间：2018-07-21
 */
@Controller
@RequestMapping(value="/aspirations")
public class AspirationsController{
	
	String menuUrl = "aspirations/show.do"; //菜单地址(权限用)
	@Resource(name="picturesService")
	private PicturesManager picturesService;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/show")
	public ModelAndView list(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = new PageData(this.getRequest());
		pd.put("MASTER_ID", "1");
		List<PageData>	varList = picturesService.exhibition(pd);	//列出Pictures列表
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
		mv.setViewName("system/aspirations/index_u");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	/**得到request对象
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
}
