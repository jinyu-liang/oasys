
package com.fh.service.system.util;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2018年7月25日
* 类说明
*/


public interface SequenceManager {

	public String getById(PageData pd) throws Exception;

	public String getLogID(PageData pd) throws Exception;
	
	public String getLenId(PageData pd) throws Exception;
}
