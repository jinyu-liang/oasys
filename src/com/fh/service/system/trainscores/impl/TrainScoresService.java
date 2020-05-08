package com.fh.service.system.trainscores.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.system.trainscores.TrainScoresManager;

/** 
 * 说明： 培训具体分数
 * 创建人：zhangxuan5
 * 创建时间：2018-11-19
 * @version
 */
@Service("trainscoresService")
public class TrainScoresService implements TrainScoresManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("TrainScoresMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("TrainScoresMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("TrainScoresMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TrainScoresMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TrainScoresMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TrainScoresMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TrainScoresMapper.deleteAll", ArrayDATA_IDS);
	}

	//判断是否给打分，根据报名id在分数表查询是否有数据
	@Override
	public PageData findByTrainJoinId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("TrainScoresMapper.findByTrainJoinId", pd);
	}
	//修改2
	@Override
	public void edit2(PageData pd) throws Exception {
		dao.update("TrainScoresMapper.edit2", pd);
	}
	
}

