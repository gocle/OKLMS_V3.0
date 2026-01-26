
/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.la.api.service;

import java.util.List;

import kr.co.gocle.oklms.la.api.vo.ApiVO;
import kr.co.gocle.oklms.la.authority.vo.AuthMapVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;

import org.springframework.transaction.annotation.Transactional;

@Transactional(rollbackFor=Exception.class)
public interface ApiService {

	/** 센터전담자 리스트 */
	List<ApiVO> ccnMemberList() throws Exception;

	int companyNoChk(String companyNo) throws Exception;

	String insertCompany(CompanyVO companyVO) throws Exception;

	void updateCompany(CompanyVO companyVO) throws Exception;

}
