package kr.co.gocle.oklms.lu.traningstatus.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.lu.traningstatus.vo.TraningReportVO;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningStatusVO;

@Mapper
public interface  TraningStatusMapper {
	/**
	 * 권장진도율 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * TraningStatusVO
	 */
	TraningStatusVO getProgress(TraningStatusVO traningStatusVO) throws Exception;
	
 	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * TraningStatusVO
	 */
	List<TraningStatusVO> listTraningStatus(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listTraningStatusDetail(TraningStatusVO traningStatusVO) throws Exception;

	List<TraningStatusVO> listTraningStatusPrt(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listTraningStatusDetailPrt(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listTraningStatusCot(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listTraningStatusDetailCot(TraningStatusVO traningStatusVO) throws Exception;

	List<TraningStatusVO> listTraningStatusCcm(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listTraningStatusDetailCcm(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> popupAttendListOff(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listTraningComplete(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> popupAttendListOnlineOff(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningReportVO> listOnlineScheduleAttend(TraningReportVO traningReportVO) throws Exception;
	
	/**
	 * OFF 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * TraningStatusVO
	 */
	List<TraningStatusVO> listOffTraningStatus(TraningStatusVO traningStatusVO) throws Exception;
	
	/**
	 * OJT 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * TraningStatusVO
	 */
	List<TraningStatusVO> listOjtTraningStatus(TraningStatusVO traningStatusVO) throws Exception;
	
	/**
	 * 주차별 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * TraningStatusVO
	 */
	List<TraningStatusVO> listWeekTraningStatus(TraningStatusVO traningStatusVO) throws Exception;
	
	
	List<TraningStatusVO> listSubject(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningReportVO> listSubjectWeek(TraningReportVO traningReportVO) throws Exception;
	
	List<TraningReportVO> listSubjectTraning(TraningReportVO traningReportVO) throws Exception;
	
	List<TraningReportVO> listSubjectTraningOff(TraningReportVO traningReportVO) throws Exception;
	
	List<TraningReportVO> listSubjectReport(TraningReportVO traningReportVO) throws Exception;
	
	List<TraningReportVO> listSubjectOnline(TraningReportVO traningReportVO) throws Exception;
	
	List<TraningReportVO> listSubjectActivity(TraningReportVO traningReportVO) throws Exception;
	
	List<TraningStatusVO> listTraningOff(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningReportVO> listTraningStatusCcn(TraningReportVO traningStatusVO) throws Exception;
	
	List<TraningReportVO> listTraningSubjectStatusCcn(TraningReportVO traningStatusVO) throws Exception;
	
	List<TraningReportVO> listTraningNcsSubjectStatusCcn(TraningReportVO traningStatusVO) throws Exception;
	
	
	List<TraningStatusVO> listTraningYear(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listCompanyTraningProcessNote(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listCompanyTraningProcessAct(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listCompanyTraningProcessEval(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listOjtTraningstatusCdp(TraningStatusVO traningStatusVO) throws Exception;
	
	List<TraningStatusVO> listOjtTraningstatusExcel(TraningStatusVO traningStatusVO) throws Exception;
	
	int updateLessonPassYn(TraningStatusVO traningStatusVO) throws Exception;
	
	int updateLessonGrade(TraningStatusVO traningStatusVO) throws Exception;
	
}
