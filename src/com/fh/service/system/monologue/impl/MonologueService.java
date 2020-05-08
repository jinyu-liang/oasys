package com.fh.service.system.monologue.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.monologue.MonologueManager;
import com.fh.util.PageData;


/** 员工独白
 * @author liangjy@asiainfo.com
 * 修改时间：2018.7.21
 */
@Service("monologueService")
public class MonologueService implements MonologueManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MonologueMapper.datalistPage", page);
	}

	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> show(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MonologueMapper.show", page);
	}

	@Override
	public List<PageData> show1(Page page) throws Exception {
		return (List<PageData>)dao.findForList("MonologueMapper.show1", page);
	}

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("MonologueMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("MonologueMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("MonologueMapper.edit", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MonologueMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAllM(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("MonologueMapper.deleteAllM", ArrayDATA_IDS);
	}
	
	/**批量获取
	 * @param ArrayDATA_IDS
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getAllById(String[] ArrayDATA_IDS)throws Exception{
		return (List<PageData>)dao.findForList("MonologueMapper.getAllById", ArrayDATA_IDS);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delTp(PageData pd)throws Exception{
		dao.update("MonologueMapper.delTp", pd);
	}

}

