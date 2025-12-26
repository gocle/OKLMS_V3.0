package kr.co.gocle.oklms.mm.mypage.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import kr.co.gocle.ifx.service.IfxService;
import kr.co.gocle.ifx.vo.AunuriMemberVO;
import kr.co.gocle.ifx.vo.AunuriSubjectVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.util.BizUtil;
import kr.co.gocle.oklms.la.popup.service.PopupService;
import kr.co.gocle.oklms.lu.main.service.LmsUserMainPageService;
import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;
@Controller
public class LmsMypageMMController extends BaseController {
	
	private static final Logger LOG = LoggerFactory.getLogger(LmsMypageMMController.class);
	
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
	
	@Resource(name = "egovBannerService")
    private EgovBannerService egovBannerService;
	
	@Resource(name = "ifxService")
	private IfxService ifxService;
		
	// 마이페이지
	@RequestMapping(value = "/mm/mypage/lmsMyPage.do")
	public String lmsMyPage(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		// View호출

		LOG.debug("#### /mm/mypage/lmsMyPage.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
				
		Map<String, Object> map1 = null;
		Map<String, Object> map2 = null;
		Map<String, Object> map3 = null; 
		
		List<LmsUserMainPageVO> listLmsUserMainPageTotalCnt = null;
		List<LmsUserMainPageVO> listLmsUserMainPageTodayCnt = null;
		List<LmsUserMainPageVO> listLectureS​chedule = null;
		List<LmsUserMainPageVO> listLmsUserMainPageStatusCnt = null;
		
		BoardVO boardVO = new BoardVO();	 
		boardVO.setMemType(loginInfo.getMemType());
		boardVO.setMemSeq(loginInfo.getMemSeq());
		
		String retView ="";
		
		//전체 공지사항
		boardVO.setFrstRegisterId(loginVO.getMemSeq());
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

		model.addAttribute("noticeResultList", map1.get("resultList"));
		model.addAttribute("stdRefResultList", map2.get("resultList"));
		model.addAttribute("quAndAnResultList", map3.get("resultList"));

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
		
		
		listLmsUserMainPageTotalCnt = lmsUserMainPageService.listLmsUserMainPageTotalCnt(mainPageVO);
		listLmsUserMainPageTodayCnt = lmsUserMainPageService.listLmsUserMainPageTodayCnt(mainPageVO);
		listLectureS​chedule = lmsUserMainPageService.listLectureS​chedule(mainPageVO);

		model.addAttribute("readTotalCnt", listLmsUserMainPageTotalCnt);
		model.addAttribute("readTodayCnt", listLmsUserMainPageTodayCnt);
		model.addAttribute("resultList", listLectureS​chedule);
		 
		model.addAttribute("memType",loginInfo.getMemType());
		//API 통한 교과정보, 관리자 제외한 진행중인 교과정보.
		AunuriMemberVO aunuriMemberVO = new AunuriMemberVO();
		aunuriMemberVO.setSessionMemSeq(loginInfo.getMemSeq());
		
		
		if("STD".equals(loginInfo.getMemType())){ //학습근로자 개설교과
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectLesson(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			
			List<AunuriSubjectVO> listOffJtAunuriSubject= ifxService.getOffJtAunuriSubjectLesson(aunuriMemberVO);
			model.addAttribute( "listOffJtAunuriSubject", listOffJtAunuriSubject );		
			
			mainPageVO.setSubjectTraningType("OFF");
			List<LmsUserMainPageVO> offlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPageStdSchedule(mainPageVO);
			mainPageVO.setSubjectTraningType("OJT");
			List<LmsUserMainPageVO> ojtlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPageStdSchedule(mainPageVO);

			model.addAttribute("offListSchedule", offlistLectureS​chedule);
			model.addAttribute("ojtListSchedule", ojtlistLectureS​chedule);
			
			listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageStatusCnt(mainPageVO);
			model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
			
			retView = "oklms/mm/mypage/lmsMyPageStd";
			
		} else if("PRT".equals(loginInfo.getMemType())){ //담당교수 개설교과
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectInsMapping(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			List<AunuriSubjectVO> listOffJtAunuriSubject= ifxService.getOffJtAunuriSubjectInsMapping(aunuriMemberVO);
			model.addAttribute( "listOffJtAunuriSubject", listOffJtAunuriSubject );
			int hSkillCnt = ifxService.getOjtAunuriSubjectInsHSkillCnt(aunuriMemberVO);
			model.addAttribute( "hSkillCnt", hSkillCnt );
			
			mainPageVO.setSubjectTraningType("OFF");
			List<LmsUserMainPageVO> offlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPagePrtSchedule(mainPageVO);
			List<LmsUserMainPageVO> offStatus = lmsUserMainPageService.listLmsUserMainPageStatusCnt(mainPageVO);
			
			mainPageVO.setSubjectTraningType("OJT");
			List<LmsUserMainPageVO> ojtlistLectureS​chedule =  lmsUserMainPageService.listLmsUserMainPagePrtSchedule(mainPageVO);
			List<LmsUserMainPageVO> ojtStatus  = lmsUserMainPageService.listLmsUserMainPagePrtStatusPrtCnt(mainPageVO);
			
			model.addAttribute("offStatus", offStatus);
			model.addAttribute("ojtStatus", ojtStatus);			
			model.addAttribute("offListSchedule", offlistLectureS​chedule);
			model.addAttribute("ojtListSchedule", ojtlistLectureS​chedule);
			
			
			retView ="oklms/mm/mypage/lmsMyPagePrt";
		} else if("COT".equals(loginInfo.getMemType())){ //기업현장교사 개설교과
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectTutMapping(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			
			// 훈련일정 
			List<LmsUserMainPageVO> listLectureCotSchedule =  lmsUserMainPageService.listLmsUserMainPageCotSchedule(mainPageVO);
			model.addAttribute("listLectureCotSchedule", listLectureCotSchedule);
			
			listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageStatusCnt(mainPageVO);
			model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
			
			// 로그인권한별 URL 분기처리			
			retView ="oklms/mm/mypage/lmsMyPageCot";
		}
		
		
		
		return retView;
	}	
}
