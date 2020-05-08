package com.fh.service.system.sortplan;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 站内信接口
 * 创建人：liangjy@asiainfo.com
 * 创建时间：2016-01-17
 * @version
 */
public interface SortplanManager {

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void saveS(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteS(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editS(PageData pd)throws Exception;
	

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByIdS(PageData pd)throws Exception;

	public void savesingin(PageData pd) throws Exception ;
}

