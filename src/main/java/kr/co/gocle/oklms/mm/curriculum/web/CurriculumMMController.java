package kr.co.gocle.oklms.mm.curriculum.web;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gocle.ifx.service.IfxService;
import kr.co.gocle.ifx.vo.AunuriMemberVO;
import kr.co.gocle.ifx.vo.AunuriSubjectVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.online.service.OnlineTraningService;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.report.service.ReportService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;
import kr.co.gocle.oklms.lu.traningstatus.service.TraningStatusService;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningStatusVO;

@Controller
public class CurriculumMMController  extends BaseController {
	
	private static final Logger LOG = LoggerFactory.getLogger(  CurriculumMMController.class);

	@Resource(name = "companyService")
	private CompanyService companyService;

	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	@Resource(name = "ifxService")
	private IfxService ifxService;
	
	@Resource(name = "ReportService")
	private ReportService reportService;
	
	@Resource(name = "OnlineTraningService")
	private OnlineTraningService onlineTraningService;
	
	@Resource(name = "TraningStatusService")
	private TraningStatusService traningStatusService;
		
	@RequestMapping(value = "/mm/curriculum/listCurriculum.do")
	public String listCurriculum(@ModelAttribute("frmCurriculum")  CurrProcVO currProcVO, ModelMap model, HttpServletRequest request) throws Exception {
		
  		LOG.debug("#### URL = /mm/curriculum/listCurriculum.do" );
		String retView = "";
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(currProcVO); // session의 정보를 VO에 추가. 
		
		//API 통한 교과정보, 관리자 제외한 진행중인 교과정보.
		AunuriMemberVO aunuriMemberVO = new AunuriMemberVO();
		aunuriMemberVO.setSessionMemSeq(loginInfo.getMemSeq());
		
		// 로그인권한별 URL 분기처리
    	OnlineTraningSchVO onlineTraningSchVO = new OnlineTraningSchVO();
    	loginInfo.putSessionToVo(onlineTraningSchVO); // session의 정보를 VO에 추가. 
    	onlineTraningSchVO.setYyyy(currProcVO.getYyyy());
    	onlineTraningSchVO.setTerm(currProcVO.getTerm());
    	onlineTraningSchVO.setSubjectCode(currProcVO.getSubjectCode());
    	onlineTraningSchVO.setSubjectClass(currProcVO.getSubClass());
    	
		
		
		if("STD".equals(loginInfo.getMemType())){ //학습근로자 개설교과
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectLesson(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			
			List<AunuriSubjectVO> listOffJtAunuriSubject= ifxService.getOffJtAunuriSubjectLesson(aunuriMemberVO);
			model.addAttribute( "listOffJtAunuriSubject", listOffJtAunuriSubject );
			
			
			if("OJT".equals(currProcVO.getSubjectTraningType())){
        		
        		List<OnlineTraningSchVO> resultList = onlineTraningService.listOjtTraningStdSchedule(onlineTraningSchVO);
        		OnlineTraningSchVO progress = onlineTraningService.getTraningStatus(onlineTraningSchVO);
        		
            	model.addAttribute("progress", progress);
        		model.addAttribute("resultList", resultList);
        		retView = "oklms/mm/curriculum/listStdCurriculumOjt";
        	} else {
        		
        		OnlineTraningSchVO progress = onlineTraningService.getAllProgressRateLesson(onlineTraningSchVO);
            	model.addAttribute("progress", progress);
            	
            	List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningStdSchedule(onlineTraningSchVO);
            	model.addAttribute("resultList", resultList);
            	retView = "oklms/mm/curriculum/listStdCurriculum";
        	}
			
		} else if("PRT".equals(loginInfo.getMemType())){ //담당교수 개설교과
			
			// 모바일 버전은 분반정보가 필요해 분반처리
			//List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectInsMapping(aunuriMemberVO);
			
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectInsClassMappingList(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			
		    List<AunuriSubjectVO> listOffJtAunuriSubject= ifxService.getOffJtAunuriSubjectInsMapping(aunuriMemberVO);
			model.addAttribute( "listOffJtAunuriSubject", listOffJtAunuriSubject );
			
        	// 진행중인 온라인교과 목록
        	if("OJT".equals(currProcVO.getSubjectTraningType())){
        		
        		TraningStatusVO traningStatusVO = new TraningStatusVO();
            	traningStatusVO.setYyyy(currProcVO.getYyyy());
        		traningStatusVO.setTerm(currProcVO.getTerm());
        		traningStatusVO.setClassId(currProcVO.getSubjectCode());
        		traningStatusVO.setSubjectCode(currProcVO.getSubClass());
            	
            	//진도율 조회
        		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
        		model.addAttribute("getProgress", getProgress);
        		
        		List<OnlineTraningSchVO> resultList = onlineTraningService.listOjtTraningInsSchedule(onlineTraningSchVO);
            	model.addAttribute("resultList", resultList);
            	retView = "oklms/mm/curriculum/listPrtCurriculumOjt";
        	} else {
        		// 진행중인 온라인교과 목록
            	List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningInsSchedule(onlineTraningSchVO);
            	model.addAttribute("resultList", resultList);
            	retView = "oklms/mm/curriculum/listPrtCurriculum";
        	}
        	
			
		} else if("COT".equals(loginInfo.getMemType())){ //기업현장교사 개설교과
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectTutMapping(aunuriMemberVO);
			model.addAttribute( "listOjtAunuriSubject", listOjtAunuriSubject );
			// 로그인권한별 URL 분기처리			
			
			List<OnlineTraningSchVO> resultList = onlineTraningService.listOjtTraningCotSchedule(onlineTraningSchVO);
        	model.addAttribute("resultList", resultList);
        	
        	retView = "oklms/mm/curriculum/listCotCurriculumOjt";
		}
		 
		// 과정정보 
		currProcVO = reportService.getCurrproc(currProcVO);
		model.addAttribute("currProcVO", currProcVO);
		 
  		// View호출
		return retView;
	}
	
	@RequestMapping(value = "/mm/curriculum/getCurriculumOnlineStudy.do")
	public String getCurriculumOnlneStudy(@ModelAttribute("frmCurriculum")  OnlineTraningSchVO onlineTraningSchVO, ModelMap model, HttpServletRequest request) throws Exception {
		
  		LOG.debug("#### URL = /mm/curriculum/getCurriculumOnlineStudy.do" );
		String retView = "oklms/mm/curriculum/getCurriculumOnlineStudy";
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(onlineTraningSchVO);
		onlineTraningSchVO = onlineTraningService.getOnlineWeekLessonSchedule(onlineTraningSchVO);
		model.addAttribute("onlineTraningSchVO", onlineTraningSchVO);
		
		OnlineTraningVO onlineTraningVO = new OnlineTraningVO();
		onlineTraningVO.setYyyy(onlineTraningSchVO.getYyyy());
        onlineTraningVO.setTerm(onlineTraningSchVO.getTerm());
        onlineTraningVO.setSubjectCode(onlineTraningSchVO.getSubjectCode());
        onlineTraningVO.setSubjectClass(onlineTraningSchVO.getSubjectClass());
        onlineTraningVO = onlineTraningService.getOnlineTraningStand(onlineTraningVO);
        model.addAttribute("onlineTraningVO", onlineTraningVO);
		
		 
  		// View호출
		return retView;
	}
	
	@RequestMapping(value = "/mm/curriculum/getCurriculumOnlineStudyPreview.do")
	public String getCurriculumOnlineStudyPrevew(@ModelAttribute("frmCurriculum")  OnlineTraningSchVO onlineTraningSchVO, ModelMap model, HttpServletRequest request) throws Exception {
		
  		LOG.debug("#### URL = /mm/curriculum/getCurriculumOnlineStudyPreview.do" );
		String retView = "oklms/mm/curriculum/getCurriculumOnlineStudyPreview";
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(onlineTraningSchVO);
		onlineTraningSchVO = onlineTraningService.getOnlineWeekLessonSchedulePreview(onlineTraningSchVO);
		model.addAttribute("onlineTraningSchVO", onlineTraningSchVO);
		
		OnlineTraningVO onlineTraningVO = new OnlineTraningVO();
		onlineTraningVO.setYyyy(onlineTraningSchVO.getYyyy());
        onlineTraningVO.setTerm(onlineTraningSchVO.getTerm());
        onlineTraningVO.setSubjectCode(onlineTraningSchVO.getSubjectCode());
        onlineTraningVO.setSubjectClass(onlineTraningSchVO.getSubjectClass());
        onlineTraningVO = onlineTraningService.getOnlineTraningStand(onlineTraningVO);
        model.addAttribute("onlineTraningVO", onlineTraningVO);
		
		 
  		// View호출
		return retView;
	}
}
