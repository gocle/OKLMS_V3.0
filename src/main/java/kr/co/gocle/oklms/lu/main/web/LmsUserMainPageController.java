package kr.co.gocle.oklms.lu.main.web;

import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.gocle.aunuri.service.AunuriLinkService;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectGradeVO;
import kr.co.gocle.ifx.service.IfxService;
import kr.co.gocle.ifx.vo.AunuriMemberVO;
import kr.co.gocle.ifx.vo.AunuriSubjectVO;
import kr.co.gocle.oklms.comm.util.CommonUtil;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.util.BizUtil;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.menu.vo.MenuVO;
import kr.co.gocle.oklms.la.popup.service.PopupService;
import kr.co.gocle.oklms.la.popup.vo.PopupVO;
import kr.co.gocle.oklms.lu.grade.vo.GradeVO;
import kr.co.gocle.oklms.lu.main.service.LmsUserMainPageService;
import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;
import kr.co.gocle.oklms.lu.member.vo.MemberStdVO;
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectCompanyVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO; 
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningReportVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;

@Controller
public class LmsUserMainPageController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(LmsUserMainPageController.class);

	/** EgovPopupManageService */
	@Resource(name = "egovPopupManageService")
	private EgovPopupManageService egovPopupManageService;

	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;

	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;

	@Resource(name = "popupService")
	private PopupService popupService;

	@Resource(name = "LmsUserMainPageService")
	private LmsUserMainPageService lmsUserMainPageService;
	
	@Resource(name = "aunuriLinkService")
	private AunuriLinkService aunuriLinkService;
	
	@Resource(name = "SubjectService")
	private SubjectService subjectService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
