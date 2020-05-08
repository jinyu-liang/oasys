package com.fh.service.system.subsys;

import com.fh.util.PageData;

import java.util.List;

public interface SubsysManager {

    /**子系统列表(全部)
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> listAllsubsys(PageData pd)throws Exception;
}
