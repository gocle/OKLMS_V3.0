package kr.co.gocle.oklms.la.statistics.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO; 
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

@Controller
public class TraningstatusStatisticsController  extends BaseController{
	

	@Resource(name = "SubjectService")
	private SubjectService subjectService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	/**
	 * 학과별훈련현황
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/traningstatus/listDepartmentStat.do")
	public String listDepartmentStat( @ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model) throws Exception {
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
	 
		List <SubjectVO> resultList = subjectService.listDepartmentStat(subjectVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("subjectVO", subjectVO);
		 
		return  "oklms/la/statistics/traningstatus/listDepartmentStat";
	}
	@RequestMapping(value = "/la/statistics/traningstatus/listDepartmentStatExcelDownload.do")
	public String listTraningProcessStatExcelDownload(@ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
		subjectVO.setPageSize(10000); // 1만건 조회
		List <SubjectVO> resultList = subjectService.listDepartmentStat(subjectVO);
		model.addAttribute("resultList", resultList);
		
        request.setAttribute("ExcelName", URLEncoder.encode( "학과별훈련현황".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/traningstatus/excelDepartmentStat";
	}
	
	/**
	 * 학과별훈련현황
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/traningstatus/saveDepartmentStat.do")
	public String mergeDeptLimit( @ModelAttribute("frmSubject") SubjectVO subjectVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
		
	 
		int iResult = subjectService.mergeDeptLimit(subjectVO);
		 
		return "redirect:/la/statistics/traningstatus/listDepartmentStat.do";
	}
}
