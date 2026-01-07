package kr.co.gocle.oklms.commbiz.outmember.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.aunuri.service.impl.AunuriLinkMapper;
import kr.co.gocle.oklms.comm.util.CommonUtil;
import kr.co.gocle.oklms.comm.util.Config;
import kr.co.gocle.oklms.comm.util.FileUploadUtil;
import kr.co.gocle.oklms.comm.util.TextStringUtil;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.mail.service.MailService;
import kr.co.gocle.oklms.commbiz.util.SecurityUtil;
import kr.co.gocle.oklms.commbiz.util.SendMail;
import kr.co.gocle.oklms.commbiz.mail.service.impl.MailMapper; 
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 
import kr.co.gocle.oklms.commbiz.outmember.service.OutMemberService;
import kr.co.gocle.oklms.commbiz.outmember.vo.OutMemberVO;
import kr.co.gocle.oklms.la.member.service.impl.MemberMapper;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

/**
* Service Implements 클레스 : 비지니스 로직을 구현하는 클레스.
* @author 최선호
* @since 2016. 9. 05.
*/
@Transactional(rollbackFor=Exception.class)
@Service("outMemberService")
public class OutMemberServiceImpl extends EgovAbstractServiceImpl implements OutMemberService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OutMemberServiceImpl.class);
	
   
   @Resource(name = "outMemberMapper")
   private OutMemberMapper outMemberMapper;
   	
       
	/** ID Generation */
   @Resource(name="mailIdGnrService")
   private EgovIdGnrService mailIdGnrService;
   
   /** ID Generation */
   @Resource(name="memberIdGnrService")
   private EgovIdGnrService memberIdGnrService;
   
   /** ID Generation */
   @Resource(name="outMemberIdGnrService")
   private EgovIdGnrService outMemberIdGnrService;
   
   @Resource(name = "aunuriLinkMapper")
   private AunuriLinkMapper aunuriLinkMapper;
   
   @Resource(name = "mailMapper")
   private MailMapper mailMapper;
   
   @Resource(name = "atchFileService")
   private AtchFileService atchFileService;
   
   @Resource(name = "memberMapper")
   private MemberMapper memberMapper;

   @Override
   public OutMemberVO tempMemIdCheck(OutMemberVO outMemberVO) throws Exception {
		// TODO Auto-generated method stub
	   OutMemberVO data = outMemberMapper.tempMemIdCheck(outMemberVO);
		return data;
   }
   
   @Override
   public MemberVO memIdCheck(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
	   MemberVO data = outMemberMapper.memIdCheck(memberVO);
		return data;
   }
   
   @Override
   public List<OutMemberVO>  tempMemInfoCheck(OutMemberVO outMemberVO) throws Exception {
		// TODO Auto-generated method stub
	   List<OutMemberVO> data = outMemberMapper.tempMemInfoCheck(outMemberVO);
		return data;
   }
   
   @Override
   public List<MemberVO> memInfoCheck(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
	   List<MemberVO> data = outMemberMapper.memInfoCheck(memberVO);
		return data;
   }

	@Override
	public String inesertTempOutMember(OutMemberVO outMemberVO,final MultipartHttpServletRequest multiRequest) throws Exception {
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
	    sendmail.setFilePath("");
	    //============ 이메일 세팅 ed =============//
	    
	    //============ SMS 세팅 st =============//
		//송신번호
		sms.setTrCallBack(trCallback);
		//보내는사람 sendName
		sms.setSendName(sendName);
		//============ SMS 세팅 ed =============//
		
		
		String pkStr = "";
		String emplNo = "";
		String authGroup = "";
		if( outMemberVO.getAuthGroupIds() != null ){
			for( int i=0; i< outMemberVO.getAuthGroupIds().length; i++ ){
				
				authGroup += outMemberVO.getAuthGroupIds()[i]+",";
			}
		}
		
		
		pkStr = memberIdGnrService.getNextStringId();
		outMemberVO.setEmplNo(pkStr);
		outMemberVO.setAuthGroupId(authGroup);		
		
		outMemberVO.setIhidnum(outMemberVO.getIhidnum().replaceAll("\\.", ""));
		
		//첨부파일 저장	 		
		final List< MultipartFile > fileObj = multiRequest.getFiles("file-input");
		String storePathString ="Globals.fileStorePath";
		String atchFileId = atchFileService.saveAtchFile( fileObj, "COP", "", storePathString ,"licence");
		outMemberVO.setLicenceFile(atchFileId);
		
		// 첨부파일 2번째
		final List<MultipartFile> fileObj2 = multiRequest.getFiles("file-input2");
		String atchFileId2 = atchFileService.saveAtchFile(fileObj2, "COP", "", storePathString, "licence2");
		outMemberVO.setLicenceFile2(atchFileId2);
		
		outMemberVO.setLoginPwd(outMemberVO.getEncryptShaPw());
		
		int iResult = outMemberMapper.inesertTempOutMember(outMemberVO);
		if(iResult > 0) emplNo = outMemberVO.getEmplNo();
		
		mailVO.setCompanyId(outMemberVO.getCompanyId());
		List<MailVO> data = mailMapper.listCompanyCcnMember(mailVO);
		if(data != null){
			for(int i=0; i < data.size(); i++){
				MailVO mVO = data.get(i);
				
			   if(mVO.getHpNo() != null){
				   if(!mVO.getHpNo().equals("") && mVO.getHpNo().length() > 10){
					   
					   smsMsg = "OK-LMS ["+mVO.getCompanyName()+"] 기업의 회원가입 승인요청이 왔습니다. ";
					   
					   //받는사람 receiveName
					   sms.setReceiveName(mVO.getMemName());
					   //수신번호
					   sms.setTrPhone(mVO.getHpNo().replaceAll("\\-", ""));
					   //내용
					   sms.setTrMsg(smsMsg);
					   // 전송
					   aunuriLinkMapper.smsSendCall(sms);
				   }
			   }
					 
			   if(mVO.getEmail() != null){
				   if(!mVO.getEmail().equals("")){
					   
					   mailTitle = "OK-LMS ["+mVO.getCompanyName()+"] 기업의 회원가입 승인요청 메일";
					   
					   mailContent = "OK-LMS ["+mVO.getCompanyName()+"] 기업의 회원가입 승인요청이 왔습니다. ";
					   
					   //받는사람 receiveName
					   
					   //제목 셋팅
			           sendmail.setSubject(mailTitle);
			           // 내용 세팅
			           sendmail.setText(mailContent);
						  
			           sendmail.setToAddr(mVO.getEmail());
			           sendmail.send();
				           
				   	}
			   }
			}
		}
		
		
		return emplNo;
	}
	
	@Override
   	public List<OutMemberVO> listTempOutMember(OutMemberVO outMemberVO) throws Exception {
   		List<OutMemberVO> data = outMemberMapper.listTempOutMember(outMemberVO);
   		return data;
   	}
	
	@Override
   	public int updateOutMemberStatus(OutMemberVO outMemberVO) throws Exception {
   		return outMemberMapper.updateOutMemberStatus(outMemberVO);
   	}
	
	@Override
   	public int deleteOutMember(OutMemberVO outMemberVO) throws Exception {
   		return outMemberMapper.deleteOutMember(outMemberVO);
   	}
	
	@Override
   	public int approvalTempMember(OutMemberVO outMemberVO) throws Exception {
		int iResult = 0;
		
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
	    sendmail.setFilePath("");
	    //============ 이메일 세팅 ed =============//
	    
	    //============ SMS 세팅 st =============//
		//송신번호
		sms.setTrCallBack(trCallback);
		//보내는사람 sendName
		sms.setSendName(sendName);
		//============ SMS 세팅 ed =============//
	
		OutMemberVO oVO = outMemberMapper.getOutMember(outMemberVO);
		
		oVO.setMemSeq(memberIdGnrService.getNextStringId());
		oVO.setSex(oVO.getSexdstnCd().equals("101") ? "M" : "F");
		oVO.setSessionMemId(outMemberVO.getSessionMemId());
		
		String authGroupId = oVO.getAuthGroupId();
		
		if(authGroupId.indexOf(",") != -1){
			String [] authGroupIds = authGroupId.split(",");
			
			for(int i=0; i<authGroupIds.length; i++){
						
				String authGroup = authGroupIds[i];
				MemberVO memberVO = new MemberVO();
				memberVO.setMemSeq(oVO.getMemSeq());
				memberVO.setAuthGroupId(authGroup.split("_")[0]);
				memberVO.setMemType(authGroup.split("_")[1]);
				memberMapper.insertAuthMember(memberVO);
				
				if(i==0) {
					oVO.setAuthGroupId(authGroup.split("_")[0]);
					oVO.setMemType(authGroup.split("_")[1]);
				}
			}
		} 
		
		iResult = outMemberMapper.insertMember(oVO);
		
		
		if(iResult > 0){
			iResult += outMemberMapper.updateOutMemberStatus(outMemberVO);
		}
		
		//, #{email}
		//, #{mbtlnum}
		//, koreanNm
		if(!oVO.getMbtlnum().equals("") && oVO.getMbtlnum().length() > 10){
			   
			if(oVO.getMemType().equals("COT")){ 
				smsMsg = "[OK-LMS] 회원가입이 승인 되었습니다.";
			} else {
				smsMsg = "[OK-LMS] 회원가입이 승인 되었습니다.";
			}
			    
			   //받는사람 receiveName
			   sms.setReceiveName(oVO.getKoreanNm());
			   //수신번호
			   sms.setTrPhone(oVO.getMbtlnum().replaceAll("\\-", ""));
			   //내용
			   sms.setTrMsg(smsMsg);
			   // 전송
			   aunuriLinkMapper.smsSendCall(sms);	
			}
				 
		   if(!oVO.getEmail().equals("")){
			   
			   mailTitle = "[OK-LMS] 회원가입 승인메일";
			   
			   if(oVO.getMemType().equals("COT")){ 
				   smsMsg = "[OK-LMS] 회원가입이 승인 되었습니다.";
				} else {
					mailContent = "[OK-LMS] 회원가입이 승인 되었습니다.";
				}
			   
			   //받는사람 receiveName
			   
			   //제목 셋팅
	           sendmail.setSubject(mailTitle);
	           // 내용 세팅
	           sendmail.setText(mailContent);
				  
	           sendmail.setToAddr(oVO.getEmail());
	           sendmail.send();
		           
		   	}
		
		
   		return iResult;
   	}

	@Override
	public int changePassword(LoginVO loginVO) throws Exception {
		
		String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); // 비밀번호 변경없이 최대 사용 일수
		loginVO.setLoginPWMaxUsedDays(loginPWMaxUsedDays);
		
		int updateCnt = outMemberMapper.changePassword(loginVO);
		
		return updateCnt;
	}

	@Override
	public String selectPassword(LoginVO user) throws Exception {
		String selectPassword = outMemberMapper.selectPassword(user);
		return selectPassword;
	}
	
	
}