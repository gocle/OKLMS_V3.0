package kr.co.gocle.oklms.la.log.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.gocle.oklms.la.log.vo.AdminLogVO;


@Transactional(rollbackFor=Exception.class)
public interface AdminLogService {

	List<AdminLogVO> selectLogList(AdminLogVO searchVO) throws Exception;
	
	int insertAdminLog(AdminLogVO adminLogVO) throws Exception;

}
