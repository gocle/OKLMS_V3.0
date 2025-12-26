package kr.co.gocle.oklms.lu.traning.web;
 

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
 










import kr.co.gocle.oklms.comm.util.CommonUtil;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.lu.interview.service.InterviewService;
import kr.co.gocle.oklms.lu.interview.vo.InterviewCompanyVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.report.service.ReportService;
import kr.co.gocle.oklms.lu.traning.service.TraningNoteSerivce;
import kr.co.gocle.oklms.lu.traning.service.WeekTraningService;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;  

/**
 * 주간훈련일지
 *
 */
@Controller
public class WeekTraningController  extends BaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(WeekTraningController.class);

	@Resource(name = "traningNoteSerivce")
	private TraningNoteSerivce traningNoteSerivce;

	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;

	@Resource(name= "weekTraningService")
	private WeekTraningService weekTraningService;

	@Resource(name = "ReportService")
	private ReportService reportService;
	
	@Resource(name = "InterviewService")
	private InterviewService interviewService;
	
	@Resource(name = "atchFileService")
	private AtchFileService atchFileService;
	
	/**
	 * 훈련지원 > 주간훈련일지 (기업현장교사)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/listWeekTraningNoteCot.do")
	public String listWeekTraningNote(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model, HttpSession session) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/listWeekTraningNoteCot.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
				
		if(traningNoteVO.getYyyy()==null || traningNoteVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			traningNoteVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
			traningNoteVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		traningNoteVO.setMemSeq(traningNoteVO.getSessionMemSeq());
		
		//주간훈련일지하단고정목록
		List<TraningNoteVO> bottomList =weekTraningService.listWeekTraningNoteBottomCot(traningNoteVO);
		model.put("bottomList", bottomList);
		
		if(traningNoteVO.getWeekCnt()==null||traningNoteVO.getWeekCnt().equals("")){
			if(bottomList!=null && bottomList.size()>0){
				traningNoteVO.setWeekCnt(bottomList.get(0).getNowWeekCnt());
			}else{
				traningNoteVO.setWeekCnt("1");
			}
		}
		
		//주간훈련일지목록
		List<TraningNoteVO> topList =weekTraningService.listWeekTraningNoteCot(traningNoteVO);
		model.put("topList", topList);
				
		
		model.put("traningNoteVO", traningNoteVO);
		//현장 교수
		return "oklms/lu/weektraning/listWeekTraningNoteCot";

	}

	/**
	 * 훈련지원 > 주간훈련일지 제출 (기업현장교사)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/insertWeekTraningNoteCot.do")
	public String insertWeekTraningNoteCot(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model, HttpSession session,  RedirectAttributes redirectAttributes) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/insertWeekTraningNoteCot.do" );
		int insertCnt = 0;
		String retMsg="";
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
				
		traningNoteVO.setMemSeq(traningNoteVO.getSessionMemSeq());
		 
		//주간훈련일지하단고정목록
		insertCnt = weekTraningService.updateWeekTraningNoteCot(traningNoteVO);

		if(insertCnt > 0){
			retMsg = "저장되었습니다.";
		}else{
			retMsg = "저장할 수 없습니다.";
		}
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		//제출
		return "redirect:/lu/weektraning/listWeekTraningNoteCot.do?weekCnt="+traningNoteVO.getWeekCnt()+"&yyyy="+traningNoteVO.getYyyy()+"&term="+traningNoteVO.getTerm();

	}

	/**
	 * 훈련지원 > 주간훈련일지인쇄 (기업현장교사)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/printWeekTraningNoteCot.do")
	public String printWeekTraningNoteCot(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/printWeekTraningNoteCot.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		 
		List<TraningNoteVO> detailTraningNoteCot =weekTraningService.detailTraningNoteCot(traningNoteVO);
		model.addAttribute("detailTraningNotePrd", detailTraningNoteCot);
		
		traningNoteVO.setMemSeq(traningNoteVO.getSessionMemSeq());
			// OJT출력
		if(traningNoteVO.getAddyn().equals("N")){

	  		model.addAttribute("traningNoteVO", traningNoteVO);
	  		if(traningNoteVO.getCurrent().equals("sign")){
		  		//주간훈련일지하단고정목록
				List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteSingCot(traningNoteVO);
				model.addAttribute("resultList", resultList);
	  		}else{
		  		//주간훈련일지하단고정목록
				List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteCot(traningNoteVO);
				model.addAttribute("resultList", resultList);	  			
	  		}
		}else{
 
		  	model.addAttribute("traningNoteVO", traningNoteVO);
	  		 
	  		//주간훈련일지하단고정목록
			List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteAddCot(traningNoteVO);
			model.addAttribute("resultList", resultList);
 
		}		
		if(traningNoteVO.getCurrent().equals("sign")){
			return "oklms_popup/lu/weektraning/printWeekTraningNoteCotOjt";	
		}else{
			return "oklms_popup/lu/weektraning/printWeekTraningNoteCotOjtPrd";		
		}
		 
	}
	/**
	 * 훈련지원 > 주간훈련일지 (교수)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/listWeekTraningNotePrd.do")
	public String listWeekTraningNotePrd(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model, HttpSession session) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/listWeekTraningNotePrd.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
				
		if(traningNoteVO.getYyyy()==null || traningNoteVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			traningNoteVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
			traningNoteVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		traningNoteVO.setMemSeq(traningNoteVO.getSessionMemSeq());
		
		//주간훈련일지하단고정목록
		List<TraningNoteVO> bottomList =weekTraningService.listWeekTraningNoteBottomPrd(traningNoteVO);
		model.put("bottomList", bottomList);
		
		if(traningNoteVO.getWeekCnt()==null||traningNoteVO.getWeekCnt().equals("")){
			if(bottomList!=null && bottomList.size()>0){
				traningNoteVO.setWeekCnt(bottomList.get(0).getNowWeekCnt());
			}else{
				traningNoteVO.setWeekCnt("1");
			}
		}

		//주간훈련일지목록
		List<TraningNoteVO> topList =weekTraningService.listWeekTraningNotePrd(traningNoteVO);
		model.put("topList", topList);

		model.put("traningNoteVO", traningNoteVO);
		//현장 교수
		return "oklms/lu/weektraning/listWeekTraningNotePrd";

	}

	/**
	 * 훈련지원 > 주간훈련일지 제출 (교수)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/insertWeekTraningNotePrd.do")
	public String insertWeekTraningNotePrd(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model, HttpSession session,  RedirectAttributes redirectAttributes) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/insertWeekTraningNotePrd.do" );
		int insertCnt = 0;
		String retMsg="";
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
				
		traningNoteVO.setMemSeq(traningNoteVO.getSessionMemSeq());
		 
		//주간훈련일지하단고정목록
		insertCnt = weekTraningService.updateWeekTraningNotePrd(traningNoteVO);

		if(insertCnt > 0){
			retMsg = "저장되었습니다.";
		}else{
			retMsg = "저장할 수 없습니다.";
		}
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		//제출
		return "redirect:/lu/weektraning/listWeekTraningNotePrd.do?weekCnt="+traningNoteVO.getWeekCnt()+"&yyyy="+traningNoteVO.getYyyy()+"&term="+traningNoteVO.getTerm();

	}
	
	/**
	 * 훈련지원 > 주간훈련일지인쇄 (교수)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/printWeekTraningNotePrd.do")
	public String printWeekTraningNotePrd(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/printWeekTraningNotePrd.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

		 
		List<TraningNoteVO> detailTraningNotePrd =weekTraningService.detailTraningNotePrd(traningNoteVO);
		model.addAttribute("detailTraningNotePrd", detailTraningNotePrd);
		
		if(traningNoteVO.getTraningType().equals("OFF")){
			// OFF-JT출력
			
			if(traningNoteVO.getAddyn().equals("N")){


		  		model.addAttribute("traningNoteVO", traningNoteVO);
		  		 
		  		//주간훈련일지하단고정목록
				List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNotePrd(traningNoteVO);
				model.addAttribute("resultList", resultList);
	 
			}else{
 
		  		model.addAttribute("traningNoteVO", traningNoteVO);
		  		 
		  		//주간훈련일지 
				List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteAddPrd(traningNoteVO);
				model.addAttribute("resultList", resultList);
	 
			}
			if(traningNoteVO.getCurrent().equals("sign")){
				return "oklms_popup/lu/weektraning/printWeekTraningNoteOff";
			}else{
				return "oklms_popup/lu/weektraning/printWeekTraningNoteOffPrd";
			}
			 
			
		}else{
			// OJT출력

			if(traningNoteVO.getAddyn().equals("N")){


		  		model.addAttribute("traningNoteVO", traningNoteVO);
		  		 
		  		//주간훈련일지하단고정목록
				List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNotePrd(traningNoteVO);
				model.addAttribute("resultList", resultList);
	 
			}else{
 
		  		model.addAttribute("traningNoteVO", traningNoteVO);
		  		 
		  		//주간훈련일지 
				List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteAddPrd(traningNoteVO);
				model.addAttribute("resultList", resultList);
	 
			}
			if(traningNoteVO.getCurrent().equals("sign")){
				return "oklms_popup/lu/weektraning/printWeekTraningNoteOjt";	
			}else{
				return "oklms_popup/lu/weektraning/printWeekTraningNoteOjtPrd";	
			}
			
			 	
		}

	}
	
	/**
	 * 훈련지원 > 주간훈련일지 (센터전담자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/listWeekTraningNoteCcn.do")
	public String listWeekTraningNoteCcn(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/listWeekTraningNoteCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		
		

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		loginInfo.putSessionToVo(interviewCompanyVO); // session의 정보를 VO에 추가.
  		
  		
  		//interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		//interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());
  		//InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		//baseCheckCompanyIds
  		
  		
  		// =================   조회 기업체 세팅 ==================
  		if( traningNoteVO.getBaseCheckCompanyIds() != null && traningNoteVO.getBaseCheckCompanyIds().indexOf(",") != -1 ){
  			interviewCompanyVO.setBaseSearchCompanyIds(CommonUtil.toDataStr(traningNoteVO.getBaseCheckCompanyIds()));
  			
  			LOGGER.debug("======================== interviewCompanyVO.getBaseSearchCompanyIds() :  "+interviewCompanyVO.getBaseSearchCompanyIds());
  		}
  		// =================  조회 기업체 세팅 ==================
  		
  		
		List<InterviewCompanyVO> resultList = interviewService.listSearchCompanyTraning(interviewCompanyVO);
  		
  		model.addAttribute("resultList", resultList);
  		model.addAttribute("traningNoteVO", traningNoteVO);
  		
  		//기업현장교사,HRD담당자 
  		Map<String, Object> commandMap = new HashMap<String, Object>();
  		commandMap.put("companyId", traningNoteVO.getCompanyId());
  		commandMap.put("traningProcessId", traningNoteVO.getTraningProcessId());
  		ArrayList<Map<String, Object>> cotList = commonCodeService.getCotListName(commandMap);
  		ArrayList<Map<String, Object>> ccmList =commonCodeService.getCcmListName(commandMap);
  		model.addAttribute("cotList", cotList );
  		model.addAttribute("ccmList", ccmList );
  		
  		model.addAttribute("companyId", traningNoteVO.getCompanyId() );
  		model.addAttribute("traningProcessId", traningNoteVO.getTraningProcessId() );
  		
		//주간훈련일지하단고정목록
		List<TraningNoteVO> bottomList =weekTraningService.listWeekTraningNoteBottomCcn(traningNoteVO);
		model.put("bottomList", bottomList);
 
		return "oklms/lu/weektraning/listWeekTraningNoteCcn";
	}
	/**
	 * 훈련지원 > 주간훈련일지인쇄 (센터전담자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/printWeekTraningNote.do")
	public String printWeekTraningNote(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/printWeekTraningNote.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());

  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result);
  		model.addAttribute("traningNoteVO", traningNoteVO);

		//주간훈련일지하단고정목록
		List<TraningNoteVO> bottomList =weekTraningService.listWeekTraningNoteBottomCcn(traningNoteVO);
		model.put("bottomList", bottomList);
 
		return "oklms_popup/lu/weektraning/printWeekTraningNote";

	}
	/**
	 * 훈련지원 > 주간훈련일지엑셀다운로드 (센터전담자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/excelWeekTraningNote.do")
	public String excelWeekTraningNote(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model , HttpServletRequest request ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/excelWeekTraningNote.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());
  		
  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result);
  		model.addAttribute("traningNoteVO", traningNoteVO);

		//주간훈련일지하단고정목록
		List<TraningNoteVO> bottomList =weekTraningService.listWeekTraningNoteBottomCcn(traningNoteVO);
		model.put("bottomList", bottomList);

		request.setAttribute("ExcelName", URLEncoder.encode( "훈련일지 제출현황".replaceAll(" ", "_") ,"UTF-8") );
 
		return "oklms_excel/lu/weektraning/excelWeekTraningNote";

	}
	
	/**
	 * 훈련지원 > 주간훈련일지 상세보기 (센터전담자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/getWeekTraningNoteCcn.do")
	public String getWeekTraningNoteCcn(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/getWeekTraningNoteCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());
  		 
  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result);
  		model.addAttribute("traningNoteVO", traningNoteVO);
  		
  		List<TraningNoteVO> resultList = new ArrayList<TraningNoteVO>();
  		
  		 if(traningNoteVO.getAddyn().equals("N")){
  	  		//주간훈련일지하단고정목록
  			resultList =weekTraningService.getWeekTraningNoteAddCcn(traningNoteVO);
  			model.addAttribute("resultList", resultList);  			 
  		 }else{
  	  		//주간훈련일지하단고정목록
  			resultList =weekTraningService.getWeekTraningNoteAddCcnAdd(traningNoteVO);
  			model.addAttribute("resultList", resultList);
  		 }
  		 
  		AtchFileVO atchFileVO = new AtchFileVO();
		atchFileVO.setFileSn(1);
		
		if(resultList != null && resultList.size() > 0){
			if(resultList.get(0).getAtchFileId() != null){
				atchFileVO.setAtchFileId(resultList.get(0).getAtchFileId());
			}
		}
		
		//첨부파일
		AtchFileVO resultFile = atchFileService.getAtchFile(atchFileVO);
        model.addAttribute("resultFile", resultFile);     
 

		return "oklms/lu/weektraning/getWeekTraningNoteCcn"; 
	}
	
	/**
	 * 훈련지원 > 주간훈련일지수정 (센터전담자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/updateWeekTraningNoteCcn.do")
	public String updateWeekTraningNoteCcn(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model, HttpSession session,  RedirectAttributes redirectAttributes) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/updateWeekTraningNoteCcn.do" );
		int insertCnt = 0;
		String retMsg="";
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

		if(traningNoteVO.getStatusType().equals("U")){
			insertCnt  = traningNoteSerivce.goInsertTraningNoteDetail(traningNoteVO);			
		}else if(traningNoteVO.getStatusType().equals("X")){ //반려
			traningNoteVO.setState("X");
			insertCnt = weekTraningService.updateWeekTraningNoteCcn(traningNoteVO);
		}else if(traningNoteVO.getStatusType().equals("C")){ //확정
			traningNoteVO.setState("C");
			insertCnt = weekTraningService.updateWeekTraningNoteCcn(traningNoteVO);
		}	
		
		if(insertCnt > 0){
			retMsg = "수정되었습니다.";
		}else{
			retMsg = "수정할 수 없습니다.";
		}
		redirectAttributes.addFlashAttribute("retMsg", retMsg);

		//제출 
		return "redirect:/lu/weektraning/getWeekTraningNoteCcn.do?traningType="+traningNoteVO.getTraningType() +"&addyn="+traningNoteVO.getAddyn()+"&weekCnt="+traningNoteVO.getWeekCnt()+"&yyyy="+traningNoteVO.getYyyy()+"&term="+traningNoteVO.getTerm()+"&companyId="+traningNoteVO.getCompanyId()+"&traningProcessId="+traningNoteVO.getTraningProcessId();
	}
	
	/**
	 * 훈련지원 > 주간훈련일지 상세보기 (센터전담자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/updateWeekTraningNoteCcnFile.do")
	public String updateWeekTraningNoteCcnFile(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ,  RedirectAttributes redirectAttributes, final MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.debug("#### URL = /lu/weektraning/updateWeekTraningNoteCcnFile.do" );
		int insertCnt = 0;
		String retMsg="";
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

		insertCnt = weekTraningService.updateWeekTraningNoteCcnFile(traningNoteVO,multiRequest);

		if(insertCnt > 0){
			retMsg = "수정되었습니다.";
		}else{
			retMsg = "수정할 수 없습니다.";
		}
		redirectAttributes.addFlashAttribute("retMsg", retMsg);

		//제출 
		return "redirect:/lu/weektraning/getWeekTraningNoteCcn.do?traningType="+traningNoteVO.getTraningType() +"&addyn="+traningNoteVO.getAddyn()+"&weekCnt="+traningNoteVO.getWeekCnt()+"&yyyy="+traningNoteVO.getYyyy()+"&term="+traningNoteVO.getTerm()+"&companyId="+traningNoteVO.getCompanyId()+"&traningProcessId="+traningNoteVO.getTraningProcessId();
	}
	
	/**
	 * 훈련지원 > 주간훈련일지 (HRD담당자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/listWeekTraningNoteHrd.do")
	public String listWeekTraningNoteHrd(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/listWeekTraningNoteHrd.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());

  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result);
  		model.addAttribute("traningNoteVO", traningNoteVO);

		//주간훈련일지하단고정목록
		List<TraningNoteVO> bottomList =weekTraningService.listWeekTraningNoteBottomCcn(traningNoteVO);
		model.put("bottomList", bottomList);
 
		return "oklms/lu/weektraning/listWeekTraningNoteHrd";
	}	

	/**
	 * 훈련지원 > 주간훈련일지 상세보기 (HRD담당자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/getWeekTraningNoteHrd.do")
	public String getWeekTraningNoteHrd(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/getWeekTraningNoteHrd.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		
  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());
  		 
  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result);
  		model.addAttribute("traningNoteVO", traningNoteVO);
  		
		if(traningNoteVO.getAddyn().equals("N")){
	  		//주간훈련일지하단고정목록
			List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteCcn(traningNoteVO);
			model.addAttribute("resultList", resultList);
 
		}else{
	  		//주간훈련일지하단고정목록
			List<TraningNoteVO> resultList =weekTraningService.getWeekTraningNoteAddCcnAdd(traningNoteVO);
			model.addAttribute("resultList", resultList);

		}
		return "oklms/lu/weektraning/getWeekTraningNoteHrd";		

	}
	
	/**
	 * 월간학습근로자 출석부 (센터담당자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/listMonthTraningNoteCcn.do")
	public String listMonthTraningNoteCcn(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/listMonthTraningNoteCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		//interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		//interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());
  		//InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		loginInfo.putSessionToVo(interviewCompanyVO); // session의 정보를 VO에 추가.
  		
  		// =================   조회 기업체 세팅 ==================
  		if( traningNoteVO.getBaseCheckCompanyIds() != null && traningNoteVO.getBaseCheckCompanyIds().indexOf(",") != -1 ){
  			interviewCompanyVO.setBaseSearchCompanyIds(CommonUtil.toDataStr(traningNoteVO.getBaseCheckCompanyIds()));
  		}
  		
  		List<InterviewCompanyVO> result = interviewService.listSearchCompanyTraning(interviewCompanyVO);
  		// =================  조회 기업체 세팅 ==================
  		
  		model.addAttribute("companyId", traningNoteVO.getCompanyId()); 
  		model.addAttribute("traningProcessId", traningNoteVO.getTraningProcessId()); 
  		model.addAttribute("result", result); 
  		// 조회 연도(기본현재년)
  		String yyyy = traningNoteVO.getYyyy();
  		if(yyyy==null||yyyy.equals("")){
  			yyyy=	kr.co.gocle.oklms.commbiz.util.BizUtil.getCurrentDateString("yyyy");
  			traningNoteVO.setYyyy(yyyy);
  		}
  		// 조회 월( 기본현재월)
  		String mm = traningNoteVO.getMm();
  		if(mm==null||mm.equals("")){
  			mm=	kr.co.gocle.oklms.commbiz.util.BizUtil.getCurrentDateString("MM");
  			traningNoteVO.setMm(mm);
  		}
  		if(mm.length()==1){
  			mm="0"+mm;
  		}

  		// 월의 마지막날짜반환  		
  		int lastDay = kr.co.gocle.oklms.commbiz.util.BizUtil.getMonthLastday(yyyy+mm+"01");
  		model.addAttribute("lastDay", lastDay);

		traningNoteVO.setTraningMonth(yyyy+"."+mm);
  		List<List<TraningNoteVO>> resultlistSum = new ArrayList<List<TraningNoteVO>>(); 
  		if(traningNoteVO.getCompanyId()!=null&&!traningNoteVO.getCompanyId().equals("")){
	  			
	  		for(int a=1;lastDay>=a ;a++){
		  		//주간훈련일지하단고정목록
	  			String day = ""+a;
	  			if(a<=9){
	  				day="0"+day;
	  			}
	  			traningNoteVO.setTraningDate(yyyy+"."+mm+"."+day);

	  			
				List<TraningNoteVO> resultList =weekTraningService.selectDayTraningNoteAll(traningNoteVO);
				resultlistSum.add(resultList);
	  		}
	  		
	  		List<TraningNoteVO> resultTotal = weekTraningService.selectDayTraningNoteTotal(traningNoteVO);
	  		model.addAttribute("resultTotal", resultTotal);
	  		
	  		TraningNoteVO resultSum = weekTraningService.selectDayTraningNoteAllSum(traningNoteVO);
	  		model.addAttribute("resultSum", resultSum);
  		}  	
  		
  		traningNoteVO.setTraningNoteVOArr(resultlistSum);
  		
  		model.addAttribute("traningNoteVO", traningNoteVO);

		return "oklms/lu/weektraning/listMonthTraningNoteCcn";		

	}
	
	/**
	 * 월간학습근로자 출석부인쇄페이지 (센터담당자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/printMonthTraningNoteCcn.do")
	public String printMonthTraningNoteCcn(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/printMonthTraningNoteCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());

  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result); 
  		// 조회 연도(기본현재년)
  		String yyyy = traningNoteVO.getYyyy();
  		if(yyyy==null||yyyy.equals("")){
  			yyyy=	kr.co.gocle.oklms.commbiz.util.BizUtil.getCurrentDateString("yyyy");
  			traningNoteVO.setYyyy(yyyy);
  		}
  		// 조회 월( 기본현재월)
  		String mm = traningNoteVO.getMm();
  		if(mm==null||mm.equals("")){
  			mm=	kr.co.gocle.oklms.commbiz.util.BizUtil.getCurrentDateString("MM");
  			traningNoteVO.setMm(mm);
  		}
  		if(mm.length()==1){
  			mm="0"+mm;
  		}

  		// 월의 마지막날짜반환  		
  		int lastDay = kr.co.gocle.oklms.commbiz.util.BizUtil.getMonthLastday(yyyy+mm+"01");
  		model.addAttribute("lastDay", lastDay);

  		traningNoteVO.setTraningMonth(yyyy+"."+mm);
  		List<List<TraningNoteVO>> resultlistSum = new ArrayList<List<TraningNoteVO>>(); 
  		if(traningNoteVO.getCompanyId()!=null&&!traningNoteVO.getCompanyId().equals("")){
	  			
	  		for(int a=1;lastDay>=a ;a++){
		  		//주간훈련일지하단고정목록
	  			String day = ""+a;
	  			if(a<=9){
	  				day="0"+day;
	  			}
	  			traningNoteVO.setTraningDate(yyyy+"."+mm+"."+day);
				List<TraningNoteVO> resultList =weekTraningService.selectDayTraningNoteAll(traningNoteVO);
				resultlistSum.add(resultList);
	  		}
	  		List<TraningNoteVO> resultTotal = weekTraningService.selectDayTraningNoteTotal(traningNoteVO);
	  		model.addAttribute("resultTotal", resultTotal);
	  		
	  		TraningNoteVO resultSum = weekTraningService.selectDayTraningNoteAllSum(traningNoteVO);
	  		model.addAttribute("resultSum", resultSum);
  		}  	
  		
  		traningNoteVO.setTraningNoteVOArr(resultlistSum);
  		
  		model.addAttribute("traningNoteVO", traningNoteVO);

		return "oklms_popup/lu/weektraning/printMonthTraningNoteCcn";		

	}		
	/**
	 * 월간학습근로자 출석부엑셀다운로드 (센터담당자)
	 * @param traningNoteVO
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/weektraning/excelMonthTraningNoteCcn.do")
	public String excelMonthTraningNoteCcn(@ModelAttribute("frmWeekTraning") TraningNoteVO  traningNoteVO ,ModelMap model , HttpServletRequest request ) throws Exception {

		LOGGER.debug("#### URL = /lu/weektraning/listMonthTraningNoteCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		

  		InterviewCompanyVO interviewCompanyVO = new InterviewCompanyVO();
  		interviewCompanyVO.setCompanyId(traningNoteVO.getCompanyId());
  		interviewCompanyVO.setTraningProcessId(traningNoteVO.getTraningProcessId());

  		InterviewCompanyVO result=interviewService.InterviewCompany(interviewCompanyVO);
  		model.addAttribute("result", result); 
  		// 조회 연도(기본현재년)
  		String yyyy = traningNoteVO.getYyyy();
  		if(yyyy==null||yyyy.equals("")){
  			yyyy=	kr.co.gocle.oklms.commbiz.util.BizUtil.getCurrentDateString("yyyy");
  			traningNoteVO.setYyyy(yyyy);
  		}
  		// 조회 월( 기본현재월)
  		String mm = traningNoteVO.getMm();
  		if(mm==null||mm.equals("")){
  			mm=	kr.co.gocle.oklms.commbiz.util.BizUtil.getCurrentDateString("MM");
  			traningNoteVO.setMm(mm);
  		}
  		if(mm.length()==1){
  			mm="0"+mm;
  		}

  		// 월의 마지막날짜반환  		
  		int lastDay = kr.co.gocle.oklms.commbiz.util.BizUtil.getMonthLastday(yyyy+mm+"01");
  		model.addAttribute("lastDay", lastDay);

  		traningNoteVO.setTraningMonth(yyyy+"."+mm);
  		List<List<TraningNoteVO>> resultlistSum = new ArrayList<List<TraningNoteVO>>(); 
  		if(traningNoteVO.getCompanyId()!=null&&!traningNoteVO.getCompanyId().equals("")){
	  			
	  		for(int a=1;lastDay>=a ;a++){
		  		//주간훈련일지하단고정목록
	  			String day = ""+a;
	  			if(a<=9){
	  				day="0"+day;
	  			}
	  			traningNoteVO.setTraningDate(yyyy+"."+mm+"."+day);
				List<TraningNoteVO> resultList =weekTraningService.selectDayTraningNoteAll(traningNoteVO);
				resultlistSum.add(resultList);
	  		}
	  		List<TraningNoteVO> resultTotal = weekTraningService.selectDayTraningNoteTotal(traningNoteVO);
	  		model.addAttribute("resultTotal", resultTotal);
	  		
	  		TraningNoteVO resultSum = weekTraningService.selectDayTraningNoteAllSum(traningNoteVO);
	  		model.addAttribute("resultSum", resultSum);
  		}  		
  		traningNoteVO.setTraningNoteVOArr(resultlistSum);
  		
  		model.addAttribute("traningNoteVO", traningNoteVO);
 
		request.setAttribute("ExcelName", URLEncoder.encode( "월간출석부".replaceAll(" ", "_") ,"UTF-8") );
 
		return "oklms_excel/lu/weektraning/excelMonthTraningNoteCcn";

	}	
	
	/*
	@RequestMapping(value = "/lu/weektraning/excelWeekTraningAttendCot.do")
	public String excelWeekTraningAttend(TraningNoteVO traningNoteVO, ModelMap model, HttpServletRequest request)
	        throws Exception
	    {
	        LOGGER.debug("#### URL = /lu/weektraning/excelWeekTraningAttendCot.do");
	        LoginInfo loginInfo = new LoginInfo();
	        loginInfo.getLoginInfo();
	        loginInfo.putSessionToVo(traningNoteVO);
	        
	        String excelFileName = traningNoteVO.getYyyy()+"년도_"+traningNoteVO.getTermName()+"_"+traningNoteVO.getWeekCnt()+"주차_"+traningNoteVO.getCompanyName()+"_"+traningNoteVO.getSubjectName();
	        
	        List resultList = weekTraningService.excelWeekTraningAttendCot(traningNoteVO);
	        model.put("resultList", resultList);
	        request.setAttribute("ExcelName", URLEncoder.encode(excelFileName, "UTF-8"));
	        return "oklms_excel_data/lu/weektraning/excelWeekTraningAttendCot";
	    }
	@RequestMapping(value = "/lu/weektraning/excelWeekTraningAttendPrd.do")
    public String excelWeekTraningAttendPrd(TraningNoteVO traningNoteVO, ModelMap model, HttpServletRequest request)
        throws Exception
    {
        LOGGER.debug("#### URL = /lu/weektraning/excelWeekTraningAttendPrd.do");
        LoginInfo loginInfo = new LoginInfo();
        loginInfo.getLoginInfo();
        loginInfo.putSessionToVo(traningNoteVO);

        String excelFileName = traningNoteVO.getYyyy()+"년도_"+traningNoteVO.getTermName()+"_"+traningNoteVO.getWeekCnt()+"주차_"+traningNoteVO.getSubjectName();
        
        model.put("traningType", traningNoteVO.getTraningType());
        List resultList = weekTraningService.excelWeekTraningAttendPrd(traningNoteVO);
        model.put("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode(excelFileName, "UTF-8"));
        return "oklms_excel_data/lu/weektraning/excelWeekTraningAttendPrd";
    }
    */
	
	@RequestMapping(value = "/lu/weektraning/excelWeekTraningAttendCot.do")
	public View excelWeekTraningAttend(TraningNoteVO traningNoteVO, ModelMap model, HttpServletRequest request)
	        throws Exception
	    {
	        LOGGER.debug("#### URL = /lu/weektraning/excelWeekTraningAttendCot.do");
	        LoginInfo loginInfo = new LoginInfo();
	        loginInfo.getLoginInfo();
	        loginInfo.putSessionToVo(traningNoteVO);
	        
	        String excelFileName = traningNoteVO.getYyyy()+"년도_"+traningNoteVO.getTermName()+"_"+traningNoteVO.getWeekCnt()+"주차_"+traningNoteVO.getCompanyName()+"_"+traningNoteVO.getSubjectName();
	        model.put("excelFileName", URLEncoder.encode(excelFileName, "UTF-8"));
	        List resultList = weekTraningService.excelWeekTraningAttendCot(traningNoteVO);
	        model.put("resultList", resultList);
	        request.setAttribute("ExcelName", URLEncoder.encode(excelFileName, "UTF-8"));
	        
	        return new listAttendCotExcelView();
	    }
	
	@RequestMapping(value = "/lu/weektraning/excelWeekTraningAttendPrd.do")
    public View excelWeekTraningAttendPrd(TraningNoteVO traningNoteVO, ModelMap model, HttpServletRequest request)
        throws Exception
    {
        LOGGER.debug("#### URL = /lu/weektraning/excelWeekTraningAttendPrd.do");
        LoginInfo loginInfo = new LoginInfo();
        loginInfo.getLoginInfo();
        loginInfo.putSessionToVo(traningNoteVO);

        String excelFileName = traningNoteVO.getYyyy()+"년도_"+traningNoteVO.getTermName()+"_"+traningNoteVO.getWeekCnt()+"주차_"+traningNoteVO.getSubjectName();
        model.put("excelFileName", URLEncoder.encode(excelFileName, "UTF-8"));
        model.put("traningType", traningNoteVO.getTraningType());
        List resultList = weekTraningService.excelWeekTraningAttendPrd(traningNoteVO);
        model.put("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode(excelFileName, "UTF-8"));
        
        return new listAttendPrdExcelView();
    }
}