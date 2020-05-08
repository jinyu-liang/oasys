package com.fh.service.system.subsys.impl;

import com.fh.dao.DaoSupport;
import com.fh.service.system.subsys.SubsysManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.annotation.Resource;
import java.util.List;

/** 子系统成员
 * @author fengjj3@asiainfo.com
 * 修改时间：2018.9.5
 */

@Service("SubsysService")
public class SubsysService implements SubsysManager {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    @Override
    public List<PageData> listAllsubsys(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("SubsysMapper.ListAllsubsys",pd);
    }

}
