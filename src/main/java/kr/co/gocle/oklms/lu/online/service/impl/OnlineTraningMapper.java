package kr.co.gocle.oklms.lu.online.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.ifx.vo.CmsCourseContentVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchElemVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekFileVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekVO;

@Mapper
public interface OnlineTraningMapper {

	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<onlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<onlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningSubject(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<onlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningCdpSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<onlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOfflineTraningCdpSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<onlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningAllWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<onlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningStdOnlineSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	String getOnlineTraningWeekProgressYn(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	String getOnlineTraningWeekScheduleProgressYn(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * 단건을 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * CompanyVO
	 */
	OnlineTraningVO getOnlineTraningStand(OnlineTraningVO onlineTraningVO) throws Exception;
	
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int insertOnlineTraningStand(OnlineTraningVO onlineTraningVO) throws Exception;
	
	/**
	 * 정보를 단건 수정하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int updateOnlineTraningStand(OnlineTraningVO onlineTraningVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int insertOnlineTraningWeekContent(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int updateOnlineTraningWeekContent(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
	
	/**
	 * 정보를 여러건 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int deleteOnlineTraningWeekContent(String weekId) throws Exception;
	
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int insertOnlineTraningWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int updateOnlineTraningWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * 정보를 여러건 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int deleteOnlineTraningWeekSchedule(String weekId) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningWeekSch(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchElemVO> listOnlineTraningWeekSchElem(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchElemVO> listOnlineTraningWeekScheduleElemLesson(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningStdSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	OnlineTraningSchVO getOnlineWeekLessonSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	OnlineTraningSchVO getOnlineWeekLessonSchedulePreview(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	OnlineTraningSchVO getAllProgressRateLesson(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	OnlineTraningSchVO getTraningStatus(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	List<OnlineTraningSchVO> listOjtTraningStdSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningInsSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOjtTraningInsSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOjtTraningCotSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * 정보를 여러건 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int deleteOnlineTraningWeekScheduleElem(String weekId) throws Exception;
	
	/**
	 * 정보를 단건 등록하는 SQL 을 호출한다.
	 * @param onlineTraningSchElemVO
	 * @return
	 * String
	 */
	int insertOnlineTraningWeekScheduleElem(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param onlineTraningSchElemVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchElemVO> listOnlineTraningWeekScheduleElem(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	int insertOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception; 
	
   	int deleteOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception; 
   	
   	String getOnlineTraningWeekFileSeq(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception; 
   	
   	List<OnlineTraningWeekFileVO> listOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception;
   	
	List<OnlineTraningWeekFileVO> listOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception;
   	
   	
   	int insertOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception; 
   	
   	int updateOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception; 
   	
   	
	int insertTermOnStand(OnlineTraningVO onlineTraningVO) throws Exception; 
	
	int deleteTermOnStand(OnlineTraningVO onlineTraningVO) throws Exception; 
	
	OnlineTraningVO getTermOnStand(OnlineTraningVO onlineTraningVO) throws Exception; 
	
	int insertTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
   	
	int deleteTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
	
	List<OnlineTraningWeekVO> listTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
	
	List<OnlineTraningSchElemVO> listContentUrl() throws Exception;
	
	int updateContentUrl(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception;
	
	
	
}
