package com.fh.service.system.trainjoin;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 培训签到接口
 * 创建人：zhangxuan5
 * 创建时间：2018-11-09
 * @version
 */
public interface TrainJoinManager{

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
	
	//批量通过
	public void passAll(String[] ArrayDATA_IDS)throws Exception;

	public List<PageData> list3(Page page) throws Exception;

	
	//级联删除
	public void deletecascade(PageData pd) throws Exception;

	public void deleteAllCascade(String[] arrayDATA_IDS) throws Exception;
	
}

