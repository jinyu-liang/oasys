package com.fh.service.system.util.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.service.system.util.SequenceManager;
import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2018年7月25日
* 类说明
*/

@Service("sequenceService")
public class SequenceService implements SequenceManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public String getById(PageData pd) throws Exception {
		return (String) dao.findOne("SequenceMapper.getSpellFull", pd);
	}

	@Override
	public String getLogID(PageData pd) throws Exception {
		return (String) dao.findOne("SequenceMapper.getLogID", pd);
	}

	@Override
	public String getLenId(PageData pd) throws Exception {
		return (String) dao.findOne("SequenceMapper.getLenId", pd);
	}

	
}


