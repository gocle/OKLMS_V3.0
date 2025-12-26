package kr.co.gocle.oklms.commbiz.outmember.web;

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
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.mail.service.MailService;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 
import kr.co.gocle.oklms.commbiz.outmember.service.OutMemberService;
import kr.co.gocle.oklms.commbiz.outmember.vo.OutMemberVO;
import kr.co.gocle.oklms.commbiz.util.SecurityUtil;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.lu.member.vo.MemberStdVO;

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
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class OutMemberController extends BaseController{

	@Resource(name = "mailService")
	private MailService mailService;
	
	@Resource(name = "outMemberService")
	private OutMemberService outMemberService;
	
	@Resource(name = "companyService")
	private CompanyService companyService;
	
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
	
	
	@RequestMapping(value = "/commbiz/outmember/popupAgree.do")
	public String  popupAgree(@RequestParam Map<String, Object> commandMap, @ModelAttribute("frmAgree") MemberStdVO memberStdVO, ModelMap model) throws Exception {
		
		// View호출
		return "oklms_popup/lu/member/agree";
	}
	
	@RequestMapping("/commbiz/outmember/popupJoinPage.do")
	public String joinPage(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		CompanyVO companyVO = new CompanyVO();
		List<CompanyVO> listCompany = companyService.listCompanySearch(companyVO);
		
		model.addAttribute("listCompany", listCompany);

		return "oklms_popup/lu/member/popupJoin";

	}
	
	/**
	 * 아이디등록확인
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value = { "/commbiz/outmember/memIdCheck.do" })
	public @ResponseBody Map<String, Object> memIdCheck(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
 
		logger.debug("#### /commbiz/outmember/memIdCheck.do" );
		
		OutMemberVO outMemberVO = new OutMemberVO();
		outMemberVO.setLoginId((String)commandMap.get("loginId"));
		OutMemberVO oVO =  outMemberService.tempMemIdCheck(outMemberVO);
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId((String)commandMap.get("loginId"));
		MemberVO mVO =  outMemberService.memIdCheck(memberVO);
		
		HashMap<String,Object> returnMap = new HashMap<String,Object>();
		if(oVO != null ){
			returnMap.put("memId", oVO.getLoginId());			
		} else {
			if(mVO != null ){
				returnMap.put("memId", mVO.getMemId());			
			}
		}
		
		return returnMap;
	}
	
	@RequestMapping(value = "/commbiz/outmember/inesertTempOutMember.do")
	public String inesertTempOutMember(@ModelAttribute("frmJoin") OutMemberVO outMemberVO, ModelMap model, RedirectAttributes redirectAttributes,HttpServletRequest request,final MultipartHttpServletRequest multiRequest) throws Exception {
		
		String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getHeader("REMOTE_ADDR");
		}else{
			logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
		}

		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getRemoteAddr();
		}else{
			logger.info("#### is REMOTE_ADDR : " + usrIP );
		}
		
		outMemberVO.setRegIp(usrIP);
		
		String returnPage = "";
		String retMsg = "입력값 확인이 필요합니다.";
		
		String emplNo = outMemberService.inesertTempOutMember(outMemberVO,multiRequest);
		returnPage = "redirect:/lu/login/goLmsUserLogin.do";
		
		if(!emplNo.equals("")){
			retMsg = "정상적으로 (저장)처리되었습니다.\n센터전담자 승인 후 이용이 가능합니다.";
		}
		

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("outMemberVO", outMemberVO);
        
		// View호출
        return returnPage;
		
	}
	
	
	@RequestMapping(value = "/commbiz/outmember/inesertTempOutMember.json")
	public @ResponseBody Map<String, Object> inesertTempOutMemberJson(@RequestParam Map<String, Object> commandMap,
			@ModelAttribute("frmJoin") OutMemberVO outMemberVO, 
			ModelMap model, RedirectAttributes redirectAttributes,
			HttpServletRequest request,
			final MultipartHttpServletRequest multiRequest
			,SessionStatus status
			) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getHeader("REMOTE_ADDR");
		}else{
			logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
		}

		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getRemoteAddr();
		}else{
			logger.info("#### is REMOTE_ADDR : " + usrIP );
		}
		
		outMemberVO.setRegIp(usrIP);
		
		String returnPage = "";
		String retMsg = "입력값 확인이 필요합니다.";
		
		
		List<OutMemberVO> listOutMember =  outMemberService.tempMemInfoCheck(outMemberVO);
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId(outMemberVO.getLoginId());
		memberVO.setMemId(outMemberVO.getEmail());
		List<MemberVO> listMember =  outMemberService.memInfoCheck(memberVO);
		
		String memId =  "";
		
		if(listOutMember.size() == 0  && listMember.size() == 0){
			String emplNo = outMemberService.inesertTempOutMember(outMemberVO,multiRequest);
			retMsg = "정상적으로 (저장)처리되었습니다.\n센터전담자 승인 후 이용이 가능합니다.";
		} else {
			retMsg = "이미 가입되어 있는 사용자이거나 승인대기중인 사용자입니다.";
		}
		
		returnMap.put("retMsg", retMsg);
        
		// View호출
        return returnMap;
		
	}
	
	@RequestMapping(value = "/commbiz/outmember/result.do")
	public String  result(@RequestParam Map<String, Object> commandMap, @ModelAttribute("frmJoin") OutMemberVO outMemberVO, ModelMap model) throws Exception {
		String emplNo = (String)commandMap.get("emplNo");
		String memType = (String)commandMap.get("memType");
		// View호출
		model.addAttribute("emplNo", emplNo);
		model.addAttribute("memType", memType);
		return "oklms_popup/lu/member/result";
	}
	
	@RequestMapping(value = "/lu/temp/listTempMember.do")
	public String listTempMember(@ModelAttribute("frmTemp") OutMemberVO outMemberVO, ModelMap model) throws Exception {
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(outMemberVO); // session의 정보를 VO에 추가.
		
		List<OutMemberVO> resultList = outMemberService.listTempOutMember( outMemberVO );
		
		model.addAttribute("resultList", resultList);
        
		// View호출
		return "oklms/lu/member/tempMemberList";
	}
	
	
	
	@RequestMapping(value = "/lu/temp/deleteTempMember.do")
	public String deleteTempMember(@ModelAttribute("frmTemp") OutMemberVO outMemberVO, ModelMap model, RedirectAttributes redirectAttributes,HttpServletRequest request) throws Exception {
		
		
		String returnPage = "";
		String retMsg = "처리에 실패했습니다.";
		
		int iResult = outMemberService.deleteOutMember(outMemberVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}
		
		// View호출
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
        return "redirect:/lu/temp/listTempMember.do";
		
	}
	
	@RequestMapping(value = "/lu/temp/approvalTempMember.do")
	public String applovalTempMember(@ModelAttribute("frmTemp") OutMemberVO outMemberVO, ModelMap model, RedirectAttributes redirectAttributes,HttpServletRequest request) throws Exception {
		
		
		String returnPage = "";
		String retMsg = "처리에 실패했습니다.";
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(outMemberVO); // session의 정보를 VO에 추가.
		
		int iResult = outMemberService.approvalTempMember(outMemberVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}
		
		// View호출
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
        return "redirect:/lu/temp/listTempMember.do";
		
	}
	
	/*@RequestMapping(value = "/lu/temp/updateTempMemberStatu.do")
	public String inesertTempOutMember(@ModelAttribute("frmJoin") OutMemberVO outMemberVO, ModelMap model, RedirectAttributes redirectAttributes,HttpServletRequest request) throws Exception {
		
		String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getHeader("REMOTE_ADDR");
		}else{
			logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
		}

		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getRemoteAddr();
		}else{
			logger.info("#### is REMOTE_ADDR : " + usrIP );
		}
		
		outMemberVO.setRegIp(usrIP);
		
		String returnPage = "";
		String retMsg = "입력값 확인이 필요합니다.";
		
		String emplNo = outMemberService.inesertTempOutMember(outMemberVO);
		
		if(!emplNo.equals("")){
			returnPage = "redirect:/commbiz/outmember/result.do?memType="+outMemberVO.getMemType()+"&emplNo="+emplNo;
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}else{
			returnPage = "redirect:/commbiz/outmember/popupJoinPage.do";
		}
		

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("outMemberVO", outMemberVO);
        
		// View호출
        return returnPage;
		
	}*/

	/*@RequestMapping(value = "/la/mail/mail/listMailHistory.do")
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
		List<CommonCodeVO> smsTableList = commonCodeService.selectSmsTableList(codeVO);
		
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
        model.addAttribute("smsTableList", smsTableList);
        
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
	
	*//**
     * request의 parameter값을 가져옴
     * 
     * @param request HttpServletRequest
     * @param key parateter key값
     * @param defaultValue 값이 없을경우의 기본값
     * @return String parameter value
     *//*
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
			
			int insertCnt = mailService.insertSmsLu( mailVO );

			if( 0 < insertCnt ){
				retMsg = insertCnt+"건이 정상적으로 처리되었습니다.";
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
	}	*/
	
	@RequestMapping(value = "/commbiz/outmember/changePassword.json")
	public @ResponseBody Map<String, Object> changePassword(@ModelAttribute LoginVO loginVO,
			ModelMap model, RedirectAttributes redirectAttributes,
			HttpServletRequest request,SessionStatus status
			) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getHeader("REMOTE_ADDR");
		}else{
			logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
		}

		if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
			usrIP = request.getRemoteAddr();
		}else{
			logger.info("#### is REMOTE_ADDR : " + usrIP );
		}
		
		String retMsg = "입력값 확인이 필요합니다.";
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 비밀번호 확인
		String memPassword = outMemberService.selectPassword(user);
		
		String memPasswordEncripted = SecurityUtil.encryptSha256(loginVO.getMemPasswordEncript()); // 입력한 기존 비밀번호
		String newPasswordEncripted = SecurityUtil.encryptSha256(loginVO.getNewPasswordEncript()); // 입력한 새 비밀번호
		
		//System.out.println("아이디: " + user.getId());
		//System.out.println("DB 비밀번호: " + memPassword);
		//System.out.println("기존 비밀번호: " + loginVO.getMemPasswordEncript());
		//System.out.println("기존 비밀번호 암호화: " + memPasswordEncripted);
		//System.out.println("새 비밀번호: " + loginVO.getNewPasswordEncript());
		//System.out.println("새 비밀번호 암호화: " + newPasswordEncripted);
		
		loginVO.setId(user.getId());
		loginVO.setMemSeq(user.getMemSeq());
		loginVO.setNewPasswordEncripted(newPasswordEncripted);
		
		if (!memPassword.equals(memPasswordEncripted)) {
			retMsg = "비밀번호를 다시 확인하세요.";
		}else{
			// 비밀번호 변경
			int updateCnt = outMemberService.changePassword(loginVO);
			
			retMsg = "비밀번호를 변경하였습니다.";
			if(updateCnt > 0){
				retMsg = "비밀번호를 변경하였습니다.";
			}else{
				retMsg = "비밀번호 변경실패하였습니다.";
			}
		}
		
		returnMap.put("retMsg", retMsg);
        
		// View호출
        return returnMap;
		
	}
}
