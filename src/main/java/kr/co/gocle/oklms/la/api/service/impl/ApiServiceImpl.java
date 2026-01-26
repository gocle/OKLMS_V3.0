
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
package kr.co.gocle.oklms.la.api.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.la.api.service.ApiService;
import kr.co.gocle.oklms.la.api.vo.ApiVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;


@Transactional(rollbackFor=Exception.class)
@Service("apiService")
public class ApiServiceImpl extends EgovAbstractServiceImpl implements ApiService {

	private static final Logger LOG = LoggerFactory.getLogger(ApiServiceImpl.class);

    @Resource(name = "apiMapper")
    private ApiMapper apiMapper;
    
    @Resource(name="companyIdGnrService")
    private EgovIdGnrService companyIdGnrService;

	@Override
	public List<ApiVO> ccnMemberList() throws Exception {
		List<ApiVO> data = apiMapper.ccnMemberList();
		return data;
	}

	@Override
	public int companyNoChk(String companyNo) throws Exception {
		int data = apiMapper.companyNoChk(companyNo);
		return data;
	}

	@Override
	public String insertCompany(CompanyVO companyVO) throws Exception {
		String returnStr = "";
		String pkCompanyId = companyIdGnrService.getNextStringId();
		companyVO.setCompanyId(pkCompanyId);

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
		
		//공백제거
		companyVO.setCompanyId(StringUtils.delete(companyVO.getCompanyId(), " ").trim());
		
		int sqlResultInt = apiMapper.insertCompany(companyVO);
		if( 0 < sqlResultInt ){
			returnStr = pkCompanyId;
			if (companyVO.getMemSeq() != null && !companyVO.getMemSeq().trim().isEmpty()) {
				// 매핑된 센터전담자가 있는지 확인
				int ccnChk = apiMapper.getCcn(companyVO);
				
				if(ccnChk == 0) {
					apiMapper.insertCcnCompany(companyVO);
				}
			}
		}
		
		return returnStr;
	}

	@Override
	public void updateCompany(CompanyVO companyVO) throws Exception {
		int sqlResultInt = apiMapper.updateCompany(companyVO);
		
		if( 0 < sqlResultInt ){
			if (companyVO.getMemSeq() != null && !companyVO.getMemSeq().trim().isEmpty()) {
				// 매핑된 센터전담자가 있는지 확인
				int ccnChk = apiMapper.getCcn(companyVO);
				
				if(ccnChk == 0) {
					apiMapper.insertCcnCompany(companyVO);
				}
			}
		}
	}

}
