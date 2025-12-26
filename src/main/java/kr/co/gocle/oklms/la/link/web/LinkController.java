/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.la.link.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import kr.co.gocle.aunuri.vo.AunuriLinkSubjectVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.link.service.LinkService;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.report.vo.ReportVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;

//import egovframework.com.cmm.util.EgovDoubleSubmitHelper;

@Controller
public class LinkController extends BaseController{
	
	@Resource(name = "linkService")
	private LinkService linkService;
	
	
	
	@RequestMapping(value = "/la/aunuri/listAunuriLink.do")
	public String listAunuriLink(@ModelAttribute("frmLink") AunuriLinkSubjectVO aunuriLinkSubjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
  		logger.debug("#### URL =/la/aunuri/listAunuriLink.do" );
		String retMsg = "";
  		
		// View호출
		return "oklms/lu/report/listReport";
	}
	
	
	@RequestMapping(value = "/la/aunuri/insertAunuriLinkTerm.json")
	public @ResponseBody Map<String, Object> insertAunuriLinkTerm(@ModelAttribute("frmLink") @Valid AunuriLinkSubjectVO aunuriLinkSubjectVO, BindingResult bindingResult, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {	
  		logger.debug("#### URL =/la/aunuri/insertAunuriLinkTerm.do" );
  		
  		
  		Map<String , Object> returnMap = new HashMap<String , Object>();
  		String retCd = "FAILE";
		String retMsg = "입력값을 확인해주세요";
		
  		
  		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(aunuriLinkSubjectVO); // session의 정보를 VO에 추가.
  		
  		// 해당학기의 교과가 없다면 등록진행
  		int iResult = linkService.insertAunuriLinkTerm(aunuriLinkSubjectVO);
  		
  		
  		if( 0 < iResult ){
			retCd = "SUCCESS";
			retMsg = "정상적으로 처리되었습니다.";
		}else{
			retMsg = "처리된 정보가 없습니다.";
		}
		
		returnMap.put("retCd", retCd);
		returnMap.put("retMsg", retMsg);

		return returnMap;
	}

	
}
