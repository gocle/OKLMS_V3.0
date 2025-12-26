package kr.co.gocle.oklms.lu.traningstatus.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.gocle.ifx.vo.AunuriMemberVO;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentItemSubItemListVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.member.service.MemberService;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.service.ActivityService;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.main.service.LmsUserMainPageService;
import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;
import kr.co.gocle.oklms.lu.member.service.MemberStdService;
import kr.co.gocle.oklms.lu.member.vo.MemberSearchVO;
import kr.co.gocle.oklms.lu.online.service.OnlineTraningService;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.report.service.ReportService;
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;
import kr.co.gocle.oklms.lu.traning.service.TraningNoteSerivce;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;
import kr.co.gocle.oklms.lu.traningstatus.service.TraningStatusService;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningReportVO;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningStatusVO;

import org.apache.commons.collections.ListUtils;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class TraningStatusController  extends BaseController{

	private static final Logger LOG = LoggerFactory.getLogger(TraningStatusController.class);
	
	@Resource(name = "ReportService")
	private ReportService reportService;
	
	@Resource(name = "OnlineTraningService")
	private OnlineTraningService onlineTraningService;
	
	@Resource(name = "TraningStatusService")
	private TraningStatusService traningStatusService;

	@Resource(name = "traningNoteSerivce")
	private TraningNoteSerivce traningNoteSerivce;
	
	@Resource(name = "LmsUserMainPageService")
	private LmsUserMainPageService lmsUserMainPageService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	@Resource(name = "SubjectService")
	private SubjectService subjectService;
	
	@Resource(name = "MemberStdService")
	private MemberStdService memberStdService;
	
	@Resource(name = "ActivityService")
	private ActivityService activityService;
	
	//학습근로자 관리 (교수)
  	@RequestMapping(value = "/lu/traningstatus/listTraningstatusPrt.do")
	public String listTraningstatusPrt(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listTraningstatusPrt.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		 
		traningStatusVO.setYyyy((String)httpSession.getAttribute(Globals.YYYY));
		traningStatusVO.setTerm((String)httpSession.getAttribute(Globals.TERM));
		traningStatusVO.setSubjectCode((String)httpSession.getAttribute(Globals.SUBJECT_CODE));
		
		
		String traningType= (String)httpSession.getAttribute(Globals.SUBJECT_TRANING_TYPE);
		
		if( traningType.equals("OJT")){
			traningStatusVO.setClassId("");
		}else{
			traningStatusVO.setClassId((String)httpSession.getAttribute(Globals.CLASS));
		}
		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());		
		currProcVO.setSubClass(traningStatusVO.getClassId());
		
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);

		// 출석정책조회
		OnlineTraningVO onlineTraningVO = new OnlineTraningVO();
		onlineTraningVO.setYyyy(traningStatusVO.getYyyy());
		onlineTraningVO.setTerm(traningStatusVO.getTerm());
		onlineTraningVO.setSubjectCode(traningStatusVO.getSubjectCode());
		onlineTraningVO.setSubjectClass(traningStatusVO.getClassId());
		
		onlineTraningVO = onlineTraningService.getOnlineTraningStand(onlineTraningVO);
		model.addAttribute("onlineTraningVO", onlineTraningVO);
		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);
		
		//전체조회 목록
		List<TraningStatusVO> resultlist = traningStatusService.listTraningStatus(traningStatusVO);
		model.addAttribute("resultlist", resultlist);
				
 
		// 주차정보 
		List<OnlineTraningSchVO> onlineTraningSchVO =reportService.listLmsSubjWeek(currProcVO);
		model.addAttribute("onlineTraningSchVO", onlineTraningSchVO);
		
		if( httpSession==null || traningStatusVO.getSubjectCode()==null ||traningStatusVO.getSubjectCode().equals("")  ){
			retMsg = "교과정보가 없습니다.";
			retMsg = URLEncoder.encode( retMsg ,"UTF-8");
			logger.debug("#### retMsg=" + retMsg );
			return "redirect:/lu/main/lmsUserMainPage.do?retMsgEncode="+ retMsg;
		}
		 
		
		// 주차정보없을때 첫번째주차 정보입력
		if(traningStatusVO.getWeekCnt()==null||traningStatusVO.getWeekCnt().equals("")){
			// 최근주차정보조회
			TraningNoteVO  traningNowWeekCn = traningNoteSerivce.getTraningNowWeekCnt(traningStatusVO);	
			if(traningNowWeekCn.getWeekCnt()==null||traningNowWeekCn.getWeekCnt().equals("")){
				traningStatusVO.setWeekCnt("1");
			}else{
				traningStatusVO.setWeekCnt(traningNowWeekCn.getWeekCnt());
			}
		}

		//상세조회 목록
		List<TraningStatusVO> resultBottomlist = traningStatusService.listTraningStatusDetail(traningStatusVO);
		model.addAttribute("resultBottomlist", resultBottomlist);
		
		
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
		if(traningStatusVO.getMode()==1){
			// 인쇄페이지
			if(currProcVO!=null && currProcVO.getSubjectTraningType().equals("OFF")){
	
	
				return "oklms_popup/lu/traningstatus/printTraningstatusPrtOff";			
			}else{
	
	
				return "oklms_popup/lu/traningstatus/printTraningstatusPrtOjt";
			}
	
		}else{
			// 조회페이지			
			if(currProcVO!=null && currProcVO.getSubjectTraningType().equals("OFF")){
	
	
				return "oklms/lu/traningstatus/listTraningstatusPrtOff";			
			}else{
	
	
				return "oklms/lu/traningstatus/listTraningstatusPrtOjt";
			}
		}
	}

	//학습근로자 관리 (교수) 출석부
  	@RequestMapping(value = "/lu/traningstatus/popupTraningstatusPrt.do")
	public String popupTraningstatusPrt(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/popupTraningstatusPrt.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubClass(traningStatusVO.getClassId());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);
 
		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);
		
		if(currProcVO!=null && currProcVO.getSubjectTraningType().equals("OFF")){
			if(traningStatusVO.getSearchCondition().equals("offline") ){
	
				//전체조회 목록
				List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOff(traningStatusVO);
				model.addAttribute("resultlist", resultlist);
						
				model.addAttribute("traningStatusVO", traningStatusVO);		
				
				return "oklms_popup/lu/traningstatus/popupAttendanceRecord";	
			}else{
	
				//전체조회 목록
				List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOnlineOff(traningStatusVO);
				model.addAttribute("resultlist", resultlist);					 
						
				model.addAttribute("traningStatusVO", traningStatusVO);		
				
				return "oklms_popup/lu/traningstatus/popupOnlineAttendanceRecord";
				
			}
		}else{
			
			//회사정보
			List<TraningNoteVO> subjectNameList = traningNoteSerivce.listSubjcetName(traningStatusVO);
			model.put("subjectNameList", subjectNameList); 
				//전체조회 목록
				List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOff(traningStatusVO);
				model.addAttribute("resultlist", resultlist);
						
				model.addAttribute("traningStatusVO", traningStatusVO);		
				
			return "oklms_popup/lu/traningstatus/popupAttendanceRecordOjt";	
		}			

	}

	//학습근로자 관리 (교수OFF) 출석부 엑셀다운로드
  	@RequestMapping(value = "/lu/traningstatus/excelTraningstatusPrt.do")
	public String excelTraningstatusPrt(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/excelTraningstatusPrt.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		 

		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubClass(traningStatusVO.getClassId());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);
 
		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);
		
		
		request.setAttribute("ExcelName", URLEncoder.encode( "출석부".replaceAll(" ", "_") ,"UTF-8") );
        
		 
		if(traningStatusVO.getSearchCondition().equals("offline") ){

			//전체조회 목록
			List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOff(traningStatusVO);
			model.addAttribute("resultlist", resultlist);
					
			model.addAttribute("traningStatusVO", traningStatusVO);		
			
		}else{

			//전체조회 목록
			List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOnlineOff(traningStatusVO);
			model.addAttribute("resultlist", resultlist);					 
					
			model.addAttribute("traningStatusVO", traningStatusVO);		
			
			
		}
		return "oklms_excel/lu/traningstatus/excelAttendanceRecord";		

	}

	//학습근로자 관리 (기업현장교사)
  	@RequestMapping(value = "/lu/traningstatus/listTraningstatusCot.do")
	public String listTraningstatusCot(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listTraningstatusCot.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.

		traningStatusVO.setYyyy((String)httpSession.getAttribute(Globals.YYYY));
		traningStatusVO.setTerm((String)httpSession.getAttribute(Globals.TERM));
		traningStatusVO.setClassId((String)httpSession.getAttribute(Globals.CLASS));
		traningStatusVO.setSubjectCode((String)httpSession.getAttribute(Globals.SUBJECT_CODE));

		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());		
		currProcVO.setSubClass(traningStatusVO.getClassId());

		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);

		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);

		//전체조회 목록
		List<TraningStatusVO> resultlist = traningStatusService.listTraningStatus(traningStatusVO);
		model.addAttribute("resultlist", resultlist);

		// 주차정보 
		List<OnlineTraningSchVO> onlineTraningSchVO =reportService.listLmsSubjWeek(currProcVO);
		model.addAttribute("onlineTraningSchVO", onlineTraningSchVO);
		
		if( httpSession==null || traningStatusVO.getSubjectCode()==null ||traningStatusVO.getSubjectCode().equals("")  ){
			retMsg = "교과정보가 없습니다.";
			retMsg = URLEncoder.encode( retMsg ,"UTF-8");
			logger.debug("#### retMsg=" + retMsg );
			return "redirect:/lu/main/lmsUserMainPage.do?retMsgEncode="+ retMsg;
		}
		 
		
		// 주차정보없을때 첫번째주차 정보입력
		if(traningStatusVO.getWeekCnt()==null||traningStatusVO.getWeekCnt().equals("")){
			// 최근주차정보조회
			TraningNoteVO  traningNowWeekCn = traningNoteSerivce.getTraningNowWeekCnt(traningStatusVO);	
			if(traningNowWeekCn.getWeekCnt()==null||traningNowWeekCn.getWeekCnt().equals("")){
				traningStatusVO.setWeekCnt("1");
			}else{
				traningStatusVO.setWeekCnt(traningNowWeekCn.getWeekCnt());
			}
		}

		//상세조회 목록
		List<TraningStatusVO> resultBottomlist = traningStatusService.listTraningStatusDetail(traningStatusVO);
		model.addAttribute("resultBottomlist", resultBottomlist);
		
		
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
		if(traningStatusVO.getMode()==1){
			// 인쇄페이지
			
				return "oklms_popup/lu/traningstatus/printTraningstatusPrtOjt";

		}else{
			// 조회페이지
			
				return "oklms/lu/traningstatus/listTraningstatusCotOjt";
		}
	}

	//학습근로자 관리 (기업현장교사 출석부)
  	@RequestMapping(value = "/lu/traningstatus/popupTraningstatusCot.do")
	public String popupTraningstatusCot(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/popupTraningstatusCot.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubClass(traningStatusVO.getClassId());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);
 
		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);
		
		//전체조회 목록
		List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOff(traningStatusVO);
		model.addAttribute("resultlist", resultlist);
				
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
		return "oklms_popup/lu/traningstatus/popupAttendanceRecord";	
	}  	

	//학습근로자 관리 (학과전담자)
  	@RequestMapping(value = "/lu/traningstatus/listTraningstatusCdp.do")
	public String listTraningstatusCdp(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listTraningstatusCdp.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.

		traningStatusVO.setYyyy((String)httpSession.getAttribute(Globals.YYYY));
		traningStatusVO.setTerm((String)httpSession.getAttribute(Globals.TERM));
		traningStatusVO.setClassId((String)httpSession.getAttribute(Globals.CLASS));
		traningStatusVO.setSubjectCode((String)httpSession.getAttribute(Globals.SUBJECT_CODE));

		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());		
		currProcVO.setSubClass(traningStatusVO.getClassId());

		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);

		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);

		//전체조회 목록
		List<TraningStatusVO> resultlist = traningStatusService.listTraningStatus(traningStatusVO);
		model.addAttribute("resultlist", resultlist);

		// 주차정보 
		List<OnlineTraningSchVO> onlineTraningSchVO =reportService.listLmsSubjWeek(currProcVO);
		model.addAttribute("onlineTraningSchVO", onlineTraningSchVO);
		
		if( httpSession==null || traningStatusVO.getSubjectCode()==null ||traningStatusVO.getSubjectCode().equals("")  ){
			retMsg = "교과정보가 없습니다.";
			retMsg = URLEncoder.encode( retMsg ,"UTF-8");
			logger.debug("#### retMsg=" + retMsg );
			return "redirect:/lu/main/lmsUserMainPage.do?retMsgEncode="+ retMsg;
		}
		 
		
		// 주차정보없을때 첫번째주차 정보입력
		if(traningStatusVO.getWeekCnt()==null||traningStatusVO.getWeekCnt().equals("")){
			// 최근주차정보조회
			TraningNoteVO  traningNowWeekCn = traningNoteSerivce.getTraningNowWeekCnt(traningStatusVO);	
			if(traningNowWeekCn.getWeekCnt()==null||traningNowWeekCn.getWeekCnt().equals("")){
				traningStatusVO.setWeekCnt("1");
			}else{
				traningStatusVO.setWeekCnt(traningNowWeekCn.getWeekCnt());
			}
		}

		//상세조회 목록
		List<TraningStatusVO> resultBottomlist = traningStatusService.listTraningStatusDetail(traningStatusVO);
		model.addAttribute("resultBottomlist", resultBottomlist);
		
		
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
		if(traningStatusVO.getMode()==1){
			// 인쇄페이지
			
				return "oklms_popup/lu/traningstatus/printTraningstatusCdpOff";

		}else{
			// 조회페이지
			
				return "oklms/lu/traningstatus/listTraningstatusCdpOff";
		}
	}  	
	//학습근로자 관리 (학과전담자 출석부)
  	@RequestMapping(value = "/lu/traningstatus/popupTraningstatusCdp.do")
	public String popupTraningstatusCdp(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/popupTraningstatusCdp.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubClass(traningStatusVO.getClassId());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);
 
		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);
		
		
		//전체조회 목록
		List<TraningStatusVO> resultlist = traningStatusService.popupAttendListOnlineOff(traningStatusVO);
		model.addAttribute("resultlist", resultlist);					 
				
		model.addAttribute("traningStatusVO", traningStatusVO);		
		 
		
		return "oklms_popup/lu/traningstatus/popupOnlineAttendanceRecordCdp";	
	}

	//학습근로자 관리(학과전담자 훈련현황) 엑셀다운로드
  	@RequestMapping(value = "/lu/traningstatus/excelTraningstatusCdp.do")
	public String excelTraningstatusCdp(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/excelTraningstatusCdp.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.

		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());		
		currProcVO.setSubClass(traningStatusVO.getClassId());

		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);

		//권장진도율 조회
		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
		model.addAttribute("getProgress", getProgress);

		//전체조회 목록
		List<TraningStatusVO> resultlist = traningStatusService.listTraningStatus(traningStatusVO);
		model.addAttribute("resultlist", resultlist);
  
		
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
		
		request.setAttribute("ExcelName", URLEncoder.encode( "현황".replaceAll(" ", "_") ,"UTF-8") );
        
		  
		return "oklms_excel/lu/traningstatus/excelAttendanceRecordCdp";		

	}
  	
  	
  	//학습근로자 관리 (교과목별 훈련형황)
  	@RequestMapping(value = "/lu/traning/listTraningReport.do")
	public String listTraningReport(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traning/listTraningReport.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.


		// 과정 및 주차기준정보 조회
		List<TraningStatusVO> listSubject = traningStatusService.listSubject(traningStatusVO);
		
		model.addAttribute("resultList", listSubject);
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
			
		return "oklms/lu/traningstatus/listTraningReport";
	}
  	
  	
  	@RequestMapping(value = "/lu/traning/listTraningReport.json")
	public @ResponseBody Map<String, Object> listTraningReport(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmTraningstatus") TraningReportVO traningReportVO 
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
		String subjectTraningType = (String) commandMap.get("subjectTraningType");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningReportVO); // session의 정보를 VO에 추가.
		
		traningReportVO.setYyyy(yyyy);
		traningReportVO.setTerm(term);
		traningReportVO.setSubjectCode(subjectCode);
		traningReportVO.setSubjectClass(subjectClass);
		traningReportVO.setSubjectTraningType(subjectTraningType);
		
		try {
		   
		   	List<TraningReportVO> listSubjectWeek = traningStatusService.listSubjectWeek(traningReportVO);
		   	List<TraningReportVO> listSubjectTraning = null;
		   	
		   	if(subjectTraningType.equals("OJT")){
		   		listSubjectTraning = traningStatusService.listSubjectTraning(traningReportVO);
		   	} else {
		   		listSubjectTraning = traningStatusService.listSubjectTraningOff(traningReportVO);
		   	}
		   	
		   	
			List<TraningReportVO> listSubjectReport = traningStatusService.listSubjectReport(traningReportVO);
			List<TraningReportVO> listSubjectActivity = traningStatusService.listSubjectActivity(traningReportVO);
			List<TraningReportVO> listSubjectOnline = traningStatusService.listSubjectOnline(traningReportVO);
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("listSubjectWeek", listSubjectWeek);
			returnMap.put("listSubjectTraning", listSubjectTraning);
			returnMap.put("listSubjectReport", listSubjectReport);
			returnMap.put("listSubjectActivity", listSubjectActivity);
			returnMap.put("listSubjectOnline", listSubjectOnline);
		
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
  	
  	
  //학습근로자 관리 (교과목별 훈련형황)
  	@RequestMapping(value = "/lu/traning/listTraningComplete.do")
	public String listTraningComplete(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traning/listTraningComplete.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
  		MemberSearchVO memberVO = new MemberSearchVO();
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(memberVO); // session의 정보를 VO에 추가.
		
		String searchMemId = StringUtils.defaultString(traningStatusVO.getSearchMemId(),"");
		
		// 학생 본인이 아니라 검색을 통해 들어올경우 세변변수에 검색값을 넣어줌
		if(!searchMemId.equals("")){
			traningStatusVO.setSessionMemId(searchMemId);
			memberVO.setSessionMemId(searchMemId);
		}

		traningStatusVO.setYyyy((String)httpSession.getAttribute(Globals.YYYY));
		traningStatusVO.setTerm((String)httpSession.getAttribute(Globals.TERM));
		traningStatusVO.setClassId((String)httpSession.getAttribute(Globals.CLASS));
		traningStatusVO.setSubjectCode((String)httpSession.getAttribute(Globals.SUBJECT_CODE));

		memberVO = memberStdService.getMemberInfo( memberVO );
		model.addAttribute("memberVO", memberVO);

		List<TraningStatusVO> resultList = traningStatusService.listTraningComplete(traningStatusVO);
		model.addAttribute("resultList", resultList);
		
		if(loginInfo.getMemType().equals("CCN")){
			return "oklms/lu/traningstatus/listTraningCompleteCcn";
		} else {
			return "oklms/lu/traningstatus/listTraningComplete";
		}
	}
  	
  //학습근로자 관리 (교과목별 훈련형황)
  	@RequestMapping(value = "/lu/traning/listTraningOff.do")
	public String listTraningOff(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traning/listTraningOff.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.



		List<TraningStatusVO> resultList = traningStatusService.listTraningOff(traningStatusVO);
		model.addAttribute("resultList", resultList);
		
		model.addAttribute("traningStatusVO", traningStatusVO);		
			
		return "oklms/lu/traningstatus/listTraningOff";
	}
  	
  //학습근로자 관리 (교과목별 훈련형황)
  	@RequestMapping(value = "/lu/traning/listTraningStatusCcn.do")
	public String listTraningStatusCcn(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traning/listTraningStatusCcn.do" );
  		
  		LmsUserMainPageVO mainPageVO = new LmsUserMainPageVO();
  		
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(mainPageVO); // session의 정보를 VO에 추가.

		// 기업체현황조회
		List<LmsUserMainPageVO> listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCcnCnt(mainPageVO);
		model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
		
		
		model.addAttribute("traningStatusVO", traningStatusVO);		
		
			
		return "oklms/lu/traningstatus/listTraningStatusCcn";
	}
  	
  	
  	@RequestMapping(value = "/lu/traning/listTraningStatusCcn.json")
	public @ResponseBody Map<String, Object> listTraningStatusCcn(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmTraningstatus") TraningReportVO traningStatusVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
  		
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		String year = (String) commandMap.get("year");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		traningStatusVO.setYear(year);
		
		try {
		   
		   	List<TraningReportVO> listTraningStatusCcn = traningStatusService.listTraningStatusCcn(traningStatusVO);
			model.addAttribute("listTraningStatusCcn", listTraningStatusCcn);
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("listTraningStatusCcn", listTraningStatusCcn);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
  	
  //학습근로자 관리 (교과목별 훈련형황)
  	@RequestMapping(value = "/lu/traning/listTraningMappingStatusCcn.do")
	public String listTraningMappingStatusCcn(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traning/listTraningMappingStatusCcn.do" );
  		
  		LmsUserMainPageVO mainPageVO = new LmsUserMainPageVO();
  		
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(mainPageVO); // session의 정보를 VO에 추가.

		
			
		return "oklms/lu/traningstatus/listTraningMappingStatusCcn";
	}
  	
  	
  	@RequestMapping(value = "/lu/traning/listTraningSubjectStatusCcn.json")
	public @ResponseBody Map<String, Object> listTraningSubjectStatusCcn(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmTraningstatus") TraningReportVO traningStatusVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
  		
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "SUCCESS";
		String retMsg = "";
		
		String traningProcessId = (String) commandMap.get("traningProcessId");
		String companyId = (String) commandMap.get("companyId");
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		traningStatusVO.setTraningProcessId(traningProcessId);
		traningStatusVO.setCompanyId(companyId);
		
		try {
		   
		   	List<TraningReportVO> listTraningSubjectStatusCcn = traningStatusService.listTraningSubjectStatusCcn(traningStatusVO);
			model.addAttribute("listTraningSubjectStatusCcn", listTraningSubjectStatusCcn);
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("listTraningSubjectStatusCcn", listTraningSubjectStatusCcn);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
  	
  	
  //학습근로자 관리 (학과전담자 출석부)
  	@RequestMapping(value = "/lu/traningstatus/listOnlineTraningstatusCcn.do")
	public String listOnlineTraningstatusCcn(@ModelAttribute("frmTraningstatus") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listOnlineTraningstatusCcn.do" );
  		
  		TraningStatusVO traningStatusVO = new TraningStatusVO();
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		
		List<SubjectVO> subjectList = subjectService.listSubjectOnlineCcn(subjectVO); // 학과
		model.addAttribute("subjectList", subjectList);
 
		traningStatusVO.setYyyy(subjectVO.getYyyy());
		traningStatusVO.setTerm(subjectVO.getTerm());
		traningStatusVO.setSubjectCode(subjectVO.getSubjectCode());
		traningStatusVO.setClassId(subjectVO.getSubjectClass());
		
		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubClass(traningStatusVO.getClassId());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);
		
		// 전체조회 목록
		
		// 주차
		// List<TraningStatusVO> resultlis = traningStatusService.popupAttendListOnlineOff(traningStatusVO);
		
		// 차시
		// List<TraningStatusVO> resultlis = traningStatusService.popupAttendListOnlineScheduleOff(traningStatusVO);
		
		//model.addAttribute("resultlist", resultlis);					 
				
		model.addAttribute("subjectVO", subjectVO);		
		
		return "oklms/lu/traningstatus/listOnlineTraningStatusCcn";	
		 
	}
  	
  	@RequestMapping(value = "/lu/traningstatus/listOnlineScheduleAttend.json")
	public @ResponseBody Map<String, Object> listOnlineScheduleAttend(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmTraningstatus") TraningReportVO traningReportVO 
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
		loginInfo.putSessionToVo(traningReportVO); // session의 정보를 VO에 추가.
		
		traningReportVO.setYyyy(yyyy);
		traningReportVO.setTerm(term);
		traningReportVO.setSubjectCode(subjectCode);
		traningReportVO.setSubjectClass(subjectClass);
		
		try {
		   
		   	List<TraningReportVO> resultList = traningStatusService.listOnlineScheduleAttend(traningReportVO);
			
			
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);
			returnMap.put("resultList", resultList);
			
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
  	
  	
  //학습근로자 관리 (학과전담자 출석부)
  	@RequestMapping(value = "/lu/traningstatus/listCompanyTraningProcessCcn.do")
	public String listCompanyTraningProcessCcn(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listCompanyTraningstatusCcn.do" );
  		
  		TraningReportVO traningReportVO =  new TraningReportVO();
		LmsUserMainPageVO lmsUserMainPageVO = new LmsUserMainPageVO();
  		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(traningReportVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(lmsUserMainPageVO); // session의 정보를 VO에 추가.
		
		Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		
		String searchTab = StringUtils.defaultString(traningStatusVO.getSearchTab(),"note");
		String searchYear = StringUtils.defaultString(traningStatusVO.getYear(), String.valueOf(year));
		String searchTraningProcess = StringUtils.defaultString((String) commandMap.get("searchTraningProcess"),"");
		
		if(!searchTraningProcess.equals("") && searchTraningProcess.indexOf("|") != -1){
			traningStatusVO.setTraningProcessId(searchTraningProcess.split("\\|")[0]);
			traningStatusVO.setCompanyId(searchTraningProcess.split("\\|")[1]);
			traningStatusVO.setTraningProcessManageId(searchTraningProcess.split("\\|")[2]);
		}
	
		model.addAttribute("searchTab", searchTab);
		model.addAttribute("searchYear", searchYear);
		
		// 1.실시년도
		List<TraningStatusVO> listTraningYear = traningStatusService.listTraningYear(traningStatusVO);
		model.addAttribute("listTraningYear", listTraningYear);
		
		// 2.실시년도 훈련과정
		traningReportVO.setYear(searchYear);
		List<TraningReportVO> listTraningStatusCcn = traningStatusService.listTraningStatusCcn(traningReportVO);
		model.addAttribute("listTraningStatusCcn", listTraningStatusCcn);
		
		
		if(searchTab.equals("act")){
			
			if(traningStatusVO.getTraningProcessId() != null && traningStatusVO.getCompanyId() != null && traningStatusVO.getTraningProcessManageId() != null){
				List<TraningStatusVO> resultList = traningStatusService.listCompanyTraningProcessAct(traningStatusVO);
				model.addAttribute("resultList", resultList);
			}
			
			return "oklms/lu/traningstatus/listCompanyTraningProcessActCcn";
		} else if(searchTab.equals("eval")){

			if(traningStatusVO.getTraningProcessId() != null && traningStatusVO.getCompanyId() != null && traningStatusVO.getTraningProcessManageId() != null){
				
				// 3.실시년도 훈련과정의 교과목
				traningReportVO.setTraningProcessId(traningStatusVO.getTraningProcessId());
				traningReportVO.setCompanyId(traningStatusVO.getCompanyId());
				List<TraningReportVO> listTraningSubjectStatusCcn = traningStatusService.listTraningNcsSubjectStatusCcn(traningReportVO);
				model.addAttribute("listTraningSubjectStatusCcn", listTraningSubjectStatusCcn);
				
				if( traningStatusVO.getYyyy() != null && traningStatusVO.getTerm() != null && traningStatusVO.getSubjectCode() != null && traningStatusVO.getSubjectClass() != null ){
					List<TraningStatusVO> resultList = traningStatusService.listCompanyTraningProcessEval(traningStatusVO);
					model.addAttribute("resultList", resultList);
				}
				
			}
			return "oklms/lu/traningstatus/listCompanyTraningProcessEvalCcn";
		} else {

			if(traningStatusVO.getTraningProcessId() != null && traningStatusVO.getCompanyId() != null && traningStatusVO.getTraningProcessManageId() != null ){
				
				List<TraningStatusVO> resultList = traningStatusService.listCompanyTraningProcessNote(traningStatusVO);
				model.addAttribute("resultList", resultList);
			}
			return "oklms/lu/traningstatus/listCompanyTraningProcessCcn";
		}
		
			
	}
  	
  //학습근로자 관리 (학과전담자 출석부)
  	@RequestMapping(value = "/lu/traningstatus/getCompanyTraningProcessCcn.do")
	public String getCompanyTraningProcessCcn(@RequestParam Map<String, Object> commandMap,@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listCompanyTraningstatusCcn.do" );
  		
  		TraningReportVO traningReportVO =  new TraningReportVO();
		LmsUserMainPageVO lmsUserMainPageVO = new LmsUserMainPageVO();
  		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(traningReportVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(lmsUserMainPageVO); // session의 정보를 VO에 추가.
		
		Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		
		String searchTab = StringUtils.defaultString(traningStatusVO.getSearchTab(),"note");
		String searchYear = StringUtils.defaultString(traningStatusVO.getYear(), String.valueOf(year));
		String searchTraningProcess = StringUtils.defaultString((String) commandMap.get("searchTraningProcess"),"");
		
		if(!searchTraningProcess.equals("") && searchTraningProcess.indexOf("|") != -1){
			traningStatusVO.setTraningProcessId(searchTraningProcess.split("\\|")[0]);
			traningStatusVO.setCompanyId(searchTraningProcess.split("\\|")[1]);
			traningStatusVO.setTraningProcessManageId(searchTraningProcess.split("\\|")[2]);
		}
	
		model.addAttribute("searchTab", searchTab);
		model.addAttribute("searchYear", searchYear);
		
		// 1.실시년도
		List<TraningStatusVO> listTraningYear = traningStatusService.listTraningYear(traningStatusVO);
		model.addAttribute("listTraningYear", listTraningYear);
		
		// 2.실시년도 훈련과정
		traningReportVO.setYear(searchYear);
		List<TraningReportVO> listTraningStatusCcn = traningStatusService.listTraningStatusCcn(traningReportVO);
		model.addAttribute("listTraningStatusCcn", listTraningStatusCcn);
		
		if(searchTab.equals("act")){
			ActivityVO activityVO = new ActivityVO();
			activityVO.setYyyy(traningStatusVO.getYyyy());
			activityVO.setTerm(traningStatusVO.getTerm());
			activityVO.setSubjectCode(traningStatusVO.getSubjectCode());
			activityVO.setSubjectClass(traningStatusVO.getSubjectClass());
			activityVO.setMemId(traningStatusVO.getMemId());
			
			List<ActivityVO> resultList = activityService.listActivityCcn(activityVO);
			model.put("resultList", resultList);
			
			return "oklms/lu/traningstatus/getCompanyTraningProcessActCcn";
		} else {
			
			TraningNoteVO traningNoteVO = new TraningNoteVO();
			traningNoteVO.setYyyy(traningStatusVO.getYyyy());
			traningNoteVO.setTerm(traningStatusVO.getTerm());
			traningNoteVO.setSubjectCode(traningStatusVO.getSubjectCode());
			traningNoteVO.setClassId(traningStatusVO.getSubjectClass());
		
			List<TraningNoteVO> resultList =traningNoteSerivce.listTraningNoteCcn(traningNoteVO);
			model.put("resultList", resultList);

			
			return "oklms/lu/traningstatus/getCompanyTraningProcessCcn";
		}
		
			
	}
  	
  //학습근로자 관리 (학과전담자 출석부)
  	@RequestMapping(value = "/lu/traningstatus/listCompanyTraningProcessCcm.do")
	public String listCompanyTraningProcessCcm(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listCompanyTraningProcessCcm.do" );
  		
  		TraningReportVO traningReportVO =  new TraningReportVO();
		LmsUserMainPageVO lmsUserMainPageVO = new LmsUserMainPageVO();
  		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(traningReportVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(lmsUserMainPageVO); // session의 정보를 VO에 추가.
		
		Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		
		String searchTab = StringUtils.defaultString(traningStatusVO.getSearchTab(),"note");
		String searchYear = StringUtils.defaultString(traningStatusVO.getYear(), String.valueOf(year));
		
		model.addAttribute("searchTab", searchTab);
		model.addAttribute("searchYear", searchYear);
		
		// 1.실시년도
		List<TraningStatusVO> listTraningYear = traningStatusService.listTraningYear(traningStatusVO);
		model.addAttribute("listTraningYear", listTraningYear);
		
		// 2.실시년도 훈련과정
		traningReportVO.setYear(searchYear);
		List<TraningReportVO> listTraningStatusCcn = traningStatusService.listTraningStatusCcn(traningReportVO);
		model.addAttribute("listTraningStatusCcn", listTraningStatusCcn);
		
		
		if(searchTab.equals("act")){
			
			if(traningStatusVO.getTraningProcessId() != null && traningStatusVO.getCompanyId() != null ){
				List<TraningStatusVO> resultList = traningStatusService.listCompanyTraningProcessAct(traningStatusVO);
				model.addAttribute("resultList", resultList);
			}
			
			return "oklms/lu/traningstatus/listCompanyTraningProcessActCcm";
		} else if(searchTab.equals("eval")){

			if(traningStatusVO.getTraningProcessId() != null && traningStatusVO.getCompanyId() != null ){
				
				// 3.실시년도 훈련과정의 교과목
				traningReportVO.setTraningProcessId(traningStatusVO.getTraningProcessId());
				traningReportVO.setCompanyId(traningStatusVO.getCompanyId());
				List<TraningReportVO> listTraningSubjectStatusCcn = traningStatusService.listTraningNcsSubjectStatusCcn(traningReportVO);
				model.addAttribute("listTraningSubjectStatusCcn", listTraningSubjectStatusCcn);
				
				if( traningStatusVO.getYyyy() != null && traningStatusVO.getTerm() != null && traningStatusVO.getSubjectCode() != null && traningStatusVO.getSubjectClass() != null ){
					List<TraningStatusVO> resultList = traningStatusService.listCompanyTraningProcessEval(traningStatusVO);
					model.addAttribute("resultList", resultList);
				}
				
			}
			return "oklms/lu/traningstatus/listCompanyTraningProcessEvalCcm";
		} else {

			if(traningStatusVO.getTraningProcessId() != null && traningStatusVO.getCompanyId() != null ){
				
				List<TraningStatusVO> resultList = traningStatusService.listCompanyTraningProcessNote(traningStatusVO);
				model.addAttribute("resultList", resultList);
			}
			return "oklms/lu/traningstatus/listCompanyTraningProcessCcm";
		}
		
			
	}
  	
  	
  	//학습근로자 관리 (학과전담자 출석부)
  	@RequestMapping(value = "/lu/traningstatus/listCompanyTraningstatusCcn.do")
	public String listCompanyTraningstatusCcn(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listCompanyTraningstatusCcn.do" );
  		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
 
		
		// 과정정보
  		CurrProcVO currProcVO=new CurrProcVO();
		currProcVO.setYyyy(traningStatusVO.getYyyy());
		currProcVO.setTerm(traningStatusVO.getTerm());
		currProcVO.setSubClass(traningStatusVO.getClassId());
		currProcVO.setSubjectCode(traningStatusVO.getSubjectCode());
		currProcVO = reportService.getCurrproc(currProcVO);  		
		model.addAttribute("currProcVO", currProcVO);
		
		//전체조회 목록
		List<TraningStatusVO> resultlis = traningStatusService.popupAttendListOnlineOff(traningStatusVO);
		
		model.addAttribute("resultlist", resultlis);				
		 
		
		return "oklms/lu/traningstatus/listCompanyTraningstatusCcn";	
	}
  	
  	
  //학습근로자 관리 (교수OFF) 출석부 엑셀다운로드
  	@RequestMapping(value = "/lu/traningstatus/excelOnlineScheduleAttend.do")
	public String excelOnlineScheduleAttend(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/excelOnlineScheduleAttend.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		 

		// 과정정보
  		SubjectVO subjectVO=new SubjectVO();
  		subjectVO.setYyyy(traningStatusVO.getYyyy());
  		subjectVO.setTerm(traningStatusVO.getTerm());
  		subjectVO.setSubjectClass(traningStatusVO.getSubjectClass());
		subjectVO.setSubjectCode(traningStatusVO.getSubjectCode());
		subjectVO = subjectService.getSubjectInfo(subjectVO); 		
		
		model.addAttribute("subjectVO", subjectVO);
		
		request.setAttribute("ExcelName", URLEncoder.encode( subjectVO.getSubjectName()+" 차시별 출석부".replaceAll(" ", "_") ,"UTF-8") );
        
		 
		return "oklms_excel/lu/traningstatus/excelOnlineScheduleAttend";		

	}
  	
  //학습근로자 관리 (학과전담자)
  	@RequestMapping(value = "/lu/traningstatus/listOjtTraningstatusCdp.do")
	public String listOjtTraningstatusCdp(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listTraningstatusCdp.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		if(traningStatusVO.getYyyy()==null || traningStatusVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			traningStatusVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			traningStatusVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		

		List<TraningStatusVO> resultList = traningStatusService.listOjtTraningstatusCdp(traningStatusVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = traningStatusVO.getPageSize();
		Integer page = traningStatusVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(traningStatusVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(traningStatusVO.getPageSize());
        paginationInfo.setPageSize(traningStatusVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		model.addAttribute("traningStatusVO", traningStatusVO);
		
		
		// View호출
		return "oklms/lu/traningstatus/listOjtTraningstatusCdp";
	
	}  
  	
  	@RequestMapping(value = "/lu/traningstatus/listOjtTraningstatusPrt.do")
	public String listOjtTraningstatusPrt(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/listOjtTraningstatusPrt.do" );
		String retMsg = ""; 
  		HttpSession httpSession = request.getSession(); 
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		
		if(traningStatusVO.getYyyy()==null || traningStatusVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			traningStatusVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			traningStatusVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		

		List<TraningStatusVO> resultList = traningStatusService.listOjtTraningstatusCdp(traningStatusVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = traningStatusVO.getPageSize();
		Integer page = traningStatusVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(traningStatusVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(traningStatusVO.getPageSize());
        paginationInfo.setPageSize(traningStatusVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		model.addAttribute("traningStatusVO", traningStatusVO);
		
		
		// View호출
		return "oklms/lu/traningstatus/listOjtTraningstatusPrt";
  	}
  	
  	
  	@RequestMapping(value = "/lu/traningstatus/excelOjtTraningstatus.do")
	public String excelOjtTraningstatus(@ModelAttribute("frmTraningstatus") TraningStatusVO traningStatusVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		LOG.debug("#### URL = /lu/traningstatus/excelOjtTraningstatus.do" );
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
		 
		
		request.setAttribute("ExcelName", URLEncoder.encode( "OJT 운영현황".replaceAll(" ", "_") ,"UTF-8") );
        
		
		List<TraningStatusVO> resultList = traningStatusService.listOjtTraningstatusExcel(traningStatusVO);
		model.addAttribute("resultList", resultList);
		 
		
		return "oklms_excel/lu/traningstatus/excelOjtTraningstatus";		

	}
  	
  	
  	@RequestMapping(value = "/lu/traning/updateLessonPassYn.json")
	public @ResponseBody Map<String, Object> updateLessonPassYn(@ModelAttribute("frmLes") TraningStatusVO traningStatusVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		LOG.debug("#### URL = /lu/online/updateLessonPass.json" );
		
		
		int iResult =  traningStatusService.updateLessonPassYn(traningStatusVO);
		
		if(iResult > 0){
			returnMap.put("retCd", "10000");
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
		}
		return returnMap;
	}
  	
  	@RequestMapping(value = "/lu/traning/updateLessonGrade.json")
	public @ResponseBody Map<String, Object> updateLessonGrade(@ModelAttribute("frmLes") TraningStatusVO traningStatusVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		LOG.debug("#### URL = /lu/online/updateLessonGrade.json" );
		
		
		int iResult = traningStatusService.updateLessonGrade(traningStatusVO);
		
		if(iResult > 0){
			returnMap.put("retCd", "10000");
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
		}
		return returnMap;
	}
	
}