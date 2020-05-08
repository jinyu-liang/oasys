package com.fh.service.system.breakdown;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

public interface BreakdownManager {
    public List<PageData> selectAllbkPage(Page page) throws Exception;

    public void saveB(PageData pd) throws Exception;

    public  PageData findbyIdB(PageData pd) throws Exception;

    public void editB(PageData pd)throws Exception;

    public void deleteB(PageData pd)throws Exception;

    public void deleteAllB(String[] ArrayDATA_IDS)throws Exception;


}
