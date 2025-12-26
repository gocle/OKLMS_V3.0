package kr.co.gocle.oklms.la.main.web;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.dept.service.DeptService;
import kr.co.gocle.oklms.la.dept.vo.DeptVO;
import kr.co.gocle.oklms.la.link.service.LinkService;
import kr.co.gocle.oklms.la.traningprocess.service.TraningProcessService;
import kr.co.gocle.oklms.la.traningprocess.vo.TraningProcessVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekFileVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;

@Controller
public class LmsAdminMainPageController extends BaseController {

	private static final Logger LOG = LoggerFactory.getLogger(LmsAdminMainPageController.class);
 
	@Resource(name = "deptService")
	private DeptService deptService;
	
	
	@Resource(name = "companyService")
	private CompanyService companyService;
	
	@Resource(name = "traningProcessService")
	private TraningProcessService traningProcessService;
	
	@Resource(name = "linkService")
	private LinkService linkService;
	
	@RequestMapping(value = "/la/main/lmsAdminMainPage.do")
	public String lmsAdminMainPage(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		// View호출

		LOG.debug("#### /la/main/lmsAdminMainPage.do" );
		
		String retMsg = StringUtils.defaultIfBlank( (String) commandMap.get("retMsg"), "");
		model.addAttribute("retMsg", retMsg );
		
		String retMsgEncode = StringUtils.defaultIfBlank( (String) commandMap.get("retMsgEncode"), "");
		retMsgEncode = URLDecoder.decode( retMsgEncode ,"UTF-8");
		model.addAttribute("retMsgEncode", retMsgEncode );
		
		//사용자 권한
		LoginInfo loginInfo = new LoginInfo();
        LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
        if( loginInfo.isLogin() ){
        	
        	model.addAttribute("authGroupId", loginVO.getAuthGroupId());
        	model.addAttribute("usrId", loginVO.getMemId());
        	model.addAttribute("usrSeq", loginVO.getMemSeq());
        }
        
		DeptVO deptVO = new DeptVO();
        List<DeptVO> resultList = deptService.listDeptStat(deptVO);
        
        model.addAttribute("resultList", resultList);
        
        //CompanyVO companyVO = companyService.mainCompanyStat();
        CompanyVO companyVO = companyService.mainCompanyStatCnt();
        model.addAttribute("companyVO", companyVO);
        
        List<HashMap> result = traningProcessService.mainTraningProcessStat();
        model.addAttribute("result", result);
        
        List<TraningProcessVO> deptList = traningProcessService.listTraningDeptStat();
        model.addAttribute("deptList", deptList);
        
        
		return "oklms/la/main/lmsAdminMainPage";
        //return  "redirect:/la/lecture/lectureLms/listLectureForIns.do";
	}
	@RequestMapping(value = "/la/main/lmsAdminMainPageExcelDownload.do")
	public String listCompanyStatExcelDownload( ModelMap model,HttpServletRequest request)  throws Exception {
		
 
	      
		DeptVO deptVO = new DeptVO();
        List<DeptVO> resultList = deptService.listDeptStat(deptVO);
        
        model.addAttribute("resultList", resultList);
        
        //CompanyVO companyVO = companyService.mainCompanyStat();
        CompanyVO companyVO = companyService.mainCompanyStatCnt();
        model.addAttribute("companyVO", companyVO);
        
        List<HashMap> result = traningProcessService.mainTraningProcessStat();
        model.addAttribute("result", result);
        
        List<TraningProcessVO> deptList = traningProcessService.listTraningDeptStat();
        model.addAttribute("deptList", deptList);
        
        request.setAttribute("ExcelName", URLEncoder.encode( "관리자메인".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/main/excelAdminMainPage";
	}
	/**
	 * 관리자 화면에서 LCMS 와 LMS 관리 화면 전환을 위해 사용됨.
	 * @param request
	 * @param response
	 * @param commandMap
	 * @param model
	 * @param redirectAttributes
	 * @param status
	 * @return
	 * @throws Exception
	 * String
	 */
	@RequestMapping(value = "/la/main/changeMenuArea.do")
	public String changeMenuArea(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {

		String redirectUrl = "/lc/main/lcmsMainPage.do";
		//사용자 권한
		LoginInfo loginInfo = new LoginInfo();
        LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
        if( loginInfo.isLogin() ){

        	HttpSession  session = request.getSession(false);
        	String menuArea = loginInfo.getAttribute(Globals.MENU_AREA);
        	
        	LOG.debug("#### menuArea : " + menuArea );
        	
        	if( "LMS".equals( menuArea ) ){
	    		session.setAttribute(Globals.MENU_AREA, "LCMS");
	    		redirectUrl = "/lc/main/lcmsMainPage.do";        		
        	}else if( "LCMS".equals( menuArea ) ){

	    		session.setAttribute(Globals.MENU_AREA, "LMS");
	    		redirectUrl = "/la/main/lmsAdminMainPage.do";
        	}else{
	    		session.setAttribute(Globals.MENU_AREA, "LCMS");
	    		redirectUrl = "/lc/main/lcmsMainPage.do";
        	}
        }
    	
        LOG.debug("#### redirectUrl : " + redirectUrl );
    	
		// View호출
		return "redirect:" + redirectUrl;
	}
	
	
	@RequestMapping(value = "/la/main/stdMerge.json")
	public @ResponseBody Map<String, Object> popupOnlineTraningFileSave(@ModelAttribute("frmFile") OnlineTraningWeekFileVO onlineTraningWeekFileVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		LOG.debug("#### URL = /la/main/stdMerge.json" );
		
		int iResult = linkService.excuteStdBatch();
		
		if(iResult > 0){
			returnMap.put("retCd", "10000");
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
		}
		return returnMap;
	 }
	
	/*
	@RequestMapping(value = "/la/main/stdMerge1.json")
	public @ResponseBody Map<String, Object> stdMerge1(@ModelAttribute("frmFile") OnlineTraningWeekFileVO onlineTraningWeekFileVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		LOG.debug("#### URL = /la/main/stdMerge.json" );
		
		int iResult = companyService.pwMember();
		
		
		if(iResult > 0){
			returnMap.put("retCd", "10000");
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
		}
		return returnMap;
	 }
	 */
	
}
