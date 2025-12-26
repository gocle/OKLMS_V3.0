
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
package kr.co.gocle.oklms.la.ncs.service;

import java.util.List;

import kr.co.gocle.oklms.la.ncs.vo.NcsLicenceVO;
import kr.co.gocle.oklms.la.statistics.vo.LoginLogVO;

import org.springframework.transaction.annotation.Transactional;

@Transactional(rollbackFor=Exception.class)
public interface NcsService {
	
	List<NcsLicenceVO> listLicence(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	List<NcsLicenceVO> listNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception;

	NcsLicenceVO getNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	int insertNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	int updateNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	int deleteNcsLicence(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	List<NcsLicenceVO> listNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception;

	NcsLicenceVO getNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	int insertNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	int updateNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception;
	
	int deleteNcsLicenceUnit(NcsLicenceVO ncsLicenceVO) throws Exception;

}
