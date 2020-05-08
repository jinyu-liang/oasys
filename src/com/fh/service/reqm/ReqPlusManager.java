package com.fh.service.reqm;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年4月29日
* 类说明
*/

public interface ReqPlusManager {

	/**
	 * 主需求列表-条件
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> datalistPage(Page page) throws Exception;

	/**
	 * 子需求列表
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> listAll(Page page) throws Exception;
	
	/**
	 * 子需求详细内容
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> findById(PageData pd) throws Exception;

	/**
	 * 子需求详细内容
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> findBySdpId(PageData pd) throws Exception;

	/**
	 * 子需求详细内容
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> findBySdpId2(PageData pd) throws Exception;

	
	/**
	 * 子需求更新
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 子需求状态更新
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void editStats(PageData pd) throws Exception;

	/**
	 * 子需求新增
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void save(PageData pd) throws Exception;
	
	/**
	 * 子需求删除
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public void del(PageData pd) throws Exception;

	
	public List<PageData> findByStaffSum(PageData pd) throws Exception;
	
	public List<PageData> findByStaffSum6(PageData pd) throws Exception;

	public List<PageData> findBySdpIdSum(PageData pd) throws Exception;


}
