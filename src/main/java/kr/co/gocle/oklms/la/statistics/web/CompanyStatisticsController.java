package kr.co.gocle.oklms.la.statistics.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO; 

@Controller
public class CompanyStatisticsController extends BaseController{

	private static final Logger LOG = LoggerFactory.getLogger(CompanyStatisticsController.class);
	
 
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	@Resource(name = "companyService")
	private CompanyService companyService;
 
	/**
	 * 기업
	 * @param		    CompanyVO						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/company/listCompanyStat.do")
	public String listCompanyStat(@ModelAttribute("frmCompany") CompanyVO companyVO, ModelMap model) throws Exception {
		 
		LOG.debug("listCompanyStat : companyVO=" + companyVO.toString() );
		Integer pageSize = companyVO.getPageSize();
		Integer page = companyVO.getPageIndex();
		int totalCnt = 0;
		List<CompanyVO> resultList = null;
		
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);

		resultList = companyService.listCompanyStat(companyVO);

		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}
		
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(companyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(companyVO.getPageUnit());
		paginationInfo.setPageSize(companyVO.getPageSize());
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAttribute("resultCnt", totalCnt );
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("companyVO", companyVO);

		
		return  "oklms/la/statistics/company/listCompanyStat";
	}
	
	@RequestMapping(value = "/la/statistics/company/listCompanyStatExcelDownload.do")
	public String listCompanyStatExcelDownload(@ModelAttribute("frmCompany") CompanyVO companyVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
		companyVO.setPageSize(10000); // 1만건 조회
		
		List <CompanyVO> resultList =  companyService.listCompanyStat(companyVO);
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
        model.addAttribute("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode( "기업".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/company/excelCompanyStat";
	}
	
	@RequestMapping(value = "/la/statistics/company/listCompanyStatExcelDownload1.do")
	public String listCompanyStatExcelDownload1(@ModelAttribute("frmCompany") CompanyVO companyVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
		companyVO.setPageSize(10000); // 1만건 조회
		
		List <CompanyVO> resultList =  companyService.listCompanyStat1(companyVO);
		
        model.addAttribute("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode( "기업코드".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/company/excelCompanyStat1";
	}
	
	@RequestMapping(value = "/la/statistics/company/listCompanyStatExcelDownload2.do")
	public String listCompanyStatExcelDownload2(@ModelAttribute("frmCompany") CompanyVO companyVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
		companyVO.setPageSize(10000); // 1만건 조회
		
		List <CompanyVO> resultList =  companyService.listMember(companyVO);
		
        model.addAttribute("resultList", resultList);
        request.setAttribute("ExcelName", URLEncoder.encode( "학습근로자".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/company/excelCompanyStat2";
	}
	
	
}