//	@Resource(name = "mainPageService")
//	private MainPageService mainPageService;
	
	@Resource(name = "companyService")
	private CompanyService companyService;
	
	@Resource(name = "ifxService")
	private IfxService ifxService;
	


	@RequestMapping(value = "/lu/main/lmsUserMainPage.do")
	public String lmsUserMainPage(@ModelAttribute("frmSubject") SubjectVO subjectVO ,HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		// View호출
		
		LOGGER.debug("#### /lu/main/lmsUserMainPage.do" );
		String view="oklms/lu/main/lmsUserMainPage";
		Map<String, Object> map1 = null;
		Map<String, Object> map2 = null;
		Map<String, Object> map3 = null; 
		Map<String, Object> map4 = null; 
		List<LmsUserMainPageVO> listLmsUserMainPageTodayCnt = null;
		List<LmsUserMainPageVO> listLmsUserMainPageStatusCnt = null;
		List<LmsUserMainPageVO> listLectureS​chedule = null;
		LmsUserMainPageVO mainPageVO = new LmsUserMainPageVO();

		// 현재일자
		String nowDay =  StringUtils.defaultIfBlank( (String) commandMap.get("nowDay"), BizUtil.getCurrentDateString());
		nowDay = nowDay.replaceAll("-", "");
		nowDay = nowDay.replaceAll("\\.", "");
 
		
		model.addAttribute("yesDay", BizUtil.addDate(nowDay,-1));
		model.addAttribute("tomDay", BizUtil.addDate(nowDay,1));
		
		nowDay = BizUtil.toDateString(nowDay,"yyyyMMdd","yyyy.MM.dd");
		
		model.addAttribute("nowDay", nowDay);		
		model.addAttribute("nowDayName", BizUtil.getDayWeek(nowDay));
		
		//강의 일정
		mainPageVO.setTraningDate(nowDay);
  
		// 강의매뉴 표시 여부 Key 세션 설정
		HttpSession session = request.getSession(true);
		session.setAttribute("lecMenuMarkYn" , "N" );

		
		//교과목 관련 세션삭제 2017.02.20 csh
		BizUtil.setEmptyLecInfo(request);

		
		
		String retMsg = StringUtils.defaultIfBlank( (String) commandMap.get("retMsg"), "");
		model.addAttribute("retMsg", retMsg );

		String retMsgEncode = StringUtils.defaultIfBlank( (String) commandMap.get("retMsgEncode"), "");
		LOGGER.debug("#######retMsgEncode:"+retMsgEncode );
		retMsgEncode = URLDecoder.decode( retMsgEncode ,"UTF-8");
		LOGGER.debug("#######retMsgEncodeEncode:"+retMsgEncode );
		model.addAttribute("retMsgEncode", retMsgEncode );

		//사용자 권한
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		String sessionMemType = StringUtils.defaultIfBlank((String) session.getAttribute("SESSION_MEM_TYPE"),"");
		loginVO.setMemType(StringUtils.defaultIfBlank( sessionMemType , loginVO.getMemType()));
		
		loginInfo.putSessionToVo(mainPageVO);
		String userUniqId = "";
		if( loginInfo.isLogin() ){
			MenuVO aa = new MenuVO();
			LOGGER.debug("#### aa.getSessionMemSeq() 1 : " + aa.getSessionMemSeq() );

			BeanUtils.copyProperties(loginVO,aa);
			LOGGER.debug("#### aa.getSessionMemSeq() 2 : " + aa.getSessionMemSeq() );

			model.addAttribute("authGroupId", loginVO.getAuthGroupId());
			model.addAttribute("usrId", loginVO.getMemId());
			model.addAttribute("usrSeq", loginVO.getMemSeq());
			model.addAttribute("memType", loginVO.getMemType());

			userUniqId = loginVO.getMemSeq();
		}

		PopupVO popupVO = new PopupVO();
		popupVO.setPageType("P0001");//메인
		List<PopupVO> popupList = popupService.getPopupAllList(popupVO);
		model.addAttribute("popupList", popupList);

		//전체 공지사항
		BoardVO boardVO = new BoardVO();
		if(loginVO.getMemSeq()!=null){
			boardVO.setFrstRegisterId(loginVO.getMemSeq());	
		}
		
		boardVO.setMemType(loginVO.getMemType());
		boardVO.setMemSeq(loginVO.getMemSeq());

		boardVO.setBbsId("BBSMSTR_000000000005");
		boardVO.setOrderByFlag(null);
		map1 = bbsMngService.selectMainPageBoardArticles(boardVO, "BBSA01");
		

		//전체 학습자료실
		boardVO.setBbsId("BBSMSTR_000000000006");
		map2 = bbsMngService.selectMainPageBoardArticles(boardVO, "BBSA01");

		//전체 Q&A
		boardVO.setBbsId("BBSMSTR_000000000007");
		map3 = bbsMngService.selectMainPageBoardArticles(boardVO, "BBSA02");
		
		//전체 공지사항
		boardVO.setBbsId("BBSMSTR_000000000000");
		map4 = bbsMngService.selectMainPageBoardArticles(boardVO, "BBSA01");
		
		//hye08 추가
		//전체 알림사항
		Map<String, Object> map5 = null;
		boardVO.setBbsId("BBSMSTR_000000000050");
		map5 = bbsMngService.selectMainPageBoardArticles(boardVO, "BBSA01");
		
		model.addAttribute("newsResultList", map5.get("resultList"));
		model.addAttribute("noticeResultList", map1.get("resultList"));
		model.addAttribute("stdRefResultList", map2.get("resultList"));
		model.addAttribute("quAndAnResultList", map3.get("resultList"));
		model.addAttribute("noticeAllResultList", map4.get("resultList"));
		
		//listLmsUserMainPageTodayCnt = lmsUserMainPageService.listLmsUserMainPageTodayCnt(mainPageVO);
		//istLectureS​chedule = lmsUserMainPageService.listLectureS​chedule(mainPageVO);
 
		//model.addAttribute("readTodayCnt", listLmsUserMainPageTodayCnt);
		//model.addAttribute("resultList", listLectureS​chedule);
		
				
		model.addAttribute("mainPageVO", mainPageVO);
		
		if(loginVO.getMemType().equals("STD")){
			
			mainPageVO.setSubjectTraningType("OFF");
			List<LmsUserMainPageVO> offlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPageStdSchedule(mainPageVO);
			mainPageVO.setSubjectTraningType("OJT");
			List<LmsUserMainPageVO> ojtlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPageStdSchedule(mainPageVO);
			
			List<LmsUserMainPageVO> listComplete =  lmsUserMainPageService.listLmsUserMainPageStdComplete(mainPageVO);
			
			model.addAttribute("listComplete", listComplete);
			model.addAttribute("offListSchedule", offlistLectureS​chedule);
			model.addAttribute("ojtListSchedule", ojtlistLectureS​chedule);
			
			//listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageStatusCnt(mainPageVO);
			//model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
			view="oklms/lu/main/lmsUserMainPageStd";
		}else if(loginVO.getMemType().equals("PRT")){

			
			mainPageVO.setSubjectTraningType("OFF");
			//List<LmsUserMainPageVO> offlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPagePrtSchedule(mainPageVO);
			List<LmsUserMainPageVO> offlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPagePrtOffSchedule(mainPageVO);
			//List<LmsUserMainPageVO> offStatus =  listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageStatusCnt(mainPageVO);
			
			mainPageVO.setSubjectTraningType("OJT");
			List<LmsUserMainPageVO> ojtlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPagePrtSchedule(mainPageVO);
			//List<LmsUserMainPageVO> ojtStatus = listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPagePrtStatusPrtCnt(mainPageVO);
			
			int noteApplovalCnt  = lmsUserMainPageService.getNoteApplovalCnt(mainPageVO);
			int actApplovalCnt = lmsUserMainPageService.getActApplovalCnt(mainPageVO);
			
			List<LmsUserMainPageVO> listOffCut = listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCutMember(mainPageVO);
			model.addAttribute("noteApplovalCnt", noteApplovalCnt);
			model.addAttribute("actApplovalCnt", actApplovalCnt);
			model.addAttribute("listOffCut", listOffCut);
			
			//model.addAttribute("offStatus", offStatus);
			//model.addAttribute("ojtStatus", ojtStatus);			
			model.addAttribute("offListSchedule", offlistLectureS​chedule);
			model.addAttribute("ojtListSchedule", ojtlistLectureS​chedule);
			
			
			AunuriMemberVO aunuriMemberVO = new AunuriMemberVO();
			aunuriMemberVO.setSessionMemSeq(loginInfo.getMemSeq());
			
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectInsMapping(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			List<AunuriSubjectVO> listOffJtAunuriSubject= ifxService.getOffJtAunuriSubjectInsMapping(aunuriMemberVO);
			model.addAttribute( "listOffJtAunuriSubject", listOffJtAunuriSubject );
			
			
			view="oklms/lu/main/lmsUserMainPagePrt";
		}else if(loginVO.getMemType().equals("COT") || loginVO.getMemType().equals("CCM")){
			
			
			// 훈련일정 
			List<LmsUserMainPageVO> listLectureCotSchedule =  lmsUserMainPageService.listLmsUserMainPageCotSchedule(mainPageVO);
			model.addAttribute("listLectureCotSchedule", listLectureCotSchedule);
			
			//listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageStatusCnt(mainPageVO);
			//model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
			
			List<LmsUserMainPageVO> listLmsUserMainPageCotTraningProcess =  lmsUserMainPageService.listLmsUserMainPageCotTraningProcess(mainPageVO);
			model.addAttribute("listLmsUserMainPageCotTraningProcess", listLmsUserMainPageCotTraningProcess);
			
			if(loginVO.getMemType().equals("COT")){
				view="oklms/lu/main/lmsUserMainPageCot";
			} else {
				view="oklms/lu/main/lmsUserMainPageCcm";
			}
			
			
		}else if(loginVO.getMemType().equals("CCN")){
			
			
			// 기업체현황조회
			listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCcnCnt(mainPageVO);
			model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);			
			// 훈련일정 
			//List<LmsUserMainPageVO> listLectureCcnSchedule =  lmsUserMainPageService.listLmsUserMainPageCcnSchedule(mainPageVO);
			//model.addAttribute("listLectureCcnSchedule", listLectureCcnSchedule);
			
			String noteOrderValue = StringUtils.defaultIfBlank( (String) commandMap.get("noteOrderValue"), "");
			String noteOrderType = StringUtils.defaultIfBlank( (String) commandMap.get("noteOrderType"), "");
			String noteSearchKeyword = StringUtils.defaultIfBlank( (String) commandMap.get("noteSearchKeyword"), "");
			String actOrderValue = StringUtils.defaultIfBlank( (String) commandMap.get("actOrderValue"), "");
			String actOrderType = StringUtils.defaultIfBlank( (String) commandMap.get("actOrderType"), "");
			String actSearchKeyword = StringUtils.defaultIfBlank( (String) commandMap.get("actSearchKeyword"), "");
			
			mainPageVO.setNoteOrderValue(noteOrderValue);
			mainPageVO.setNoteOrderType(noteOrderType);
			mainPageVO.setNoteSearchKeyword(noteSearchKeyword);
			mainPageVO.setActOrderValue(actOrderValue);
			mainPageVO.setActOrderType(actOrderType);
			mainPageVO.setActSearchKeyword(actSearchKeyword);
			
			
			List<LmsUserMainPageVO> listLmsUserMainPageCcnNote =  lmsUserMainPageService.listLmsUserMainPageCcnNote(mainPageVO);
			model.addAttribute("listLmsUserMainPageCcnNote", listLmsUserMainPageCcnNote);
			
			List<LmsUserMainPageVO> listLmsUserMainPageCcnAct =  lmsUserMainPageService.listLmsUserMainPageCcnAct(mainPageVO);
			model.addAttribute("listLmsUserMainPageCcnAct", listLmsUserMainPageCcnAct);
			
			
			view="oklms/lu/main/lmsUserMainPageCcn";
		}else if(loginVO.getMemType().equals("CDP")){
			
			//return "redirect:/lu/subject/listSubjectCdp.do";
			 
			
			loginInfo.putSessionToVo(subjectVO);
			// 학과코드,학과명 코드 리스트
			CommonCodeVO codeVO = new  CommonCodeVO();
			codeVO.setCodeGroup("DEPT_CD");
			List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
			model.addAttribute("deptCodeList", deptCodeList);
			
			List<LmsUserMainPageVO> listOffCut = listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCutMember(mainPageVO);
			model.addAttribute("listOffCut", listOffCut);
			
			List <SubjectVO> resultList = subjectService.listSubjectCdpMain(subjectVO);
			model.addAttribute("resultList", resultList);
			model.addAttribute("subjectVO", subjectVO);

			view="oklms/lu/main/lmsUserMainPageCdp";
			
			
			
		}/*else if(loginVO.getMemType().equals("CCM")){
			// 참여기업현황
			listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCcmCnt(mainPageVO);
			model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);		
			
			List<LmsUserMainPageVO> listLectureScheduleCcm =  lmsUserMainPageService.listLmsUserMainPageCcmSchedule(mainPageVO);
			model.addAttribute("listLectureScheduleCcm", listLectureScheduleCcm);	
			
			view="oklms/lu/main/lmsUserMainPageCcm";
		}*/
 
		return view;
	}
	
	@RequestMapping(value = "/lu/main/listSubject.json")
	public @ResponseBody Map<String, Object> listSubject(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmMain") LmsUserMainPageVO lmsUserMainPageVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		String traningProcessId = (String) commandMap.get("traningProcessId");
		String companyId = (String) commandMap.get("companyId");
		String yyyy = (String) commandMap.get("yyyy");
		String term = (String) commandMap.get("term");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(lmsUserMainPageVO); // session의 정보를 VO에 추가.
		
		lmsUserMainPageVO.setTraningProcessId(traningProcessId);
		lmsUserMainPageVO.setCompanyId(companyId);
		lmsUserMainPageVO.setYyyy(yyyy);
		lmsUserMainPageVO.setTerm(term);
		
		try {
		   
		   	List<LmsUserMainPageVO> listSubjectCot = lmsUserMainPageService.listSubjectCot(lmsUserMainPageVO);
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("listSubjectCot", listSubjectCot);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/main/listSubjectStd.json")
	public @ResponseBody Map<String, Object> listSubjectStd(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmMain") LmsUserMainPageVO lmsUserMainPageVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		String yyyy = (String) commandMap.get("yyyy");
		String term = (String) commandMap.get("term");
		String subjectCode = (String) commandMap.get("subjectCode");
		String subjectClass = (String) commandMap.get("subjectClass");
		
		String traningProcessId = (String) commandMap.get("traningProcessId");
		String companyId = (String) commandMap.get("companyId");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(lmsUserMainPageVO); // session의 정보를 VO에 추가.
		
		lmsUserMainPageVO.setYyyy(yyyy);
		lmsUserMainPageVO.setTerm(term);
		lmsUserMainPageVO.setSubjectCode(subjectCode);
		lmsUserMainPageVO.setSubjectClass(subjectClass);
		lmsUserMainPageVO.setTraningProcessId(traningProcessId);
		lmsUserMainPageVO.setCompanyId(companyId);

		try {
		   
		   	List<LmsUserMainPageVO> listSubjectStd = lmsUserMainPageService.listSubjectStd(lmsUserMainPageVO);
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("listSubjectStd", listSubjectStd);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/main/listSubjectStdOff.json")
	public @ResponseBody Map<String, Object> listSubjectStdOff(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmMain") LmsUserMainPageVO lmsUserMainPageVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		String yyyy = (String) commandMap.get("yyyy");
		String term = (String) commandMap.get("term");
		String subjectCode = (String) commandMap.get("subjectCode");
		String subjectClass = (String) commandMap.get("subjectClass");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(lmsUserMainPageVO); // session의 정보를 VO에 추가.
		
		lmsUserMainPageVO.setYyyy(yyyy);
		lmsUserMainPageVO.setTerm(term);
		lmsUserMainPageVO.setSubjectCode(subjectCode);
		lmsUserMainPageVO.setSubjectClass(subjectClass);
		
		try {
		   
		   	List<LmsUserMainPageVO> listSubjectStdOff = lmsUserMainPageService.listSubjectStdOff(lmsUserMainPageVO);
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("listSubjectStdOff", listSubjectStdOff);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/main/lmsUserMainPageUpdate.json")
	public @ResponseBody Map<String, Object>  lmsUserMainPageUpdate(@ModelAttribute("frmMember") AunuriLinkMemberVO aunuriLinkMemberVO
			,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap modelt) throws Exception {	
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(aunuriLinkMemberVO); // session의 정보를 VO에 추가.
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		logger.debug("#### URL = /lu/main/lmsUserMainPageUpdate.json" );
		
		
        int iResult = aunuriLinkService.updateAunuriOutMemberInfoEtc(aunuriLinkMemberVO);
       
        if(iResult > 0){
			returnMap.put("retCd", "10000");
		} else {
			returnMap.put("retCd", "");
		}
		
		return returnMap;
	}
 
	
	@RequestMapping(value = "/lu/main/lmsUserMainPagePopupAgree.do")
	public String  lmsUserMainPagePopupAgree(@RequestParam Map<String, Object> commandMap, @ModelAttribute("frmAgree") MemberStdVO memberStdVO, ModelMap model) throws Exception {
		
		// View호출
		return "oklms_popup/lu/main/lmsUserMainPagePopupAgree";
	}
	
	@RequestMapping(value = "/lu/main/lmsUserMainPageUpdateAgree.json")
	public @ResponseBody Map<String, Object>  lmsUserMainPageUpdateAgree(
			 RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,ModelMap modelt) throws Exception {	
		
		logger.debug("#### URL = /lu/main/lmsUserMainPageUpdateAgree.json" );
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		
		int iResult = lmsUserMainPageService.updateMemberAgreeYn(loginInfo.getMemSeq());
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
        if(iResult > 0){
			returnMap.put("retCd", "10000");
		} else {
			returnMap.put("retCd", "");
		}
		
		return returnMap;
	}
	
	
	
	@RequestMapping(value = "/lu/test/currproc/listCurrProc.do")
	public String test(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		return null;
	}
	
	@RequestMapping("/lu/main/changePasswordPop.do")
	public String changePasswordPopup(ModelMap model) throws Exception {

		return "oklms_popup/lu/egovframework/com/cop/login/changePasswordPopup";
	}
}
