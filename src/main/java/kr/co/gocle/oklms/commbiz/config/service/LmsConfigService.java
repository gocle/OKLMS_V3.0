/*******************************************************************************
 * COPYRIGHT(C) 2019 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 최선호    2020. 01. 29.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.commbiz.config.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.co.gocle.oklms.commbiz.config.vo.LmsConfigVO;

import org.springframework.transaction.annotation.Transactional;

/**
* Service 클래스에 대한 내용을 작성한다.
* @author 최선호
* @since 2020. 01. 29.
*/
@Transactional(rollbackFor=Exception.class)
public interface LmsConfigService {

	List<LmsConfigVO> listConfig(String sitePrefix) throws Exception;

	LmsConfigVO getConfig(LmsConfigVO lmsConfigVO)throws Exception;
	
	LmsConfigVO getUseConfig(LmsConfigVO lmsConfigVO)throws Exception;

	int updateConfig(LmsConfigVO lmsConfigVO)throws Exception;
	
	int insertConfigHist(LmsConfigVO lmsConfigVO)throws Exception;
}
