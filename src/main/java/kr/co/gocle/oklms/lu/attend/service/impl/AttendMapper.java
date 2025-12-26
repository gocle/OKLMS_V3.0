package kr.co.gocle.oklms.lu.attend.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.ifx.vo.CmsCourseContentVO;
import kr.co.gocle.oklms.lu.attend.vo.AttendVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekVO;

@Mapper
public interface AttendMapper {
	
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */ 
	String getProgressId(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */ 
	String getCmsProgressId(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertCmsProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getTimeCount(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	String getTimeId(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertTime(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer updateTime(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getTimeMaxCount(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertTimeMax(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer updateTimeMax(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getPageProgressCount(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertPageProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getPageProgressSumCount(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	AttendVO getPageProgressInfo(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 저장하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertPageProgressSum(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 수정하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer updatePageProgressSum(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getCmsTimeProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getTimeProgress(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건을 수정하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer updateTimeProgress(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * String
	 */
	String getCmsLessonItemProgress(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * String
	 */
	String getLessonProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * String
	 */
	String getWeekScheduleLessonProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	String getLessonScheduleProgress(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	String getWeekProgressRate(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer getWeekProgressRateCnt(AttendVO attendVO) throws Exception;
	
	
	/**
	 * 단건을 수정하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer insertWeekProgressRate(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 수정하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer updateWeekProgressRate(AttendVO attendVO) throws Exception;
	
	/**
	 * 단건을 수정하는 SQL 을 호출한다.
	 * @param attendVO
	 * @return
	 * Interger
	 */
	Integer updateLessonProgressRate(AttendVO attendVO) throws Exception;
	

}
