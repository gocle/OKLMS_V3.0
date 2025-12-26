
/*******************************************************************************
 * COPYRIGHT(C) 2020 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2020. 01. 29.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.commbiz.config.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.config.vo.LmsConfigVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

/**
* CRUD 쿼리를 마이바티스로 연결하는 클레스.
* @author 최선호
* @since 2020. 01. 29.
*/
@Mapper
public interface LmsConfigMapper {

	/**
	 * 목록을 조회하는 SQL 을 호출한다.
	 * @param String
	 * @return
	 * List<LmsConfigVO>
	 */
	List<LmsConfigVO> listConfig(String sitePrefix) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param LmsConfigVO
	 * @return
	 * List<LmsConfigVO>
	 */
	LmsConfigVO getConfig(LmsConfigVO lmsConfigVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param LmsConfigVO
	 * @return
	 * List<LmsConfigVO>
	 */
	LmsConfigVO getUseConfig(LmsConfigVO lmsConfigVO) throws Exception;
	
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param LmsConfigVO
	 * @return
	 * List<LmsConfigVO>
	 */
	int updateConfig(LmsConfigVO lmsConfigVO) throws Exception;
	
	int insertConfigHist(LmsConfigVO lmsConfigVO)throws Exception;
}
