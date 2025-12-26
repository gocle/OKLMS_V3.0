/*******************************************************************************
 * COPYRIGHT(C) 2016 WIZI LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of WIZI LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 12. 28.        First Draft.
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.lu.currproc.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.gocle.ifx.service.CmsIfxService;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentItemSubItemListVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.util.BizUtil;
import kr.co.gocle.oklms.lu.attend.service.AttendService;
import kr.co.gocle.oklms.lu.attend.vo.AttendVO;
import kr.co.gocle.oklms.lu.currproc.service.CurrProcService;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.online.service.OnlineTraningService;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchElemVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;
import kr.co.gocle.oklms.lu.teamproject.vo.TeamprojectVO;
import kr.co.gocle.oklms.lu.traning.service.TraningNoteSerivce;
import kr.co.gocle.oklms.lu.traning.service.TraningService;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO;
import kr.co.gocle.oklms.lu.traningstatus.service.TraningStatusService;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningStatusVO;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;

/**
* Controller 클래스에 대한 내용을 작성한다.
* @author 이진근
* @since 2016. 10. 27.
*/
@Controller
public class CurrProcController extends BaseController{

	@Resource(name = "beanValidatorJSR303")
	Validator validator;
	
	@Resource(name = "SubjectService")
	private SubjectService subjectService;
	
	@Resource(name = "OnlineTraningService")
	private OnlineTraningService onlineTraningService;
	
	@Resource(name = "cmsIfxService")
	private CmsIfxService cmsIfxService;
	
	@Resource(name = "AttendService")
	private AttendService attendService;
	
	@Resource(name = "traningNoteSerivce")
	private TraningNoteSerivce traningNoteSerivce;
	
	@Resource(name = "TraningStatusService")
	private TraningStatusService traningStatusService;
	
	@Resource(name = "currProcService")
	private CurrProcService currProcService;
	
