package com.fh.service.system.cut.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.cut.CutManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 切割报告
 * @author fengjj3@asiainfo.com
 * 修改时间：2018.9.11
 */
@Service("cutService")
public class CutService implements CutManager {


    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**列出查询条件下的切割报告
     * @param page
     * @return
     * @throws Exception
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<PageData> selectAllcutPage(Page page) throws Exception {
        return (List<PageData>) dao.findForList("CutMapper.cutlistPage", page);

    }

    /**新添切割报告
     * @param pd
     * @return
     * @throws Exception
     */
    @Override
    public void saveC(PageData pd) throws Exception {
        dao.save("CutMapper.saveC", pd);
    }

    /**通过ID查找切割报告
     * @param pd
     * @return
     * @throws Exception
     */
    @Override
    public PageData findbyIdC(PageData pd) throws Exception {
        return (PageData) dao.findForObject("CutMapper.findbyIdC",pd);
    }

    /**修改
     * @param pd
     * @throws Exception
     */
    @Override
    public void editC(PageData pd) throws Exception {
        dao.update("CutMapper.editC", pd);

    }

    /**删除
     * @param pd
     * @throws Exception
     */
    @Override
    public void deleteC(PageData pd) throws Exception {
        dao.delete("CutMapper.deleteC", pd);
    }

    /**批量删除
     * @param ArrayDATA_IDS
     * @throws Exception
     */
    @Override
    public void deleteAllC(String[] ArrayDATA_IDS)throws Exception{
        dao.delete("CutMapper.deleteAllC", ArrayDATA_IDS);
    }
}
