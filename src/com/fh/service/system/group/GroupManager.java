package com.fh.service.system.group;

import java.util.List;

import com.fh.entity.system.Group;
import com.fh.util.PageData;;


/**
* @author 梁金玉 E-mail:liangjy@asiainfo.com
* @version 创建时间：2018年2月11日 下午6:06:22
* 类说明
*/

public interface GroupManager {

	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Group> listAllGroupsByPId(PageData pd) throws Exception;
	
}
