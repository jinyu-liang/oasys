package com.fh.service.system.teambuildingscore.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.system.teambuildingscore.TeamBuildingScoreManager;

/** 
 * 说明： 团队建设分数
 * 创建人：ADMIN
 * 创建时间：2018-11-28
 * @version
 */
@Service("teambuildingscoreService")
public class TeamBuildingScoreService implements TeamBuildingScoreManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("TeamBuildingScoreMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("TeamBuildingScoreMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("TeamBuildingScoreMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TeamBuildingScoreMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TeamBuildingScoreMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findById(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TeamBuildingScoreMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TeamBuildingScoreMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData findById2(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TeamBuildingScoreMapper.findById2", pd);
	}

	@Override
	public PageData findByJoinId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("TeamBuildingScoreMapper.findByJoinId", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> detail(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("TeamBuildingScoreMapper.detail", pd);
	}

	@Override
	public void deleteByBuildingID(PageData pd) throws Exception {
		dao.delete("TeamBuildingScoreMapper.deleteByBuildingID", pd);
	}
	
}

