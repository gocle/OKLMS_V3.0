
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 02. 14.         First Draft.
 *
 *******************************************************************************/ 
package kr.co.gocle.ifx.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.ifx.vo.AunuriMemberVO;
import kr.co.gocle.ifx.vo.AunuriSubjectVO;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentVO;

/**
* CRUD 쿼리를 마이바티스로 연결하는 클레스.
* @author 이진근
* @since 2017. 02. 14.
*/
@Mapper
public interface CmsIfxMapper {
	
	/**
	 * 콘텐츠별 버전정보가 등록 되었는지 확인하는 SQL 을 호출한다.
	 * @param cmsCourseContentVO
	 * @return
	 * List<CmsCourseContentVO>
	 */
	int getCourseContentSummaryCnt() throws Exception;
	

	/**
	 * 콘텐츠별 버전정보를 저장하는 SQL을 호출한다
	 * @param cmsCourseContentVO
	 * @return
	 * String
	 */
	int insertCourseContentSummary(CmsCourseContentVO cmsCourseContentVO) throws Exception;
	
	/**
	 * 콘텐츠별 버전정보를 저장하는 SQL을 호출한다
	 * @param cmsCourseContentVO
	 * @return
	 * String
	 */
	int deleteCourseContentSummary() throws Exception;
	
	/**
	 * 콘텐츠별 버전정보 목록을 조회하는 SQL 을 호출한다.
	 * @param cmsCourseContentVO
	 * @return
	 * List<CmsCourseContentVO>
	 */
	List<CmsCourseContentVO> listCourseContentSummary(CmsCourseBaseVO cmsCourseBaseVO) throws Exception;
	
	
	
}
