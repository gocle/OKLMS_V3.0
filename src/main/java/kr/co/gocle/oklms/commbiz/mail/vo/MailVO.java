package kr.co.gocle.oklms.commbiz.mail.vo;

import java.io.Serializable;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import kr.co.gocle.oklms.comm.util.TextStringUtil;
import kr.co.gocle.oklms.comm.vo.BaseVO;

/**
* VO 클래스에 대한 내용을 작성한다.
* @author 최선호
* @since 2016. 9. 05.
*/
public class MailVO extends BaseVO implements Serializable{

	private static final long serialVersionUID = -3142369806592720520L;
	/**
	* 메일정보 Field
	*/
	private String insertUser = "";
	private String insertDate = "";
	private String sendUser = "";       //보내는 사람 sequence
	private String sendEmail = "";      //보내는 사람 이메일
	private String sendName = "";       //보내는 사람 이름
	private String sendNameEng = "";    //보내는 사람 영문 이름
	private String receiveUser = "";    //받는 사람 sequence
	private String recvEmailSet = "";   //받는 사람 이메일 집합(여러명 동시발송을 위해)
	private String recvMemSeqSet = "";  //받는 사람 시퀀스 집합
	private String receiveEmail = "";   //받는 사람 이메일
	private String receiveName = "";    //받는 사람 이름    
	private String mailTitle = "";      //메일 제목
	private String mailContent = "";    //메일 내용
	private String mailContentText = "";//템플릿적용안된 메일 내용
	private String successYn = "";      //메일 발송 성공 여부
	private String commId = "";         //커뮤니티 아이디
	private String commMemSeq = "";     //커뮤니티 멤버시퀀스
	private int msgType = 0;            //메일보내기 타입(0-text, 1-html)
	private String mailTempType = "";   //메일템플릿타입(join->가입, confirm->승인 등등.. 컨피그에 정의.)
	private String mailForeignYn = "";  //영문메일 or 국문메일
	private String memId = "";          //아이디
	private String memSeq = "";          //아이디
	private String memType = "";        //회원유형
	private String memPassword="";      //패스워드
	private String memName;			 //회원이름
	private String foreignYn = "";      //외국인여부
	private String lecId = "";			//강의아이디
	private String lecName = "";        //강의명
	private String lessonStartDate = "";//수강시작일
	private String lessonEndDate = "";  //수강종료일

	private String periodId = "";       //분반 아이디
	private String classId = "";        //분반 아이디
	private String className= "";       //분반 명
	private String boardName = "";      //게시판 이름

	private String htmlUseYn ="";		//메일 html 적용여부
    private String[] memIds;           //받는사람 고유아이디  
	private String[] memSeqs;           //받는사람 고유번호  
	private String templateId;			//템플릿아이디
	 
	private String lastDate="";			//마감일			
	private String subjectName="";		//교과명
	private String subjectCode;		//교과코드
	private String yyyy;
	private String term;
	private String weekCnt;			//주차
	private String mbtlnum;
	private String emplNo;
	private String email;
	private String hpNo;
	/**
	* 첨부파일정보 Field
	*/
	private ArrayList attachFile = new ArrayList();
	private String filePath = "";       //첨부파일 경로
	private String fileName = "";       //첨부파일 명

	//private ArrayList mailFileList = new ArrayList();  //여러파일 첨부시 사용

	private String imagesPath = EgovProperties.getProperty("Globals.mailtemplate.imagesPath"); 

	//메일 히스토리 추가
	private String historyId;				//이력아이디
	private String[] historyIdArr;			//이력아이디
	private String senderMemSeq;			//발신자회원번호
	private String senderEmail;				//발신자이메일
	private String receiverMemSeq;			//수신자회원번호
	private String receiverEmail;			//수신자이메일
	private String sendSuccessYn;			//발신성공여부
	private String mailClass;				//메일유형
	private String mailClassName;			//메일유형
	private String senderMemName;			//발신자
	private String receiverMemName;			//수신자
	private String receiverMemId;			//수신자아이디
	private String searchMailClass;			//메일유형 검색
	private String searchMailTitle;			//메일제목 검색
	private String searchSenderMemName;		//발신자 검색
	private String searchReceiverMemName;	//수신자 검색
	private String receiverLessonId;		//수신자수강아이디
	private String aspId;		//aspId
	private String aspName;		//aspId
	private String searchAspId;		//aspId

	private String receiveMailYnBypass;		//인증 이메일은 무조건 보내야 하므로 설정 변수

	private String examId = "";				// 자격시험 접수자, 자격증 접수자 메일 발송
	private String qfeType = "";				// 자격시험 : E, 자격증 : C
	private String receiverReferenceId = "";		// 수신자 시험접수 or 자격증접수 아이디
	private String paymentStatus = "";
	private String bgColorNum = "";

	private String trNum;

	private String trSenddate;          //메시지를 전송할 시간, 미래시간을 넣으면 예약 발송
	private String trId;           		//관리번호
	private String trSendstat;          //발송상태 :::::::::::::      '0' = 발송대기, '1' = 전송완료, '2' = 결과수신완료
	private String trRsltstat;          //발송 결과 수신 값
	private String trMsgtype;           //문자 전송형태 '0' = 일반메시지, '1' = 콜백 URL메시지
	private String trPhone;           	//수신할 핸드폰 번호
	private String trCallBack;          //송신할 핸드폰 번호
	private String trCallback;          //송신할 핸드폰 번호
	private String trMsg;           	//전송할 메시지
	private String tFlag;           	//예약문자 전송 여부 0=미사용, 1=사용
	private String trRsltdate;
	private String trModified;
	private String lecNo;          		//공지사항 분반원 핸드폰번호 가져올 변수
	private String classNo;          	//공지사항 분반원 핸드폰번호 가져올 변수
	private String smsFlag;           	//공지사항 분반원 핸드폰번호 가져올 변수
	private String smsType;           	//문자 서비스 타입
	private String trNet;
	private String trEtc1;				//보내는사람 SEQ
	private String trEtc2;				//받는사람 SEQ
	private String trEtc3;				//받는사람 수강아이디(LESSON_ID)
	private String trEtc4;
	private String trEtc5;
	private String trEtc6; 
	private String trClass;
	private String scLogTable ;			//2011년 6월 이후 로그테이블이 월단위로 생김 (ex: "sc_log_201104"형식)
	 
