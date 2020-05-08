package com.fh.service.system.group.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.Group;
import com.fh.service.system.group.GroupManager;
import com.fh.util.PageData;

/**
* @author 梁金玉 E-mail:liangjy@asiainfo.com
* @version 创建时间：2018年2月11日 下午6:17:33
* 类说明
*/
@Service("groupService")
public class GroupService implements GroupManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	public GroupService() {
		// TODO Auto-generated constructor stub
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Group> listAllGroupsByPId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (List<Group>) dao.findForList("GroupMapper.listAllGroupsByPId", pd);
	}

}
