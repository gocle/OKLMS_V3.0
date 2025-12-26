package kr.co.gocle.oklms.la.dept.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.dept.vo.DeptVO;

@Mapper
public interface DeptMapper {

	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param deptVO
	 * @return
	 * List<CompanyVO>
	 */
	List<DeptVO> listDeptStat(DeptVO deptVO) throws Exception;
	
	List<DeptVO> listDept(DeptVO deptVO) throws Exception;
	
	DeptVO getDept(DeptVO deptVO) throws Exception;
	
	int insertDept(DeptVO deptVO) throws Exception;
	
	int updateDept(DeptVO deptVO) throws Exception;
	
	int deleteDept(DeptVO deptVO) throws Exception;
	
}
