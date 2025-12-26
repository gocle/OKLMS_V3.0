package kr.co.gocle.oklms.commbiz.mail.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.gocle.oklms.comm.util.Config;
import kr.co.gocle.oklms.comm.util.TextStringUtil;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.mail.service.MailService;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 
import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Validator;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MailController extends BaseController{

	@Resource(name = "mailService")
	private MailService mailService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	@Resource(name = "beanValidatorJSR303")
	Validator validator;
	
	@InitBinder
	public void initBinder(WebDataBinder dataBinder){
		try {
			dataBinder.setValidator(this.validator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/la/mail/mail/listMailHistory.do")
	public String listMailHistory(@ModelAttribute("frmMail") MailVO mailVO, ModelMap model) throws Exception {
		
		Integer pageSize = 10;
		
		List<MailVO> listMailHistory = mailService.listMailHistory( mailVO );
		
		CommonCodeVO codeVO = new CommonCodeVO();
		codeVO.setCodeGroup( "MAIL_CLASS" );
		List<CommonCodeVO> mailClassCodeList = commonCodeService.selectCmmCodeList(codeVO);
		
		Integer page = mailVO.getPageIndex();
		int totalCnt = 0;
		if( 0 < listMailHistory.size() ){
			
			totalCnt = Integer.parseInt( listMailHistory.get(0).getTotalCount() );
		}
//		int totalPage = (int) Math.ceil(totalCnt / pageSize);

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageUnit());
        paginationInfo.setPageSize(mailVO.getPageSize());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("mailVO", mailVO);
        model.addAttribute("listMailHistory", listMailHistory);
        model.addAttribute("mailClassCodeList", mailClassCodeList);
        
		// View호출
		return "oklms/la/mail/mailHistoryList";
	}
	

	@RequestMapping(value = "/la/mail/mail/getMailHistory.do")
	public String getMailHistory(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model ) throws Exception {
		
		mailVO = mailService.getMailHistory( mailVO );

        model.addAttribute("mailVO", mailVO);

		// View호출
		return "oklms/la/mail/mailHistoryRead";
	}
	
	
	@RequestMapping(value = "/la/mail/mail/updateMailHistory.do")
	public String updateMailHistory(@ModelAttribute("frmMail") MailVO mailVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		
		String retMsg = "입력값을 확인해주세요.";
		
		if( StringUtils.isBlank( mailVO.getHistoryId()) ){
			retMsg = "수정할 정보가 없습니다.";
		}else{
			
			int updateCnt = mailService.updateMailHistory( mailVO );
			
			if(updateCnt > 0){
				retMsg = "정상적으로 (삭제)처리되었습니다.!";
			} 
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("mailVO", mailVO);
        
		// View호출
        return "redirect:/la/mail/mail/listMailHistory.do";
		
	}
	
	
	@RequestMapping(value = "/la/mail/mail/listSmsHistory.do")
	public String listSmsHistory(@ModelAttribute("frmMail") MailVO mailVO, ModelMap model) throws Exception {
		
		Integer pageSize = 10;
		
		if( StringUtils.isBlank( mailVO.getSearchScLogTable() ) ){
			mailVO.setScLogTable("SC_LOG");
			mailVO.setSearchScLogTable("SC_LOG");
		}else{
			mailVO.setScLogTable(mailVO.getSearchScLogTable());
		}
		
		
		List<MailVO> listSmsHistory = mailService.listSmsHistory( mailVO );
		
		CommonCodeVO codeVO = new CommonCodeVO();
		codeVO.setCodeGroup( "SMS_TABLE" );
		//List<CommonCodeVO> smsTableList = commonCodeService.selectSmsTableList(codeVO);
		
		Integer page = mailVO.getPageIndex();
		int totalCnt = 0;
		if( 0 < listSmsHistory.size() ){
			
			totalCnt = Integer.parseInt( listSmsHistory.get(0).getTotalCount() );
		}
//		int totalPage = (int) Math.ceil(totalCnt / pageSize);

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageUnit());
        paginationInfo.setPageSize(mailVO.getPageSize());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("mailVO", mailVO);
        model.addAttribute("listSmsHistory", listSmsHistory);
        //model.addAttribute("smsTableList", smsTableList);
        
		// View호출
		return "oklms/la/mail/smsHistoryList";
	}
	

	@RequestMapping(value = "/la/mail/mail/getSmsHistory.do")
	public String getSmsHistory(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		
		mailVO.setScLogTable(mailVO.getSearchScLogTable());
		mailVO = mailService.getSmsHistory( mailVO );

        model.addAttribute("mailVO", mailVO);

		// View호출
		return "oklms/la/mail/smsHistoryRead";
	}
	
	
	@RequestMapping(value = "/la/mail/mail/goSaveSendSms.do")
	public String goSendSms(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		CommonCodeVO codeVO = new CommonCodeVO();
		codeVO.setCodeGroup( "SMS_GROUP" );
		List<CommonCodeVO> smsGroupCodeList = commonCodeService.selectCmmCodeList(codeVO);
		
		mailVO.setTrCallBack(EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
		model.addAttribute("smsGroupCodeList", smsGroupCodeList);
        model.addAttribute("mailVO", mailVO);

		// View호출
		return "oklms/la/mail/smsSendSave";
	}
	
	@RequestMapping(value = "/la/mail/mail/saveSendSms.do")
	public String saveSendSms(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		
		String sender = this.getStringParameter(request, "trCallBack", EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
		String reservation = this.getStringParameter(request, "reservation", "");
		String useFlag = this.getStringParameter(request, "tFlag", "0");
		String smsContent = this.getStringParameter(request, "smsContent", "");
		String retMsg = "";		

		mailVO.setTrCallBack(sender);
		mailVO.setTrPhone(mailVO.getTrPhone());
		mailVO.setTrSenddate(reservation);
		mailVO.settFlag(useFlag);
		mailVO.setTrMsgtype("0");
		mailVO.setTrMsg(smsContent);
		mailVO.setSenderMemSeq(mailVO.getSenderMemSeq());		//보내는 사람 SEQ
		
		int insertCnt = mailService.insertSendSms( mailVO );

		if( 0 < insertCnt ){
			retMsg = "정상적으로 처리되었습니다.";
		}else{
			retMsg = "처리된 정보가 없습니다.";
		}
		
		model.addAttribute("retMsg", retMsg);
        model.addAttribute("sendSuccess", "send");
        model.addAttribute("mailVO", mailVO);

		// View호출
        return "oklms/la/mail/smsSendSave";
	}
	
	/**
     * request의 parameter값을 가져옴
     * 
     * @param request HttpServletRequest
     * @param key parateter key값
     * @param defaultValue 값이 없을경우의 기본값
     * @return String parameter value
     */
    protected String getStringParameter(HttpServletRequest request, String key,
            String defaultValue) {
        return ServletRequestUtils.getStringParameter(request, key,
                defaultValue);

    }

    // 회원목록에서 SMS보내기 버튼 클릭시 실행하는 메소드
	@RequestMapping(value = "/la/popup/popup/popupMemberInfoSaveSendSms.do")
	public String popupMemberInfoSaveSendSms(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		String sender = this.getStringParameter(request, "trCallBack", EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
		String reservation = this.getStringParameter(request, "reservation", "");
		String useFlag = this.getStringParameter(request, "tFlag", "0");
		String smsContent = this.getStringParameter(request, "smsContent", "");
		String retMsg = "";		

		mailVO.setTrCallBack(sender);
		mailVO.setTrPhone(mailVO.getTrPhone());
		mailVO.setTrSenddate(reservation);
		mailVO.settFlag(useFlag);
		mailVO.setTrMsgtype("0");
		mailVO.setTrMsg(smsContent);
		mailVO.setSenderMemSeq(mailVO.getSenderMemSeq());		//보내는 사람 SEQ
		
		int insertCnt = mailService.insertSendSms( mailVO );

		if( 0 < insertCnt ){
			retMsg = "Y";
		}else{
			retMsg = "N";
		}
		
		//model.addAttribute("retMsg", retMsg);
        model.addAttribute("sendSuccess", retMsg);
        model.addAttribute("mailVO", mailVO);

		// View호출
        return "oklms_popup/la/popup/smsSendPopup";
	}
	
	
	@RequestMapping(value = "/lu/mail/mailSendPopup.do")
	public String mailSendPopup(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		logger.debug("#### URL = /lu/mail/mailSendPopup.do");
		List<MailVO> resultlist = null ;

		if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>0){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemid(mailVO);
		}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>0){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemseq(mailVO);			
		}

		model.addAttribute("resultlist", resultlist);
		model.addAttribute("mailVO", mailVO);

		// View호출
		return "oklms_popup/lu/popup/mailSendPopup";
	}
	
	
	@RequestMapping(value = "/lu/mail/mailSend.do")
	public String mailSend(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request,RedirectAttributes redirectAttributes,final MultipartHttpServletRequest multiRequest) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		String retMsg="";
        String successYn = "N";
        
		//첨부파일 저장
		MultipartFile  fileObj = multiRequest.getFile("file-input");
		ArrayList attachFile = new ArrayList();
		attachFile.add(fileObj);
		mailVO.setAttachFile(attachFile);
		
        
		successYn = mailService.sendMailLu(mailVO);

		if(successYn.equals("Y")){
			retMsg="메일이 발송되었습니다.";
		}else{
			retMsg="발송이 실패했습니다.";
		}
        redirectAttributes.addFlashAttribute("successYn", successYn);	
		redirectAttributes.addFlashAttribute("retMsg", retMsg);

 
		// View호출
		return "redirect:/lu/mail/mailSendPopup.do?qfeType="+mailVO.getQfeType();
	}
	
	
	@RequestMapping(value = "/lu/sms/smsSendPopup.do")
	public String smsSendPopup(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		logger.debug("#### URL = /lu/sms/smsSendPopup.do-start");
		List<MailVO> resultlist = null ;
		
		// 아이디인지 사번인지 조회 후 리턴
		if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>0){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemid(mailVO);
		}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>0){
			mailVO.setMemSeqs(mailVO.getMemSeq().split(","));
			resultlist = mailService.listMemberMemseq(mailVO);			
		}		
		
		model.addAttribute("resultlist", resultlist);
		model.addAttribute("mailVO", mailVO);
		if(mailVO.getQfeType().equals("All")){
			return "oklms_popup/lu/popup/smsSendPopupAll";
		}
		// View호출
		return "oklms_popup/lu/popup/smsSendPopup";
	}
	
	
	@RequestMapping(value = "/lu/sms/smsSendPopupCot.do")
	public String smsSendPopupCot(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		logger.debug("#### URL = /lu/sms/smsSendPopupCot");
		List<MailVO> resultlist = null ;
		
		// 아이디인지 사번인지 조회 후 리턴
		if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>3){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemid(mailVO);
		}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>3){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemseq(mailVO);			
		}		
		
		model.addAttribute("resultlist", resultlist);
		model.addAttribute("mailVO", mailVO);
		if(mailVO.getQfeType().equals("All")){
			return "oklms_popup/lu/popup/smsSendPopupAll";
		}
		// View호출
		return "oklms_popup/lu/popup/smsSendPopupCot";
	}
	 
	@RequestMapping(value = "/lu/sms/smsSendPopupCompany.do")
	public String smsSendPopupCompany(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		logger.debug("#### URL = /lu/sms/smsSendPopupCompany");
		List<MailVO> resultlist = null ;
		
		
		Map<String, Object> commandMap = new HashMap<String, Object>();
		commandMap.put("companyId", mailVO.getCompanyId());
		commandMap.put("traningProcessId", mailVO.getTraningProcessId());
		ArrayList<Map<String, Object>> cotList = commonCodeService.getCotListName(commandMap);
		ArrayList<Map<String, Object>> ccmList =commonCodeService.getCcmListName(commandMap);
		String memIdTemp="";
		if(mailVO.getCotMemIds().equals("cot")){
			for(int a=0; cotList.size()>a ;a++){
				memIdTemp= memIdTemp+","+(String)(cotList.get(a).get("memId"));
			}
		}
		if(mailVO.getCcmMemIds().equals("ccm")){
			for(int a=0; ccmList.size()>a ;a++){
				memIdTemp= memIdTemp+","+(String)(ccmList.get(a).get("memId"));
			}		
		}
		mailVO.setMemId(memIdTemp);
		
		// 아이디인지 사번인지 조회 후 리턴
		if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>0){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemid(mailVO);
		}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>0){
			mailVO.setMemIds(mailVO.getMemId().split(","));
			resultlist = mailService.listMemberMemseq(mailVO);			
		}		
		
		model.addAttribute("resultlist", resultlist);
		model.addAttribute("mailVO", mailVO);
		if(mailVO.getQfeType().equals("All")){
			return "oklms_popup/lu/popup/smsSendPopupAll";
		}
		// View호출
		return "oklms_popup/lu/popup/smsSendPopupCot";
	}
	
	
	@RequestMapping(value = "/lu/sms/smsSend.do")
	public String smsSend(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request,RedirectAttributes redirectAttributes) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		String retMsg="";
		
		String sender = this.getStringParameter(request, "trCallback", EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
		String senderName = EgovProperties.getProperty("Globals.sms.sender.default.phonename");
		String smsContent = this.getStringParameter(request, "smsContent", "");
		
 			
		if(mailVO.getMemIds()!=null&&mailVO.getMemIds().length>0){
			//보내는 전화번호
			mailVO.setTrCallBack(sender);
			//보낸 이름
			mailVO.setSendName(senderName);
			//전송내용
			mailVO.setTrMsg(smsContent);
			//보내는 사람 SEQ
			mailVO.setSenderMemSeq(mailVO.getSessionMemSeq());		
			
			//int insertCnt = mailService.insertSmsLu( mailVO );
			mailVO.setSendType("SMS");
			int iResult = mailService.insertSendMaster(mailVO);

			if( 0 < iResult ){
				retMsg = iResult+"건이 정상적으로 처리되었습니다.";
			}else{
				retMsg = "처리된 정보가 없습니다.";
			}
			
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("sendSuccess", "send");
 
		// View호출
		return "redirect:/lu/sms/smsSendPopup.do?qfeType="+mailVO.getQfeType();
	}
	
	@RequestMapping(value = "/lu/sms/smsSendLocal.do")
	public String smsSendLocal(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request,RedirectAttributes redirectAttributes) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		String retMsg="";
		
		String sender = this.getStringParameter(request, "trCallback", EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
		String senderName = EgovProperties.getProperty("Globals.sms.sender.default.phonename");
		String smsContent = this.getStringParameter(request, "smsContent", "");
		
 			
		if(mailVO.getMemIds()!=null&&mailVO.getMemIds().length>0){
			//보내는 전화번호
			mailVO.setTrCallBack(sender);
			//보낸 이름
			mailVO.setSendName(senderName);
			//전송내용
			mailVO.setTrMsg(smsContent);
			//보내는 사람 SEQ
			mailVO.setSenderMemSeq(mailVO.getSessionMemSeq());		
			
			int insertCnt = mailService.insertSmsLocal( mailVO );

			if( 0 < insertCnt ){
				retMsg =  insertCnt+"건이 정상적으로 처리되었습니다.";
			}else{
				retMsg = "처리된 정보가 없습니다.";
			}
			
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("sendSuccess", "send");
 
		// View호출
		return "redirect:/lu/sms/smsSendPopup.do?qfeType="+mailVO.getQfeType();
	}	
	
	
	@RequestMapping(value = "/lu/mail/mailSendPopup.json")
	public @ResponseBody Map<String, Object> mailSendPopupJson(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmMail") MailVO mailVO
			,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		//세션자동복사
		/*
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		*/
		logger.debug("#### URL = /lu/mail/mailSendPopup.json");
		List<MailVO> resultlist = null ;

		
		try {
			   
			if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>0){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemid(mailVO);
			}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>0){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemseq(mailVO);			
			}
			
			model.addAttribute("resultlist", resultlist);
			model.addAttribute("mailVO", mailVO);

			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("resultlist", resultlist);
			returnMap.put("mailVO", mailVO);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/mail/mailSendJson.json")
	public @ResponseBody Map<String, Object> mailSendJson(@ModelAttribute("frmMail") MailVO mailVO,final MultipartHttpServletRequest multiRequest
			,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		logger.debug("#### URL = /lu/mail/mailSendJson.json");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		
		String retCd = "SUCCESS";
		String retMsg = "";
        String successYn = "N";
        
		//첨부파일 저장
		MultipartFile  fileObj = multiRequest.getFile("file-input");
		ArrayList attachFile = new ArrayList();
		
		if( fileObj != null ){
			attachFile.add(fileObj);
			mailVO.setAttachFile(attachFile);
		}
		
		mailVO.setSendType("EMAIL");
		logger.debug("#### mailVO.getRealTypeYn() : "+mailVO.getRealTypeYn());
		try {
			   
			// 즉시발송
			if(mailVO.getRealTypeYn().equals("Y")){
				//successYn = mailService.sendMailLu(mailVO);
				int iResult = mailService.insertSendMaster(mailVO);
				//if(successYn.equals("Y")){
				if(iResult > 0){
					retMsg="메일이 발송되었습니다.";
				}else{
					retMsg="발송이 실패했습니다.";
				}
			} else { // 예약발송

				int iResult = mailService.insertSendMaster(mailVO);
				
				logger.debug("===================== iResult : "+iResult);
				
				if(iResult > 0){
					retMsg="예약발송이 되었습니다.";
				} else {
					retMsg="예약발송에 실패했습니다.";
				}
			}

			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("successYn", successYn);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/sms/smsSendPopupJson.json")
	public @ResponseBody Map<String, Object> smsSendPopupJson(@ModelAttribute("frmSms") MailVO mailVO
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		//세션자동복사
		/*
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		*/
		logger.debug("#### URL = /lu/sms/smsSendPopupJson.json");
		List<MailVO> resultlist = null ;
		
		try {
			   
			// 아이디인지 사번인지 조회 후 리턴
			if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>0){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemid(mailVO);
			}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>0){
				mailVO.setMemSeqs(mailVO.getMemSeq().split(","));
				resultlist = mailService.listMemberMemseq(mailVO);			
			}	
			
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("resultlist", resultlist);
			returnMap.put("mailVO", mailVO);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
		
			
		
	
	
	@RequestMapping(value = "/lu/sms/smsSendPopupCot.json")
	public @ResponseBody Map<String, Object> smsSendPopupCotJson(@ModelAttribute("frmSms") MailVO mailVO ,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		logger.debug("#### URL = /lu/sms/smsSendPopupCot.json");
		List<MailVO> resultlist = null ;
		
		try {
			   
			// 아이디인지 사번인지 조회 후 리턴
			if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>3){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemid(mailVO);
			}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>3){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemseq(mailVO);			
			}		
			
			model.addAttribute("resultlist", resultlist);
			model.addAttribute("mailVO", mailVO);
			
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("resultlist", resultlist);
			returnMap.put("mailVO", mailVO);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
		
	}
	 
	@RequestMapping(value = "/lu/sms/smsSendPopupCompany.Json")
	public @ResponseBody Map<String, Object> smsSendPopupCompanyJson(@ModelAttribute("frmSms") MailVO mailVO,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		logger.debug("#### URL = /lu/sms/smsSendPopupCompany.Json");
		List<MailVO> resultlist = null ;
		
		
		try {
			   
			Map<String, Object> commandMap = new HashMap<String, Object>();
			commandMap.put("companyId", mailVO.getCompanyId());
			commandMap.put("traningProcessId", mailVO.getTraningProcessId());
			ArrayList<Map<String, Object>> cotList = commonCodeService.getCotListName(commandMap);
			ArrayList<Map<String, Object>> ccmList =commonCodeService.getCcmListName(commandMap);
			String memIdTemp="";
			if(mailVO.getCotMemIds().equals("cot")){
				for(int a=0; cotList.size()>a ;a++){
					memIdTemp= memIdTemp+","+(String)(cotList.get(a).get("memId"));
				}
			}
			if(mailVO.getCcmMemIds().equals("ccm")){
				for(int a=0; ccmList.size()>a ;a++){
					memIdTemp= memIdTemp+","+(String)(ccmList.get(a).get("memId"));
				}		
			}
			mailVO.setMemId(memIdTemp);
			
			// 아이디인지 사번인지 조회 후 리턴
			if(mailVO.getMemId()!=null&&mailVO.getMemId().split(",").length>0){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemid(mailVO);
			}else if(mailVO.getMemSeq()!=null&&mailVO.getMemSeq().split(",").length>0){
				mailVO.setMemIds(mailVO.getMemId().split(","));
				resultlist = mailService.listMemberMemseq(mailVO);			
			}	
			
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("resultlist", resultlist);
			returnMap.put("mailVO", mailVO);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	
	@RequestMapping(value = "/lu/sms/smsSendJson.json")
	public @ResponseBody Map<String, Object> smsSendJson(@ModelAttribute("frmSms") MailVO mailVO,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		logger.debug("#### URL = /lu/sms/smsSendJson.Json");
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		
		try {
			   
			String sender = this.getStringParameter(request, "trCallback", EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
			String senderName = EgovProperties.getProperty("Globals.sms.sender.default.phonename");
			String smsContent = this.getStringParameter(request, "smsContent", "");
			
	 			
			if(mailVO.getMemIds()!=null&&mailVO.getMemIds().length>0){
				//보내는 전화번호
				mailVO.setTrCallBack(sender);
				//보낸 이름
				mailVO.setSendName(senderName);
				//전송내용
				mailVO.setTrMsg(smsContent);
				//보내는 사람 SEQ
				mailVO.setSenderMemSeq(mailVO.getSessionMemSeq());		
				
				mailVO.setSendType("SMS");
				// 즉시발송
				if(mailVO.getRealTypeYn().equals("Y")){
					//int insertCnt = mailService.insertSmsLu( mailVO );
					
					int iResult = mailService.insertSendMaster(mailVO);
					
					//if( 0 < insertCnt ){
					if(iResult > 0){
						retMsg = iResult+"건이 정상적으로 처리되었습니다.";
					}else{
						retMsg = "처리된 정보가 없습니다.";
					}
				} else { // 예약발송

					int iResult = mailService.insertSendMaster(mailVO);
					
					if(iResult > 0){
						retMsg="예약발송이 되었습니다.";
					} else {
						retMsg="예약발송에 실패했습니다.";
					}
				}
				
			}

			redirectAttributes.addFlashAttribute("retMsg", retMsg);
			redirectAttributes.addFlashAttribute("sendSuccess", "send");
			
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("sendSuccess", "send");
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
		
	}
	
	@RequestMapping(value = "/lu/sms/smsSendLocalJson.do")
	public @ResponseBody Map<String, Object>  smsSendLocalJson(@ModelAttribute("frmMail") MailVO mailVO,  RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		logger.debug("#### URL = /lu/sms/smsSendLocalJson.Json");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		
		try {
			   
			String sender = this.getStringParameter(request, "trCallback", EgovProperties.getProperty("Globals.sms.sender.default.phoneno"));
			String senderName = EgovProperties.getProperty("Globals.sms.sender.default.phonename");
			String smsContent = this.getStringParameter(request, "smsContent", "");
			
	 			
			if(mailVO.getMemIds()!=null&&mailVO.getMemIds().length>0){
				//보내는 전화번호
				mailVO.setTrCallBack(sender);
				//보낸 이름
				mailVO.setSendName(senderName);
				//전송내용
				mailVO.setTrMsg(smsContent);
				//보내는 사람 SEQ
				mailVO.setSenderMemSeq(mailVO.getSessionMemSeq());		
				
				int insertCnt = mailService.insertSmsLocal( mailVO );

				if( 0 < insertCnt ){
					retMsg =  insertCnt+"건이 정상적으로 처리되었습니다.";
				}else{
					retMsg = "처리된 정보가 없습니다.";
				}
				
			}

			redirectAttributes.addFlashAttribute("retMsg", retMsg);
			redirectAttributes.addFlashAttribute("sendSuccess", "send");
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("sendSuccess", "send");
			
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
 
	}	
	

	
	
	@RequestMapping(value = "/la/batch/getNoticeBatch.do")
	public String getNoticeBatch(@ModelAttribute("frmMail") MailVO mailVO, ModelMap model) throws Exception {
		
		
		mailVO = mailService.getNoticeBatch( mailVO );
		

        model.addAttribute("mailVO", mailVO);
        
		// View호출
		return "oklms/la/batch/noticeBatchSave";
	}
	
	@RequestMapping(value = "/la/batch/insertNoticeBatch.do")
	public String insertNoticeBatch(@ModelAttribute("frmMail") MailVO mailVO,  ModelMap model , HttpServletRequest request,RedirectAttributes redirectAttributes) throws Exception {
		
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
		String retMsg="";
		
		
		int insertCnt = mailService.insertNoticeBatch( mailVO );

		if( 0 < insertCnt ){
			retMsg =  insertCnt+"건이 정상적으로 처리되었습니다.";
		}else{
			retMsg = "처리된 정보가 없습니다.";
		}
			

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("sendSuccess", "send");
 
		// View호출
		return "redirect:/la/batch/getNoticeBatch.do";
	}	
}
