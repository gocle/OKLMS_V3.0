
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 7. 20.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.la.ncs.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.member.vo.ExcelMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.la.ncs.vo.NcsLicenceVO;
import kr.co.gocle.oklms.la.statistics.vo.LoginLogVO;

 /**
 * COM_MENU에 대한 CRUD 쿼리를 마이바티스로 연결하는 클레스.
* 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface NcsMapper {
	
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
