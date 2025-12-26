package kr.co.gocle.oklms.la.link.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.aunuri.vo.AunuriLinkLessonVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberMappingVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.aunuri.vo.AunuriLinkScheduleVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekVO;

@Mapper
public interface LinkMapper {
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int insertAunuriMember(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int insertAunuriStdMember(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int insertAunuriStdAuthMember(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int updateStdLecTargetYear() throws Exception;

	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param ㅁunuriLinkSubjectVO
	 * @return
	 * Integer
	 */
	int insertAunuriSubject(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param ㅁunuriLinkSubjectVO
	 * @return
	 * Integer
	 */
	int insertAunuriLesson(AunuriLinkLessonVO aunuriLinkLessonVO) throws Exception;
	
	int getAunuriLessonCnt(AunuriLinkLessonVO aunuriLinkLessonVO) throws Exception;
	
	int getAunuriInsCnt(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * Integer
	 */
	int insertAunuriSubjectWeek(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	/**
	 * 단건을 호출하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * String
	 */
	String getAunuriWeekTimeLeadTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	/**
	 * 단건을 호출하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * String
	 */
	String getAunuriWeekOnlineFourTimeLeadTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	/**
	 * 단건을 호출하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * String
	 */
	String getAunuriWeekOnlineTimeLeadTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * Integer
	 */
	int insertAunuriWeekTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * Integer
	 */
	int updateAunuriWeekTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * Integer
	 */
	int insertAunuriIns(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	

	
	/**
	 * 목록을 조회하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	List<AunuriLinkMemberVO> listAunuriMember(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	
	/**
	 * 목록을 조회하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	List<AunuriLinkMemberMappingVO> listSubjectCdp(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberMappingVO
	 * @return
	 * Integer
	 */
	int insertAunuriCdp(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	
	
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkScheduleVO
	 * @return
	 * Integer
	 */
	int insertAunuriSchedule(AunuriLinkScheduleVO aunuriLinkScheduleVO) throws Exception;
	
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * Integer
	 */
	int insertAunuriWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * Integer
	 */
	int updateAunuriWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * Integer
	 */
	int insertAunuriWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * Integer
	 */
	int updateAunuriWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * Integer
	 */
	int comMemberTest(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	/**
	 * 목록을 조회하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * List<aunuriLinkSubjectWeekNcsVO>
	 */
	List<AunuriLinkSubjectWeekNcsVO> listAunuriWeek(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	
	
	
	int insertAunuriSubjectTerm(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception;
	
	/**
	 * 목록을 조회하는 SQL 을 호출한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	List<AunuriLinkMemberMappingVO> listSubjectCdpTerm(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int updateAunuriMemberOutYn(String memId) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int updateAunuriMemberMerge(String memId) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * StringLinkMapper
	 */
	int updateAunuriMemberPassYn(String memId) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param ㅁunuriLinkSubjectVO
	 * @return
	 * Integer
	 */
	List<AunuriLinkSubjectWeekVO> listSubjectWeek(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;
	
	
	List<AunuriLinkSubjectVO> listSubjectTerm(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception;
	
	
	int getWeekNcsUnitCnt(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int updateWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int insertWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int getWeekNcsElemCnt(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int updateWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int insertWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int deleteWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int deleteWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int delete_WeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	int excuteStdBatch() throws Exception;
	
	int deleteAttend() throws Exception;
	
	int insertAttend() throws Exception;
	
	
	
	
	
}
