
/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 01. 20.         First Draft.
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.lu.main.service;

import java.util.List;

import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

 /**
 * 클래스에 대한 내용을 작성한다.
 * @author 이진근
 * @since 2017. 01. 20.
 */
@Transactional(rollbackFor=Exception.class)
public interface LmsUserMainPageService {


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
	 
	/**
	 * 현장교사  일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageCotSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	 
	/**
	 * 교수 강의 일정 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPagePrtSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	List<LmsUserMainPageVO> listLmsUserMainPagePrtOffSchedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	List<LmsUserMainPageVO> listLmsUserMainPageCutMember(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	int getNoteApplovalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	int getActApplovalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
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
	List<LmsUserMainPageVO> listLmsUserMainPageTotalCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageTodayCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLectureS​chedule(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	/**
	 * 학습관리 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPageStatusCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	/**
	 * 교수OJT용
	 * @param memberVO
	 * @return
	 * List<LmsUserMainPageVO>
	 */
	List<LmsUserMainPageVO> listLmsUserMainPagePrtStatusPrtCnt(LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	
	int getMemberAgreeYnCnt(String memSeq) throws Exception;
	
	int updateMemberAgreeYn(String memSeq) throws Exception;
	List<LmsUserMainPageVO> listLmsUserMainPageCcnNote(
			LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	List<LmsUserMainPageVO> listLmsUserMainPageCcnAct(
			LmsUserMainPageVO lmsUserMainPageVO) throws Exception;
	List<LmsUserMainPageVO> listLmsUserMainPageCotTraningProcess(
			LmsUserMainPageVO lmsUserMainPageVO) throws Exception;	
}
