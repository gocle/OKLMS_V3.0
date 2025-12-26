package kr.co.gocle.oklms.commbiz.mail.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.aunuri.service.impl.AunuriLinkMapper;
import kr.co.gocle.oklms.comm.util.CommonUtil;
import kr.co.gocle.oklms.comm.util.Config;
import kr.co.gocle.oklms.comm.util.FileUploadUtil;
import kr.co.gocle.oklms.comm.util.TextStringUtil;
import kr.co.gocle.oklms.commbiz.mail.service.MailService;
import kr.co.gocle.oklms.commbiz.util.SendMail;
import kr.co.gocle.oklms.commbiz.mail.service.impl.MailMapper; 
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 
import kr.co.gocle.oklms.la.member.vo.MemberVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

/**
* Service Implements 클레스 : 비지니스 로직을 구현하는 클레스.
* @author 최선호
* @since 2016. 9. 05.
*/
@Transactional(rollbackFor=Exception.class)
@Service("mailService")
public class MailServiceImpl extends EgovAbstractServiceImpl implements MailService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MailServiceImpl.class);
	
	//메일첨부파일 업로드 경로
   private String uploadPath = "/upload/mail";
   private MultipartFile mFile;
   
   @Resource(name = "mailMapper")
   private MailMapper mailMapper;
   	
   @Resource(name = "aunuriLinkMapper")
   private AunuriLinkMapper aunuriLinkMapper;
       
	/** ID Generation */
   @Resource(name="mailIdGnrService")
   private EgovIdGnrService mailIdGnrService;
   
   /** ID Generation */
   @Resource(name="sendMasterIdGnrService")
   private EgovIdGnrService sendMasterIdGnrService;
   
   /** ID Generation */
   @Resource(name="sendDetailIdGnrService")
   private EgovIdGnrService sendDetailIdGnrService;
   
   @Override
	public List<MailVO> listMailHistory(MailVO mailVO) throws Exception {
		// TODO Auto-generated method stub
		List<MailVO> data = mailMapper.listMailHistory(mailVO);
		return data;
	}
   
   @Override
	public List<MailVO> listSmsHistory(MailVO mailVO) throws Exception {
		// TODO Auto-generated method stub
		List<MailVO> data = mailMapper.listSmsHistory(mailVO);
		return data;
	}
	
   @Override
   public MailVO getMailHistory(MailVO mailVO) throws Exception{
		// TODO Auto-generated method stub
       return mailMapper.getMailHistory(mailVO);
   }
   
   @Override
   public MailVO getSmsHistory(MailVO mailVO) throws Exception{
		// TODO Auto-generated method stub
       return mailMapper.getSmsHistory(mailVO);
   }
   
   @Override
   public String getMemSeqEmailSet(MailVO mailVO) throws Exception{
   	String recieveMemSeq = "";
   	List memberList = mailMapper.listMemberMail(mailVO);
       if (memberList!=null && memberList.size()>0){
           for(int idx=0 ; idx<memberList.size() ; idx++){
           	MemberVO member = (MemberVO) memberList.get(idx);
               recieveMemSeq += member.getMemSeq();
               if (idx<memberList.size()-1){
                   recieveMemSeq += ",";
               }
           }
       }
       return recieveMemSeq;
   }
   
   @Override
   public String getMemTypeEmailSet(MailVO mailVO) throws Exception{
   	String emailSet = "";
   	List memberList = mailMapper.listMemberMail(mailVO);
   	if (memberList!=null && memberList.size()>0){
           for(int idx=0 ; idx<memberList.size() ; idx++){
               MemberVO member = (MemberVO) memberList.get(idx);
               emailSet += member.getEmail();
               if (idx<memberList.size()-1){
                   emailSet += ","; 
               }
           }
       }
       return emailSet;
   }
   
   @Override
   public String sendMail(MailVO mailVO) throws Exception{
   	String strClassId = "";
   	String smtpHost = EgovProperties.getProperty("mail.smtp.host");    	
       String sendName = mailVO.getSendName();
       String sendEmail = mailVO.getSendEmail();
       String senderMemSeq = mailVO.getSenderMemSeq();
       String mailClass = mailVO.getMailClass();
       String sendResult = "Y";
       int msgType = mailVO.getMsgType();
       String recvEmailSet = "";
       String recvMemSeqSet = "";
       String recvLessonIdSet = "";
       String[] receiveEmail = null;
       //수신자 회원번호
       String[] receiverMemSeq = null;
       String[] receiverLessonId = null;
       strClassId = mailVO.getClassId();
    
       recvEmailSet = mailVO.getRecvEmailSet();
       recvMemSeqSet = mailVO.getRecvMemSeqSet();
       recvLessonIdSet = mailVO.getReceiverLessonId();
       receiveEmail = recvEmailSet.split(",");
       receiverMemSeq = recvMemSeqSet.split(",");
       if (!StringUtils.isBlank(recvLessonIdSet) ) {
       	receiverLessonId = recvLessonIdSet.split(",");
       } 


       String mailTitle = mailVO.getMailTitle();
       String mailContent = "";
       mailContent = mailVO.getMailContent();
       
     //첨부파일이 존재할 경우
       if (mailVO.hasFile()) {
           ArrayList aFileList = mailVO.getAttachFile();
           int fileCnt = aFileList.size();

           String tempFileName;
           String realUploadPath = CommonUtil.appendPath(Config.realPath,uploadPath );
           //String fileLocalPath=gocleProperties.get("system.mail.file.path")+uploadPath+File.separator;

           for (int idx = 0; idx < fileCnt; idx++) {
               mFile = (MultipartFile) aFileList.get(idx);;

               if (!mFile.isEmpty()) {
                   tempFileName = FileUploadUtil.uploadFormFileAsRealName(mFile, realUploadPath );
                   mailVO.setFilePath( realUploadPath +File.separator+ tempFileName);
                   mailVO.setFileName( tempFileName);
               }
           }
       }
       String filePath = mailVO.getFilePath();
       
       try{
           SendMail sendmail = new SendMail(smtpHost);

           //본문인코딩방식,제목 인코딩방식
           sendmail.setEncoding("euc-kr","euc-kr");

           //보내는 사람 주소
           sendmail.setFromAddr(new String(sendName.getBytes("euc-kr"),"8859_1")+"<"+sendEmail+">");

           //0-받는사람,1-참고,2-숨은참고
           sendmail.setRecType(0);

           //메일 방식, 0-텍스트, 1-html
           sendmail.setMsgType(1);

           //제목 셋팅
           sendmail.setSubject(mailTitle);

           //내용셋팅
           sendmail.setText(mailContent);

           //첨부파일경로셋팅
           sendmail.setFilePath(filePath);

           //보내는 사람 수 만큼 메일 발송
           for(int idx = 0 ; idx < receiveEmail.length ; idx++ ){
           	if( !StringUtils.isBlank( receiverMemSeq[idx]) ){
           		// 이메일 수신 여부에 상관없이 무조건 보내야 하는 메일이 있는 경우 때문에 수정 (회원인증 메일 등)
           		String receiveMailYn = "";
           		if("Y".equals(mailVO.getReceiveMailYnBypass())){
           			receiveMailYn = "Y";
           		}else{
           			receiveMailYn = mailMapper.getReceiveMailYn(receiverMemSeq[idx]);
           		}

           		if(receiveMailYn.equals("Y")){
                       if( !StringUtils.isBlank( receiveEmail[idx]) ){
                       	sendmail.setToAddr(receiveEmail[idx].trim());
                       	sendmail.send();
                       }
           		}
           	}else{
           		// 이메일 수신 여부에 상관없이 무조건 보내야 하는 메일이 있는 경우 때문에 수정 (회원인증 메일 등)
           		String receiveMailYn = "";
           		if("Y".equals(mailVO.getReceiveMailYnBypass())){
           			receiveMailYn = "Y";
           		}

           		if(receiveMailYn.equals("Y")){
                       if( !StringUtils.isBlank( receiveEmail[idx]) ){                        	
                       	sendmail.setToAddr(receiveEmail[idx].trim());
                       	sendmail.send();
                       }
           		}
           	}
           }

           return sendResult;
       }catch(Exception e){
       	LOGGER.error( e.getMessage(), e );
           sendResult = "N";
           return sendResult;
       }finally{
           if (mailVO.hasFile()) FileUploadUtil.deleteFormFile(mFile, filePath);
           //메일 전송후 메일 이력 테이블에 저장
           insertMailHistory(mailVO, mailTitle, sendEmail, receiveEmail, sendResult, senderMemSeq, receiverMemSeq, mailClass, receiverLessonId);
       }
   }
   
   public void insertMailHistory(MailVO mailVO, String mailTitle, String senderEmail,
   		String[] receiverEmail, String sendResult, String senderMemSeq,
   		String[] receiverMemSeq, String mailClass, String[] receiverLessonId) throws Exception{
   	
   	if(receiverEmail != null){
   		for(int i=0;i<receiverEmail.length;i++){
   			mailVO.setHistoryId(mailIdGnrService.getNextStringId());
   			mailVO.setSenderMemSeq(senderMemSeq);
   			mailVO.setSenderEmail(senderEmail);
       		mailVO.setReceiverMemSeq(receiverMemSeq[i]);
       		mailVO.setReceiverEmail(receiverEmail[i]);
       		mailVO.setSendSuccessYn(sendResult);
       		mailVO.setMailClass(mailClass);
       		mailVO.setMailTitle(mailTitle);
       		mailVO.setInsertUser(senderMemSeq);
       		if(receiverLessonId != null){
       			mailVO.setReceiverLessonId(receiverLessonId[i]);
       		}
       		mailMapper.insertMailHistory(mailVO);
       	}
   	}
   }
   
   @Override
   public int updateMailHistory(MailVO mailVO) throws Exception{
		// TODO Auto-generated method stub
       return mailMapper.updateMailHistory(mailVO);
   }

   @Override
   public int insertSendSms(MailVO mailVO) throws Exception{
		// TODO Auto-generated method stub
	   	String strReceiver = mailVO.getTrPhone();
	   	String [] receiverArr = null;
	   	String receiver = "";
	   	strReceiver = strReceiver.replaceAll("-", "");
	       int result = 0;
	   	receiverArr = TextStringUtil.split(strReceiver, ",");
	   	
	   	//공지사항 sms 보내기
		for (int i = 0; i < receiverArr.length; i++) {
			
			String pkStr = mailIdGnrService.getNextIntegerId()+"";
			mailVO.setTrNum(pkStr);
			
			receiver = receiverArr[i];
			
			mailVO.setTrPhone(receiver);
			mailVO.setTrEtc1(mailVO.getSenderMemSeq());
			
		   result++;
		   
		   MailVO   sms = new MailVO();
		   //송신번호
		   sms.setTrCallBack(mailVO.getTrCallBack());
		   //수신번호
		   sms.setTrPhone(mailVO.getTrPhone());
		   //내용
		   sms.setTrMsg(mailVO.getTrMsg());
		   //보내는사람 sendName
		   sms.setSendName(mailVO.getSendName());
		   //받는사람 receiveName
		   sms.setReceiveName(mailVO.getReceiveName());

		   // 전송
		   aunuriLinkMapper.smsSendCall(sms);
		   //전송결과값
		   mailVO.setTrRsltstat(sms.getTrRsltstat());
		   mailMapper.insertSendSms(mailVO);
		}

       return result;
   }

   @Override
   public int insertSms(MailVO sms) throws Exception{
   	String strReceiver = sms.getTrPhone();
   	String recvMemSeq = sms.getRecvMemSeqSet();
   	String lessonId = sms.getReceiverLessonId();
   	String [] receiverArr = null;
   	String [] recvMemSeqArr = null;
   	String [] receiverLessonIdArr = null;
   	String receiver = "";
   	String receiverMemSeq = "";
   	String receiverLessonId = ""; 
   	strReceiver = strReceiver.replaceAll("-", "");
       int result = 0;

   	receiverArr = TextStringUtil.split(strReceiver, ","); 
   	recvMemSeqArr = TextStringUtil.split(recvMemSeq, ",");
   	if(!"".equals(lessonId)){
   		receiverLessonIdArr = TextStringUtil.split(lessonId, ",");
   	}
   		// id 가져오는 부분
	   	sms.setMemSeqs(recvMemSeqArr);
	   	String[] memIds = mailMapper.getMemIds(sms);
	   	sms.setMemIds(memIds);
	   	
	   	// id , email, phone 가져오는 부분
		//List<MailVO> smsVO = aunuriLinkMapper.smsSendMailTel(sms);
	    //local로 변경
	    List<MailVO> smsVO = mailMapper.listMemberMemid(sms);
	    
		// 정상적으로 가져온 대상자만 보내도록처리		
	    //for (int i = 0; i < receiverArr.length; i++) {
		for(int i=0; smsVO.size()>i ;i++){

	    	//receiver = receiverArr[i];			
			//receiver = smsVO.get(i).getMbtlnum();
			receiver = smsVO.get(i).getHpNo();

	    	receiverMemSeq = recvMemSeqArr[i];
	    	if(receiverLessonIdArr != null){
	    		receiverLessonId = receiverLessonIdArr[i];
	    	}

	    	//SMS 수신동의 여부에 따라 처리
	    	String receiveSmsYn = mailMapper.getReceiveSmsYn(receiverMemSeq);
	    	if (!StringUtils.isBlank(receiveSmsYn) ) {
	    		if(receiveSmsYn.equals("Y")){
	    			String pkStr = mailIdGnrService.getNextIntegerId()+"";
	    			sms.setTrNum(pkStr);
	    	    	sms.setTrPhone(receiver);
	    			sms.setTrEtc1(sms.getSenderMemSeq());
	    			sms.setTrEtc2(receiverMemSeq);
	    			sms.setTrEtc3(receiverLessonId);
	    			sms.settFlag("0");
 
	    			aunuriLinkMapper.smsSendCall(sms);
	                result += mailMapper.insertSms(sms);
	    		}
	    	}
	    }
       return result;
   }
	
	@Override
	public List<MailVO> listMemberMemseq(MailVO mailVO) throws Exception {
		// TODO Auto-generated method stub
		return mailMapper.listMemberMemseq(mailVO);
	}
	
	@Override
	public List<MailVO> listMemberMemid(MailVO mailVO) throws Exception {
		// TODO Auto-generated method stub
		return mailMapper.listMemberMemid(mailVO);
	}
	
	@Override
	public int insertSmsLu(MailVO mailVO) throws Exception {
		 
	   	String receiver = "";  
	   	String receiverMemId= "";
	   	String receiverMemName= "";
	   	
	    String smsContent = "";
	    smsContent = mailVO.getSmsContent();
	    String smsContentSend = "";
	    
	    int result = 0; 
	
	   	// id , email, phone 가져오는 부분
		//List<MailVO> smsVO = aunuriLinkMapper.smsSendMailTel(mailVO);
	    //local로 변경
	    List<MailVO> smsVO = mailMapper.listMemberMemid(mailVO);
		
		mailVO.setSubjectName(mailMapper.getSubjectName(mailVO));
		
		// 정상적으로 가져온 대상자만 보내도록처리		
		for(int i=0; smsVO.size()>i ;i++)
		{						
			//receiver = smsVO.get(i).getMbtlnum();
			receiver = smsVO.get(i).getHpNo();
			receiver = receiver.replaceAll("-", "");
						
			//receiverMemId = smsVO.get(i).getEmplNo();			 
			//receiverMemName = smsVO.get(i).getReceiveName();
			receiverMemId = smsVO.get(i).getMemId();			 
			receiverMemName = smsVO.get(i).getMemName();
			
			//SMS 수신동의 여부에 따라 처리
			String receiveSmsYn = mailMapper.getReceiveSmsYnId(receiverMemId);
			if (!StringUtils.isBlank(receiveSmsYn) ) {
				
				if(receiveSmsYn.equals("Y")){
					String pkStr = mailIdGnrService.getNextIntegerId()+"";
					mailVO.setTrNum(pkStr);
					//수신자 전화번호
					mailVO.setTrPhone(receiver);
					//수신자 이름
					mailVO.setReceiveName(receiverMemName);
					//발신자 아이디
					mailVO.setTrEtc1(mailVO.getSenderMemSeq());
					// 변수치환
					smsContentSend = smsContent.replaceAll("_학습근로자_",StringUtils.defaultString( receiverMemName,""));
					if(smsContentSend.indexOf("_개설교과_")>-1){
						smsContentSend = smsContentSend.replaceAll("_개설교과_", StringUtils.defaultString(mailMapper.getSubjectName(mailVO),""));	
					}
					smsContentSend = smsContentSend.replaceAll("_주차_", StringUtils.defaultString(mailVO.getWeekCnt(),""));
					smsContentSend = smsContentSend.replaceAll("_마감일_", StringUtils.defaultString(mailVO.getLastDate(),""));
 
					//전송내용
					mailVO.setTrMsg(smsContentSend);
 					mailVO.setTrClass(mailVO.getMailTempType());
					mailVO.settFlag("0");
					mailVO.setTrEtc2(receiverMemId); 
					aunuriLinkMapper.smsSendCall(mailVO);
					
					if(mailVO.getTrRsltstat().equals("Y")){
						result += mailMapper.insertSms(mailVO);	
					}				
					
				}				
			}
		}
		
		/*
		MailVO smsSend = new MailVO();
		String [] memIds = new String[1];
		memIds[0]=mailVO.getSessionMemId();
		smsSend.setMemIds(memIds);
		List<MailVO> listMemberMail = mailMapper.listMemberMail(smsSend);
		
		
		
		if(listMemberMail!=null && listMemberMail.size()>0){ 
			smsSend = listMemberMail.get(0);
			
			String pkStrTemp = mailIdGnrService.getNextIntegerId()+"";
			mailVO.setTrNum(pkStrTemp);
			
			receiver=smsSend.getHpNo();
			receiver = receiver.replaceAll("-", "");
			
			mailVO.setTrPhone(receiver);			
			
			smsSend.setTrCallBack(mailVO.getTrCallBack());
			smsSend.setSendName(mailVO.getSendName());
			//받는 휴대폰번호
			smsSend.setTrPhone(receiver);
			smsSend.setReceiveName(mailVO.getReceiveName());
			smsSend.setTrMsg(mailVO.getTrMsg());
			
			aunuriLinkMapper.smsSendCall(mailVO); 
			if(mailVO.getTrRsltstat().equals("Y")){ 
				result += mailMapper.insertSms(mailVO);	
			} 
		}
		*/
		
		 

		return result;
	}
	
	@Override
	public int insertSmsLocal(MailVO mailVO) throws Exception {
		// 기업현장교사용 내부조회후 전송
	   	String receiver = "";  
	   	String receiverMemId= "";	 
	   	String receiverMemName="";
	   	
	    String smsContent = "";
	    smsContent = mailVO.getSmsContent();
	    String smsContentSend = "";
	    int result = 0; 
	
	   	// id , email, phone 가져오는 부분	    
	    List<MailVO> smsVO = mailMapper.listMemberMail(mailVO);
		mailVO.setSubjectName(StringUtils.defaultString(mailMapper.getSubjectName(mailVO),""));
		
		// 정상적으로 가져온 대상자만 보내도록처리		
		for(int i=0; smsVO.size()>i ;i++)
		{						
			receiver = smsVO.get(i).getHpNo();
			receiver = receiver.replaceAll("-", "");
			
			receiverMemId = smsVO.get(i).getMemId();			 
			receiverMemName = smsVO.get(i).getMemName();
			
			//SMS 수신동의 여부에 따라 처리
//			String receiveSmsYn = mailMapper.getReceiveSmsYnId(receiverMemId);
//			if (!StringUtils.isBlank(receiveSmsYn) ) {
				
//				if(receiveSmsYn.equals("Y")){
					String pkStr = mailIdGnrService.getNextIntegerId()+"";
					mailVO.setTrNum(pkStr);
					//수신자 전화번호
					mailVO.setTrPhone(receiver);
					//수신자 이름
					mailVO.setReceiveName(receiverMemName);					
					//발신자 아이디
					mailVO.setTrEtc1(mailVO.getSessionMemId());
					// 변수치환
					smsContentSend = smsContent.replaceAll("_학습근로자_", StringUtils.defaultString(receiverMemName,""));
					smsContentSend = smsContentSend.replaceAll("_개설교과_", StringUtils.defaultString(mailMapper.getSubjectName(mailVO),""));
					smsContentSend = smsContentSend.replaceAll("_주차_", StringUtils.defaultString(mailVO.getWeekCnt(),""));
					smsContentSend = smsContentSend.replaceAll("_마감일_", StringUtils.defaultString(mailVO.getLastDate(),""));
 
					//전송내용
					mailVO.setTrMsg(smsContentSend);
					
					
 					mailVO.setTrClass(mailVO.getMailTempType());
					mailVO.settFlag("0");
					mailVO.setTrEtc2(receiverMemId);
					aunuriLinkMapper.smsSendCall(mailVO);
					result += mailMapper.insertSms(mailVO);
//				}				
//			}
		}

		MailVO smsSend = new MailVO();
		String [] memIds = new String[1];
		memIds[0]=mailVO.getSessionMemId();
		smsSend.setMemIds(memIds);
		List<MailVO> listMemberMail = mailMapper.listMemberMail(smsSend);
 
		if(listMemberMail!=null && listMemberMail.size()>0){ 
			smsSend = listMemberMail.get(0);
			
			String pkStrTemp = mailIdGnrService.getNextIntegerId()+"";
			mailVO.setTrNum(pkStrTemp);
			
			receiver=smsSend.getHpNo();
			receiver = receiver.replaceAll("-", "");
			
			mailVO.setTrPhone(receiver);			
			
			smsSend.setTrCallBack(mailVO.getTrCallBack());
			smsSend.setSendName(mailVO.getSendName());
			//받는 휴대폰번호
			smsSend.setTrPhone(receiver);
			smsSend.setReceiveName(mailVO.getReceiveName());
			smsSend.setTrMsg(mailVO.getTrMsg());
			
			aunuriLinkMapper.smsSendCall(mailVO); 
			if(mailVO.getTrRsltstat().equals("Y")){ 
				result += mailMapper.insertSms(mailVO);	
			} 
		}
		 

		return result;
	} 
	   @Override
	   public String sendMailLu(MailVO mailVO) throws Exception{
		   
			String strClassId = "";
			
			
			String smtpHost = EgovProperties.getProperty("mail.smtp.host");	
			String sendName = mailVO.getSendName();

			String sendEmail = StringUtils.defaultIfEmpty(EgovProperties.getProperty("mail.admin.mailaddress"), "oklms@koreatech.ac.kr") ;			
			String senderMemSeq = mailVO.getSenderMemSeq();
			String mailClass = mailVO.getMailClass();
			String sendResult = "Y";
			int msgType = mailVO.getMsgType();
 
			String recvMemNameSet = "";
			String[] receiveEmail = null;
			//수신자 회원번호
			String[] receiverMemSeq = null;
			String[] receiverLessonId = null;
			strClassId = mailVO.getClassId();
 
	       String mailTitle = mailVO.getMailTitle();
	       String mailContent = "";
	       mailContent = mailVO.getMailContent();
	       String mailContentSend = "";
	       
	     //첨부파일이 존재할 경우
	       if (mailVO.hasFile()) {
	           ArrayList aFileList = mailVO.getAttachFile();
	           int fileCnt = aFileList.size();

	           String tempFileName;
	           String realUploadPath = CommonUtil.appendPath(Config.realPath,uploadPath );
	     
	           for (int idx = 0; idx < fileCnt; idx++) {
	               mFile = (MultipartFile) aFileList.get(idx);;

	               if (!mFile.isEmpty()) {
	                   tempFileName = FileUploadUtil.uploadFormFileAsRealName(mFile, realUploadPath );
	                   mailVO.setFilePath( realUploadPath +File.separator+ tempFileName);
	                   mailVO.setFileName( tempFileName);
	               }
	           }
	       }
	       String filePath = mailVO.getFilePath();
	       
	       try{
	           SendMail sendmail = new SendMail(smtpHost);

	           //본문인코딩방식,제목 인코딩방식
	           sendmail.setEncoding("euc-kr","euc-kr");
 
	           //보내는 사람 주소
	           sendmail.setFromAddr(new String(sendName.getBytes("euc-kr"),"8859_1")+"<"+sendEmail+">");

	           //0-받는사람,1-참고,2-숨은참고
	           sendmail.setRecType(0);

	           //메일 방식, 0-텍스트, 1-html
	           sendmail.setMsgType(msgType);

	           //제목 셋팅
	           sendmail.setSubject(mailTitle);

	           //첨부파일경로셋팅
	           sendmail.setFilePath(filePath);

		   	   	String receiver = "";  
			   	String receiverMemId= "";	   	
			    int result = 0; 
			
			   	// id , email, phone 가져오는 부분
				//List<MailVO> smsVO = aunuriLinkMapper.smsSendMailTel(mailVO);
			    //local로 변경
			    System.out.println("========== mailVO.getmemIds : "+mailVO.getMemIds());
			    
			    for(int i=0; i < mailVO.getMemIds().length; i++){
			    	System.out.println("========== mailVO.getmemIds : "+mailVO.getMemIds()[i]);
			    }
			    
			    List<MailVO> smsVO = mailMapper.listMemberMemid(mailVO);				
				mailVO.setSubjectName(mailMapper.getSubjectName(mailVO));

				
				if(smsVO!=null && smsVO.size()>0){
					receiveEmail = new String[smsVO.size()];
					receiverMemSeq = new String[smsVO.size()];					
				}
				
				// 정상적으로 가져온 대상자만 보내도록처리		
				for(int i=0; smsVO.size()>i ;i++)
				{						

					receiver = smsVO.get(i).getEmail();				
					receiverMemId = smsVO.get(i).getMemId();
					recvMemNameSet = smsVO.get(i).getMemName();
					
					receiveEmail[i] = receiver;
					receiverMemSeq[i] = receiverMemId; 
					// 변수치환
					mailContentSend = mailContent.replaceAll("_학습근로자_", StringUtils.defaultString(recvMemNameSet,""));
					if(mailVO.getSubjectCode()!=null && !mailVO.getSubjectCode().equals("")){
						mailContentSend = mailContentSend.replaceAll("_개설교과_", StringUtils.defaultString(mailMapper.getSubjectName(mailVO),""));
					}
					mailContentSend = mailContentSend.replaceAll("_주차_", StringUtils.defaultString(mailVO.getWeekCnt(),""));
					mailContentSend = mailContentSend.replaceAll("_마감일_", StringUtils.defaultString(mailVO.getLastDate(),""));
 
					
		           //내용셋팅
		           sendmail.setText(mailContentSend);

					//메일 수신동의 여부에 따라 처리
//					String receiveMailYn = mailMapper.getReceiveMailYnId(receiverMemId);
//					if (!StringUtils.isBlank(receiveMailYn) ) {
						 
                       if( !StringUtils.isBlank( receiver) ){                        	
	                       sendmail.setToAddr(receiver); 
	                       sendmail.send();
                       }
 		
//					}
				}


				MailVO smsSend = new MailVO();
				String [] memIds = new String[1];
				memIds[0]=mailVO.getSessionMemId();
				smsSend.setMemIds(memIds);
				List<MailVO> listMemberMail = mailMapper.listMemberMail(smsSend);
				
				if(listMemberMail!=null && listMemberMail.size()>0){
					smsSend = listMemberMail.get(0);
             	    sendmail.setToAddr(smsSend.getEmail()); 
                    sendmail.send();
				}
				
	           return sendResult;
	       }catch(Exception e){
	       	LOGGER.error( e.getMessage(), e );
	           sendResult = "N";
	           return sendResult;
	       }finally{
	           if (mailVO.hasFile()) FileUploadUtil.deleteFormFile(mFile, filePath);
	           //메일 전송후 메일 이력 테이블에 저장
	           insertMailHistory(mailVO, mailTitle, sendEmail, receiveEmail, sendResult, senderMemSeq, receiverMemSeq, mailClass, receiverLessonId);
	       }
	   }
	   
	   @Override
	   public int insertNoticeBatch(MailVO mailVO) throws Exception {
			// TODO Auto-generated method stub
		   int iResult = mailMapper.insertNoticeBatch(mailVO);
		   return iResult;
	   }
	   
	   @Override
	   public MailVO getNoticeBatch(MailVO mailVO) throws Exception {
			// TODO Auto-generated method stub
			return mailMapper.getNoticeBatch(mailVO);
	   }
	   
	   @Override
	   public int excuteMailBatch() throws Exception{
		   MailVO mailVO = new MailVO();
		   MailVO sms = new MailVO();
		   MailVO vo = new MailVO();
		   mailVO = mailMapper.getNoticeBatch(mailVO);
		   String smtpHost = EgovProperties.getProperty("mail.smtp.host");
		   String sendEmail = StringUtils.defaultIfEmpty(EgovProperties.getProperty("mail.admin.mailaddress"), "oklms@koreatech.ac.kr") ;		
		   String smsMsg = "";
		   String mailTitle = "";
		   String mailContent = "";
		   String sendName = "OK-LMS";
		   String trCallback = EgovProperties.getProperty("Globals.sms.sender.default.phoneno");
		  
		   //============ 이메일 세팅 st =============//
		   SendMail sendmail = new SendMail(smtpHost);
		   //본문인코딩방식,제목 인코딩방식
           sendmail.setEncoding("euc-kr","euc-kr");
           //보내는 사람 주소
           sendmail.setFromAddr(new String(sendName.getBytes("euc-kr"),"8859_1")+"<"+sendEmail+">");
           //0-받는사람,1-참고,2-숨은참고
           sendmail.setRecType(0);
           //메일 방식, 0-텍스트, 1-html
           sendmail.setMsgType(0);
           //첨부파일경로셋팅
           sendmail.setFilePath("");
           //============ 이메일 세팅 ed =============//
           
           //============ SMS 세팅 st =============//
		   //송신번호
		   sms.setTrCallBack(trCallback);
		   //보내는사람 sendName
		   sms.setSendName(sendName);
		   //============ SMS 세팅 ed =============//

		   if( mailVO != null){
			   if(!mailVO.getRepDay().equals("")){
				   List<MailVO> listNoticeBatchRep = mailMapper.listNoticeBatchRep(mailVO);
				   
				   if(listNoticeBatchRep.size() > 0){
					   for(int i=0; i < listNoticeBatchRep.size(); i++){
						   vo = listNoticeBatchRep.get(i);
						   if(mailVO.getRepSmsUseYn().equals("Y")){
							   smsMsg = "["+vo.getSubjectName()+"] 과제 제출 마감일은"
									   +" "+vo.getSubmitDay()+"("+vo.getSubmitWeek()+") 입니다."
									   +" 아직 제출하지 않은 분들은 마감일내로 꼭 제출하여 주시기 바랍니다. "
							   		   +" 감사합니다. ";
							   
							   if(!vo.getHpNo().equals("")){
								   
								   //받는사람 receiveName
								   sms.setReceiveName(vo.getMemName());
								   //수신번호
								   sms.setTrPhone(vo.getHpNo());
								   //내용
								   sms.setTrMsg(smsMsg);
								   // 전송
								   aunuriLinkMapper.smsSendCall(sms);
							   }
							 
						   }
						   if(mailVO.getRepMailUseYn().equals("Y")){ 
							   
							   mailTitle = "OK-LMS ["+vo.getSubjectName()+"] 과제 제출 안내";
							   
							   mailContent = "["+vo.getSubjectName()+"] 과제 제출 마감일은"
									   +" "+vo.getSubmitDay()+"("+vo.getSubmitWeek()+") 입니다.\n\n"
									   +" 아직 제출하지 않은 분들은 마감일내로 꼭 제출하여 주시기 바랍니다. \n\n"
							   		   +" 감사합니다. ";
							   
							   //제목 셋팅
					           sendmail.setSubject(mailTitle);
					           // 내용 세팅
					           sendmail.setText(mailContent);
							   
							   if(!vo.getEmail().equals("")){
								   sendmail.setToAddr(vo.getEmail());
								   sendmail.send();
							   }	
					           
						   }
					   }
				   }
				   
			   }
			   if(!mailVO.getDisDay().equals("")){
				   List<MailVO> listNoticeBatchDis = mailMapper.listNoticeBatchDis(mailVO);
				   
				   if(listNoticeBatchDis.size() > 0){
					   for(int i=0; i < listNoticeBatchDis.size(); i++){
						   vo = listNoticeBatchDis.get(i);
						   if(mailVO.getDisSmsUseYn().equals("Y")){
							   smsMsg = "["+vo.getSubjectName()+"] 토론 참여 마감일은"
									   +" "+vo.getSubmitDay()+"("+vo.getSubmitWeek()+") 입니다."
									   +" 아직 제출하지 않은 분들은 마감일내로 꼭 참여하여 주시기 바랍니다. "
							   		   +" 감사합니다. ";
							   
							   if(!vo.getHpNo().equals("")){
								   
								   //받는사람 receiveName
								   sms.setReceiveName(vo.getMemName());
								   //수신번호
								   sms.setTrPhone(vo.getHpNo());
								   //내용
								   sms.setTrMsg(smsMsg);
								   // 전송
								   aunuriLinkMapper.smsSendCall(sms);
							   }
						   }
						   if(mailVO.getDisMailUseYn().equals("Y")){
							   
							   mailTitle = "OK-LMS ["+vo.getSubjectName()+"] 토론 참여 안내";
							   
							   mailContent = "["+vo.getSubjectName()+"] 토론 참여 마감일은"
									   +" "+vo.getSubmitDay()+"("+vo.getSubmitWeek()+") 입니다.\n\n"
									   +" 아직 제출하지 않은 분들은 마감일내로 꼭 참여하여 주시기 바랍니다.\n\n"
							   		   +" 감사합니다. ";
							   
							   //제목 셋팅
					           sendmail.setSubject(mailTitle);
					           // 내용 세팅
					           sendmail.setText(mailContent);
							   
							   if(!vo.getEmail().equals("")){
								   sendmail.setToAddr(vo.getEmail());
								   sendmail.send();
							   }
						   }
					   }
				   }
				   
			   }
			   if(!mailVO.getTprDay().equals("")){
				   List<MailVO> listNoticeBatchTpr = mailMapper.listNoticeBatchTpr(mailVO);
				   
				   if(listNoticeBatchTpr.size() > 0){
					   for(int i=0; i < listNoticeBatchTpr.size(); i++){
						   vo = listNoticeBatchTpr.get(i);
						   if(mailVO.getTprSmsUseYn().equals("Y")){
							   smsMsg = "["+vo.getSubjectName()+"] 팀프로젝트 제출 마감일은"
									   +" "+vo.getSubmitDay()+"("+vo.getSubmitWeek()+") 입니다."
									   +" 아직 제출하지 않은 분들은 마감일내로 꼭 제출하여 주시기 바랍니다. "
							   		   +" 감사합니다. ";
							   
							   if(!vo.getHpNo().equals("")){
								   
								   //받는사람 receiveName
								   sms.setReceiveName(vo.getMemName());
								   //수신번호
								   sms.setTrPhone(vo.getHpNo());
								   //내용
								   sms.setTrMsg(smsMsg);
								   // 전송
								   aunuriLinkMapper.smsSendCall(sms);
							   }
						   }
						   if(mailVO.getTprMailUseYn().equals("Y")){
							   
							   mailTitle = "OK-LMS ["+vo.getSubjectName()+"] 팀프로젝트 제출 안내";
							   
							   mailContent = "["+vo.getSubjectName()+"] 팀프로젝트 제출 마감일은"
									   +" "+vo.getSubmitDay()+"("+vo.getSubmitWeek()+") 입니다.\n\n"
									   +" 아직 제출하지 않은 분들은 마감일내로 꼭 제출하여 주시기 바랍니다. \n\n"
							   		   +" 감사합니다. ";
							   
							   //제목 셋팅
					           sendmail.setSubject(mailTitle);
					           // 내용 세팅
					           sendmail.setText(mailContent);
							   
							   if(!vo.getEmail().equals("")){
								   sendmail.setToAddr(vo.getEmail());
								   sendmail.send();
							   }
							   
						   }
					   }
				   }
			   }
		   }
		   
		   
		   int iResult = 0;
		   
		   return iResult;
	   }
	   
	   
	   
	   @Override
	   public int excuteSendBatch(String sendDate) throws Exception {
		   // TODO Auto-generated method stub
		   
		   MailVO mailVO = new MailVO();
		   MailVO sms = new MailVO();
		   MailVO vo = new MailVO();
		   String smtpHost = EgovProperties.getProperty("mail.smtp.host");
		   String sendEmail = StringUtils.defaultIfEmpty(EgovProperties.getProperty("mail.admin.mailaddress"), "oklms@koreatech.ac.kr") ;		
		   String smsMsg = "";
		   String mailTitle = "";
		   String mailContent = "";
		   String sendName = "OK-LMS";
		   String trCallback = EgovProperties.getProperty("Globals.sms.sender.default.phoneno");
		  
		   //============ 이메일 세팅 st =============//
		   SendMail sendmail = new SendMail(smtpHost);
		   //본문인코딩방식,제목 인코딩방식
           sendmail.setEncoding("euc-kr","euc-kr");
           //보내는 사람 주소
           sendmail.setFromAddr(new String(sendName.getBytes("euc-kr"),"8859_1")+"<"+sendEmail+">");
           //0-받는사람,1-참고,2-숨은참고
           sendmail.setRecType(0);
           //메일 방식, 0-텍스트, 1-html
           sendmail.setMsgType(0);
           //첨부파일경로셋팅
          
           //============ 이메일 세팅 ed =============//
           
           //============ SMS 세팅 st =============//
		   //송신번호
		   sms.setTrCallBack(trCallback);
		   //보내는사람 sendName
		   sms.setSendName(sendName);
		   //============ SMS 세팅 ed =============//
		   
		   int iResult = 0;
		   List<MailVO> listSendMaster = mailMapper.listSendMaster(sendDate);
		   
		   for(int i=0; i < listSendMaster.size(); i++ ){
			   MailVO sendMVO = listSendMaster.get(i);
			   
			   List<MailVO> listSendDetail = mailMapper.listSendDetail(sendMVO.getSendSeq());
			   
			   for(int x=0; x < listSendDetail.size(); x++ ){
				   MailVO sendDVO = listSendDetail.get(x);
				   
				   if(sendMVO.getSendType().equals("EMAIL")){
					   
					   //제목 셋팅
			           sendmail.setSubject(sendDVO.getTitle());
			           // 내용 세팅
			           sendmail.setText(sendDVO.getContent());
			           
			           if(sendMVO.getAtchFileId() != null){
			        	   sendmail.setFilePath(sendMVO.getAtchFileId());
			           } else {
			        	   sendmail.setFilePath("");
			           }
			           String reciveYn = "N";
					   if(!sendDVO.getEmail().equals("")){
						   sendmail.setToAddr(sendDVO.getEmail());
						   try {
							   // 전송
							   reciveYn = "Y";
							   sendmail.send();
							} catch (Exception e) {
								// TODO: handle exception
								reciveYn = "N";
							}
						   
					   }	
					   sendDVO.setReciveYn(reciveYn);
					   mailMapper.updateSendDetailStatus(sendDVO);
					  
					   if(sendDVO.getSendYn().equals("Y")){
						   iResult++;
					   }
					   
				   } else {
					   
					   //받는사람 receiveName
					   sms.setReceiveName(sendDVO.getMemName());
					   //수신번호
					   sms.setTrPhone(sendDVO.getHpNo().replaceAll("-", ""));
					   //내용
					   sms.setTrMsg(sendDVO.getContent());
					   
					   String reciveYn = "N";
					   
					   if(!sendDVO.getHpNo().equals("")){
						   try {
							   // 전송
							   reciveYn = "Y";
							   aunuriLinkMapper.smsSendCall(sms);
							} catch (Exception e) {
								// TODO: handle exception
								reciveYn = "N";
							}
					   }
					   
					   sendDVO.setReciveYn(reciveYn);
					   mailMapper.updateSendDetailStatus(sendDVO);
					   
					   if(sendDVO.getSendYn().equals("Y")){
						   iResult++;
					   }
					   
					   
				   }
				   
			   }
			   
			   //String sendYn = "N";
			   //if(iResult > 0){
				//   sendYn = "Y";
			   //}
			   sendMVO.setSendYn("Y");
			   mailMapper.updateSendMasterStatus(sendMVO);
		   }
		   
		  
		   
		   return iResult;
	   }
	   
	   @Override
		public List<MailVO> listSendMaster(String sendDate) throws Exception {
			// TODO Auto-generated method stub
		   
			return mailMapper.listSendMaster(sendDate);
		}
	   
	   
	   @Override
	   public int insertSendMaster(MailVO mailVO) throws Exception {
			// TODO Auto-generated method stub
			int iResult = 0;
			  
			mailVO.setSendSeq(sendMasterIdGnrService.getNextStringId());
			mailVO.setTempletType("");
			String mailContentSend = "";
			
			
			String receiver = "";  
			String receiverMemId= ""; 
			String subjectName = StringUtils.defaultString( mailMapper.getSubjectName(mailVO),"");
			mailVO.setSubjectName(subjectName);
			
			String weekCnt = StringUtils.defaultString(mailVO.getWeekCnt(),"") ;
			String lastDate = StringUtils.defaultString(mailVO.getLastDate(),"");
			
			 LOGGER.debug("########################################mailVO.subjectName(:"+subjectName);
			 LOGGER.debug("########################################mailVO.weekCnt(:"+weekCnt);
			 LOGGER.debug("########################################mailVO.lastDate(:"+lastDate);
			 
			
			
			String recvMemNameSet = "";
			String[] receiveEmail = null;
			//수신자 회원번호
			String[] receiverMemSeq = null;
			String[] receiverLessonId = null;
			
			String sendResult = "Y"; 
			
		    String mailContent = "";
		    String mailTitle = "";
		    
		    String smtpHost = EgovProperties.getProperty("mail.smtp.host");
	        SendMail sendmail = new SendMail(smtpHost);
	        
		   if(mailVO.getSendType().equals("EMAIL")){	// EMAIL
			   
					
				String sendName = mailVO.getSendName();
				String sendEmail = StringUtils.defaultIfEmpty(EgovProperties.getProperty("mail.admin.mailaddress"), "oklms@koreatech.ac.kr") ;			
				String senderMemSeq = mailVO.getSenderMemSeq();
				String mailClass = mailVO.getMailClass();
				int msgType = mailVO.getMsgType();
				 
		       mailTitle = mailVO.getMailTitle(); 
		       mailContent = mailVO.getMailContent(); 
		       
		     //첨부파일이 존재할 경우
		       if (mailVO.hasFile()) {
		           ArrayList aFileList = mailVO.getAttachFile();
		           int fileCnt = aFileList.size();

		           String tempFileName;
		           String realUploadPath = CommonUtil.appendPath(Config.realPath,uploadPath );
		     
		           for (int idx = 0; idx < fileCnt; idx++) {
		               mFile = (MultipartFile) aFileList.get(idx);;

		               if (!mFile.isEmpty()) {
		                   tempFileName = FileUploadUtil.uploadFormFileAsRealName(mFile, realUploadPath );
		                   mailVO.setFilePath( realUploadPath +File.separator+ tempFileName);
		                   mailVO.setFileName( tempFileName);
		               }
		           }
		       }
		       
		       String filePath = mailVO.getFilePath();
		       mailVO.setAtchFileId(filePath);
		       
 

	           //본문인코딩방식,제목 인코딩방식
	           sendmail.setEncoding("euc-kr","euc-kr");
 
	           //보내는 사람 주소
	           sendmail.setFromAddr(new String(sendName.getBytes("euc-kr"),"8859_1")+"<"+sendEmail+">");

	           //0-받는사람,1-참고,2-숨은참고
	           sendmail.setRecType(0);

	           //메일 방식, 0-텍스트, 1-html
	           sendmail.setMsgType(msgType);

	           //제목 셋팅
	           sendmail.setSubject(mailTitle);

	           //첨부파일경로셋팅
	           sendmail.setFilePath(filePath);

			    int result = 0; 
 			    			
			   
			   mailVO.setTitle(mailVO.getMailTitle());
			   mailVO.setTempletType(mailVO.getMailTempType());
			   mailContentSend=mailVO.getMailContent();
				// 변수치환
				if(mailVO.getSubjectCode()!=null && !mailVO.getSubjectCode().equals("")){
					mailContentSend = mailContentSend.replaceAll("_개설교과_", subjectName);
				}
				mailContentSend = mailContentSend.replaceAll("_주차_", weekCnt);
				mailContentSend = mailContentSend.replaceAll("_마감일_",lastDate);
				mailVO.setContent(mailContentSend);
				
		   } else { // SMS
			   mailVO.setTempletType(mailVO.getSmsTempType());
			   mailContentSend=mailVO.getSmsContent();
				// 변수치환
				if(mailVO.getSubjectCode()!=null && !mailVO.getSubjectCode().equals("")){
					mailContentSend = mailContentSend.replaceAll("_개설교과_", subjectName);
				}
				mailContentSend = mailContentSend.replaceAll("_주차_", weekCnt);
				mailContentSend = mailContentSend.replaceAll("_마감일_",lastDate);
				mailVO.setContent(mailContentSend);
				
		   }
		   
		   if(mailVO.getRealTypeYn().equals("Y")){
			   mailVO.setSendYn("Y");
			   mailVO.settFlag("0");
		   } else {
			   mailVO.setSendYn("N");
			   mailVO.settFlag("1");
			   mailVO.setTrSenddate(mailVO.getSendDate().replace(".", ""));
		   }
		   LOGGER.debug("mailVO.getRealTypeYn():"+mailVO.getRealTypeYn());
		   LOGGER.debug("mailVO.setSendYn():"+mailVO.getSendYn());
		   LOGGER.debug(" mailVO.settFlag():"+ mailVO.gettFlag());
		   LOGGER.debug("mailVO.setTrSenddate(:"+mailVO.getTrSenddate());
 
		   mailVO.setSendDate(mailVO.getSendDate().replaceAll("\\.", ""));
		 
		   iResult = mailMapper.insertSendMaster(mailVO);
		   if(iResult > 0){
		   
			   List<MailVO> smsVO = mailMapper.listMemberMemid(mailVO);	
			   iResult = 0;
 
			 //  List<MailVO> smsVO = list;
				// 정상적으로 가져온 대상자만 보내도록처리		
				for(int i=0; smsVO.size()>i ;i++)
				{					
					if(mailVO.getSendType().equals("EMAIL")){
 
							
						// 정상적으로 가져온 대상자만 보내도록처리
						receiver = smsVO.get(i).getEmail();				
						receiverMemId = smsVO.get(i).getMemId();
						recvMemNameSet = smsVO.get(i).getMemName();
						
						// 변수치환
						mailContent 	  = mailContentSend.replaceAll("_학습근로자_", StringUtils.defaultString(recvMemNameSet,""));
						mailVO.setContent(mailContent);
						 //내용셋팅
						sendmail.setText(mailContent);

						//메일 수신동의 여부에 따라 처리
						String receiveMailYn = mailMapper.getReceiveMailYnId(receiverMemId);
						if (!StringUtils.isBlank(receiveMailYn) ) {
							if( !StringUtils.isBlank( receiver) ){   
								
								// 즉시발송 예약발송 관련해 추가
								if(mailVO.getRealTypeYn().equals("Y")){
									  
									   sendmail.setToAddr(receiver); 
								       sendmail.send();
										
									   mailVO.setSendDetailSeq(sendDetailIdGnrService.getNextStringId());
									   mailVO.setReciveMemSeq(smsVO.get(i).getMemSeq());
									   mailVO.setReciveYn("Y");
									   iResult += mailMapper.insertSendDetail(mailVO);
								} else {
									  mailVO.setSendDetailSeq(sendDetailIdGnrService.getNextStringId());
									  mailVO.setReciveMemSeq(smsVO.get(i).getMemSeq());
									  mailVO.setReciveYn("N");
									  iResult += mailMapper.insertSendDetail(mailVO);
								}
								
								   
							}
						}

					}else {
						receiver = smsVO.get(i).getHpNo();
						receiver = receiver.replaceAll("-", "");
									 
						receiverMemId = smsVO.get(i).getMemId();			 
						String receiverMemName = smsVO.get(i).getMemName();
						
						//SMS 수신동의 여부에 따라 처리
						String receiveSmsYn = mailMapper.getReceiveSmsYnId(receiverMemId);
						if (!StringUtils.isBlank(receiveSmsYn) ) {
							
							if(receiveSmsYn.equals("Y")){
								String pkStr = mailIdGnrService.getNextIntegerId()+"";
								mailVO.setTrNum(pkStr);
								//수신자 전화번호
								mailVO.setTrPhone(receiver);
								//수신자 이름
								mailVO.setReceiveName(receiverMemName);
								//발신자 아이디
								mailVO.setTrEtc1(mailVO.getSenderMemSeq());
								// 변수치환
								String smsContentSend = mailVO.getContent(); 
								//전송내용
								mailVO.setTrMsg(smsContentSend);
			 					mailVO.setTrClass(mailVO.getMailTempType());
							
								mailVO.setTrEtc2(receiverMemId); 
								
								
								//if(mailVO.getTrRsltstat().equals("Y")){
									 //mailMapper.insertSms(mailVO);	
								//}				
							
								// 즉시발송 예약발송 관련해 추가
								if(mailVO.getRealTypeYn().equals("Y")){
									 aunuriLinkMapper.smsSendCall(mailVO);
									 mailVO.setSendDetailSeq(sendDetailIdGnrService.getNextStringId());
									 mailVO.setReciveMemSeq(smsVO.get(i).getMemSeq());
									 mailVO.setReciveYn("Y");
									 iResult += mailMapper.insertSendDetail(mailVO);
								} else {
									 mailVO.setSendDetailSeq(sendDetailIdGnrService.getNextStringId());
									 mailVO.setReciveMemSeq(smsVO.get(i).getMemSeq());
									 mailVO.setReciveYn("N");
									 iResult += mailMapper.insertSendDetail(mailVO);
								}
								
								
							  
							   
							}
						}
					 
					}
 
				}
				
		   }
		   System.out.println("==================== iResult : "+iResult);
		return iResult;
	   }
	   
	   @Override
	   public String sendPasswordMail(MailVO mailVO) throws Exception {
		   String smtpHost = EgovProperties.getProperty("mail.smtp.host");;    	
	       String sendName = mailVO.getSendName();
	       String sendEmail = mailVO.getSendEmail();
	       String sendResult = "Y";
	       String mailTitle = mailVO.getMailTitle();
	       String mailContent = "";
	       mailContent = mailVO.getMailPasswordContent().replaceAll("\n", "<br/>");
	       
	       try{
	    	   
	    	   
	           SendMail sendmail = new SendMail(smtpHost);

	           //본문인코딩방식,제목 인코딩방식
	           sendmail.setEncoding("euc-kr","euc-kr");

	           //보내는 사람 주소
	           sendmail.setFromAddr(new String(sendName.getBytes("euc-kr"),"8859_1")+"<"+sendEmail+">");

	           //0-받는사람,1-참고,2-숨은참고
	           sendmail.setRecType(0);

	           //메일 방식, 0-텍스트, 1-html
	           sendmail.setMsgType(1);

	           //제목 셋팅
	           sendmail.setSubject(mailTitle);

	           //내용셋팅
	           sendmail.setText(mailContent);
	           //메일 발송
	           sendmail.setFilePath("");
	    	   sendmail.setToAddr(mailVO.getReceiveEmail());
	           sendmail.send();

	       return sendResult;
	       }catch(Exception e){
	       	LOGGER.error( e.getMessage(), e );
	           sendResult = "N";
	           return sendResult;
	       }finally{
	          // if (mailVO.hasFile()) FileUploadUtil.deleteFormFile(mFile, filePath);
	           //메일 전송후 메일 이력 테이블에 저장
	          // insertMailHistory(mailVO, mailTitle, sendEmail, receiveEmail, sendResult, senderMemSeq, receiverMemSeq, mailClass, receiverLessonId);
	       }
	   }
	   
}