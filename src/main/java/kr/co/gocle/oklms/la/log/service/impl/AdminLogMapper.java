package kr.co.gocle.oklms.la.log.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.log.vo.AdminLogVO;

@Mapper
public interface AdminLogMapper {

	List<AdminLogVO> selectLogList(AdminLogVO searchVO) throws Exception;

	int insertAdminLog(AdminLogVO adminLogVO) throws Exception;

}
