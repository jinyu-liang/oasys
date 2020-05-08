package com.fh.service.system.sortplan.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.sortplan.SortplanManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("sortplanService")
public class SortplanService implements SortplanManager {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    @Override
    public void saveS(PageData pd) throws Exception {
        dao.save("SortplanMapper.saveS",pd);

    }

    @Override
    public void savesingin(PageData pd) throws Exception {
        dao.save("SortplanMapper.savesingin",pd);

    }
    @Override
    public void deleteS(PageData pd) throws Exception {
        dao.delete("SortplanMapper.deleteS",pd);
    }

    @Override
    public void editS(PageData pd) throws Exception {
        dao.update("SortplanMapper.editS", pd);
    }

    @Override
    public List<PageData> listAll(Page page) throws Exception {
        return (List<PageData>)dao.findForList("SortplanMapper.sortplanlistPage", page);
    }

    @Override
    public PageData findByIdS(PageData pd) throws Exception {
        return (PageData) dao.findForObject("SortplanMapper.findbyIdS",pd);
    }
}
