package com.fh.service.reqm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.reqm.ReqPlusManager;
import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年4月29日
* 类说明
*/
@Service("reqplusservice")
public class ReqPlusService implements ReqPlusManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Override
	public List<PageData> datalistPage(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.datalistPage", page);
	}
	
	@Override
	public List<PageData> listAll(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.listAll", page);
	}
	
	@Override
	public List<PageData> findById(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.findById", pd);
	}
	@Override
	public List<PageData> findBySdpId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.findBySdpId", pd);
	}
	
	@Override
	public List<PageData> findBySdpId2(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.findBySdpId2", pd);
	}
	
	
	@Override
	public void edit(PageData pd)throws Exception {
		dao.update("ReqPlusMapper.edit", pd);
	}
	
	@Override
	public void editStats(PageData pd)throws Exception {
		dao.update("ReqPlusMapper.editStats", pd);
	}

	@Override
	public void save(PageData pd)throws Exception {
		dao.update("ReqPlusMapper.save", pd);
	}

	@Override
	public void del(PageData pd) throws Exception {
		dao.delete("ReqPlusMapper.delete", pd);
		
	}

	@Override
	public List<PageData> findByStaffSum(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.findByStaffSum", pd);
	}
	
	public List<PageData> findByStaffSum6(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.findByStaffSum6", pd);
	}
	
	@Override
	public List<PageData> findBySdpIdSum(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqPlusMapper.findBySdpIdSum", pd);
	}
}
