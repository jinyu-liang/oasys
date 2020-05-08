package com.fh.service.system.teambuildingscoretype.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.system.teambuildingscoretype.TeamBuildingScoreTypeManager;

/** 
 * 说明： 团队建设打分类型
 * 创建人：ADMIN
 * 创建时间：2018-11-27
 * @version
 */
@Service("teambuildingscoretypeService")
public class TeamBuildingScoreTypeService implements TeamBuildingScoreTypeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("TeamBuildingScoreTypeMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("TeamBuildingScoreTypeMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("TeamBuildingScoreTypeMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TeamBuildingScoreTypeMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TeamBuildingScoreTypeMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findById(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("TeamBuildingScoreTypeMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TeamBuildingScoreTypeMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public void deleteByBuildingID(PageData pd) throws Exception {
		dao.delete("TeamBuildingScoreTypeMapper.deleteByBuildingID", pd);		
	}
	
}

