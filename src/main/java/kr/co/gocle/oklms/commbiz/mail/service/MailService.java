package kr.co.gocle.oklms.commbiz.mail.service;

import java.util.List;

import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 

import org.springframework.transaction.annotation.Transactional;

@Transactional(rollbackFor=Exception.class)
public interface MailService {
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param lessonVO
	 * @return
	 * List<MailVO>
	 */
	List<MailVO> listMailHistory(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * List<MailVO>
	 */
	List<MailVO> listSmsHistory(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param lessonVO
	 * @return
	 * MailVO
	 */
	MailVO getMailHistory(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	MailVO getSmsHistory(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String getMemSeqEmailSet(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String getMemTypeEmailSet(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String sendMail(MailVO mailVO) throws Exception;
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String sendMailLu(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건을 수정하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * int
	 */
	int updateMailHistory(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건을 등록하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * int
	 */
	int insertSendSms(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건을 등록하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * int
	 */
	int insertSms(MailVO mailVO) throws Exception;

	/**
	 *  신규 사용자 문자
	 * @param mailVO
	 * @return
	 * int
	 */
	int insertSmsLu(MailVO mailVO) throws Exception;
	
	int insertSmsLocal(MailVO mailVO) throws Exception;
	
	List<MailVO> listMemberMemseq(MailVO mailVO) throws Exception;
	
	List<MailVO> listMemberMemid(MailVO mailVO) throws Exception;
	
	
	int excuteMailBatch() throws Exception;
	
	int excuteSendBatch(String sendDate) throws Exception;

	int insertNoticeBatch(MailVO mailVO) throws Exception;

	MailVO getNoticeBatch(MailVO mailVO) throws Exception;

	List<MailVO> listSendMaster(String sendDate) throws Exception;
	
	int insertSendMaster(MailVO mailVO) throws Exception;
	
	String sendPasswordMail(MailVO mailVO) throws Exception;

	
}