	@Resource(name = "traningService")
	private TraningService traningService;
	
	
	@InitBinder
	public void initBinder(WebDataBinder dataBinder){
		try {
			dataBinder.setValidator(this.validator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 관리자 > 강의실관리 > 강의관리 > 기본정보 목록 메소드
	@RequestMapping(value = "/lu/currproc/listCurrProc.do")
	public String listCurrProc(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		//subjectTraningType=OFF&year=2017&term=1&subjectCode=MEM360&subClass=01&weekCnt=1
		//subjectTraningType=OJT&year=2017&term=1&subjectCode=MEM370&subClass=01&weekCnt=1
		/*====================================================================
    	* 초기화 영역
    	====================================================================*/
		String returnUrl = "";
		String subjectTraningType	= "";   //과목구분코드(OJT:OJT, OFF-JT:OFF)
		String yyyy	= ""; 			//학년도
	    String term	= ""; 			//학기
	    String subjectCode	= ""; 	//교과목코드
	    String subjectName	= ""; 	//교과목명
	    String classs	= ""; 		//분반
	    String weekCnt	= ""; 		//학습주차
	    String lecMenuMarkYn	= ""; //교과별 강의 메뉴 표시여부
	    String preSubjectCode = ""; // 이전교과코드 (진행중인 교과X)
	    String onlineType = ""; // 온라인교과타입
	    String subjectType = "";
	    String retUrl = "";
	    //String subjectIdParam	= ""; 	// 교과별-교과목
	    CurrProcVO currProcVO = new CurrProcVO();
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		SubjectVO subjectVO = new SubjectVO();
		OnlineTraningVO onlineTraningVO = new OnlineTraningVO();
		TraningVO traningVO = new TraningVO();
		loginInfo.putSessionToVo(currProcVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
        loginInfo.putSessionToVo(onlineTraningVO); // session의 정보를 VO에 추가.
        loginInfo.putSessionToVo(traningVO); // session의 정보를 VO에 추가.
        
        String sessionMemName = subjectVO.getSessionMemName();
        logger.debug("sessionMemName1 : " + sessionMemName );
        logger.debug("getSessionMemType : " + subjectVO.getSessionMemType() );
		
		/*====================================================================
    	* 초기값 셋팅 영역
    	====================================================================*/
		subjectTraningType = (String) commandMap.get("subjectTraningType");
		yyyy = (String) commandMap.get("year");
		term = (String) commandMap.get("term");
		subjectCode = (String) commandMap.get("subjectCode");
		subjectName = (String) commandMap.get("subjectName");
		classs = (String) commandMap.get("subClass");
		weekCnt = (String) commandMap.get("weekCnt");
		lecMenuMarkYn = (String) commandMap.get("lecMenuMarkYn");
		preSubjectCode = (String) commandMap.get("preSubjectCode");
		onlineType = (String) commandMap.get("onlineType");
		subjectType = (String) commandMap.get("subjectType");
		retUrl = StringUtils.defaultString((String) commandMap.get("retUrl"),"");
		
		logger.debug("subjectTraningType : " + subjectTraningType );
		logger.debug("yyyy : " + yyyy );
		logger.debug("term : " + term );
		logger.debug("subjectCode : " + subjectCode );
		logger.debug("subjectName : " + subjectName );
		logger.debug("classs : " + classs );
		logger.debug("weekCnt : " + weekCnt );
		logger.debug("lecMenuMarkYn : " + lecMenuMarkYn );
		logger.debug("preSubjectCode : " + preSubjectCode );
		logger.debug("onlineType : " + onlineType );
		logger.debug("subjectType : " + subjectType );
		
		subjectVO.setYyyy(yyyy);
        subjectVO.setTerm(term);
        subjectVO.setSubjectCode(subjectCode);
		
		// 교수자 and OJT교과 and 분반이 안넘어 올 경우 분반 세팅
        if( "PRT".equals(subjectVO.getSessionMemType()) && "OJT".equals(subjectTraningType) && ( classs == null || classs.equals("") ) ){
        	 classs = subjectService.getMinSubjectClass(subjectVO);
        	 logger.debug("OJT init class : " + classs );
        } 
    	
        logger.debug("************* classs : " + classs );
        
        subjectVO.setSubjectClass(classs);
		
		/*====================================================================
    	* 업무화면에서 사용하는 공통 Detail Vo 셋팅 영역
    	====================================================================*/
        // left 메뉴에서 현재 진행중인 교과목 선택시 SESSION 설정
		paramMap.put("subjectTraningType", subjectTraningType);
		paramMap.put("yyyy", yyyy);
        paramMap.put("term", term);
        paramMap.put("subjectCode", subjectCode);
        paramMap.put("subjectName", subjectName);
        paramMap.put("classs", classs);
        paramMap.put("weekCnt", weekCnt);
        paramMap.put("lecMenuMarkYn", lecMenuMarkYn);
        paramMap.put("preSubjectCode", preSubjectCode);
        paramMap.put("onlineType", onlineType);
        paramMap.put("subjectType", subjectType);
        
        // 강의관리 관련 세션 생성 메소드 BizUtil 호출
        BizUtil.setLecInfo(request, paramMap);
		
        /*====================================================================
    	* 업무화면에서 사용하는 model 속성 셋팅 영역
    	====================================================================*/
        /*model.addAttribute("lectureLmsVO", lectureLmsVO);
        model.addAttribute("criterionList", criterionList);*/

        /*====================================================================
    	* 업무화면 Jsp File Path 셋팅영역
    	====================================================================*/
        
        
        subjectVO = subjectService.getSubjectInfo(subjectVO);
      //  subjectVO.setSessionMemSeq(loginVO.getSessionMemSeq());
        loginInfo.putSessionToVo(subjectVO);
        
        onlineTraningVO.setYyyy(yyyy);
        onlineTraningVO.setTerm(term);
        onlineTraningVO.setSubjectCode(subjectCode);
        onlineTraningVO.setSubjectClass(classs);
        onlineTraningVO = onlineTraningService.getOnlineTraningStand(onlineTraningVO);
        
        model.addAttribute("onlineTraningVO", onlineTraningVO);
        model.addAttribute("subjectVO", subjectVO);
        model.addAttribute("sessionMemName", sessionMemName);
        
        // 리턴 URL 이 넘어올경우 이동
        if(!retUrl.equals("")){
        	return "redirect:"+retUrl;
        }
       
        if("STD".equals(currProcVO.getSessionMemType())){
        	OnlineTraningSchVO onlineTraningSchVO = new OnlineTraningSchVO();
        	onlineTraningSchVO.setYyyy(yyyy);
        	onlineTraningSchVO.setTerm(term);
        	onlineTraningSchVO.setSubjectCode(subjectCode);
        	onlineTraningSchVO.setSubjectClass(classs);
        	onlineTraningSchVO.setSessionMemSeq(loginVO.getMemSeq());
        	
        	if("OJT".equals(subjectTraningType)){
        		
        		List<OnlineTraningSchVO> resultList = onlineTraningService.listOjtTraningStdSchedule(onlineTraningSchVO);
            	model.addAttribute("resultList", resultList);
            	
            	OnlineTraningSchVO progress = onlineTraningService.getTraningStatus(onlineTraningSchVO);
            	model.addAttribute("progress", progress);
        		returnUrl = "oklms/lu/currproc/listStdCurrProcOjt";
        		
        	} else {
        		OnlineTraningSchVO progress = onlineTraningService.getAllProgressRateLesson(onlineTraningSchVO);
            	model.addAttribute("progress", progress);
            	
            	// 진행중인 온라인교과 목록
            	List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningStdSchedule(onlineTraningSchVO);
            	model.addAttribute("resultList", resultList);
            	
           
            	onlineTraningSchVO.setYyyy(yyyy);
            	onlineTraningSchVO.setTerm(term);
            	onlineTraningSchVO.setSubjectCode(subjectCode);
            	onlineTraningSchVO.setSubClass(classs);
            	onlineTraningSchVO.setSessionMemSeq(loginVO.getMemSeq());
            	
            	
            	List<OnlineTraningSchVO> scheduleList = onlineTraningService.listOnlineTraningStdOnlineSchedule(onlineTraningSchVO);
            	model.addAttribute("scheduleList", scheduleList);
            	
            	returnUrl = "oklms/lu/currproc/listStdCurrProc";
        	}
        	
        } else if("PRT".equals(currProcVO.getSessionMemType())){
        	
        	OnlineTraningSchVO onlineTraningSchVO = new OnlineTraningSchVO();
        	onlineTraningSchVO.setYyyy(yyyy);
        	onlineTraningSchVO.setTerm(term);
        	onlineTraningSchVO.setSubjectCode(subjectCode);
        	onlineTraningSchVO.setSubjectClass(classs);
        	onlineTraningSchVO.setSessionMemSeq(loginVO.getMemSeq());
        	
        	if("OJT".equals(subjectTraningType)){
        		
        		TraningStatusVO traningStatusVO = new TraningStatusVO();
        		
        		traningStatusVO.setYyyy(yyyy);
        		traningStatusVO.setTerm(term);
        		traningStatusVO.setClassId(classs);
        		traningStatusVO.setSubjectCode(subjectCode);
        		
        		//권장진도율 조회
        		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
        		model.addAttribute("getProgress", getProgress);
    			
        		List<SubjectVO> listOjtClassName = subjectService.listOjtClassName(subjectVO);
    			model.put("listOjtClassName", listOjtClassName);
    			
    			List<SubjectVO> listOjtCompanyName = subjectService.listOjtCompanyName(subjectVO);
    			if(listOjtCompanyName != null  && listOjtCompanyName.size() > 0 ){
    				model.put("companyName", listOjtCompanyName.get(0).getCompanyName());
    			}
    			
    			List<OnlineTraningSchVO> resultList = onlineTraningService.listOjtTraningInsSchedule(onlineTraningSchVO);
            	model.addAttribute("resultList", resultList);
            	
            	
            	traningVO.setYyyy(yyyy);
            	traningVO.setTerm(term);
            	traningVO.setSubClass(classs);
            	traningVO.setSubjectCode(subjectCode);
        		
        		List<TraningVO> traningList = traningService.listTraningSubjectPrt(traningVO);
        		model.addAttribute("traningList", traningList);
            	
            	returnUrl = "oklms/lu/currproc/listPrtCurrProcOjt";
            	
        	} else {
        		TraningStatusVO traningStatusVO = new TraningStatusVO();
        		
        		traningStatusVO.setYyyy(yyyy);
        		traningStatusVO.setTerm(term);
        		traningStatusVO.setClassId(classs);
        		traningStatusVO.setSubjectCode(subjectCode);
        		
        		//권장진도율 조회
        		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
        		model.addAttribute("getProgress", getProgress);
        		
            	// 진행중인 온라인교과 목록
            	List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningInsSchedule(onlineTraningSchVO);
            	
            	model.addAttribute("resultList", resultList);
            	returnUrl = "oklms/lu/currproc/listPrtCurrProc";
        		
        	}
        	
        } else if("COT".equals(currProcVO.getSessionMemType())){
    		TraningStatusVO traningStatusVO = new TraningStatusVO();
    		
    		traningStatusVO.setYyyy(yyyy);
    		traningStatusVO.setTerm(term);
    		traningStatusVO.setClassId(classs);
    		traningStatusVO.setSubjectCode(subjectCode);
    		
    		//권장진도율 조회
    		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
    		model.addAttribute("getProgress", getProgress);
    		
        	OnlineTraningSchVO onlineTraningSchVO = new OnlineTraningSchVO();
        	onlineTraningSchVO.setYyyy(yyyy);
        	onlineTraningSchVO.setTerm(term);
        	onlineTraningSchVO.setSubjectCode(subjectCode);
        	onlineTraningSchVO.setSubjectClass(classs);
        	onlineTraningSchVO.setSessionMemSeq(loginVO.getMemSeq());
        	
        	List<OnlineTraningSchVO> resultList = onlineTraningService.listOjtTraningCotSchedule(onlineTraningSchVO);
        	model.addAttribute("resultList", resultList);
        	
        	returnUrl = "oklms/lu/currproc/listCotCurrProc";
        } else {
        	
        	OnlineTraningSchVO onlineTraningSchVO = new OnlineTraningSchVO();
        	onlineTraningSchVO.setYyyy(yyyy);
        	onlineTraningSchVO.setTerm(term);
        	onlineTraningSchVO.setSubjectCode(subjectCode);
        	onlineTraningSchVO.setSubClass(classs);
        	onlineTraningSchVO.setSessionMemSeq(loginVO.getMemSeq());
        	// 진행중인 온라인교과 목록
        	//List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningInsSchedule(onlineTraningSchVO);
        	//model.addAttribute("resultList", resultList);
    		
    		List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningCdpSchedule(onlineTraningSchVO);
    		
    		List<OnlineTraningSchVO> scheduleList = onlineTraningService.listOnlineTraningAllWeekSchedule(onlineTraningSchVO);
    		
    		List<OnlineTraningSchVO> resultList1 = onlineTraningService.listOfflineTraningCdpSchedule(onlineTraningSchVO);
    		
    		TraningStatusVO traningStatusVO = new TraningStatusVO();
    		
    		loginInfo.putSessionToVo(traningStatusVO); // session의 정보를 VO에 추가.
    		
    		traningStatusVO.setYyyy(yyyy);
    		traningStatusVO.setTerm(term);
    		traningStatusVO.setClassId(classs);
    		traningStatusVO.setSubjectCode(subjectCode);
    		
    		//권장진도율 조회
    		TraningStatusVO getProgress = traningStatusService.getProgress(traningStatusVO);
    		model.addAttribute("getProgress", getProgress);

    		//전체조회 목록
    		List<TraningStatusVO> resultlist = traningStatusService.listTraningStatus(traningStatusVO);
    		model.addAttribute("resultlist", resultlist);
    		
    		
    		model.addAttribute("resultList1", resultList1);
    		model.addAttribute("resultList", resultList);
    		model.addAttribute("scheduleList", scheduleList);
        	//if("excel".equals(pageType)){
        	//	request.setAttribute("ExcelName", URLEncoder.encode( "OFF-LINE 강의일정".replaceAll(" ", "_") ,"UTF-8") );
        	//	returnUrl = "oklms_excel/lu/currproc/excelCdpCurriProc";
        	//} else {
        		returnUrl = "oklms/lu/currproc/listCdpCurrProc";
        	//}
        	
        } 
        
		return returnUrl;
	}
	
	@RequestMapping(value = "/lu/currproc/saveTraningSubject.json")
	public @ResponseBody Map<String, Object> saveTraningSubject(@ModelAttribute("frmTraning") TraningVO traningVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		String retMsg = "";
		
		int iResult = traningService.saveTraningPrt(traningVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 처리되었습니다.!";
		}else{
			retMsg = "저장 처리된건이 없습니다.!";
		}
		
		if(iResult > 0){
			returnMap.put("retCd", "200");
			returnMap.put("retMsg", retMsg);
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retMsg", retMsg);
		}
		return returnMap;
	 }
	
	
	@RequestMapping(value = "/lu/currproc/listCurrProcStdWeekSubSchedule.json")
	public @ResponseBody Map<String, Object> listCurrProcStdWeekSubSchedule(@ModelAttribute("frmLesson") OnlineTraningSchVO onlineTraningSchVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		
		OnlineTraningSchElemVO onlineTraningSchElemVO = new OnlineTraningSchElemVO();
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo(); 
		loginInfo.putSessionToVo(onlineTraningSchVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(onlineTraningSchElemVO); // session의 정보를 VO에 추가.
		
		
 		onlineTraningSchElemVO.setWeekId(onlineTraningSchVO.getWeekId());
 		onlineTraningSchElemVO.setSubjSchId(onlineTraningSchVO.getSubjSchId());
		List<OnlineTraningSchElemVO> resultList = onlineTraningService.listOnlineTraningWeekScheduleElemLesson(onlineTraningSchElemVO);
		
		
		String weekProgressYn =  onlineTraningService.getOnlineTraningWeekScheduleProgressYn(onlineTraningSchVO);
		
		if(resultList.size() > 0){
			returnMap.put("retCd", "200");
			returnMap.put("retData", resultList);
			returnMap.put("weekProgressYn", weekProgressYn);
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
			returnMap.put("weekProgressYn", "");
		}
		return returnMap;
	 }
	
	
	@RequestMapping(value = "/lu/currproc/listCurrProcStdWeekSchedule.json")
	public @ResponseBody Map<String, Object> listCurrProcStdWeekSchedule(@ModelAttribute("frmLesson") OnlineTraningSchVO onlineTraningSchVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		//List<OnlineTraningSchVO> data = onlineTraningService.listOnlineTraningWeekSchedule(onlineTraningSchVO);
		List<OnlineTraningSchVO> data = onlineTraningService.listOnlineTraningWeekSch(onlineTraningSchVO);
		List<OnlineTraningSchVO> resultList = new ArrayList<OnlineTraningSchVO>();
		
		String progressAttendTypeCode =  StringUtils.defaultIfBlank( (String) request.getParameter("progressAttendTypeCode"), "");
	    String stdLessonId 					= StringUtils.defaultIfBlank( (String) request.getParameter("stdLessonId"), "");
		String weekId 							= StringUtils.defaultIfBlank( (String) request.getParameter("weekId"), "");
	    String subjSchId 						= StringUtils.defaultIfBlank( (String) request.getParameter("subjSchId"), "");
	    
		
		for( int i = 0 ; i < data.size(); i++ ){
			OnlineTraningSchVO schVO = data.get(i);
			if(schVO.getLinkContentYn().equals("N")){
				AttendVO attendVO = new AttendVO();
				attendVO.setStdLessonId(stdLessonId);
				attendVO.setWeekId(weekId);
				attendVO.setSubjSchId(subjSchId);
				attendVO.setProgressAttendTypeCode(progressAttendTypeCode);
				String lessonProgress =  attendService.getLessonProgress(attendVO);
				schVO.setLessonProgress(lessonProgress);
			}
			resultList.add(schVO);
		}
		
		String weekProgressYn =  onlineTraningService.getOnlineTraningWeekProgressYn(onlineTraningSchVO);
		
		if(resultList.size() > 0){
			returnMap.put("retCd", "200");
			returnMap.put("retData", resultList);
			returnMap.put("weekProgressYn", weekProgressYn);
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
			returnMap.put("weekProgressYn", "");
		}
		return returnMap;
	 }
	
	
	
	@RequestMapping(value = "/lu/currproc/listCurrProcStdLesson.json")
	public @ResponseBody Map<String, Object> listCurrProcStdLesson(@ModelAttribute("frmLesson") CmsCourseBaseVO cmsCourseBaseVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		logger.debug("#### URL = /lu/currproc/listCurrProcStdLesson.json" );
		
        /*WHERE ATT.LESSON_ID = #{stdLessonId} 
        AND ATT.WEEK_ID = #{weekId} 
        AND ATT.SUBJ_SCH_ID = #{subjSchId} 
        AND ATT.CMS_LESSON_ID = #{cmsLessonId}
        AND ATT.CMS_LESSON_ITEM_ID = #{cmsLessonItemId}*/
        
        String progressAttendTypeCode =  StringUtils.defaultIfBlank( (String) request.getParameter("progressAttendTypeCode"), "");
	    String stdLessonId 					= StringUtils.defaultIfBlank( (String) request.getParameter("stdLessonId"), "");
		String weekId 							= StringUtils.defaultIfBlank( (String) request.getParameter("weekId"), "");
	    String subjSchId 						= StringUtils.defaultIfBlank( (String) request.getParameter("subjSchId"), "");
	    String lessonId							= StringUtils.defaultIfBlank( (String) request.getParameter("lessonId"), "");
	    
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		String retCd = "SUCCESS";
		String retMsg = "";
		try {
		   //cmsCourseBaseVO.setAddURL("viewLesson");  
		   //List<CmsCourseContentItemSubItemListVO> data  = cmsIfxService.viewLessonList(cmsCourseBaseVO);
		   
		   //
		   
		    LoginInfo loginInfo = new LoginInfo();
		   LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		   OnlineTraningSchElemVO onlineTraningSchElemVO = new OnlineTraningSchElemVO();
		   loginInfo.putSessionToVo(onlineTraningSchElemVO); // session의 정보를 VO에 추가.
		   
		   onlineTraningSchElemVO.setWeekId(weekId);
		   onlineTraningSchElemVO.setSubjSchId(subjSchId);
		   List<OnlineTraningSchElemVO> data = onlineTraningService.listOnlineTraningWeekSchElem(onlineTraningSchElemVO);
		   
		   List<OnlineTraningSchElemVO> resultList = new ArrayList<OnlineTraningSchElemVO>();
		   
		   for( int i = 0 ; i < data.size(); i++ ){
			   OnlineTraningSchElemVO itemVO = data.get(i);
			   
			   if(itemVO.getDisplayOrder().equals("1")){
				   
				   System.out.println("========== stdLessonId : "+stdLessonId);
				   
				   AttendVO attendVO = new AttendVO();
				   attendVO.setStdLessonId(stdLessonId);
				   attendVO.setWeekId(weekId);
				   attendVO.setSubjSchId(subjSchId);
				   attendVO.setProgressAttendTypeCode(progressAttendTypeCode);
				   attendVO.setCmsLessonId(lessonId);
				   attendVO.setCmsLessonItemId(itemVO.getLessonItemId());
				   
				   String lessonProgress =  attendService.getCmsLessonItemProgress(attendVO);
				   
				   itemVO.setLessonProgress(lessonProgress);
			   }
			   
			   resultList.add(itemVO);
		   }
		   
		   
		   returnMap.put("retCd", retCd);
		   returnMap.put("retMsg", retMsg);
		   returnMap.put("retData", resultList);
		   
		   
		   
		   //logger.debug("#### URL = /lu/online/listCurrProcStdLesson.json : "+data.toString() );
		   
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/currproc/currProcStdNote.json")
	public @ResponseBody Map<String, Object> currProcStdNote(@ModelAttribute("frmLesson") CmsCourseBaseVO cmsCourseBaseVO
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		logger.debug("#### URL = /lu/currproc/currProcStdNote.do" );
		
		String linkContentYn 				= StringUtils.defaultIfBlank( (String) request.getParameter("linkContentYn"), "");
		String progressAttendTypeCode =  StringUtils.defaultIfBlank( (String) request.getParameter("progressAttendTypeCode"), "");
		String progressAttendId 			=  StringUtils.defaultIfBlank( (String) request.getParameter("progressAttendId"), "");
		String progressTimeId 				= StringUtils.defaultIfBlank( (String) request.getParameter("progressTimeId"), "");
		String stdLessonId 					= StringUtils.defaultIfBlank( (String) request.getParameter("stdLessonId"), "");
		String weekId 							= StringUtils.defaultIfBlank( (String) request.getParameter("weekId"), "");
		String subjSchId 						= StringUtils.defaultIfBlank( (String) request.getParameter("subjSchId"), "");
	
		String cmsLessonId 					= StringUtils.defaultIfBlank( (String) request.getParameter("cmsLessonId"), "");
		String cmsLessonItemId 			= StringUtils.defaultIfBlank( (String) request.getParameter("cmsLessonItemId"), "");
		String cmsLessonSubItem 		= StringUtils.defaultIfBlank( (String) request.getParameter("cmsLessonSubItem"), "");
		String pageInfo 						= StringUtils.defaultIfBlank( (String) request.getParameter("pageInfo"), "");
		String weekProgressYn 			= StringUtils.defaultIfBlank( (String) request.getParameter("weekProgressYn"), "");
		
		String yyyy 			= StringUtils.defaultIfBlank( (String) request.getParameter("yyyy"), "");
		String term 			= StringUtils.defaultIfBlank( (String) request.getParameter("term"), "");
		String subjectCode 			= StringUtils.defaultIfBlank( (String) request.getParameter("subjectCode"), "");
		String subjectClass 			= StringUtils.defaultIfBlank( (String) request.getParameter("subjectClass"), "");
		
		System.out.println("================ linkContentYn :  "+linkContentYn);
		System.out.println("================ progressAttendTypeCode :  "+progressAttendTypeCode);
		System.out.println("================ progressAttendId :  "+progressAttendId);
		System.out.println("================ progressTimeId :  "+progressTimeId);
		System.out.println("================ stdLessonId :  "+linkContentYn);
		System.out.println("================ weekId :  "+weekId);
		System.out.println("================ subjSchId :  "+subjSchId);
		System.out.println("================ cmsLessonId :  "+cmsLessonId);
		System.out.println("================ cmsLessonItemId :  "+cmsLessonItemId);
		System.out.println("================ cmsLessonSubItem :  "+cmsLessonSubItem);
		System.out.println("================ pageInfo :  "+pageInfo);
		System.out.println("================ weekProgressYn :  "+weekProgressYn);
		System.out.println("================ yyyy :  "+yyyy);
		System.out.println("================ term :  "+term);
		System.out.println("================ subjectCode :  "+subjectCode);
		System.out.println("================ subjectClass :  "+subjectClass);
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		String retCd = "";
		String retMsg = ""; 
		retCd = "SUCCESS";
		/*if(linkContentYn.equals("Y")){
			retCd = "SUCCESS";
			retMsg = "";
			try {
			   cmsCourseBaseVO.setAddURL("viewLesson");  
			   HashMap<String, String>  data = cmsIfxService.viewLesson(cmsCourseBaseVO);
			   JSONObject jsonObj = new JSONObject();
			   jsonObj.put("result", data);
			   retMsg = jsonObj.toString();
			 } catch (Exception e) {
			    e.printStackTrace();
			 }
		}*/
		
		
		//============================================
		
		// 조건체크 필요 진도반열일때만 등록한다
		
		// 진도정보 등록
		AttendVO attendVO =  new AttendVO();
		
		attendVO.setProgressAttendTypeCode(progressAttendTypeCode);
		attendVO.setWeekProgressYn(weekProgressYn);
		attendVO.setProgressAttendId(progressAttendId);
		attendVO.setProgressTimeId(progressTimeId);
		attendVO.setStdLessonId(stdLessonId);
		attendVO.setWeekId(weekId);
		attendVO.setSubjSchId(subjSchId);
		attendVO.setLinkContentYn(linkContentYn);
		attendVO.setCmsLessonId(cmsLessonId);
		attendVO.setCmsLessonItemId(cmsLessonItemId);
		attendVO.setCmsLessonSubItem(cmsLessonSubItem);
		attendVO.setPageInfo(pageInfo);
		attendVO.setYyyy(yyyy);
		attendVO.setTerm(term);
		attendVO.setSubjectCode(subjectCode);
		attendVO.setSubjectClass(subjectClass);
		
		logger.debug("==========getPageInfo  "+attendVO.getPageInfo());
		logger.debug("==========attendVO.getWeekProgressYn()  "+attendVO.getWeekProgressYn());
		
		// 학습상태일때만 진도율 적용 , 예습,복습 미적용
		if(attendVO.getWeekProgressYn().equals("Y")){
			AttendVO aVO = attendService.insertAttendInfo(attendVO);
			returnMap.put("progressAttendId", aVO.getProgressAttendId());
			returnMap.put("progressTimeId", aVO.getProgressTimeId());
		}
		
		
		//=============================================
		
		returnMap.put("retCd", retCd);
		returnMap.put("retMsg", retMsg);
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/currproc/currProcStdUpdateAttend.json")
	public @ResponseBody Map<String, Object> currProcStdUpdateAttend(@ModelAttribute("frmLesson") AttendVO attendVO
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		logger.debug("#### URL = /lu/currproc/currProcStdUpdateAttend.do" );
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		AttendVO aVO =  attendService.updateAttend(attendVO);
		
		returnMap.put("timeProgressRatio", aVO.getTimeProgressRatio());
		returnMap.put("weekProgressRate", aVO.getWeekProgressRate());
		
		
		String lessonProgress = "";
		if(attendVO.getLinkContentYn().equals("Y")){
			lessonProgress = attendService.getCmsLessonItemProgress(attendVO);
		} else {
			lessonProgress = attendService.getLessonProgress(attendVO);
		}
		
		returnMap.put("lessonProgress", lessonProgress);
		
		
		return returnMap;
	}
	
	
	@RequestMapping(value = "/lu/currproc/getCurrProcMovieViewer.do")
	public String getCurrProcStdMovieViewer(@ModelAttribute("frmLesson")  ModelMap model,  HttpServletRequest request) throws Exception {
		logger.debug("#### URL = /lu/currproc/getCurrProcMovieViewer.do" );
		// View호출
		return "cmm/viewer/movieViewer";
	}
	
	@RequestMapping(value = "/lu/currproc/getCurrProcMobileMovieViewer.do")
	public String getCurrProcMobileMovieViewer(@ModelAttribute("frmLesson")  ModelMap model,  HttpServletRequest request) throws Exception {
		logger.debug("#### URL = /lu/currproc/getCurrProcMobileMovieViewer.do" );
		// View호출
		return "cmm/viewer/mobileMovieViewer";
	}
	
	
	@RequestMapping(value = "/lu/currproc/listCurrProcPreviewWeekSchedule.json")
	public @ResponseBody Map<String, Object> listCurrProcPreviewWeekSchedule(@ModelAttribute("frmLesson") OnlineTraningSchVO onlineTraningSchVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		Map<String , Object> returnMap = new HashMap<String , Object>();
		
		List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningWeekSchedule(onlineTraningSchVO);
		
		
		if(resultList.size() > 0){
			returnMap.put("retCd", "200");
			returnMap.put("retData", resultList);
		} else {
			returnMap.put("retCd", "");
			returnMap.put("retData", "");
		}
		return returnMap;
	 }
	
	
	@RequestMapping(value = "/lu/currproc/listCurrProcPreviewLesson.json")
	public @ResponseBody Map<String, Object> listCurrProcPreviewLesson(@ModelAttribute("frmLesson") CmsCourseBaseVO cmsCourseBaseVO 
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		logger.debug("#### URL = /lu/currproc/listCurrProcPreviewLesson.json" );
		
        /*WHERE ATT.LESSON_ID = #{stdLessonId} 
        AND ATT.WEEK_ID = #{weekId} 
        AND ATT.SUBJ_SCH_ID = #{subjSchId} 
        AND ATT.CMS_LESSON_ID = #{cmsLessonId}
        AND ATT.CMS_LESSON_ITEM_ID = #{cmsLessonItemId}*/
        
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		String retCd = "SUCCESS";
		String retMsg = "";
		try {
		   cmsCourseBaseVO.setAddURL("viewLesson");  
		   List<CmsCourseContentItemSubItemListVO> data  = cmsIfxService.viewLessonList(cmsCourseBaseVO);
		   
		   returnMap.put("retCd", retCd);
		   returnMap.put("retMsg", retMsg);
		   returnMap.put("retData", data);
		   
		   
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		return returnMap;
	}
	
	@RequestMapping(value = "/lu/currproc/currProcPreviewNote.json")
	public @ResponseBody Map<String, Object> currProcPreviewNote(@ModelAttribute("frmLesson") CmsCourseBaseVO cmsCourseBaseVO
		,RedirectAttributes redirectAttributes
		,SessionStatus status
		,HttpServletRequest request
		,ModelMap model) throws Exception {
		
		logger.debug("#### URL = /lu/currproc/currProcPreviewNote.do" );
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
		String retCd = "SUCCESS";
		String retMsg = "";
		try {
		   cmsCourseBaseVO.setAddURL("viewLesson");  
		   HashMap<String, String>  data = cmsIfxService.viewLesson(cmsCourseBaseVO);
		   JSONObject jsonObj = new JSONObject();
		   jsonObj.put("result", data);
		   retMsg = jsonObj.toString();
		 } catch (Exception e) {
		    e.printStackTrace();
		 }
		
		
		returnMap.put("retCd", retCd);
		returnMap.put("retMsg", retMsg);
		return returnMap;
	}
	
	
	@RequestMapping(value = "/lu/currproc/getCurrProcScheduleForm.do")
	public String getCurrScheduleForm(@ModelAttribute("frmLesson")  ModelMap model,  HttpServletRequest request) throws Exception {
		logger.debug("#### URL = /lu/currproc/getCurrScheduleForm.do" );
		// View호출
		return "oklms/lu/currproc/getCurrProcScheduleForm";
	}
	
	@RequestMapping(value = "/lu/currproc/getCurrProcEvalForm.do")
	public String getCurrEvalForm(@ModelAttribute("frmLesson")  ModelMap model,  HttpServletRequest request) throws Exception {
		logger.debug("#### URL = /lu/currproc/getCurrEvalForm.do" );
		// View호출
		return "oklms/lu/currproc/getCurrProcEvalForm";
	}
	
	@RequestMapping(value = "/lu/currproc/onlineTraningStd.do")
	public String onlineTraningStd(@RequestParam Map<String, Object> commandMap ,HttpServletRequest request, @ModelAttribute("frmLesson") SubjectVO subjectVO, ModelMap model) throws Exception {
		
		HttpSession httpSession = request.getSession(); 
		
		String lessonId = (String) commandMap.get("lessonId");
		String weekId = (String) commandMap.get("weekId");
		String weekCnt = (String) commandMap.get("weekCnt");
		String contentName = (String) commandMap.get("contentName");
		String weekProgressRate = (String) commandMap.get("weekProgressRate");
		String subjSchId = (String) commandMap.get("subjSchId");
		String subjStep = (String) commandMap.get("subjStep");
		String subjTitle = (String) commandMap.get("subjTitle");
	
		OnlineTraningVO onlineTraningVO = new OnlineTraningVO();
        
        subjectVO.setYyyy(StringUtils.defaultIfBlank( subjectVO.getYyyy() ,(String)httpSession.getAttribute(Globals.YYYY)));
        subjectVO.setTerm(StringUtils.defaultIfBlank( subjectVO.getTerm() ,(String)httpSession.getAttribute(Globals.TERM)));
        subjectVO.setSubjectCode(StringUtils.defaultIfBlank( subjectVO.getSubjectCode() ,(String)httpSession.getAttribute(Globals.SUBJECT_CODE)));
        subjectVO.setSubjectClass(StringUtils.defaultIfBlank( subjectVO.getSubjectClass() ,(String)httpSession.getAttribute(Globals.CLASS)));
        
        subjectVO = subjectService.getSubjectInfo(subjectVO);
        
        model.addAttribute("subjectVO", subjectVO);
		
		onlineTraningVO.setYyyy(StringUtils.defaultIfBlank( subjectVO.getYyyy() ,(String)httpSession.getAttribute(Globals.YYYY)));
        onlineTraningVO.setTerm(StringUtils.defaultIfBlank( subjectVO.getTerm() ,(String)httpSession.getAttribute(Globals.TERM)));
        onlineTraningVO.setSubjectCode(StringUtils.defaultIfBlank( subjectVO.getSubjectCode() ,(String)httpSession.getAttribute(Globals.SUBJECT_CODE)));
        onlineTraningVO.setSubjectClass(StringUtils.defaultIfBlank( subjectVO.getSubjectClass() ,(String)httpSession.getAttribute(Globals.CLASS)));
        onlineTraningVO = onlineTraningService.getOnlineTraningStand(onlineTraningVO);
		
        model.addAttribute("onlineTraningVO", onlineTraningVO);
		
		model.addAttribute("lessonId", lessonId);
		model.addAttribute("weekId", weekId);
		model.addAttribute("weekCnt", weekCnt);
		model.addAttribute("contentName", contentName);
		model.addAttribute("weekProgressRate", weekProgressRate);
		model.addAttribute("subjSchId", subjSchId);
		model.addAttribute("subjStep", subjStep);
		model.addAttribute("subjTitle", subjTitle);
		
		// View호출
		return "oklms_blank/lu/online/onlineTraningStd";
	}
		
}