	private String smsContent;
	//검색 필드 
	private String searchCallback;
	private String searchTrPhone;
	private String searchStartDate;
	private String searchEndDate;
	private String receiveMemSeq = "";    //받는 사람 관리번호    
	private String lessonId = "";		//수강아이디
	private String reportId = "";		//과제아이디
	private String smsGroup = "";		//sms그룹
	private String searchScLogTable;	//로그테이블검색
	   
	private String searchCateDepth1 ="";//대분류
	private String searchCateDepth2 ="";//소분류
	   
	private String searchLecId ="";			//강의아이디검색
	private String searchPeriodId ="";		//기수아이디검색
	private String searchClassId="";		//반아이디검색
	private String searchSendName="";		//보낸사람검색
	private String searchReceiveName="";	//받는사람검색
	   
	private String examDate="";	//시험일자
	private String examNo=""; //수험번호
	   
	private String boardDtlId=""; //게시판번호
	private String authGroupId="";

	private String companyId;
	private String traningProcessId;
	private String ccmMemIds;
	private String cotMemIds;
	
	private String batchSeq = "";
	private String repDay = "";
	private String repSmsUseYn = "";
	private String repMailUseYn = "";
	private String disDay = "";
	private String disSmsUseYn = "";
	private String disMailUseYn = "";
	private String tprDay = "";
	private String tprSmsUseYn = "";
	private String tprMailUseYn = "";
	private String useYn = "";
	private String subjectClass = "";
	
	private String repDailyYn = "";
	private String disDailyYn = "";
	private String tprDailyYn = "";
	
	private String submitDay = "";
	private String submitWeek = "";
	private String companyName = "";
	private String sendSeq = "";
	private String sendType = "";
	private String realTypeYn = "";
	private String sendDate = "";
	private String content = "";
	private String sendYn = "";
	private String atchFileId = "";
	private String sendMemSeq = "";
	private String templetType = "";
	private String sendDetailSeq = "";
	private String reciveMemSeq = "";
	private String reciveYn = "";
	private String title = "";
	private String smsTempType = "";
	private String successCnt = "";
	private String failCnt = "";
	private String totCnt = "";
	private String id;
	private String name;
	private String password;
	private String [] sendSeqs;
	
	public String[] getSendSeqs() {
		return sendSeqs;
	}

	public void setSendSeqs(String[] sendSeqs) {
		this.sendSeqs = sendSeqs;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getTotCnt() {
		return totCnt;
	}

	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
	}

	public String getSuccessCnt() {
		return successCnt;
	}

	public void setSuccessCnt(String successCnt) {
		this.successCnt = successCnt;
	}

	public String getFailCnt() {
		return failCnt;
	}

	public void setFailCnt(String failCnt) {
		this.failCnt = failCnt;
	}
	
	public String getSmsTempType() {
		return smsTempType;
	}

