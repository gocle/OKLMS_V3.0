package kr.co.gocle.oklms.lu.subject.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.gocle.ifx.service.IfxService;
import kr.co.gocle.ifx.vo.AunuriMemberVO;
import kr.co.gocle.ifx.vo.AunuriSubjectVO;
import kr.co.gocle.oklms.comm.util.CommonUtil;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.util.AtchFileUtil;
import kr.co.gocle.oklms.commbiz.util.BizUtil;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.vo.ExcelMemberVO;
import kr.co.gocle.oklms.lu.activity.service.ActivityService;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO; 
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.vo.SubjweekStdVO;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.grade.vo.GradeVO;
import kr.co.gocle.oklms.lu.interview.service.InterviewService;
import kr.co.gocle.oklms.lu.interview.vo.InterviewCompanyVO; 
import kr.co.gocle.oklms.lu.main.service.LmsUserMainPageService;
import kr.co.gocle.oklms.lu.main.vo.LmsUserMainPageVO;
import kr.co.gocle.oklms.lu.online.service.OnlineTraningService;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.report.service.ReportService; 
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectCompanyVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;
import kr.co.gocle.oklms.lu.traning.service.TraningNoteSerivce;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningProcessMappingVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningReportVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
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
public class SubjectController  extends BaseController{

	@Resource(name = "SubjectService")
	private SubjectService subjectService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	@Resource(name = "OnlineTraningService")
	private OnlineTraningService onlineTraningService;
	
	@Resource(name = "companyService")
	private CompanyService companyService;
	
	@Resource(name = "LmsUserMainPageService")
	private LmsUserMainPageService lmsUserMainPageService;
	
	@Resource(name = "ifxService")
	private IfxService ifxService;
	
	@Resource(name = "traningNoteSerivce")
	private TraningNoteSerivce traningNoteSerivce;
	
	@Resource(name = "ActivityService")
	private ActivityService activityService;
	
	
	// 담당개설교과 - 교수
	@RequestMapping(value="/lu/subject/listSubjectPrt.do")
	public String listSubjectPrt(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listSubjectPrt.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		
		String returnView = "";
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		logger.debug("########### subjectVO.getPageSize() : " +subjectVO.getPageSize());
		logger.debug("########### subjectVO.getPageSize() : " +subjectVO.getPageSize());
		
		// 훈련방식 - 검색조건 없을시 OJT 세팅
		if( subjectVO.getSubjectTraningType() == null || subjectVO.getSubjectTraningType().equals("") ){
			subjectVO.setSubjectTraningType("OJT");
		}
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectVO.getSearchPeriodType() == null || subjectVO.getSearchPeriodType().equals("") ){
			subjectVO.setSearchPeriodType("TERM");
		}
		
		logger.debug("============ subjectVO.getPageSize() : " +subjectVO.getPageSize());
		logger.debug("============ subjectVO.getPageSize() : " +subjectVO.getPageSize());
		
		List <SubjectVO> resultList = subjectService.listSubjectPrt(subjectVO);
		model.addAttribute("resultList", resultList);
		
