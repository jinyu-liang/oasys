package com.fh.service.system.cut;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

public interface CutManager {
    public List<PageData> selectAllcutPage(Page page) throws Exception;

    public void saveC(PageData pd) throws Exception;

    public  PageData findbyIdC(PageData pd) throws Exception;

    public void editC(PageData pd)throws Exception;

    public void deleteC(PageData pd)throws Exception;


    public void deleteAllC(String[] ArrayDATA_IDS)throws Exception;
}
