package kr.co.gocle.oklms.la.statistics.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

@Controller
public class SubjectStatisticsController  extends BaseController{
	
	
	@Resource(name = "SubjectService")
	private SubjectService subjectService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	
	/**
	 * 교과목
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/subject/listSubjectStat.do")
	public String listSubjectStat( @ModelAttribute("frmSubject") SubjectVO subjectVO,ModelMap model) throws Exception {

		Integer pageSize = subjectVO.getPageSize();
		Integer page = subjectVO.getPageIndex();
		int totalCnt = 0;
		List<SubjectVO> resultList = null;
		
		if(subjectVO.getSearchyyyy() ==null || subjectVO.getSearchyyyy() .equals("")) {
			CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm(); 
			subjectVO.setSearchyyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));
		}
		
		resultList = subjectService.listSubjectStat(subjectVO);

		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}
		
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(subjectVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(subjectVO.getPageUnit());
		paginationInfo.setPageSize(subjectVO.getPageSize());
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAttribute("resultCnt", totalCnt );
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("subjectVO", subjectVO);
		
		return  "oklms/la/statistics/subject/listSubjectStat";
	}
	@RequestMapping(value = "/la/statistics/subject/listSubjectStatExcelDownload.do")
	public String listSubjectStatExcelDownload(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
		subjectVO.setPageSize(10000); // 1만건 조회
		List<SubjectVO> resultList  = subjectService.listSubjectStat(subjectVO);
		model.addAttribute("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode( "교과목".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/subject/excelSubjectStat";
	}
}
