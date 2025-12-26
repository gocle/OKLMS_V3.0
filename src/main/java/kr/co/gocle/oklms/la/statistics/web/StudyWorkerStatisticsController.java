package kr.co.gocle.oklms.la.statistics.web;

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

import egovframework.com.cmm.service.Globals;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.service.MemberService;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.lu.traningstatus.service.TraningStatusService;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningStatusVO;
import kr.co.gocle.oklms.lu.traningstatus.web.TraningStatusController;

@Controller
public class StudyWorkerStatisticsController  extends BaseController{
	
	private static final Logger LOG = LoggerFactory.getLogger(StudyWorkerStatisticsController.class);
	
	
	@Resource(name = "memberService")
	private MemberService memberService;
	

	@Resource(name = "TraningStatusService")
	private TraningStatusService traningStatusService;

	
	
	/**
	 * 학습근로자종합
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/study/listStudyWorkerStat.do")
	public String listStudyWorkerStat( @ModelAttribute("frmMember") MemberVO memberVO, ModelMap model) throws Exception {
		  

		Integer pageSize = memberVO.getPageSize();
		Integer page = memberVO.getPageIndex();
		int totalCnt = 0;
		List<MemberVO> resultList = null;
		

		PaginationInfo paginationInfo = new PaginationInfo();
		LOG.debug("###################################################################");
		
		if(memberVO.getSearchMemName()==null  && memberVO.getSearchMemId()==null && memberVO.getSearchDeptNm()==null ) {
			        model.addAttribute("pageSize", pageSize);
			        model.addAttribute("totalCount", totalCnt);
			        model.addAttribute("pageIndex", page);
					model.addAttribute("resultCnt", totalCnt );
					model.addAttribute("paginationInfo", paginationInfo);
					model.addAttribute("resultList", resultList);
					model.addAttribute("memberVO", memberVO);
					return  "oklms/la/statistics/study/listStudyWorkerStat";			
		}
		
		resultList = memberService.listStudyMemberStat(memberVO);
		
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}
		
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		

		paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
		paginationInfo.setPageSize(memberVO.getPageSize());
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAttribute("resultCnt", totalCnt );
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("memberVO", memberVO);
		
		return  "oklms/la/statistics/study/listStudyWorkerStat";
	}
	
	
	@RequestMapping(value = "/la/statistics/study/listStudyWorkerStatExcelDownload.do")
	public String listStudyWorkerStatExcelDownload(@ModelAttribute("frmMember") MemberVO memberVO, ModelMap model,HttpServletRequest request)  throws Exception {
		memberVO.setPageSize(10000); // 1만건 조회
		  
		List<MemberVO>  resultList = memberService.listStudyMemberStat(memberVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("memberVO", memberVO);
  
        request.setAttribute("ExcelName", URLEncoder.encode( "학습근로자종합".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/study/excelStudyWorkerStat";
	}
	
	/**
	 * 학습근로자이수현황
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception listStudyWorkerStat
	 */
	@RequestMapping(value = "/la/statistics/study/listStudyWorkerCompleteStat.do")
	public String listStudyWorkerCompleteStat( @ModelAttribute("frmMember") MemberVO memberVO,  ModelMap model, HttpServletRequest request ) throws Exception {

  		LOG.debug("#### URL = /la/statistics/study/listStudyWorkerCompleteStat.do" );
		memberVO = memberService.getMember(memberVO);
		
		TraningStatusVO traningStatusVO = new  TraningStatusVO();
		traningStatusVO.setStdId(memberVO.getMemId());

  	 
		List<TraningStatusVO> resultList = traningStatusService.listTraningComplete(traningStatusVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("memberVO", memberVO);
		
		return  "oklms/la/statistics/study/listStudyWorkerCompleteStat";
	}
	
	@RequestMapping(value = "/la/statistics/study/listStudyWorkerCompleteStatExcelDownload.do")
	public String listStudyWorkerCompleteStatExcelDownload(@ModelAttribute("frmMember")  MemberVO memberVO,  ModelMap model,HttpServletRequest request)  throws Exception {
		
		memberVO = memberService.getMember(memberVO);
		
		TraningStatusVO traningStatusVO = new  TraningStatusVO();
		traningStatusVO.setStdId(memberVO.getMemId());

  	 
		List<TraningStatusVO> resultList = traningStatusService.listTraningComplete(traningStatusVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("memberVO", memberVO);
		
        request.setAttribute("ExcelName", URLEncoder.encode( "학습근로자이수현황".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/study/excelStudyWorkerCompleteStat";
	}
	
}
