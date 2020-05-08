package com.fh.service.system.monologue;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;


/** 员工独白
 * @author liangjy@asiainfo.com
 * 修改时间：2018.7.21
 */
public interface MonologueManager {
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
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
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAllM(String[] ArrayDATA_IDS)throws Exception;
	
	/**批量获取
	 * @param ArrayDATA_IDS
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllById(String[] ArrayDATA_IDS)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delTp(PageData pd)throws Exception;


	public List<PageData> show(Page page) throws Exception;


	public List<PageData> show1(Page page)throws  Exception;


}

