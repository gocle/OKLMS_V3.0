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
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.la.traningprocess.service.TraningProcessService;
import kr.co.gocle.oklms.la.traningprocess.vo.TraningProcessVO;

@Controller
public class TraningprocessStatisticsController  extends BaseController{

	@Resource(name = "traningProcessService")
	private TraningProcessService traningProcessService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	/**
	 * 훈련과정
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/traningprocess/listTraningProcessStat.do")
	public String listTraningProcessStat( @ModelAttribute("frmTraningProcess") TraningProcessVO traningProcessVO,ModelMap model) throws Exception {
		
		Integer pageSize = traningProcessVO.getPageSize();
		Integer page = traningProcessVO.getPageIndex();
		int totalCnt = 0;
		List<TraningProcessVO> resultList = null;
		
		
		resultList = traningProcessService.listTraningProcessStat(traningProcessVO);

		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}
		
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(traningProcessVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(traningProcessVO.getPageUnit());
		paginationInfo.setPageSize(traningProcessVO.getPageSize());
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAttribute("resultCnt", totalCnt );
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("traningProcessVO", traningProcessVO);
		
		return  "oklms/la/statistics/traningprocess/listTraningProcessStat";
	}
	@RequestMapping(value = "/la/statistics/traningprocess/listTraningProcessStatExcelDownload.do")
	public String listTraningProcessStatExcelDownload(@ModelAttribute("frmTraningProcess") TraningProcessVO traningProcessVO, ModelMap model,HttpServletRequest request)  throws Exception {

		traningProcessVO.setPageSize(10000); // 1만건 조회
		  
		List<TraningProcessVO> resultList =  traningProcessService.listTraningProcessStat(traningProcessVO);
		
		model.addAttribute("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode( "훈련과정".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/traningprocess/excelTraningProcessStat";
	}
}
