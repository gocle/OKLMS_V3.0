package kr.co.gocle.oklms.lu.report.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.report.vo.ReportVO;

@Mapper
public interface ReportMapper {
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param currProcVO
	 * @return
	 * OnlineTraningSchVO
	 */
	List<OnlineTraningSchVO> listLmsSubjWeek(CurrProcVO currProcVO) throws Exception;
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */ 
	CurrProcVO getCurrproc(CurrProcVO currProcVO) throws Exception; 
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	ReportVO getReport(ReportVO reportVO) throws Exception;
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<ReportVO> listReport(ReportVO reportVO) throws Exception;
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<ReportVO> listReportStd(ReportVO reportVO) throws Exception;
 	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * String
	 */
	int insertReport(ReportVO reportVO) throws Exception;
	
	
	
	int getReportCnt(ReportVO reportVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * String
	 */ 
	int updateReport(ReportVO reportVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * String
	 */ 
	int updateReportWeek(ReportVO reportVO) throws Exception;
	
	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * int
	 */
	int deleteReport(ReportVO reportVO) throws Exception;	

	
	/**
	 * 정보를 사업자 번호 중복 체크 Count하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * int
	 */
	int getReportNoCnt(ReportVO reportVO) throws Exception;	
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	ReportVO getReportSubmit(ReportVO reportVO) throws Exception;
	
 	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * String
	 */
	int insertReportSubmit(ReportVO reportVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * String
	 */ 
	int updateReportSubmit(ReportVO reportVO) throws Exception;
	
	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * int
	 */
	int deleteReportSubmit(ReportVO reportVO) throws Exception;	
	
	List<ReportVO> reportSubmitList(ReportVO reportVO) throws Exception;	
	
	
	List<ReportVO> reportSubmitAllList(ReportVO reportVO) throws Exception;	
	
	
	ReportVO getReportSubmitInFo(ReportVO reportVO) throws Exception;
	
	ReportVO getReportFeedBack(ReportVO reportVO) throws Exception;
	
	int insertReportFeedBack(ReportVO reportVO) throws Exception;	
	
	int updateReportFeedBack(ReportVO reportVO) throws Exception;	
	
	int deleteReportFeedBack(ReportVO reportVO) throws Exception;	
	
	
	
}
