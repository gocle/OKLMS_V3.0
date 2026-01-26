package kr.co.gocle.oklms.la.log.web;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.la.log.service.AdminLogService;
import kr.co.gocle.oklms.la.log.vo.AdminLogVO;


@Controller
public class AdminLogController extends BaseController {

	@Autowired
	private AdminLogService adminLogService;
	
	
	/**
	 * 관리자 로그 목록
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/la/log/listAdminLog.do")
	public String listLog(@ModelAttribute("searchVO") AdminLogVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {

	    Integer pageSize = searchVO.getPageSize();
	    Integer pageIndex = searchVO.getPageIndex();

	    List<AdminLogVO> resultList = null;
	    int totalCnt = 0;

	    String startDate = searchVO.getStartDate();
	    String finishDate = searchVO.getFinishDate();

	    if (StringUtils.isNotEmpty(startDate)) {
	        startDate = startDate.replaceAll("-", "") + "000000";
	        searchVO.setStartDate(startDate);
	    }

	    if (StringUtils.isNotEmpty(finishDate)) {
	        finishDate = finishDate.replaceAll("-", "") + "235900";
	        searchVO.setFinishDate(finishDate);
	    }

	    resultList = adminLogService.selectLogList(searchVO);

	    if (resultList != null && !resultList.isEmpty()) {
	        totalCnt = Integer.parseInt(resultList.get(0).getTotalCount());
	    }

	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
	    paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
	    paginationInfo.setPageSize(searchVO.getPageSize());
	    paginationInfo.setTotalRecordCount(totalCnt);

	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("pageIndex", pageIndex);
	    model.addAttribute("resultCnt", totalCnt);
	    model.addAttribute("paginationInfo", paginationInfo);
	    model.addAttribute("resultList", resultList);
	    
	    return "oklms/la/log/listAdminLog";
	}
	
	@RequestMapping("/la/log/downloadAdminLog.do")
	public String adminLogExcelDownload( @ModelAttribute("searchVO") AdminLogVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {

	    // 엑셀은 페이징 제거
		searchVO.setPageSize(10000);
		String startDate = searchVO.getStartDate();
	    String finishDate = searchVO.getFinishDate();

	    if (StringUtils.isNotEmpty(startDate)) {
	        startDate = startDate.replaceAll("-", "") + "000000";
	        searchVO.setStartDate(startDate);
	    }

	    if (StringUtils.isNotEmpty(finishDate)) {
	        finishDate = finishDate.replaceAll("-", "") + "235900";
	        searchVO.setFinishDate(finishDate);
	    }
		
	    List<AdminLogVO> resultList = adminLogService.selectLogList(searchVO);
	    model.addAttribute("resultList", resultList);

	    request.setAttribute("ExcelName", URLEncoder.encode("관리자접근로그".replaceAll(" ", "_"), "UTF-8"));

	    return "oklms_excel/la/log/excelAdminLog";
	}
}
