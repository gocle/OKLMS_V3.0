package kr.co.gocle.oklms.lu.send.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO; 
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.vo.SubjweekStdVO;
import kr.co.gocle.oklms.lu.send.vo.SendVO;

@Mapper
public interface  SendMapper {

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ActivityVO
	 */
	List<SendVO> listSendCdp(SendVO sendVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<SendVO> listSend(SendVO sendVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<SendVO> listSendCcn(SendVO sendVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<MailVO> listSendEmailResult(MailVO mailVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<MailVO> listSendSmsResult(MailVO mailVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<SendVO> listSendResult(SendVO sendVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<SendVO> listSendResultDetail(SendVO sendVO) throws Exception;
	
	
	int deleteSendMaster(String sendSeq) throws Exception;
	
	MailVO getSendMaster(MailVO mailVO) throws Exception;
	
	List<MailVO> listSendDetail(MailVO mailVO) throws Exception;
	
	
	
}