		Integer pageSize = subjectVO.getPageSize();
		Integer page = subjectVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(subjectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(subjectVO.getPageSize());
        paginationInfo.setPageSize(subjectVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		if(subjectVO.getSubjectTraningType().equals("OJT")){		// 훈련방식 OJT
			if(subjectVO.getSearchPeriodType().equals("TERM")){	// 학기별
				returnView="oklms/lu/subject/listSubjectOjtTermPrt";
			} else {																			// 주차별
				returnView="oklms/lu/subject/listSubjectOjtWeekPrt";
			}
		} else { 																				// 훈련방식 Off-JT
			if(subjectVO.getSearchPeriodType().equals("TERM")){	// 학기별
				returnView="oklms/lu/subject/listSubjectOffTermPrt";
			} else {																			// 주차별
				returnView="oklms/lu/subject/listSubjectOffWeekPrt";
			}
		}
		
		model.addAttribute("subjectVO", subjectVO);
		
		// View호출
		return returnView;
	}
	
	// 담당개설교과 - 학과전담자
	@RequestMapping(value="/lu/subject/listSubjectCdp.do")
	public String listSubjectCdp(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listSubjectCdp.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <SubjectVO> resultList = subjectService.listSubjectCdp(subjectVO);
		model.addAttribute("resultList", resultList);
		
		Integer pageSize = subjectVO.getPageSize();
		Integer page = subjectVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(subjectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(subjectVO.getPageSize());
        paginationInfo.setPageSize(subjectVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		model.addAttribute("subjectVO", subjectVO);
		
		// View호출
		return "oklms/lu/subject/listSubjectOffTermCdp";
	}
	
	// 훈련개설교과 - 학습근로자
	@RequestMapping(value="/lu/subject/listSubjectStd.do")
	public String listSubjectStd(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listSubjectStd.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		String returnView = "";
		
		if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		
		// 훈련방식 - 검색조건 없을시 OJT 세팅
		if( subjectVO.getSubjectTraningType() == null || subjectVO.getSubjectTraningType().equals("") ){
			subjectVO.setSubjectTraningType("OJT");
		}
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectVO.getSearchPeriodType() == null || subjectVO.getSearchPeriodType().equals("") ){
			subjectVO.setSearchPeriodType("TERM");
		}
		
		
		List <SubjectVO> resultList = subjectService.listSubjectStd(subjectVO);
		model.addAttribute("resultList", resultList);
		
		Integer pageSize = subjectVO.getPageSize();
		Integer page = subjectVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(subjectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(subjectVO.getPageSize());
        paginationInfo.setPageSize(subjectVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		if(subjectVO.getSubjectTraningType().equals("OJT")){		// 훈련방식 OJT
			if(subjectVO.getSearchPeriodType().equals("TERM")){	// 학기별
				returnView="oklms/lu/subject/listSubjectOjtTermStd";
			} else {																			// 주차별
				returnView="oklms/lu/subject/listSubjectOjtWeekStd";
			}
		} else { 																				// 훈련방식 Off-JT
			if(subjectVO.getSearchPeriodType().equals("TERM")){	// 학기별
				returnView="oklms/lu/subject/listSubjectOffTermStd";
			} else {																			// 주차별
				returnView="oklms/lu/subject/listSubjectOffWeekStd";
			}
		}
		
		model.addAttribute("subjectVO", subjectVO);
		
		// View호출
		return returnView;
	}
	
	// 담당개설교과 - 기업현장교사
	@RequestMapping(value="/lu/subject/listSubjectCot.do")
	public String listSubjectCot(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listSubjectCot.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		String returnView = "";
		
		if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectVO.getSearchPeriodType() == null || subjectVO.getSearchPeriodType().equals("") ){
			subjectVO.setSearchPeriodType("TERM");
		}
		
		List <SubjectVO> resultList = subjectService.listSubjectCot(subjectVO);
		model.addAttribute("resultList", resultList);
		
		Integer pageSize = subjectVO.getPageSize();
		Integer page = subjectVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(subjectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(subjectVO.getPageSize());
        paginationInfo.setPageSize(subjectVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		if(subjectVO.getSearchPeriodType().equals("TERM")){	// 학기별
			returnView="oklms/lu/subject/listSubjectOjtTermCot";
		} else {																			// 주차별
			returnView="oklms/lu/subject/listSubjectOjtWeekCot";
		}
		
		model.addAttribute("subjectVO", subjectVO);
		
		
		// View호출
		return returnView;
	}
	
	/*// 담당개설교과 - 센터 당당자
	@RequestMapping(value="/lu/subject/listCompanyCcn.do")
	public String listCompanyCcn(@ModelAttribute("frmComp") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listCompanyCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		if(subjectCompnyVO.getYyyy()==null || subjectCompnyVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectCompnyVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectCompnyVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));		
		}
		
		String returnView = "";
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectCompnyVO.getSearchStatusType() == null || subjectCompnyVO.getSearchStatusType().equals("") ){
			subjectCompnyVO.setSearchStatusType("STU");
		}
		
		
		if(subjectCompnyVO.getSearchStatusType().equals("STU")){	// 학습
			List<SubjectCompanyVO> resultList = new ArrayList<SubjectCompanyVO>();
			ArrayList<Integer> memInfoList = new ArrayList<Integer>();
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> list = subjectService.listCompanyCcn(subjectCompnyVO);
			
			for( int i = 0; i < list.size(); i++ ){
				SubjectCompanyVO compVO = list.get(i);
				compVO.setYyyy(subjectCompnyVO.getYyyy());
				compVO.setTerm(subjectCompnyVO.getTerm());
				SubjectCompanyVO memVO = subjectService.getActivityNoteMemInfos(compVO);
				
				logger.debug("================   memVO.getMemInfos() : "+memVO.getMemInfos());
				logger.debug("================   memVO.getMemInfosLength() : "+memVO.getMemInfosLength());
				
				compVO.setMemInfos(memVO.getMemInfos());
				compVO.setMemInfosLength(memVO.getMemInfosLength());
				
				int length = compVO.getMemInfosLength();
				memInfoList.add(length);
				
				resultList.add(compVO);
			}
			
			if(memInfoList.size() > 0){
				int maxCnt = Collections.max(memInfoList);
				model.addAttribute("maxCnt", maxCnt);
				logger.debug("================   maxCnt : "+maxCnt);
			}
			
			
			model.addAttribute("resultList", resultList);
			
			returnView="oklms/lu/subject/listCompanyStudyCcn";
		} else {																			// 기업
			
			List <SubjectCompanyVO> resultList = subjectService.listCompanyCcn(subjectCompnyVO);
			model.addAttribute("resultList", resultList);
			returnView="oklms/lu/subject/listCompanyCcn";
		}
		
		model.addAttribute("compVO", subjectCompnyVO);
		
		// View호출
		return returnView;
	}*/
	
	// 담당개설교과 - 센터 당당자
	@RequestMapping(value="/lu/subject/listCompanyCcn.do")
	public String listCompanyCcn(@ModelAttribute("frmComp") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listCompanyCcn.do" );
		
		LmsUserMainPageVO mainPageVO = new LmsUserMainPageVO();
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mainPageVO); // session의 정보를 VO에 추가.
		
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		
		mainPageVO.setSearchSchoolYear(subjectCompnyVO.getSearchSchoolYear());
		
		// 기업체현황조회
		List<LmsUserMainPageVO> listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCcnCnt(mainPageVO);
		model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
		
		
		// 기업체현황조회
		List<SubjectCompanyVO> listTraningStatusCcn = subjectService.listTraningStatusCcn(subjectCompnyVO);
		model.addAttribute("listTraningStatusCcn", listTraningStatusCcn);
		
		// 기업체현황조회
		List<SubjectCompanyVO> listSubjectCcn = subjectService.listSubjectCcn(subjectCompnyVO);
		model.addAttribute("listSubjectCcn", listSubjectCcn);
		
		model.addAttribute("subjectCompnyVO", subjectCompnyVO);
		
		// View호출
		return "oklms/lu/subject/listCompanyCcn";
	}
	
	// 담당개설교과 - 센터 당당자
		@RequestMapping(value="/lu/subject/listAllCompanyCcn.do")
		public String listAllCompanyCcn(@ModelAttribute("frmComp") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
			
			logger.debug("#### URL = /lu/subject/listAllCompanyCcn.do" );
			
			LmsUserMainPageVO mainPageVO = new LmsUserMainPageVO();
			
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.getLoginInfo();
			loginInfo.putSessionToVo(mainPageVO); // session의 정보를 VO에 추가.
			
			loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
			
			// 기업체현황조회
			List<LmsUserMainPageVO> listLmsUserMainPageStatusCnt = lmsUserMainPageService.listLmsUserMainPageCcnCnt(mainPageVO);
			model.addAttribute("listLmsUserMainPageStatusCnt", listLmsUserMainPageStatusCnt);
			
			
			// 기업체현황조회
			List<SubjectCompanyVO> listTraningStatusCcn = subjectService.listTraningStatusCcn(subjectCompnyVO);
			model.addAttribute("listTraningStatusCcn", listTraningStatusCcn);
			
			// 기업체현황조회
			List<SubjectCompanyVO> listSubjectCcn = subjectService.listSubjectCcn(subjectCompnyVO);
			model.addAttribute("listSubjectCcn", listSubjectCcn);
			
			model.addAttribute("subjectCompnyVO", subjectCompnyVO);
			
			// View호출
			return "oklms/lu/subject/listAllCompanyCcn";
		}
		
	
	
	// 담당개설교과 - 센터 당당자 엑셀
	@RequestMapping(value="/lu/subject/excelCompanyCcn.do")
	public String excelCompanyCcn(@ModelAttribute("frmCompany") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/excelCompanyCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		if(subjectCompnyVO.getYyyy()==null || subjectCompnyVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectCompnyVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
		}
		
		String returnView = "";
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectCompnyVO.getSearchStatusType() == null || subjectCompnyVO.getSearchStatusType().equals("") ){
			subjectCompnyVO.setSearchStatusType("STU");
		}
		
		
		if(subjectCompnyVO.getSearchStatusType().equals("STU")){	// 학습
			List<SubjectCompanyVO> resultList = new ArrayList<SubjectCompanyVO>();
			ArrayList<Integer> memInfoList = new ArrayList<Integer>();
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> list = subjectService.listCompanyCcn(subjectCompnyVO);
			
			for( int i = 0; i < list.size(); i++ ){
				SubjectCompanyVO compVO = list.get(i);
				compVO.setYyyy(subjectCompnyVO.getYyyy());
				SubjectCompanyVO memVO = subjectService.getActivityNoteMemInfos(compVO);
				
				logger.debug("================   memVO.getMemInfos() : "+memVO.getMemInfos());
				logger.debug("================   memVO.getMemInfosLength() : "+memVO.getMemInfosLength());
				
				compVO.setMemInfos(memVO.getMemInfos());
				compVO.setMemInfosLength(memVO.getMemInfosLength());
				
				int length = compVO.getMemInfosLength();
				memInfoList.add(length);
				
				resultList.add(compVO);
			}
			
			if(memInfoList.size() > 0){
				int maxCnt = Collections.max(memInfoList);
				model.addAttribute("maxCnt", maxCnt);
				logger.debug("================   maxCnt : "+maxCnt);
			}
			
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-학습관리현황".replaceAll(" ", "_") ,"UTF-8") );
			returnView="oklms_excel/lu/subject/excelCompanyStudyCcn";
		} else {																			// 기업
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> resultList = subjectService.listCompanyCcn(subjectCompnyVO);
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-참여기업현황".replaceAll(" ", "_") ,"UTF-8") );
			
			returnView="oklms_excel/lu/subject/excelCompanyCcn";
		}
		
		
		
		model.addAttribute("compVO", subjectCompnyVO);
		
		// View호출
		return returnView;
	}
	
	// 담당개설교과 - 센터 당당자 엑셀
	@RequestMapping(value="/lu/subject/printCompanyCcn.do")
	public String printCompanyCcn(@ModelAttribute("frmCompany") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/printCompanyCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		if(subjectCompnyVO.getYyyy()==null || subjectCompnyVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectCompnyVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
		}
		
		String returnView = "";
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectCompnyVO.getSearchStatusType() == null || subjectCompnyVO.getSearchStatusType().equals("") ){
			subjectCompnyVO.setSearchStatusType("STU");
		}
		
		
		if(subjectCompnyVO.getSearchStatusType().equals("STU")){	// 학습
			List<SubjectCompanyVO> resultList = new ArrayList<SubjectCompanyVO>();
			ArrayList<Integer> memInfoList = new ArrayList<Integer>();
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> list = subjectService.listCompanyCcn(subjectCompnyVO);
			
			for( int i = 0; i < list.size(); i++ ){
				SubjectCompanyVO compVO = list.get(i);
				compVO.setYyyy(subjectCompnyVO.getYyyy());
				SubjectCompanyVO memVO = subjectService.getActivityNoteMemInfos(compVO);
				
				logger.debug("================   memVO.getMemInfos() : "+memVO.getMemInfos());
				logger.debug("================   memVO.getMemInfosLength() : "+memVO.getMemInfosLength());
				
				compVO.setMemInfos(memVO.getMemInfos());
				compVO.setMemInfosLength(memVO.getMemInfosLength());
				
				int length = compVO.getMemInfosLength();
				memInfoList.add(length);
				
				resultList.add(compVO);
			}
			
			if(memInfoList.size() > 0){
				int maxCnt = Collections.max(memInfoList);
				model.addAttribute("maxCnt", maxCnt);
				logger.debug("================   maxCnt : "+maxCnt);
			}
			
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-학습관리현황".replaceAll(" ", "_") ,"UTF-8") );
			returnView="oklms_popup/lu/subject/printCompanyStudyCcn";
		} else {																			// 기업
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> resultList = subjectService.listCompanyCcn(subjectCompnyVO);
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-참여기업현황".replaceAll(" ", "_") ,"UTF-8") );
			
			returnView="oklms_popup/lu/subject/printCompanyCcn";
		}
		
		
		
		model.addAttribute("compVO", subjectCompnyVO);
		
		// View호출
		return returnView;
	}
	
	
	// 담당개설교과 - hrd 당당자
	@RequestMapping(value="/lu/subject/listCompanyCcm.do")
	public String listCompanyCcm(@ModelAttribute("frmCompany") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/listCompanyCcm.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		if(subjectCompnyVO.getYyyy()==null || subjectCompnyVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectCompnyVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
		}
		
		String returnView = "";
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectCompnyVO.getSearchStatusType() == null || subjectCompnyVO.getSearchStatusType().equals("") ){
			subjectCompnyVO.setSearchStatusType("STU");
		}
		
		if(subjectCompnyVO.getSearchStatusType().equals("STU")){	// 학습
			List<SubjectCompanyVO> resultList = new ArrayList<SubjectCompanyVO>();
			ArrayList<Integer> memInfoList = new ArrayList<Integer>();
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> list = subjectService.listCompanyCcm(subjectCompnyVO);
			
			for( int i = 0; i < list.size(); i++ ){
				SubjectCompanyVO compVO = list.get(i);
				compVO.setYyyy(subjectCompnyVO.getYyyy());
				SubjectCompanyVO memVO = subjectService.getActivityNoteMemInfos(compVO);
				
				logger.debug("================   memVO.getMemInfos() : "+memVO.getMemInfos());
				logger.debug("================   memVO.getMemInfosLength() : "+memVO.getMemInfosLength());
				
				compVO.setMemInfos(memVO.getMemInfos());
				compVO.setMemInfosLength(memVO.getMemInfosLength());
				
				int length = compVO.getMemInfosLength();
				memInfoList.add(length);
				
				resultList.add(compVO);
			}
			
			if(memInfoList.size() > 0){
				int maxCnt = Collections.max(memInfoList);
				model.addAttribute("maxCnt", maxCnt);
				logger.debug("================   maxCnt : "+maxCnt);
			}
			
			
			model.addAttribute("resultList", resultList);
			
			returnView="oklms/lu/subject/listCompanyStudyCcm";
		} else {																			// 기업
			
			List <SubjectCompanyVO> resultList = subjectService.listCompanyCcm(subjectCompnyVO);
			model.addAttribute("resultList", resultList);
			returnView="oklms/lu/subject/listCompanyCcm";
		}
		
		model.addAttribute("compVO", subjectCompnyVO);
		
		// View호출
		return returnView;
	}
	
	
	// 담당개설교과 - 센터 당당자 엑셀
	@RequestMapping(value="/lu/subject/excelCompanyCcm.do")
	public String excelCompanyCcm(@ModelAttribute("frmCompany") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/excelCompanyCcm.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		if(subjectCompnyVO.getYyyy()==null || subjectCompnyVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectCompnyVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
		}
		
		String returnView = "";
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectCompnyVO.getSearchStatusType() == null || subjectCompnyVO.getSearchStatusType().equals("") ){
			subjectCompnyVO.setSearchStatusType("STU");
		}
		
		
		if(subjectCompnyVO.getSearchStatusType().equals("STU")){	// 학습
			List<SubjectCompanyVO> resultList = new ArrayList<SubjectCompanyVO>();
			ArrayList<Integer> memInfoList = new ArrayList<Integer>();
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> list = subjectService.listCompanyCcm(subjectCompnyVO);
			
			for( int i = 0; i < list.size(); i++ ){
				SubjectCompanyVO compVO = list.get(i);
				compVO.setYyyy(subjectCompnyVO.getYyyy());
				SubjectCompanyVO memVO = subjectService.getActivityNoteMemInfos(compVO);
				
				logger.debug("================   memVO.getMemInfos() : "+memVO.getMemInfos());
				logger.debug("================   memVO.getMemInfosLength() : "+memVO.getMemInfosLength());
				
				compVO.setMemInfos(memVO.getMemInfos());
				compVO.setMemInfosLength(memVO.getMemInfosLength());
				
				int length = compVO.getMemInfosLength();
				memInfoList.add(length);
				
				resultList.add(compVO);
			}
			
			if(memInfoList.size() > 0){
				int maxCnt = Collections.max(memInfoList);
				model.addAttribute("maxCnt", maxCnt);
				logger.debug("================   maxCnt : "+maxCnt);
			}
			
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-학습관리현황".replaceAll(" ", "_") ,"UTF-8") );
			returnView="oklms_excel/lu/subject/excelCompanyStudyCcm";
		} else {																			// 기업
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> resultList = subjectService.listCompanyCcm(subjectCompnyVO);
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-참여기업현황".replaceAll(" ", "_") ,"UTF-8") );
			
			returnView="oklms_excel/lu/subject/excelCompanyCcm";
		}
		
		
		
		model.addAttribute("compVO", subjectCompnyVO);
		
		// View호출
		return returnView;
	}
	
