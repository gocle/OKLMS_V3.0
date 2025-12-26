package kr.co.gocle.oklms.lu.send.service;

import java.util.List;

import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO;
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.vo.SubjweekStdVO;
import kr.co.gocle.oklms.lu.send.vo.SendVO;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Transactional(rollbackFor=Exception.class)
public interface SendService {

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<SendVO> listSendCdp(SendVO sendVO) throws Exception;
	
	
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
	List<MailVO> listSendSmsResult(MailVO sendVO) throws Exception;
	
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
	List<SendVO> listSendResult(SendVO sendVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	List<SendVO> listSendResultDetail(SendVO sendVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param reportVO
	 * @return
	 * ReportVO
	 */
	int deleteSendMaster(MailVO sendVO) throws Exception;
	
	
	MailVO getSendMaster(MailVO mailVO) throws Exception;
	
	
	List<MailVO> listSendDetail(MailVO mailVO) throws Exception;
	
}
