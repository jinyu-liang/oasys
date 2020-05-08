package com.fh.service.system.trainplan;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 培训计划接口
 * 创建人：zhangxuan5
 * 创建时间：2018-11-07
 * @version
 */
public interface TrainPlanManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

	public List<PageData> list2(Page page) throws Exception;

	//饼图
	public List<PageData> pie(PageData pd) throws Exception;
	
	public List<PageData> tutorlist(Page page) throws Exception;
	
	public List<PageData> showPlanInfo(PageData pd) throws Exception;

	public List<PageData> pie2(PageData pd) throws Exception;
	
}