	// 담당개설교과 - HRD 당당자 엑셀
	@RequestMapping(value="/lu/subject/printCompanyCcm.do")
	public String printCompanyCcm(@ModelAttribute("frmCompany") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/subject/printCompanyCcm.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		if(subjectCompnyVO.getYyyy()==null || subjectCompnyVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectCompnyVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));				
		}
		
		String returnView = "";
		
		// 훈련방식 - 검색조건 없을시 학기로 세팅
		if( subjectCompnyVO.getSearchStatusType() == null || subjectCompnyVO.getSearchStatusType().equals("") ){
			subjectCompnyVO.setSearchStatusType("STU");
		}
		
		
		if(subjectCompnyVO.getSearchStatusType().equals("STU")){	// 학습
			List<SubjectCompanyVO> resultList = new ArrayList<SubjectCompanyVO>();
			ArrayList<Integer> memInfoList = new ArrayList<Integer>();
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> list = subjectService.listCompanyCcm(subjectCompnyVO);
			
			for( int i = 0; i < list.size(); i++ ){
				SubjectCompanyVO compVO = list.get(i);
				compVO.setYyyy(subjectCompnyVO.getYyyy());
				SubjectCompanyVO memVO = subjectService.getActivityNoteMemInfos(compVO);
				
				logger.debug("================   memVO.getMemInfos() : "+memVO.getMemInfos());
				logger.debug("================   memVO.getMemInfosLength() : "+memVO.getMemInfosLength());
				
				compVO.setMemInfos(memVO.getMemInfos());
				compVO.setMemInfosLength(memVO.getMemInfosLength());
				
				int length = compVO.getMemInfosLength();
				memInfoList.add(length);
				
				resultList.add(compVO);
			}
			
			if(memInfoList.size() > 0){
				int maxCnt = Collections.max(memInfoList);
				model.addAttribute("maxCnt", maxCnt);
				logger.debug("================   maxCnt : "+maxCnt);
			}
			
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-학습관리현황".replaceAll(" ", "_") ,"UTF-8") );
			returnView="oklms_popup/lu/subject/printCompanyStudyCcm";
		} else {																			// 기업
			
			if( subjectCompnyVO.getInfoNumArr() != null && subjectCompnyVO.getInfoNumArr().length > 0 ){
				logger.debug("================   subjectCompnyVO.getInfoNumArr().length : "+subjectCompnyVO.getInfoNumArr().length);
				// IN 조건에 사용하기 위해 문자열 변환 후 쿼테이션 세팅
				subjectCompnyVO.setInfoNums(CommonUtil.toArrStr(subjectCompnyVO.getInfoNumArr()));
			}
			
			List <SubjectCompanyVO> resultList = subjectService.listCompanyCcm(subjectCompnyVO);
			model.addAttribute("resultList", resultList);
			request.setAttribute("ExcelName", URLEncoder.encode( "담당기업체현황-참여기업현황".replaceAll(" ", "_") ,"UTF-8") );
			
			returnView="oklms_popup/lu/subject/printCompanyCcm";
		}
		
		
		
		model.addAttribute("compVO", subjectCompnyVO);
		
		// View호출
		return returnView;
	}
	
	
	// 관리자 > 강의실관리 > 강의관리 > 기본정보 목록 메소드
	@RequestMapping(value = "/lu/subject/excelSubjectScheduleCdp.do")
	public String excelSubjectScheduleCdp(@ModelAttribute("frmExcel") OnlineTraningSchVO onlineTraningSchVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		OnlineTraningVO onlineTraningVO = new OnlineTraningVO();
        loginInfo.putSessionToVo(onlineTraningVO); // session의 정보를 VO에 추가.
        
		String returnUrl = "";
        
		List<OnlineTraningSchVO> resultList = onlineTraningService.listOnlineTraningCdpSchedule(onlineTraningSchVO);
		List<OnlineTraningSchVO> scheduleList = onlineTraningService.listOnlineTraningAllWeekSchedule(onlineTraningSchVO);
		List<OnlineTraningSchVO> resultList1 = onlineTraningService.listOfflineTraningCdpSchedule(onlineTraningSchVO);
		
		model.addAttribute("resultList1", resultList1);
		model.addAttribute("resultList", resultList);
		model.addAttribute("scheduleList", scheduleList);
    	if("OFF".equals(onlineTraningSchVO.getPageType())){
    		return "oklms_excel/lu/grade/excelSubjectGrade";
    	} else {
    		return "oklms_excel/lu/grade/excelSubjectGrade";
    	}
        
	}
	
	
	// 담당개설교과 - 교수
	@RequestMapping(value="/la/subject/listSubjectAdm.do")
	public String listSubjectAdm(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /la/subject/listSubjectAdm.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		String returnView = "";
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		
		logger.debug("########### subjectVO.getPageSize() : " +subjectVO.getPageSize());
		logger.debug("########### subjectVO.getPageSize() : " +subjectVO.getPageSize());
		
		
		List <SubjectVO> resultList = subjectService.listSubjectAdm(subjectVO);
		model.addAttribute("resultList", resultList);
		
		Integer pageSize = subjectVO.getPageSize();
		Integer page = subjectVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(subjectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(subjectVO.getPageSize());
        paginationInfo.setPageSize(subjectVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		returnView="oklms/la/subject/listSubjectAdm";
		model.addAttribute("subjectVO", subjectVO);
		
		// View호출
		return returnView;
	}
	@RequestMapping(value = "/la/subject/listSubjectAdmExcelDownload.do")
	public String listMemberExcelDownload(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		subjectVO.setPageSize(10000); // 1만건 조회
		
		List <SubjectVO> resultList = subjectService.listSubjectAdmAll(subjectVO);
		
        model.addAttribute("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode( "교과목정보".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/subject/listSubjectAdmExcel";
	}
	
	
	@RequestMapping(value = "/la/popup/popup/popupSubjectAdmLink.do")
	public String goPopupAunuriLink(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		logger.debug("#### URL = /la/popup/popup/popupSubjectAdmLink.do" );
		
		subjectVO = subjectService.getLinkYyyyTerm(subjectVO);
		
		model.addAttribute("subjectVO", subjectVO);
		// View호출
  		return "oklms_popup/la/popup/popupAunuriLink";
  		
	}  	
	@RequestMapping(value = "/la/popup/popup/popupSubjectAdmReinfcPop.do")
	public String goPopupReinfc(@ModelAttribute("frmWeek") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		logger.debug("#### URL = /la/popup/popup/popupSubjectAdmReinfc.do" );
		
		List <SubjectVO> resultList = subjectService.listYyyyTermReinfcDate(subjectVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("subjectVO", subjectVO);
		// View호출
  		return "oklms_popup/la/popup/popupReinfc";
  		
	}  	
	
	@RequestMapping(value = "/la/popup/popup/popupSubjectAdmReinfcSave.json")
	public @ResponseBody Map<String, Object>  saveSubjectAdmReinfc(@ModelAttribute("frmWeek") SubjectVO subjectVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		logger.debug("#### URL = /la/popup/popup/saveSubjectAdmReinfc.json" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		Map<String , Object> returnMap = new HashMap<String , Object>();
  		String retCd = "FAILE";
		String retMsg = "입력값을 확인해주세요";
		
		int iResult = subjectService.saveSubjectAdmReinfc(subjectVO);
		
		//if( iResult > 0){
			retCd = "SUCCESS";
			retMsg = "정상적으로 (저장)처리되었습니다.";
		//} else {
		//	retMsg = "처리된건이 없습니다.";
		//}
		
			returnMap.put("retCd", retCd);
			returnMap.put("retMsg", retMsg);

			return returnMap;
  		
	} 
	
	
	// 담당개설교과 - HRD 당당자 엑셀
	@RequestMapping(value="/lu/term/listTermSubject.do")
	public String listNoPointSubject(@ModelAttribute("frmCompany") SubjectCompanyVO subjectCompnyVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /lu/term/listTermSubject.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectCompnyVO); // session의 정보를 VO에 추가.
		
		// View호출
		return "oklms/lu/nopoint/listNoPointSubject";
	}
	
	/**
	 * 훈련과정관리 신규추가건 저장
	 * @param TraningVO
	 * @return TraningVO
	 * @throws Exception
	 */
	@RequestMapping(value = "/lu/term/updateTermSubject.do")
	public String updateTermSubject(@RequestParam Map<String, Object> paramMap, @ModelAttribute("frmTraning") SubjectVO subjectVO, BindingResult bindingResult, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {

		String companyId = StringUtils.defaultString( (String)paramMap.get("companyId") , "" );
		String traningProcessId = StringUtils.defaultString( (String)paramMap.get("traningProcessId") , "" );
		String traningProcessName = StringUtils.defaultString( (String)paramMap.get("traningProcessName") , "" );
		String traningProcessNo = StringUtils.defaultString( (String)paramMap.get("traningProcessNo") , "" );
		String yyyy = StringUtils.defaultString( (String)paramMap.get("yyyy1") , "" );
		String addTempCount = StringUtils.defaultString( (String)paramMap.get("count") , "0" );
		String retMsg = "훈련과정관리에 처리할 훈련과정명, 훈련과정번호, 개설강좌 정보가 없습니다.";
		int insertCount1 = 0;
		int addCount = 0;
		addCount = Integer.parseInt(addTempCount);
		
		String yyyyArr = "";
		String termArr = "";
		String subjectCodeArr = "";
		String subClassArr = "";
		String subjectNameArr = "";
		String subjTraningType = "";

		//해당기업에 훈련과정으로 개설교과메핑정보 생성
		for( int idx = 1 ; idx <= addCount ; idx++ ) {
			yyyyArr = StringUtils.defaultString( (String)paramMap.get("yyyy"+idx) , "" );
			termArr = StringUtils.defaultString( (String)paramMap.get("term"+idx) , "" );
			subjectCodeArr = StringUtils.defaultString( (String)paramMap.get("subjectCode"+idx) , "" );
			subClassArr = StringUtils.defaultString( (String)paramMap.get("subClass"+idx) , "" );
			subjectNameArr = StringUtils.defaultString( (String)paramMap.get("subjectName"+idx) , "" );
			subjTraningType = StringUtils.defaultString( (String)paramMap.get("subjType"+idx) , "" );
					
			logger.debug("#### idx ==> ["+idx + "] #### yyyyArr ==> "+yyyyArr);
			logger.debug("#### idx ==> ["+idx + "] #### termArr ==> "+termArr);
			logger.debug("#### idx ==> ["+idx + "] #### subjectCodeArr ==> "+subjectCodeArr);
			logger.debug("#### idx ==> ["+idx + "] #### subClassArr ==> "+subClassArr);
			logger.debug("#### idx ==> ["+idx + "] #### subjectNameArr ==> "+subjectNameArr);

			subjectVO.setYyyy(yyyyArr);
			subjectVO.setTerm(termArr);
			subjectVO.setSubjectCode(subjectCodeArr);
			subjectVO.setSubjectClass(subClassArr);
			
			insertCount1 += subjectService.updateTermSubject(subjectVO);
		}
		
		return "redirect:/lu/term/listTermSubject.do";
	}
	
	
	// 담당개설교과 - 교수
	@RequestMapping(value="/la/hak/listHak.do")
	public String listHak(@ModelAttribute("frmTopHak") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /la/hak/listHak.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		List <SubjectVO> resultList = subjectService.listHak(subjectVO);
		model.addAttribute("resultList", resultList);
		
		
		// View호출
		return "oklms/la/hak/listHak";
	}
	
	@RequestMapping(value = "/la/hak/insertHak.do")
	public String insertHak(@RequestParam Map<String, Object> paramMap, @ModelAttribute("frmHak") SubjectVO subjectVO, BindingResult bindingResult, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {
		
		String returnPage = "";
		String retMsg = "처리에 실패했습니다.";
		
		int iResult = subjectService.insertHak(subjectVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}
		
		// View호출
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
			
		
		return "redirect:/la/hak/listHak.do";
	}
	
	@RequestMapping(value = "/la/hak/updateHak.do")
	public String updateHak(@RequestParam Map<String, Object> paramMap, @ModelAttribute("frmHak") SubjectVO subjectVO, BindingResult bindingResult, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {

		String returnPage = "";
		String retMsg = "처리에 실패했습니다.";
		
		int iResult = subjectService.updateHak(subjectVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}
		
		// View호출
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		return "redirect:/la/hak/listHak.do";
	}
	
	@RequestMapping(value = "/la/hak/deleteHak.do")
	public String deletetHak(@RequestParam Map<String, Object> paramMap, @ModelAttribute("frmHak") SubjectVO subjectVO, BindingResult bindingResult, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {

		String returnPage = "";
		String retMsg = "처리에 실패했습니다.";
		
		int iResult = subjectService.deleteHak(subjectVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}
		
		// View호출
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		return "redirect:/la/hak/listHak.do";
	}
	
	
	@RequestMapping(value="/la/term/listWeekStudyDay.do")
	public String listWeekStudyDay(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /la/subject/listWeekStudyDay.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		String returnView = "";
		
		if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
			// 현재 년도학기조회
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
			subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		}
		
		List <SubjectVO> resultList = subjectService.listWeekStudyDay(subjectVO);
		model.addAttribute("resultList", resultList);
		
		
		returnView="oklms/la/subject/listWeekStudyDay";
		model.addAttribute("subjectVO", subjectVO);
		
		// View호출
		return returnView;
	}
	
	@RequestMapping(value="/la/term/updateWeekStudyDay.do")
	public String updateWeekStudyDay(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model, HttpServletRequest request, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {
		
		logger.debug("#### URL = /la/subject/updateWeekStudyDay.do" );
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
		
		String returnPage = "";
		String retMsg = "처리에 실패했습니다.";
		
		int iResult = subjectService.updateWeekStudyDay(subjectVO);
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		}
		
		// View호출
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		return "redirect:/la/term/listWeekStudyDay.do?yyyy="+subjectVO.getYyyy()+"&term="+subjectVO.getTerm()+"&subjectType="+subjectVO.getSubjectType();
		
	}
	
	
	// 담당개설교과 - 교수
		@RequestMapping(value="/lu/apploval/listApproval.do")
		public String listApproval(@ModelAttribute("frmApproval") SubjectVO subjectVO, ModelMap model, HttpServletRequest request) throws Exception {
			
			AunuriMemberVO aunuriMemberVO = new AunuriMemberVO();
			TraningNoteVO traningNoteVO =  new TraningNoteVO();
			ActivityVO activityVO = new ActivityVO();
			
			
			logger.debug("#### URL = /lu/subject/listApproval.do" );
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.getLoginInfo();
			loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
			loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
			loginInfo.putSessionToVo(activityVO); // session의 정보를 VO에 추가.
			
			String searchSubjectCode =  StringUtils.defaultString(subjectVO.getSearchSubjectCode(),"");
			String actSearchStatus =  StringUtils.defaultString(subjectVO.getActSearchStatus(),"1");
			String noteSearchStatus =  StringUtils.defaultString(subjectVO.getNoteSearchStatus(),"1");
			
			traningNoteVO.setNoteSearchStatus(noteSearchStatus);
			traningNoteVO.setSearchSubjectCode(searchSubjectCode);
			activityVO.setActSearchStatus(actSearchStatus);
			activityVO.setSearchSubjectCode(searchSubjectCode);
			
			// 현재 년도학기조회
			
			if(subjectVO.getYyyy()==null || subjectVO.getYyyy().equals("")){
				// 현재 년도학기조회
				CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
				subjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));			
				subjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
			}
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
			model.addAttribute("yyyy", commonCodeVO.getYyyy());
			model.addAttribute("termName", commonCodeVO.getTermName());
			
			aunuriMemberVO.setSessionMemSeq(loginInfo.getMemSeq());
			
			aunuriMemberVO.setYyyy(subjectVO.getYyyy());
			aunuriMemberVO.setTerm(subjectVO.getTerm());
			
			traningNoteVO.setYyyy(subjectVO.getYyyy());
			traningNoteVO.setTerm(subjectVO.getTerm());
			
			activityVO.setYyyy(subjectVO.getYyyy());
			activityVO.setTerm(subjectVO.getTerm());
			
			
			List<AunuriSubjectVO> listOjtAunuriSubject= ifxService.getOjtAunuriSubjectApproValInsMappingList(aunuriMemberVO);
			model.addAttribute("listOjtAunuriSubject", listOjtAunuriSubject);
			
			List<TraningNoteVO> listOjtTraningNoteApproval= traningNoteSerivce.listOjtTraningNoteApproval(traningNoteVO);
			model.addAttribute("listOjtTraningNoteApproval", listOjtTraningNoteApproval);
			
			List<ActivityVO> listOjtActivityApproval= activityService.listOjtActivityApproval(activityVO);
			model.addAttribute("listOjtActivityApproval", listOjtActivityApproval);
			
			model.addAttribute("subjectVO", subjectVO);
			model.addAttribute("activityVO", activityVO);
			model.addAttribute("traningNoteVO", traningNoteVO);
			
			// View호출
			return "oklms/lu/approval/listTraningNoteApproval";
		}
		
		/**
		 * 정규수업 등록
		 * @param cmsCourseBaseVO
		 *
		 * @param model
		 * @param session
		 * @param traningNoteVO
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/lu/apploval/saveApprovalNote.do")
		public String saveTraningNote(@RequestParam Map<String, Object> paramMap,@ModelAttribute("frmApproval")TraningNoteVO  traningNoteVO, ModelMap model, HttpSession session,  RedirectAttributes redirectAttributes ) throws Exception {

			logger.debug("#### URL = /lu/apploval/saveApproval.do" );
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.getLoginInfo();
			loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
			
			String actSearchStatus = StringUtils.defaultString( (String)paramMap.get("actSearchStatus") , "" );
			
			String retMsg = "입력값을 확인해주세요";
			int insertCnt = 0;
			
			insertCnt  = traningNoteSerivce.applovalOjtTraningNote(traningNoteVO);
			

			if(insertCnt > 0){
				retMsg = "정상적으로 처리되었습니다.!";
			}else{
				retMsg = "저장 처리된건이 없습니다.!";
			}

			redirectAttributes.addFlashAttribute("retMsg", retMsg);
			
		
			return "redirect:/lu/apploval/listApproval.do?noteSearchStatus="+traningNoteVO.getNoteSearchStatus()+"&actSearchStatus="+actSearchStatus+"&searchSubjectCode="+traningNoteVO.getSearchSubjectCode();
		}
		
		@RequestMapping(value = "/lu/apploval/saveApprovalAct.do")
		public String saveActivity(@RequestParam Map<String, Object> paramMap,@ModelAttribute("frmApproval")  ActivityVO activityVO,ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
			logger.debug("#### URL = /lu/apploval/saveApprovalAct.do" );
			//세션자동복사
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.getLoginInfo();
			loginInfo.putSessionToVo(activityVO); // session의 정보를 VO에 추가.
			
			String noteSearchStatus = StringUtils.defaultString( (String)paramMap.get("noteSearchStatus") , "" );
			
			String retMsg="";
	  		int insertCnt = activityService.saveActivity(activityVO);
			if(insertCnt > 0){
				retMsg = "정상적으로 처리되었습니다.!";
			}else{
				retMsg = "저장 처리된건이 없습니다.!";
			}

			redirectAttributes.addFlashAttribute("retMsg", retMsg);  		
			redirectAttributes.addFlashAttribute("frmActivity", activityVO);
			
			// View호출
	  		return "redirect:/lu/apploval/listApproval.do?actSearchStatus="+activityVO.getActSearchStatus()+"&noteSearchStatus="+noteSearchStatus+"&searchSubjectCode="+activityVO.getSearchSubjectCode();
		}  	
		
		
		@RequestMapping(value = "/lu/subject/listOjtClass.json")
		public @ResponseBody Map<String, Object> listOjtClass(@RequestParam Map<String, Object> commandMap
			,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,HttpSession session 
			,ModelMap model) throws Exception {
			
			Map<String , Object> returnMap = new HashMap<String , Object>();
			
			String retCd = "SUCCESS";
			String retMsg = "";
			
			SubjectVO subjectVO = new SubjectVO();
			
			String searchKeyword = (String) commandMap.get("searchKeyword");
			
			subjectVO.setSearchKeyword(searchKeyword);
			subjectVO.setYyyy(StringUtils.defaultIfBlank(  (String) commandMap.get("yyyy") ,(String)session.getAttribute(Globals.YYYY)));
			subjectVO.setTerm(StringUtils.defaultIfBlank( (String) commandMap.get("term") ,(String)session.getAttribute(Globals.TERM)));  
			subjectVO.setSubjectCode(StringUtils.defaultIfBlank( (String) commandMap.get("subjectCode"),(String)session.getAttribute(Globals.SUBJECT_CODE)));
			
			logger.debug("searchKeyword : "+searchKeyword );
			logger.debug("subjectVO.getYyyy() : "+subjectVO.getYyyy() );
			logger.debug("subjectVO.getTerm : "+subjectVO.getTerm() );
			logger.debug("subjectVO.setSubjectCode : "+subjectVO.getSubjectCode() );
			logger.debug("#### URL = /lu/apploval/saveApprovalAct.do" );
			logger.debug("#### URL = /lu/apploval/saveApprovalAct.do" );
			
			//세션자동복사
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.getLoginInfo(); 
			loginInfo.putSessionToVo(subjectVO); // session의 정보를 VO에 추가.
			
			
			try {
				List<SubjectVO> listOjtClassName = subjectService.listOjtClassName(subjectVO);
				
				returnMap.put("retCd", retCd);
				returnMap.put("retMsg", retMsg);
				returnMap.put("listOjtClassName", listOjtClassName);
				
			 } catch (Exception e) {
			    e.printStackTrace();
			 }
			
			return returnMap;
		}
		
		@RequestMapping(value = "/lu/subject/listOjtClassMember.json")
		public @ResponseBody Map<String, Object> listOjtClassMember(@RequestParam Map<String, Object> commandMap
			,@ModelAttribute("frmActivity")ActivityVO  activityVO
			,RedirectAttributes redirectAttributes
			,SessionStatus status
			,HttpServletRequest request
			,HttpSession session 
			,ModelMap model) throws Exception {
			
			Map<String , Object> returnMap = new HashMap<String , Object>();
			HttpSession httpSession = request.getSession(); 
			
			String retCd = "SUCCESS";
			String retMsg = "";
			
			activityVO.setYyyy(StringUtils.defaultIfBlank( activityVO.getYyyy() ,(String)httpSession.getAttribute(Globals.YYYY)));
			activityVO.setTerm(StringUtils.defaultIfBlank( activityVO.getTerm() ,(String)httpSession.getAttribute(Globals.TERM)));  
			activityVO.setClassId(StringUtils.defaultIfBlank( activityVO.getClassId() ,(String)httpSession.getAttribute(Globals.CLASS)));
			activityVO.setSubjectCode(StringUtils.defaultIfBlank( activityVO.getSubjectCode() ,(String)httpSession.getAttribute(Globals.SUBJECT_CODE)));
			
			MemberVO memberVO = new MemberVO();
			memberVO.setYyyy(activityVO.getYyyy());
			memberVO.setTerm(activityVO.getTerm());
			memberVO.setSubjectCode(activityVO.getSubjectCode());
			memberVO.setClassId(activityVO.getClassId());
			memberVO.setWeekCnt(activityVO.getWeekCnt());
			memberVO.setSearchName(activityVO.getSearchName());
			
			
			System.out.println("======================= memberVO.getYyyy : "+ memberVO.getYyyy());
			System.out.println("======================= memberVO.getTerm : "+ memberVO.getTerm());
			System.out.println("======================= memberVO.getSubjectCode : "+ memberVO.getSubjectCode());
			System.out.println("======================= memberVO.getClassId : "+ memberVO.getClassId());
			System.out.println("======================= memberVO.getWeekCnt : "+ memberVO.getWeekCnt());
			System.out.println("======================= memberVO.getSearchName : "+ memberVO.getSearchName());
			
			
			//세션자동복사
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.getLoginInfo(); 
			loginInfo.putSessionToVo(memberVO); // session의 정보를 VO에 추가.
			
			
			try {
				List<MemberVO> memberlist = activityService.listActivityMember(memberVO);
				
				returnMap.put("retCd", retCd);
				returnMap.put("retMsg", retMsg);
				returnMap.put("memberlist", memberlist);
				
			 } catch (Exception e) {
			    e.printStackTrace();
			 }
			
			return returnMap;
		}
  	 
}
