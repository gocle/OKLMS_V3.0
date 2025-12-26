
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
import kr.co.gocle.ifx.vo.CmsCourseContentVO;

/**
* CRUD 쿼리를 마이바티스로 연결하는 클레스.
* @author 이진근
* @since 2017. 02. 14.
*/
@Mapper
public interface IfxMapper {

	/**
	 * DB에서 학습근로자 (ojt)개설교과에 수강 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOjtAunuriSubjectLessonList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 학습근로자(off-jt)개설교과에 수강 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOffJtAunuriSubjectLessonList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 담당교사 (ojt)개설교과 메핑 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOjtAunuriSubjectInsMappingList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 담당교사 (ojt)개설교과 메핑 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOjtAunuriSubjectApproValInsMappingList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 담당교사 (ojt)개설교과 메핑 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOjtAunuriSubjectInsClassMappingList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	
	/**
	 * DB에서 담당교사 (off-jt)개설교과 메핑 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOffJtAunuriSubjectInsMappingList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 기업현장교사 (ojt)개설교과 메핑 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOjtAunuriSubjectTutMappingList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 학과전담자 (off-jt)개설교과 메핑 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriSubjectVO>
	 */
	List<AunuriSubjectVO> getOffJtAunuriSubjectCdpMappingList(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 교수의 담당 고숙련 과정 갯수를 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * Integer
	 */
	Integer getOjtAunuriSubjectInsHSkillCnt(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 교수의 담당 고숙련 과정 갯수를 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * Integer
	 */
	Integer getOjtAunuriSubjectInsOjtCnt(AunuriMemberVO aunuriMemberVO) throws Exception;
	
	
	
}
