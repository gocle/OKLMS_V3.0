package kr.co.gocle.oklms.la.log.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.gocle.oklms.la.log.service.AdminLogService;
import kr.co.gocle.oklms.la.log.vo.AdminLogVO;

@Transactional(rollbackFor=Exception.class)
@Service
public class AdminLogServiceImpl extends EgovAbstractServiceImpl implements AdminLogService {

	@Autowired
	AdminLogMapper adminLogMapper;
	
	
	@Override
	public List<AdminLogVO> selectLogList(AdminLogVO searchVO) throws Exception {
		return adminLogMapper.selectLogList(searchVO);
	}


	@Override
	public int insertAdminLog(AdminLogVO adminLogVO) throws Exception {
		return adminLogMapper.insertAdminLog(adminLogVO);
	}

}
