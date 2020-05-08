package com.fh.service.reqm;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年4月29日
* 类说明
*/

public interface ReqmManager {

	/**
	 * 主需求列表-条件
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> datalistPage(Page page) throws Exception;

	/**
	 * 主需求列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> listAll(Page page) throws Exception;
	
	/**
	 * 需求详细内容
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> findById(PageData pd) throws Exception;

	/**
	 * 需求更新
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 需求状态更新
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void editStats(PageData pd) throws Exception;

	/**
	 * 需求新增
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void save(PageData pd) throws Exception;
	
	/**
	 * 首页需求情况
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> listReqm(PageData pd) throws Exception;
	
}
