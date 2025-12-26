package kr.co.gocle.oklms.la.dept.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.co.gocle.oklms.la.dept.service.DeptService;
import kr.co.gocle.oklms.la.dept.vo.DeptVO;
@Transactional(rollbackFor=Exception.class)
@Service("deptService")
public class DeptServiceImpl extends EgovAbstractServiceImpl implements DeptService{

    @Resource(name = "deptMapper")
    private DeptMapper deptMapper;
    
    
	@Override
	public List<DeptVO> listDeptStat(DeptVO deptVO) throws Exception {
		// TODO Auto-generated method stub
		return deptMapper.listDeptStat(deptVO);
	}
	
	@Override
	public List<DeptVO> listDept(DeptVO deptVO) throws Exception {
		// TODO Auto-generated method stub
		return deptMapper.listDept(deptVO);
	}
	
	@Override
	public DeptVO getDept(DeptVO deptVO) throws Exception {
		// TODO Auto-generated method stub
		return deptMapper.getDept(deptVO);
	}
	
	@Override
	public int insertDept(DeptVO deptVO) throws Exception {
		// TODO Auto-generated method stub
		return deptMapper.insertDept(deptVO);
	}
	
	@Override
	public int updateDept(DeptVO deptVO) throws Exception {
		// TODO Auto-generated method stub
		return deptMapper.updateDept(deptVO);
	}
	
	@Override
	public int deleteDept(DeptVO deptVO) throws Exception {
		// TODO Auto-generated method stub
		return deptMapper.deleteDept(deptVO);
	}

}
