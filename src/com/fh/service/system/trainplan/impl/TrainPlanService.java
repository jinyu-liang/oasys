package com.fh.service.system.trainplan.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.trainplan.TrainPlanManager;
import com.fh.util.PageData;

/** 
 * 说明： 培训计划
 * 创建人：zhangxuan5
 * 创建时间：2018-11-07
 * @version
 */
@Service("trainplanService")
public class TrainPlanService implements TrainPlanManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("TrainPlanMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("TrainPlanMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("TrainPlanMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TrainPlanMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TrainPlanMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TrainPlanMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TrainPlanMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list2(Page page) throws Exception {
		return (List<PageData>)dao.findForList("TrainPlanMapper.datalistPage2", page);
	}

	//饼图
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> pie(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("TrainPlanMapper.pie", pd);
	}
	
	//饼图
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> pie2(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("TrainPlanMapper.pie2", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> tutorlist(Page page) throws Exception {
		return (List<PageData>)dao.findForList("TrainPlanMapper.tutorlist", page);
	}
	
	//饼图
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> showPlanInfo(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("TrainPlanMapper.showPlanInfo", pd);
	}
}

