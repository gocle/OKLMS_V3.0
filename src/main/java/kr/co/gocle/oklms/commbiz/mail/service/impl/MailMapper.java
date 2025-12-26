package kr.co.gocle.oklms.commbiz.mail.service.impl;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
 
@Mapper
public interface MailMapper {

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * List<LessonVO>
	 */
	List<MailVO> listMailHistory(MailVO mailVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * List<LessonVO>
	 */
	List<MailVO> listSmsHistory(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	List<MailVO> listMemberMail(MailVO mailVO) throws Exception;
	 
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * LessonVO
	 */
	MailVO getMailHistory(MailVO mailVO) throws Exception;
	
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * LessonVO
	 */
	MailVO getSmsHistory(MailVO mailVO) throws Exception;
	
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
	String getReceiveMailYn(String memSeq) throws Exception;
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String getReceiveSmsYn(String memSeq) throws Exception;
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String getReceiveSmsYnId(String memId) throws Exception;
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * MailVO
	 */
	String getReceiveMailYnId(String memSeq) throws Exception;	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * String
	 */
	int insertMailHistory(MailVO mailVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * String
	 */
	int updateMailHistory(MailVO mailVO) throws Exception;
	
	/**
	 * 정보를 등록하는 SQL 을 호출한다.
	 * @param lessonVO
	 * @return
	 * String
	 */
	int insertSendSms(MailVO mailVO) throws Exception;
	
	/**
	 * DB에서 Data를 단건을 등록하는 로직을 수행한다.
	 * @param mailVO
	 * @return
	 * int
	 */
	int insertSms(MailVO mailVO) throws Exception;
	
	String getSubjectName(MailVO mailVO) throws Exception;
	
	String [] getMemIds(MailVO mailVO) throws Exception;
	
	List<MailVO> listMember(MailVO mailVO) throws Exception;
	
	List<MailVO> listMemberMemseq(MailVO mailVO) throws Exception;
	
	List<MailVO> listMemberMemid(MailVO mailVO) throws Exception;
	
	int insertNoticeBatch(MailVO mailVO) throws Exception;
	
	
	MailVO getNoticeBatch(MailVO mailVO) throws Exception;
	
	List<MailVO> listNoticeBatchRep(MailVO mailVO) throws Exception;
	
	List<MailVO> listNoticeBatchDis(MailVO mailVO) throws Exception;
	
	List<MailVO> listNoticeBatchTpr(MailVO mailVO) throws Exception;
	
	List<MailVO> listCompanyCcnMember(MailVO mailVO) throws Exception;
	
	List<MailVO> listSendMaster(String sendDate) throws Exception;
	
	List<MailVO> listSendDetail(String sendDate) throws Exception;
	
	int insertSendMaster(MailVO mailVO) throws Exception;
	
	int updateSendMasterStatus(MailVO mailVO) throws Exception;
	
	int insertSendDetail(MailVO mailVO) throws Exception;
	
	int updateSendDetailStatus(MailVO mailVO) throws Exception;
	
	
}