package com.fh.service.score.userscore.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.score.userscore.UserScoreManager;
import com.fh.util.PageData;

/** 
 * 说明： 用户积分信息
 * 创建人：admin
 * 创建时间：2018-12-17
 * @version
 */
@Service("user_scoreService")
public class UserScoreService implements UserScoreManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("UserScoreMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("UserScoreMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("UserScoreMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserScoreMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UserScoreMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UserScoreMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("UserScoreMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData newInfo(PageData pd) throws Exception {
		return (PageData)dao.findForObject("UserScoreMapper.newInfo",pd);
	}

	@Override
	public PageData findBydoubleId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("UserScoreMapper.findBydoubleId", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findloginid(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("UserScoreMapper.findloginid",pd);
	}
	
}