	public void setSmsTempType(String smsTempType) {
		this.smsTempType = smsTempType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSendYn() {
		return sendYn;
	}

	public void setSendYn(String sendYn) {
		this.sendYn = sendYn;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getSendMemSeq() {
		return sendMemSeq;
	}

	public void setSendMemSeq(String sendMemSeq) {
		this.sendMemSeq = sendMemSeq;
	}

	public String getTempletType() {
		return templetType;
	}

	public void setTempletType(String templetType) {
		this.templetType = templetType;
	}

	public String getSendDetailSeq() {
		return sendDetailSeq;
	}

	public void setSendDetailSeq(String sendDetailSeq) {
		this.sendDetailSeq = sendDetailSeq;
	}

	public String getReciveMemSeq() {
		return reciveMemSeq;
	}

	public void setReciveMemSeq(String reciveMemSeq) {
		this.reciveMemSeq = reciveMemSeq;
	}

	public String getReciveYn() {
		return reciveYn;
	}

	public void setReciveYn(String reciveYn) {
		this.reciveYn = reciveYn;
	}
	
	public String getSendSeq() {
		return sendSeq;
	}

	public void setSendSeq(String sendSeq) {
		this.sendSeq = sendSeq;
	}

	public String getSendType() {
		return sendType;
	}

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}

	public String getRealTypeYn() {
		return realTypeYn;
	}

	public void setRealTypeYn(String realTypeYn) {
		this.realTypeYn = realTypeYn;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getSubmitDay() {
		return submitDay;
	}
	
	public void setSubmitDay(String submitDay) {
		this.submitDay = submitDay;
	}
	
	public String getSubmitWeek() {
		return submitWeek;
	}
	
	public void setSubmitWeek(String submitWeek) {
		this.submitWeek = submitWeek;
	}
	
	public String getRepDailyYn() {
		return repDailyYn;
	}
	public void setRepDailyYn(String repDailyYn) {
		this.repDailyYn = repDailyYn;
	}
	public String getDisDailyYn() {
		return disDailyYn;
	}
	public void setDisDailyYn(String disDailyYn) {
		this.disDailyYn = disDailyYn;
	}
	public String getTprDailyYn() {
		return tprDailyYn;
	}
	public void setTprDailyYn(String tprDailyYn) {
		this.tprDailyYn = tprDailyYn;
	}
	
	public String getSubjectClass() {
		return subjectClass;
	}
	public void setSubjectClass(String subjectClass) {
		this.subjectClass = subjectClass;
	}
	public String getBatchSeq() {
		return batchSeq;
	}
	public void setBatchSeq(String batchSeq) {
		this.batchSeq = batchSeq;
	}
	public String getRepDay() {
		return repDay;
	}
	public void setRepDay(String repDay) {
		this.repDay = repDay;
	}
	
	public String getRepSmsUseYn() {
		return repSmsUseYn;
	}
	public void setRepSmsUseYn(String repSmsUseYn) {
		this.repSmsUseYn = repSmsUseYn;
	}
	public String getRepMailUseYn() {
		return repMailUseYn;
	}
	public void setRepMailUseYn(String repMailUseYn) {
		this.repMailUseYn = repMailUseYn;
	}
	
	public String getDisDay() {
		return disDay;
	}
	public void setDisDay(String disDay) {
		this.disDay = disDay;
	}
	public String getDisSmsUseYn() {
		return disSmsUseYn;
	}
	public void setDisSmsUseYn(String disSmsUseYn) {
		this.disSmsUseYn = disSmsUseYn;
	}
	public String getDisMailUseYn() {
		return disMailUseYn;
	}
	public void setDisMailUseYn(String disMailUseYn) {
		this.disMailUseYn = disMailUseYn;
	}
	
	public String getTprDay() {
		return tprDay;
	}
	public void setTprDay(String tprDay) {
		this.tprDay = tprDay;
	}
	public String getTprSmsUseYn() {
		return tprSmsUseYn;
	}
	public void setTprSmsUseYn(String tprSmsUseYn) {
		this.tprSmsUseYn = tprSmsUseYn;
	}
	public String getTprMailUseYn() {
		return tprMailUseYn;
	}
	public void setTprMailUseYn(String tprMailUseYn) {
		this.tprMailUseYn = tprMailUseYn;
	}
	
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getTrCallback() {
		return trCallback;
	}
	public void setTrCallback(String trCallback) {
		this.trCallback = trCallback;
	}
	public String getCcmMemIds() {
		return ccmMemIds;
	}
	public void setCcmMemIds(String ccmMemIds) {
		this.ccmMemIds = ccmMemIds;
	}
	public String getCotMemIds() {
		return cotMemIds;
	}
	public void setCotMemIds(String cotMemIds) {
		this.cotMemIds = cotMemIds;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getTraningProcessId() {
		return traningProcessId;
	}
	public void setTraningProcessId(String traningProcessId) {
		this.traningProcessId = traningProcessId;
	}
	public String getSmsContent() {
		return smsContent;
	}
	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getTrClass() {
		return trClass;
	}
	public void setTrClass(String trClass) {
		this.trClass = trClass;
	}
	public String getTrCallBack() {
		return trCallBack;
	}
	public void setTrCallBack(String trCallBack) {
		this.trCallBack = trCallBack;
	}
	//SMS엑셀보내기
	private MultipartFile uploadFile; // 업로드 회원 파일
	private long uploadSize = 1024 * 200; // 파일 업로드 사이즈

	private String receiverHp = "";			// 수신자 핸드폰 번호
	private String returnUrlGubun = "";			// returnUrlGubun
	
    public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getYyyy() {
		return yyyy;
	}
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public String getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	public String[] getMemIds() {
		return memIds;
	}
	public void setMemIds(String[] memIds) {
		this.memIds = memIds;
	}
	public String getInsertUser() {
		return insertUser;
	}
	public void setInsertUser(String insertUser) {
		this.insertUser = insertUser;
	}
	
	public String getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
	}
   
	public String getMbtlnum() {
		return mbtlnum;
	}
	public void setMbtlnum(String mbtlnum) {
		this.mbtlnum = mbtlnum;
	}
	
	public String getEmplNo() {
		return emplNo;
	}
	public void setEmplNo(String emplNo) {
		this.emplNo = emplNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the receiverLessonId
	 */
	public String getReceiverLessonId() {
		return receiverLessonId;
	}
	/**
	 * @param receiverLessonId the receiverLessonId to set
	 */
	public void setReceiverLessonId(String receiverLessonId) {
		this.receiverLessonId = receiverLessonId;
	}
	/**
	 * @return the mailClass
	 */
	public String getMailClass() {
		return mailClass;
	}
	/**
	 * @param mailClass the mailClass to set
	 */
	public void setMailClass(String mailClass) {
		this.mailClass = mailClass;
	}
	/***************************************************************************
    * ETC
    **************************************************************************/
   /**
    * 첨부파일 존재 여부
    */
   public boolean hasFileA() {
       //return attachFile != null && attachFile != "";
       return attachFile != null ;
   }
   public boolean hasFile() {
       boolean hasFile = false;
       if( attachFile != null && attachFile.size() > 0 ) {           
           if( attachFile.get(0) instanceof MultipartFile ) {
               hasFile = !( (MultipartFile)attachFile.get(0) ).isEmpty();
           }
           hasFile = true;
       }

       return hasFile;
   }
   
   /***************************************************************************
    * GETTER & SETTER
    **************************************************************************/
   /**
    * @return the fileName
    */
   public String getFileName() {
       return fileName;
   }
   /**
    * @param fileName the fileName to set
    */
   public void setFileName(String fileName) {
       this.fileName = fileName;
   }
   /**
    * @return the filePath
    */
   public String getFilePath() {
       return filePath;
   }
   /**
    * @param filePath the filePath to set
    */
   public void setFilePath(String filePath) {
       this.filePath = filePath;
   }   
   /**
    * @return the mailContent
    */
   public String getMailContent() {
       return mailContent;
   }   
   /**
    * @return the mailContent
    */
   public String getMailContentAsHtml() {
       return TextStringUtil.getHtmlString(mailContent);
   }
   /**
    * @param mailContent the mailContent to set
    */
   public void setMailContent(String mailContent) {
       this.mailContent = mailContent;
   }
   /**
    * @return the mailTitle
    */
   public String getMailTitle() {
       return mailTitle;
   }
   /**
    * @param mailTitle the mailTitle to set
    */
   public void setMailTitle(String mailTitle) {
       this.mailTitle = mailTitle;
   }
   /**
    * @return the receiveEmail
    */
   public String getReceiveEmail() {
       return receiveEmail;
   }
   /**
    * @param receiveEmail the receiveEmail to set
    */
   public void setReceiveEmail(String receiveEmail) {
       this.receiveEmail = receiveEmail;
   }
   /**
    * @return the receiveName
    */
   public String getReceiveName() {
       return receiveName;
   }
   /**
    * @param receiveName the receiveName to set
    */
   public void setReceiveName(String receiveName) {
       this.receiveName = receiveName;
   }
   /**
    * @return the receiveUser
    */
   public String getReceiveUser() {
       return receiveUser;
   }
   /**
    * @param receiveUser the receiveUser to set
    */
   public void setReceiveUser(String receiveUser) {
       this.receiveUser = receiveUser;
   }
   /**
    * @return the sendEmail
    */
   public String getSendEmail() {
       return sendEmail;
   }
   /**
    * @param sendEmail the sendEmail to set
    */
   public void setSendEmail(String sendEmail) {
       this.sendEmail = sendEmail;
   }
   /**
    * @return the sendName
    */
   public String getSendName() {
       return sendName;
   }
   /**
    * @param sendName the sendName to set
    */
   public void setSendName(String sendName) {
       this.sendName = sendName;
   }
   /**
    * @return the sendUser
    */
   public String getSendUser() {
       return sendUser;
   }
   /**
    * @param sendUser the sendUser to set
    */
   public void setSendUser(String sendUser) {
       this.sendUser = sendUser;
   }
   /**
    * @return the successYn
    */
   public String getSuccessYn() {
       return successYn;
   }
   /**
    * @param successYn the successYn to set
    */
   public void setSuccessYn(String successYn) {
       this.successYn = successYn;
   }
   /**
    * @return the recvEmailSet
    */
   public String getRecvEmailSet() {
       return recvEmailSet;
   }
   /**
    * @param recvEmailSet the recvEmailSet to set
    */
   public void setRecvEmailSet(String recvEmailSet) {
       this.recvEmailSet = recvEmailSet;
   }
   /**
    * @return the classId
    */
   public String getClassId() {
       return classId;
   }
   /**
    * @param classId the classId to set
    */
   public void setClassId(String classId) {
       this.classId = classId;
   }
   /**
    * @return the periodId
    */
   public String getPeriodId() {
       return periodId;
   }
   /**
    * @param periodId the periodId to set
    */
   public void setPeriodId(String periodId) {
       this.periodId = periodId;
   }

   /**
    * @return the commId
    */
   public String getCommId() {
       return commId;
   }

   /**
    * @param commId the commId to set
    */
   public void setCommId(String commId) {
       this.commId = commId;
   }

   /**
    * @return the commMemSeq
    */
   public String getCommMemSeq() {
       return commMemSeq;
   }

   /**
    * @param commMemSeq the commMemSeq to set
    */
   public void setCommMemSeq(String commMemSeq) {
       this.commMemSeq = commMemSeq;
   }

   /**
    * @return the msgType
    */
   public int getMsgType() {
       return msgType;
   }

   /**
    * @param msgType the msgType to set
    */
   public void setMsgType(int msgType) {
       this.msgType = msgType;
   }

   /**
    * @return the mailTempType
    */
   public String getMailTempType() {
       return mailTempType;
   }

   /**
    * @param mailTempType the mailTempType to set
    */
   public void setMailTempType(String mailTempType) {
       this.mailTempType = mailTempType;
   }
   /**
    * @return the mailForeignYn
    */
   public String getMailForeignYn() {
       return mailForeignYn;
   }

   /**
    * @param mailForeignYn the mailForeignYn to set
    */
   public void setMailForeignYn(String mailForeignYn) {
       this.mailForeignYn = mailForeignYn;
   }
   /**
    * @return the memId
    */
   public String getMemId() {
       return memId;
   }

   /**
    * @param memId the memId to set
    */
   public void setMemId(String memId) {
       this.memId = memId;
   }

   /**
    * @return the memPassword
    */
   public String getMemPassword() {
       return memPassword;
   }

   /**
    * @param memPassword the memPassword to set
    */
   public void setMemPassword(String memPassword) {
       this.memPassword = memPassword;
   }
   /**
    * @return the foreignYn
    */
   public String getForeignYn() {
       return foreignYn;
   }

   /**
    * @param foreignYn the foreignYn to set
    */
   public void setForeignYn(String foreignYn) {
       this.foreignYn = foreignYn;
   }
   
   /**
    * @return the lecName
    */
   public String getLecName() {
       return lecName;
   }

   /**
    * @param lecName the lecName to set
    */
   public void setLecName(String lecName) {
       this.lecName = lecName;
   }

   /**
    * @return the lessonEndDate
    */
   public String getLessonEndDate() {
       return lessonEndDate;
   }

   /**
    * @param lessonEndDate the lessonEndDate to set
    */
   public void setLessonEndDate(String lessonEndDate) {
       this.lessonEndDate = lessonEndDate;
   }

   /**
    * @return the lessonStartDate
    */
   public String getLessonStartDate() {
       return lessonStartDate;
   }

   /**
    * @param lessonStartDate the lessonStartDate to set
    */
   public void setLessonStartDate(String lessonStartDate) {
       this.lessonStartDate = lessonStartDate;
   }

   /**
    * @return the sendNameEng
    */
   public String getSendNameEng() {
       return sendNameEng;
   }

   /**
    * @param sendNameEng the sendNameEng to set
    */
   public void setSendNameEng(String sendNameEng) {
       this.sendNameEng = sendNameEng;
   }

   /**
    * @return the boardName
    */
   public String getBoardName() {
       return boardName;
   }

   /**
    * @param boardName the boardName to set
    */
   public void setBoardName(String boardName) {
       this.boardName = boardName;
   }
   /**
    * @return the attachFile
    */
   public ArrayList getAttachFile() {
       return attachFile;
   }
   /**
    * @param attachFile the attachFile to set
    */
   public void setAttachFile(ArrayList attachFile) {
       this.attachFile = attachFile;
   }
   /**
    * @return the memType
    */
   public String getMemType() {
       return memType;
   }
   /**
    * @param memType the memType to set
    */
   public void setMemType(String memType) {
       this.memType = memType;
   }
   /**
    * @return the memSeqs
    */
   public String[] getMemSeqs() {
           return memSeqs;
   }
   /**
    * @param memSeqs the memSeqs to set
    */
   public void setMemSeqs(String[] memSeqs) {
           this.memSeqs = memSeqs;
   }
	/**
	 * @return the historyId
	 */
	public String getHistoryId() {
		return historyId;
	}
	/**
	 * @param historyId the historyId to set
	 */
	public void setHistoryId(String historyId) {
		this.historyId = historyId;
	}
	/**
	 * @return the receiverEmail
	 */
	public String getReceiverEmail() {
		return receiverEmail;
	}
	/**
	 * @param receiverEmail the receiverEmail to set
	 */
	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}
	/**
	 * @return the receiverMemSeq
	 */
	public String getReceiverMemSeq() {
		return receiverMemSeq;
	}
	/**
	 * @param receiverMemSeq the receiverMemSeq to set
	 */
	public void setReceiverMemSeq(String receiverMemSeq) {
		this.receiverMemSeq = receiverMemSeq;
	}
	/**
	 * @return the senderEmail
	 */
	public String getSenderEmail() {
		return senderEmail;
	}
	/**
	 * @param senderEmail the senderEmail to set
	 */
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	/**
	 * @return the senderMemSeq
	 */
	public String getSenderMemSeq() {
		return senderMemSeq;
	}
	/**
	 * @param senderMemSeq the senderMemSeq to set
	 */
	public void setSenderMemSeq(String senderMemSeq) {
		this.senderMemSeq = senderMemSeq;
	}
	/**
	 * @return the sendSuccessYn
	 */
	public String getSendSuccessYn() {
		return sendSuccessYn;
	}
	/**
	 * @param sendSuccessYn the sendSuccessYn to set
	 */
	public void setSendSuccessYn(String sendSuccessYn) {
		this.sendSuccessYn = sendSuccessYn;
	}
	/**
	 * @return the recvMemSeqSet
	 */
	public String getRecvMemSeqSet() {
		return recvMemSeqSet;
	}
	/**
	 * @param recvMemSeqSet the recvMemSeqSet to set
	 */
	public void setRecvMemSeqSet(String recvMemSeqSet) {
		this.recvMemSeqSet = recvMemSeqSet;
	}
	/**
	 * @return the mailClassName
	 */
	public String getMailClassName() {
		return mailClassName;
	}
	/**
	 * @param mailClassName the mailClassName to set
	 */
	public void setMailClassName(String mailClassName) {
		this.mailClassName = mailClassName;
	}
	/**
	 * @return the receiverMemName
	 */
	public String getReceiverMemName() {
		return receiverMemName;
	}
	/**
	 * @param receiverMemName the receiverMemName to set
	 */
	public void setReceiverMemName(String receiverMemName) {
		this.receiverMemName = receiverMemName;
	}
	/**
	 * @return the senderMemName
	 */
	public String getSenderMemName() {
		return senderMemName;
	}
	/**
	 * @param senderMemName the senderMemName to set
	 */
	public void setSenderMemName(String senderMemName) {
		this.senderMemName = senderMemName;
	}
	/**
	 * @return the historyIdArr
	 */
	public String[] getHistoryIdArr() {
		return historyIdArr;
	}
	/**
	 * @param historyIdArr the historyIdArr to set
	 */
	public void setHistoryIdArr(String[] historyIdArr) {
		this.historyIdArr = historyIdArr;
	}
	/**
	 * @return the searchMailClass
	 */
	public String getSearchMailClass() {
		return searchMailClass;
	}
	/**
	 * @param searchMailClass the searchMailClass to set
	 */
	public void setSearchMailClass(String searchMailClass) {
		this.searchMailClass = searchMailClass;
	}
	/**
	 * @return the searchMailTitle
	 */
	public String getSearchMailTitle() {
		return searchMailTitle;
	}
	/**
	 * @param searchMailTitle the searchMailTitle to set
	 */
	public void setSearchMailTitle(String searchMailTitle) {
		this.searchMailTitle = searchMailTitle;
	}
	/**
	 * @return the searchReceiverMemName
	 */
	public String getSearchReceiverMemName() {
		return searchReceiverMemName;
	}
	/**
	 * @param searchReceiverMemName the searchReceiverMemName to set
	 */
	public void setSearchReceiverMemName(String searchReceiverMemName) {
		this.searchReceiverMemName = searchReceiverMemName;
	}
	/**
	 * @return the searchSenderMemName
	 */
	public String getSearchSenderMemName() {
		return searchSenderMemName;
	}
	/**
	 * @param searchSenderMemName the searchSenderMemName to set
	 */
	public void setSearchSenderMemName(String searchSenderMemName) {
		this.searchSenderMemName = searchSenderMemName;
	}
	/**
	 * @return the mailContentText
	 */
	public String getMailContentText() {
		return mailContentText;
	}
	/**
	 * @param mailContentText the mailContentText to set
	 */
	public void setMailContentText(String mailContentText) {
		this.mailContentText = mailContentText;
	}
	/**
	 * @return the lecId
	 */
	public String getLecId() {
		return lecId;
	}
	/**
	 * @param lecId the lecId to set
	 */
	public void setLecId(String lecId) {
		this.lecId = lecId;
	}
	/**
	 * @return the receiverMemId
	 */
	public String getReceiverMemId() {
		return receiverMemId;
	}
	/**
	 * @param receiverMemId the receiverMemId to set
	 */
	public void setReceiverMemId(String receiverMemId) {
		this.receiverMemId = receiverMemId;
	}
	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}
	/**
	 * @param className the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
	}
	/**
	 * @return the htmlUseYn
	 */
	public String getHtmlUseYn() {
		return htmlUseYn;
	}
	/**
	 * @param htmlUseYn the htmlUseYn to set
	 */
	public void setHtmlUseYn(String htmlUseYn) {
		this.htmlUseYn = htmlUseYn;
	}
	/**
	 * @return the aspId
	 */
	public String getAspId() {
		return aspId;
	}
	/**
	 * @param aspId the aspId to set
	 */
	public void setAspId(String aspId) {
		this.aspId = aspId;
	}
	/**
	 * @return the aspName
	 */
	public String getAspName() {
		return aspName;
	}
	/**
	 * @param aspName the aspName to set
	 */
	public void setAspName(String aspName) {
		this.aspName = aspName;
	}
	/**
	 * @return the searchAspId
	 */
	public String getSearchAspId() {
		return searchAspId;
	}
	/**
	 * @param searchAspId the searchAspId to set
	 */
	public void setSearchAspId(String searchAspId) {
		this.searchAspId = searchAspId;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	/**
	 * @return the receiveMailYnBypass
	 */
	public String getReceiveMailYnBypass() {
		return receiveMailYnBypass;
	}
	/**
	 * @param receiveMailYnBypass the receiveMailYnBypass to set
	 */
	public void setReceiveMailYnBypass(String receiveMailYnBypass) {
		this.receiveMailYnBypass = receiveMailYnBypass;
	}
	/**
	 * @return the examId
	 */
	public String getExamId() {
		return examId;
	}
	/**
	 * @param examId the examId to set
	 */
	public void setExamId(String examId) {
		this.examId = examId;
	}
	/**
	 * @return the receiverReferenceId
	 */
	public String getReceiverReferenceId() {
		return receiverReferenceId;
	}
	/**
	 * @param receiverReferenceId the receiverReferenceId to set
	 */
	public void setReceiverReferenceId(String receiverReferenceId) {
		this.receiverReferenceId = receiverReferenceId;
	}
	/**
	 * @return the qfeType
	 */
	public String getQfeType() {
		return qfeType;
	}
	/**
	 * @param qfeType the qfeType to set
	 */
	public void setQfeType(String qfeType) {
		this.qfeType = qfeType;
	}
	/**
	 * @return the paymentStatus
	 */
	public String getPaymentStatus() {
		return paymentStatus;
	}
	/**
	 * @param paymentStatus the paymentStatus to set
	 */
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	
	public String getBgColorNum() {
			return bgColorNum;
	}
	public void setBgColorNum(String bgColorNum) {
		this.bgColorNum = bgColorNum;
	}
	
	public String getImagesPath() {
		return imagesPath;
	}
	public void setImagesPath(String imagesPath) {
		this.imagesPath = imagesPath;
	}
	public String getTrNum() {
		return trNum;
	}
	public void setTrNum(String trNum) {
		this.trNum = trNum;
	}
	public String getTrSenddate() {
		return trSenddate;
	}
	public void setTrSenddate(String trSenddate) {
		this.trSenddate = trSenddate;
	}
	public String getTrId() {
		return trId;
	}
	public void setTrId(String trId) {
		this.trId = trId;
	}
	public String getTrSendstat() {
		return trSendstat;
	}
	public void setTrSendstat(String trSendstat) {
		this.trSendstat = trSendstat;
	}
	public String getTrRsltstat() {
		return trRsltstat;
	}
	public void setTrRsltstat(String trRsltstat) {
		this.trRsltstat = trRsltstat;
	}
	public String getTrMsgtype() {
		return trMsgtype;
	}
	public void setTrMsgtype(String trMsgtype) {
		this.trMsgtype = trMsgtype;
	}
	public String getTrPhone() {
		return trPhone;
	}
	public void setTrPhone(String trPhone) {
		this.trPhone = trPhone;
	}
 
	public String getTrMsg() {
		return trMsg;
	}
	public void setTrMsg(String trMsg) {
		this.trMsg = trMsg;
	}
	public String gettFlag() {
		return tFlag;
	}
	public void settFlag(String tFlag) {
		this.tFlag = tFlag;
	}
	public String getTrRsltdate() {
		return trRsltdate;
	}
	public void setTrRsltdate(String trRsltdate) {
		this.trRsltdate = trRsltdate;
	}
	public String getTrModified() {
		return trModified;
	}
	public void setTrModified(String trModified) {
		this.trModified = trModified;
	}
	public String getLecNo() {
		return lecNo;
	}
	public void setLecNo(String lecNo) {
		this.lecNo = lecNo;
	}
	public String getClassNo() {
		return classNo;
	}
	public void setClassNo(String classNo) {
		this.classNo = classNo;
	}
	public String getSmsFlag() {
		return smsFlag;
	}
	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}
	public String getSmsType() {
		return smsType;
	}
	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}
	public String getTrNet() {
		return trNet;
	}
	public void setTrNet(String trNet) {
		this.trNet = trNet;
	}
	public String getTrEtc1() {
		return trEtc1;
	}
	public void setTrEtc1(String trEtc1) {
		this.trEtc1 = trEtc1;
	}
	public String getTrEtc2() {
		return trEtc2;
	}
	public void setTrEtc2(String trEtc2) {
		this.trEtc2 = trEtc2;
	}
	public String getTrEtc3() {
		return trEtc3;
	}
	public void setTrEtc3(String trEtc3) {
		this.trEtc3 = trEtc3;
	}
	public String getTrEtc4() {
		return trEtc4;
	}
	public void setTrEtc4(String trEtc4) {
		this.trEtc4 = trEtc4;
	}
	public String getTrEtc5() {
		return trEtc5;
	}
	public void setTrEtc5(String trEtc5) {
		this.trEtc5 = trEtc5;
	}
	public String getTrEtc6() {
		return trEtc6;
	}
	public void setTrEtc6(String trEtc6) {
		this.trEtc6 = trEtc6;
	}
	public String getScLogTable() {
		return scLogTable;
	}
	public void setScLogTable(String scLogTable) {
		this.scLogTable = scLogTable;
	}
	public String getSearchCallback() {
		return searchCallback;
	}
	public void setSearchCallback(String searchCallback) {
		this.searchCallback = searchCallback;
	}
	public String getSearchTrPhone() {
		return searchTrPhone;
	}
	public void setSearchTrPhone(String searchTrPhone) {
		this.searchTrPhone = searchTrPhone;
	}
	public String getSearchStartDate() {
		return searchStartDate;
	}
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	public String getReceiveMemSeq() {
		return receiveMemSeq;
	}
	public void setReceiveMemSeq(String receiveMemSeq) {
		this.receiveMemSeq = receiveMemSeq;
	}
	public String getLessonId() {
		return lessonId;
	}
	public void setLessonId(String lessonId) {
		this.lessonId = lessonId;
	}
	public String getReportId() {
		return reportId;
	}
	public void setReportId(String reportId) {
		this.reportId = reportId;
	}
	public String getSmsGroup() {
		return smsGroup;
	}
	public void setSmsGroup(String smsGroup) {
		this.smsGroup = smsGroup;
	}
	public String getSearchScLogTable() {
		return searchScLogTable;
	}
	public void setSearchScLogTable(String searchScLogTable) {
		this.searchScLogTable = searchScLogTable;
	}
	public String getSearchCateDepth1() {
		return searchCateDepth1;
	}
	public void setSearchCateDepth1(String searchCateDepth1) {
		this.searchCateDepth1 = searchCateDepth1;
	}
	public String getSearchCateDepth2() {
		return searchCateDepth2;
	}
	public void setSearchCateDepth2(String searchCateDepth2) {
		this.searchCateDepth2 = searchCateDepth2;
	}
	public String getSearchLecId() {
		return searchLecId;
	}
	public void setSearchLecId(String searchLecId) {
		this.searchLecId = searchLecId;
	}
	public String getSearchPeriodId() {
		return searchPeriodId;
	}
	public void setSearchPeriodId(String searchPeriodId) {
		this.searchPeriodId = searchPeriodId;
	}
	public String getSearchClassId() {
		return searchClassId;
	}
	public void setSearchClassId(String searchClassId) {
		this.searchClassId = searchClassId;
	}
	public String getSearchSendName() {
		return searchSendName;
	}
	public void setSearchSendName(String searchSendName) {
		this.searchSendName = searchSendName;
	}
	public String getSearchReceiveName() {
		return searchReceiveName;
	}
	public void setSearchReceiveName(String searchReceiveName) {
		this.searchReceiveName = searchReceiveName;
	}
	public String getExamDate() {
		return examDate;
	}
	public void setExamDate(String examDate) {
		this.examDate = examDate;
	}
	public String getExamNo() {
		return examNo;
	}
	public void setExamNo(String examNo) {
		this.examNo = examNo;
	}
	public String getBoardDtlId() {
		return boardDtlId;
	}
	public void setBoardDtlId(String boardDtlId) {
		this.boardDtlId = boardDtlId;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public long getUploadSize() {
		return uploadSize;
	}
	public void setUploadSize(long uploadSize) {
		this.uploadSize = uploadSize;
	}
	public String getReceiverHp() {
		return receiverHp;
	}
	public void setReceiverHp(String receiverHp) {
		this.receiverHp = receiverHp;
	}
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}
	public String getReturnUrlGubun() {
		return returnUrlGubun;
	}
	public void setReturnUrlGubun(String returnUrlGubun) {
		this.returnUrlGubun = returnUrlGubun;
	}
 
