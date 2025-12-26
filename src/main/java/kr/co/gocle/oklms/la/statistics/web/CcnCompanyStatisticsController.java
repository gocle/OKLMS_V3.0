package kr.co.gocle.oklms.la.statistics.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.service.MemberService;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

@Controller
public class CcnCompanyStatisticsController  extends BaseController{


	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "atchFileService")
	private AtchFileService atchFileService;

	
	/**
	 * 기업전담자
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/ccncompany/listCcnCompanyStat.do")
	public String listTraningProcessStat(@ModelAttribute("frmMember") MemberVO memberVO,  ModelMap model) throws Exception {
		
		Integer pageSize = memberVO.getPageSize();
		Integer page = memberVO.getPageIndex();
		int totalCnt = 0;
		List<MemberVO> resultList = null;
		
		resultList = memberService.listCotMemberStat(memberVO);
		
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}
		
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
		paginationInfo.setPageSize(memberVO.getPageSize());
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAttribute("resultCnt", totalCnt );
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("memberVO", memberVO);
		
		return  "oklms/la/statistics/ccncompany/listCcnCompanyStat";
	}
	
	@RequestMapping(value = "/la/statistics/ccncompany/listCcnCompanyStatExcelDownload.do")
	public String listCcnCompanyStatExcelDownload(@ModelAttribute("frmMember") MemberVO memberVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
		memberVO.setPageSize(10000); // 1만건 조회
  
		List<MemberVO> resultList = memberService.listCotMemberStat(memberVO);
		
		model.addAttribute("resultList", resultList);
		   
        request.setAttribute("ExcelName", URLEncoder.encode( "기업전담자".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/ccncompany/excelCcnCompanyStat";
	}
}
