
/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 7. 20.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.la.api.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.api.vo.ApiVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;

@Mapper
public interface ApiMapper {

	List<ApiVO> ccnMemberList() throws Exception;

	int companyNoChk(String companyNo) throws Exception;

	int insertCompany(CompanyVO companyVO) throws Exception;

	void insertCcnCompany(CompanyVO companyVO) throws Exception;

	int updateCompany(CompanyVO companyVO) throws Exception;

	int getCcn(CompanyVO companyVO) throws Exception;
}
