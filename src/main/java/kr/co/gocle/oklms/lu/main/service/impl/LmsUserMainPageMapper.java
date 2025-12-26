
/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 01. 06.         First Draft.
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.lu.main.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;

 /**
 * 프로토타입 게시판 CRUD 쿼리를 마이바티스로 연결하는 클레스.
 * @author 이진근
 * @since 2017. 01. 06.
 */
@Mapper
public interface LmsUserMainPageMapper {


	/**
	 * 센터담당자 기업체현황을 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcnCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	/**
	 * HRD담당자 기업체현황을 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcmCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	 
	
	/**
	 * 학습근로자 강의 일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageStdSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 학습근로자 강의 이수 목록을 조회하는 SQL 을 호출한다.
	 * @param lmsUserMainPageVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageStdComplete(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	
	/**
	 * 센터전담자  일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcnSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	List<LmsUserMainPageVO> listLmsUserMainPageCcnNote(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	List<LmsUserMainPageVO> listLmsUserMainPageCcnAct(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 현장교사  일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCotSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	List<LmsUserMainPageVO> listLmsUserMainPageCotTraningProcess(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 교수 강의 일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPagePrtSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;	
	
	List<LmsUserMainPageVO> listLmsUserMainPagePrtOffSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;	
	
	List<LmsUserMainPageVO> listLmsUserMainPageCutMember(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	Integer getNoteApplovalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	Integer getActApplovalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	
	/**
	 * hrd담당자 강의 일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcmSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;	
	
	List<LmsUserMainPageVO> listSubjectCot(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;	
	
	List<LmsUserMainPageVO> listSubjectStd(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	List<LmsUserMainPageVO> listSubjectStdOff(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageStdTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageTchTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageSubTchTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcmTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcnTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCdpTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageStdTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageTchTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageSubTchTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcmTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCcnTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCdpTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLectureS​cheduleStd(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLectureOjtS​chedulePrt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageStdStatusCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCotStatusCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPagePrtStatusCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 교수OJT용
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPagePrtStatusPrtCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * DB에서 교수의 담당 고숙련 과정 갯수를 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * Integer
	 */
	Integer getMemberAgreeYnCnt(String memSeq) throws Exception;
	
	/**
	 * DB에서 교수의 담당 고숙련 과정 갯수를 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * Integer
	 */
	Integer updateMemberAgreeYn(String memSeq) throws Exception;
}
