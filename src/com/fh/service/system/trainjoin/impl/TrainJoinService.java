package com.fh.service.system.trainjoin.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.system.trainjoin.TrainJoinManager;

/** 
 * 说明： 培训签到
 * 创建人：zhangxuan5
 * 创建时间：2018-11-09
 * @version
 */
@Service("trainjoinService")
public class TrainJoinService implements TrainJoinManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("TrainJoinMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("TrainJoinMapper.delete", pd);
	}
	/**级联删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void deletecascade(PageData pd)throws Exception{
		dao.delete("TrainJoinMapper.deletecascade", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("TrainJoinMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TrainJoinMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TrainJoinMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TrainJoinMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TrainJoinMapper.deleteAll", ArrayDATA_IDS);
	}
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAllCascade(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TrainJoinMapper.deleteAllCascade", ArrayDATA_IDS);
	}

	@Override
	public void passAll(String[] ArrayDATA_IDS) throws Exception {
		dao.update("TrainJoinMapper.passAll", ArrayDATA_IDS);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list3(Page page) throws Exception {
		return (List<PageData>)dao.findForList("TrainJoinMapper.datalistPage3", page);
	}
	
}