	/**
	* @return the mailContent
	*/
	public String getMailContentTemplate() {

	       String returnVal="";
	       
	       if (!"".equals(mailTempType)) {
	    	   
		       if ("reportContent".equals(mailTempType) ) {
		           
		               return getReportContent();  
		         
		       } else if ("termContent".equals(mailTempType)) { 
		    	   
		          		return getTermContent();                	
		 
		       }else if("discussContent".equals(mailTempType)) {
		    	   
		               return getDiscussContent();
		               
		       }else if("workcertContent".equals(mailTempType)) {
		    	   
	               return getWorkcertContent();
	               
		       }else if("onlineContent".equals(mailTempType)) {
		    	   
	               return getOnlineContent();
	               
		       }else if("activityContent".equals(mailTempType)) {
		    	   
	               return getActivityContent();
	               
		       }
	       }
	       
	       return returnVal;
	}
	/**
	* @return the smsContent
	*/
	public String getSmsContentTemplate() {

	       String returnVal=trMsg;
	       
	       if (!"".equals(mailTempType)) {
	    	   
		       if ("reportContent".equals(mailTempType) ) {
		           
		               return getReportSmsContent();  
		         
		       } else if ("termContent".equals(mailTempType)) { 
		    	   
		          		return getTermSmsContent();                	
		 
		       }else if("discussContent".equals(mailTempType)) {
		    	   
		               return getDiscussSmsContent();
		               
		       }else if("workcertContent".equals(mailTempType)) {
		    	   
	               return getWorkcertSmsContent();
	               
		       }else if("onlineContent".equals(mailTempType)) {
		    	   
	               return getOnlineSmsContent();
	               
		       }else if("activityContent".equals(mailTempType)) {
		    	   
	               return getActivitySmsContent();
	               
		       }
	       }
	       
	       return returnVal;
	}	
	/**
	* 과제 제출 메일
	* @return
	*/
	public String getReportContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append(" 안녕하세요 "+ receiveName+" 님   \n");
	   sbQuery.append(subjectName+" 의 "+ weekCnt +"주차 과제물 제출시 유의사항입니다.  \n");
	   sbQuery.append("첨부파일을 참조하여 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.  \n");	   
	   
