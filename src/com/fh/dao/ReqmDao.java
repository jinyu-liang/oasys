package com.fh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.fh.util.PageData;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年12月25日
* 类说明
*/
@Mapper
public interface ReqmDao {

	@Select("SELECT substr(a.req_id, 0, 1), a.req_state, count(1)   FROM uop_oa.t_req_list a  where a.accept_date >= sysdate-360    and (a.req_id like 'R%' or a.req_id like 'W%')    and a.req_state in ('02', '04', '07', '08', '09')  GROUP BY substr(a.req_id, 0, 1), a.req_state  ORDER BY 1")
	public List<PageData> listReqmInfo();
}
