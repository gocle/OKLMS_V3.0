
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.la.ncs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.oklms.la.member.vo.ExcelMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.la.ncs.service.NcsService;
import kr.co.gocle.oklms.la.ncs.vo.NcsLicenceVO;
import kr.co.gocle.oklms.la.popup.vo.PopupVO;
import kr.co.gocle.oklms.la.statistics.service.LoginLogService;
import kr.co.gocle.oklms.la.statistics.vo.LoginLogVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
//import org.apache.commons.beanutils.BeanUtils;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

 /**
 * Service Implements 클레스 : 비지니스 로직을 구현하는 클레스.
* 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("ncsService")
public class NcsServiceImpl extends EgovAbstractServiceImpl implements NcsService{

	private static final Logger LOG = LoggerFactory.getLogger(NcsServiceImpl.class);
	
    @Resource(name = "ncsMapper")
    private NcsMapper ncsMapper;
    
    
    /** ID Generation */
    @Resource(name="nceLicenceIdGnrService")
    private EgovIdGnrService nceLicenceIdGnrService;
    
    /** ID Generation */
    @Resource(name="nceLicenceUnitIdGnrService")
    private EgovIdGnrService nceLicenceUnitIdGnrService;
    
    @Override
	public List<NcsLicenceVO> listLicence(NcsLicenceVO ncsLicenceVO) throws Exception {
		List<NcsLicenceVO> data = ncsMapper.listLicence(ncsLicenceVO);
		return data;
	}
    
    @Override
	public List<NcsLicenceVO> listNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception {
		List<NcsLicenceVO> data = ncsMapper.listNcsLicence(ncsLicenceVO);
		return data;
	}

	 @Override
	 public NcsLicenceVO getNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 NcsLicenceVO data = ncsMapper.getNcsLicence(ncsLicenceVO);
		 return data;
	 }
	 
	 @Override
	 public int insertNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 ncsLicenceVO.setLicenceId(nceLicenceIdGnrService.getNextStringId());
		 int data = ncsMapper.insertNcsLicence(ncsLicenceVO);
		 return data;
	 }
	 
	 @Override
	 public int updateNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 int data = ncsMapper.updateNcsLicence(ncsLicenceVO);
		 return data;
	 }
	 
	 @Override
	 public int deleteNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 int data = ncsMapper.deleteNcsLicence(ncsLicenceVO);
		 return data;
	 }
	 
	@Override
	public List<NcsLicenceVO> listNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception {
		List<NcsLicenceVO> data = ncsMapper.listNcsLicenceUnit(ncsLicenceVO);
		return data;
	}

	 @Override
	 public NcsLicenceVO getNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 NcsLicenceVO data = ncsMapper.getNcsLicenceUnit(ncsLicenceVO);
		 return data;
	 }
	 
	 @Override
	 public int insertNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 ncsLicenceVO.setUnitId(nceLicenceUnitIdGnrService.getNextStringId());
		 int data = ncsMapper.insertNcsLicenceUnit(ncsLicenceVO);
		 return data;
	 }
	 
	 @Override
	 public int updateNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 int data = 0;
		 
		 // 수정시 등록건이 없다면 등록
		 if(ncsLicenceVO.getUnitId() == null){
			 ncsLicenceVO.setUnitId(nceLicenceUnitIdGnrService.getNextStringId());
			 data = ncsMapper.insertNcsLicenceUnit(ncsLicenceVO);
		 } else {
			 data = ncsMapper.updateNcsLicenceUnit(ncsLicenceVO);
		 }
		
		 return data;
	 }
	 
	 @Override
	 public int deleteNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception {
		 // TODO Auto-generated method stub
		 int data = ncsMapper.deleteNcsLicenceUnit(ncsLicenceVO);
		 return data;
	 }

    
}
