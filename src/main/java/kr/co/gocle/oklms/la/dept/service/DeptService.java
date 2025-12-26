package kr.co.gocle.oklms.la.dept.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.gocle.oklms.la.dept.vo.DeptVO;

@Transactional(rollbackFor=Exception.class)
public interface DeptService {

	List<DeptVO> listDeptStat(DeptVO deptVO) throws Exception;
	
	List<DeptVO> listDept(DeptVO deptVO) throws Exception;
	
	DeptVO getDept(DeptVO deptVO) throws Exception;
	
	int insertDept(DeptVO deptVO) throws Exception;
	
	int updateDept(DeptVO deptVO) throws Exception;
	
	int deleteDept(DeptVO deptVO) throws Exception;
}
