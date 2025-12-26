package kr.co.gocle.oklms.la.statistics.web;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;

@Controller
public class StatusNcsStatisticsController  extends BaseController{
	/**
	 * NCS기반 자격
	 * @param		    						(String) 검색 조건/ 로그인 아이피 
	 * @throws		Exception 
	 */
	@RequestMapping(value = "/la/statistics/status/listNcsStatus.do")
	public String listNcsStatus( ModelMap model) throws Exception {
		  
		
		return  "oklms/la/statistics/status/listNcsStatus";
	}
	
	@RequestMapping(value = "/la/statistics/status/listNcsStatusExcelDownload.do")
	public String listNcsStatusExcelDownload(@ModelAttribute("frmCompany") CompanyVO companyVO, ModelMap model,HttpServletRequest request)  throws Exception {
		
  
        request.setAttribute("ExcelName", URLEncoder.encode( "NCS기반자격".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/statistics/status/excelNcsStatus";
	}
}
