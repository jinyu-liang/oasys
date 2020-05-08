package com.fh.service.reqm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.reqm.ReqmManager;
import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年4月29日
* 类说明
*/
@Service("reqmservice")
public class ReqmService implements ReqmManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Override
	public List<PageData> datalistPage(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ReqmMapper.datalistPage", page);
	}
	
	@Override
	public List<PageData> listAll(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ReqmMapper.listAll", page);
	}
	
	@Override
	public List<PageData> findById(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqmMapper.findById", pd);
	}
	
	@Override
	public void edit(PageData pd)throws Exception {
		dao.update("ReqmMapper.edit", pd);
	}
	
	@Override
	public void editStats(PageData pd)throws Exception {
		dao.update("ReqmMapper.editStats", pd);
	}

	@Override
	public void save(PageData pd)throws Exception {
		dao.update("ReqmMapper.save", pd);
	}
	
	@Override
	public List<PageData> listReqm(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ReqmMapper.listReqm", pd);
	}
}