       return sbQuery.toString();
	}
	/**
	* 팀프로젝트 제출 메일
	* @return
	*/
	public String getTermContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append(" 안녕하세요 "+ receiveName+" 님   \n");
	   sbQuery.append(subjectName+" 의 팀프로젝트 제출시 유의사항입니다.  \n");
	   sbQuery.append("첨부파일을 참조하여 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.  \n");	   
	   
       return sbQuery.toString();
	}
	/**
	* 토론 참여 메일
	* @return
	*/
	public String getDiscussContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append(" 안녕하세요 "+ receiveName+" 님   \n");
	   sbQuery.append(subjectName+" 의  토론은  \n");
	   sbQuery.append(" "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.  \n");	   
	   
       return sbQuery.toString();
	}
	/**
	* 재직증빙서류 제출 메일
	* @return
	*/
	public String getWorkcertContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append(" 안녕하세요 "+ receiveName+" 님   \n"); 
	   sbQuery.append("이번 학기 재직증빙서류 마감일은 "+lastDate+"입니다. 꼭 제출하여 주시기 바랍니다. 감사합니다.  \n");	   
	   
       return sbQuery.toString();
	}
	/**
	* 온라인교과 제출 메일
	* @return
	*/
	public String getOnlineContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append(" 안녕하세요 "+ receiveName+" 님   \n");
	   sbQuery.append(subjectName+" 의 "+ weekCnt +"주차 온라인교과는  \n");
	   sbQuery.append("  "+lastDate+"까지 꼭 수강하여 주시기 바랍니다. 감사합니다.  \n");	   
	   
       return sbQuery.toString();
	}
	/**
	* 학습활동서 작성 메일
	* @return
	*/
	public String getActivityContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append(" 안녕하세요 "+ receiveName+" 님   \n");
	   sbQuery.append(subjectName+" 의 "+ weekCnt +"주차 학습활동서는  \n");
	   sbQuery.append("  "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.  \n");	   
	   
       return sbQuery.toString();
	}	 
	
	/**
	* 과제 제출 문자
	* @return
	*/
	public String getReportSmsContent(){
		
	   StringBuffer sbQuery = new StringBuffer(); 
	   	   
	   if(subjectName!=null && !subjectName.equals("")){
		   sbQuery.append(subjectName+" 의 "+ weekCnt +"주차 과제는 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.");
	   }else{
		   sbQuery.append(weekCnt +"주차 과제는 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.");
	   }	   
       return sbQuery.toString();
	}
	/**
	* 팀프로젝트 제출 문자
	* @return
	*/
	public String getTermSmsContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   	   
	   if(subjectName!=null && !subjectName.equals("")){
		   sbQuery.append(subjectName+" 의 팀프로젝트는 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.");
	   }else{
		   sbQuery.append( "팀프로젝트는 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.");
	   }
       return sbQuery.toString();
	}
	/**
	* 토론 참여 문자
	* @return
	*/
	public String getDiscussSmsContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   	   
	   if(subjectName!=null && !subjectName.equals("")){
		   sbQuery.append(subjectName+" 의  토론은 "+lastDate+"까지 꼭 참여하여 주시기 바랍니다. 감사합니다.");
	   }else{
		   sbQuery.append("토론은 "+lastDate+"까지 꼭 참여하여 주시기 바랍니다. 감사합니다."); 
	   }
       return sbQuery.toString();
	}
	/**
	* 재직증빙서류 제출 문자
	* @return
	*/
	public String getWorkcertSmsContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   sbQuery.append("이번 학기 재직증빙서류 마감일은 "+lastDate+"입니다.꼭 기간 내 제출 바랍니다. 감사합니다.");	   
	   
       return sbQuery.toString();
	}
	/**
	* 온라인교과 제출 문자
	* @return
	*/
	public String getOnlineSmsContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   if(subjectName!=null && !subjectName.equals("")){
		   sbQuery.append(subjectName+" 의 "+ weekCnt +"주차 온라인교과는 "+lastDate+"까지 꼭 수강하여 주시기 바랍니다. 감사합니다.");		   
	   }else{
		   sbQuery.append( weekCnt +"주차 온라인교과는 "+lastDate+"까지 꼭 수강하여 주시기 바랍니다. 감사합니다.");
	   }

       return sbQuery.toString();
	}
	/**
	* 학습활동서 작성 문자
	* @return
	*/
	public String getActivitySmsContent(){
		
	   StringBuffer sbQuery = new StringBuffer();
	   if(subjectName!=null && !subjectName.equals("")){
		   sbQuery.append(subjectName+" 의 "+ weekCnt +"주차 학습활동서는 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.");   
	   }else{
		   sbQuery.append( weekCnt +"주차 학습활동서는 "+lastDate+"까지 꼭 제출하여 주시기 바랍니다. 감사합니다.");
	   }	   	   
	   
       return sbQuery.toString();
	}
	
	public String getMailPasswordContent() {
		
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.append("<div style='border: 1px solid #dddddd; background-color: #ffffff; width: 650px; height: auto; position: relative;'>");
		sbQuery.append("	<div style='padding: 0 20px 20px; text-align: center;'>");
		sbQuery.append("		<p style='padding: 0 20px; font-size: 26px; color: #000000; margin-top: 40px; margin-bottom: 18px; font-weight: bold; text-align: center;'>");
		sbQuery.append("			<font style='vertical-align: inherit;'><font style='vertical-align: inherit;'>임시 비밀번호 안내</font></font>");
		sbQuery.append("		</p>");
		sbQuery.append("		<p style='padding: 0 28px; font-size: 17px; text-align: left;'>");
		sbQuery.append("			<font style='vertical-align: inherit;'>"+name+"님의 비밀번호를 안내드립니다.</font>");
		sbQuery.append("		</p>");
		sbQuery.append("		<hr noshade=''>");
		sbQuery.append("		<p style='padding: 0 28px; font-size: 17px; text-align: left;'>");
		sbQuery.append("			<ul>");
		sbQuery.append("				<li style='text-align: left;'>아이디 : "+id+"</li>");
		sbQuery.append("				<li style='text-align: left;'>이름 : "+name+"</li>");
		sbQuery.append("				<li style='text-align: left;'>이메일 주소 : "+email+"</li>");
		sbQuery.append("				<li style='text-align: left;'>비밀번호 : <span style='color:red'>"+password+"</span></li>");
		sbQuery.append("			</ul>");
		sbQuery.append("		</p>");
		sbQuery.append("		<hr noshade=''>");
		return sbQuery.toString();
	}
}
