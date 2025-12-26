package kr.co.gocle.oklms.lu.online.service;

import java.util.List;

import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchElemVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekFileVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningProcessSearchVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Transactional(rollbackFor=Exception.class)
public interface OnlineTraningService {
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningAllWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningStdOnlineSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 등록하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	int insertOnlineTraningStand(OnlineTraningVO onlineTraningVO)throws Exception;
	
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	OnlineTraningVO getOnlineTraningStand(OnlineTraningVO onlineTraningVO)throws Exception;
	
	/**
	 * DB에서 Data를 수정하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	int updateOnlineTraningStand(OnlineTraningVO onlineTraningVO)throws Exception;

	
	/**
	 * DB에서 Data를 등록하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	int insertOnlineWeekSchedule(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
	
	/**
	 * DB에서 Data를 등록하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	int updateOnlineWeekSchedule(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningStdSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningInsSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOnlineTraningWeekSch(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchElemVO> listOnlineTraningWeekSchElem(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOjtTraningInsSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param companyVO
	 * @return
	 * List<OnlineTraningSchVO>
	 */
	List<OnlineTraningSchVO> listOjtTraningCotSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;
	
	
	OnlineTraningSchVO getAllProgressRateLesson(OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	List<OnlineTraningSchVO> listOjtTraningStdSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	OnlineTraningSchVO getTraningStatus(OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	List<OnlineTraningSchVO> listOnlineTraningCdpSchedule(
			OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	List<OnlineTraningSchVO> listOfflineTraningCdpSchedule(
			OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	String getOnlineTraningWeekProgressYn(OnlineTraningSchVO onlineTraningSchVO)
			throws Exception;
	
	String getOnlineTraningWeekScheduleProgressYn(OnlineTraningSchVO onlineTraningSchVO)
			throws Exception;

	OnlineTraningSchVO getOnlineWeekLessonSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	OnlineTraningSchVO getOnlineWeekLessonSchedulePreview(OnlineTraningSchVO onlineTraningSchVO) throws Exception;

	List<OnlineTraningSchVO> listOnlineTraningSubject(
			OnlineTraningSchVO onlineTraningSchVO) throws Exception;


	/**
	 * DB에서 Data를 등록하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	int insertOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO)throws Exception;
	
	/**
	 * DB에서 Data를 등록하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	int deleteOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO)throws Exception;
	
	
	/**
	 * DB에서 Data를 등록하는 로직을 수행한다.
	 * @param onlineTraningVO
	 * @return
	 * String
	 */
	String getOnlineTraningWeekFileSeq(OnlineTraningWeekFileVO onlineTraningWeekFileVO)throws Exception;

	List<OnlineTraningWeekFileVO> listOnlineTraningWeekFile(
			OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception;
	
	List<OnlineTraningWeekFileVO> listOnlineTraningFile(
			OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception;
	
	int insertOnlineTraningFile(OnlineTraningWeekFileVO  onlineTraningWeekFileVO,final MultipartHttpServletRequest multiRequest)	throws Exception;

	int updateOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO,
			MultipartHttpServletRequest multiRequest) throws Exception;

	int saveTermOnStand(OnlineTraningVO onlineTraningVO) throws Exception;

	OnlineTraningVO getTermOnStand(OnlineTraningVO onlineTraningVO)throws Exception;

	int saveTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;

	List<OnlineTraningWeekVO> listTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception;

	int mergeContent() throws Exception;

	List<OnlineTraningSchElemVO> listOnlineTraningWeekScheduleElemLesson(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception;
		
}
