package com.fh.service.system.breakdown.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.breakdown.BreakdownManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/** 故障报告
 * @author fengjj3@asiainfo.com
 * 修改时间：2018.9.11
 */
@Service("breakdownService")
public class BreakdownService implements BreakdownManager {

    @Resource(name = "daoSupport")
    private DaoSupport dao;


    /**列出查询条件下的故障报告
     * @param page
     * @return
     * @throws Exception
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<PageData> selectAllbkPage(Page page) throws Exception {
        return (List<PageData>) dao.findForList("BreakdownMapper.breakdownlistPage", page);
    }


    /**新添保存故障报告
     * @param pd
     * @return
     * @throws Exception
     */
    @Override
    public void saveB(PageData pd) throws Exception {
        dao.save("BreakdownMapper.saveB", pd);
    }
    /**通过ID查找故障报告
     * @param pd
     * @return
     * @throws Exception
     */
    @Override
    public PageData findbyIdB(PageData pd) throws Exception {
        return (PageData) dao.findForObject("BreakdownMapper.findbyIdB",pd);
    }

    /**修改
     * @param pd
     * @throws Exception
     */
    public void editB(PageData pd)throws Exception{
        dao.update("BreakdownMapper.editB", pd);
    }

    /**删除
     * @param pd
     * @throws Exception
     */
    @Override
    public void deleteB(PageData pd) throws Exception {
        dao.delete("BreakdownMapper.deleteB", pd);

    }

    /**批量删除
     * @param ArrayDATA_IDS
     * @throws Exception
     */
    @Override
    public void deleteAllB(String[] ArrayDATA_IDS)throws Exception{
        dao.delete("BreakdownMapper.deleteAllB", ArrayDATA_IDS);
    }


}
