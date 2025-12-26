
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 최선호    2020. 01. 29.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.commbiz.config.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.config.service.LmsConfigService;
import kr.co.gocle.oklms.commbiz.config.vo.LmsConfigVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
* Service Implement 클래스에 대한 내용을 작성한다.
* @author 최선호
* @since 2020. 01. 29.
*/
@Transactional(rollbackFor=Exception.class)
@Service("lmsConfigService")
public class LmsConfigServiceImpl extends EgovAbstractServiceImpl implements LmsConfigService {

    @Resource(name = "lmsConfigMapper")
    private LmsConfigMapper lmsConfigMapper;
    
    
    /**
	 * 목록을 조회하는 SQL 을 호출한다.
	 * @param String
	 * @return
	 * List<LmsConfigVO>
	 */
    @Override
	public List<LmsConfigVO> listConfig(String sitePrefix) throws Exception {
		 List<LmsConfigVO> resultList = lmsConfigMapper.listConfig(sitePrefix);
		return resultList;
	}
    
    /**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param LmsConfigVO
	 * @return
	 * List<LmsConfigVO>
	 */
 	@Override
 	public LmsConfigVO getConfig(LmsConfigVO lmsConfigVO) throws Exception {
 		LmsConfigVO result = lmsConfigMapper.getConfig(lmsConfigVO);
 		return result;
 	}
 	
 	 /**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param LmsConfigVO
	 * @return
	 * List<LmsConfigVO>
	 */
 	@Override
 	public LmsConfigVO getUseConfig(LmsConfigVO lmsConfigVO) throws Exception {
 		LmsConfigVO result = lmsConfigMapper.getUseConfig(lmsConfigVO);
 		return result;
 	}
 	
 	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param LmsConfigVO
	 * @return
	 * List<LmsConfigVO>
	 */
 	@Override
 	public int updateConfig(LmsConfigVO lmsConfigVO) throws Exception {
 		int result = lmsConfigMapper.updateConfig(lmsConfigVO);
 		return result;
 	}

 	@Override
 	public int insertConfigHist(LmsConfigVO lmsConfigVO) throws Exception {
 		int result = lmsConfigMapper.insertConfigHist(lmsConfigVO);
 		return result;
 	}
}
