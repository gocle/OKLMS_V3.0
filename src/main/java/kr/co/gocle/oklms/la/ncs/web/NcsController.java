package kr.co.gocle.oklms.la.ncs.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.service.MemberService;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.la.ncs.service.NcsService;
import kr.co.gocle.oklms.la.ncs.vo.NcsLicenceVO;

@Controller
public class NcsController  extends BaseController{


	@Resource(name = "ncsService")
	private NcsService ncsService;
	
	@RequestMapping(value = "/la/ncs/listNcsLicence.do")
	public String listNcsLicence(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		List<NcsLicenceVO> resultList = ncsService.listNcsLicence(ncsLicenceVO);
		
		model.addAttribute("resultList", resultList);
		// View호출
		return "oklms/la/ncs/listNcsLicence";
	}
	
	@RequestMapping(value = "/la/ncs/insertNcsLicence.do")
	public String insertNcsLicence(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		int iResult = ncsService.insertNcsLicence(ncsLicenceVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("ncsLicenceVO", ncsLicenceVO);
		
		
		return "redirect:/la/ncs/listNcsLicence.do";
	}
	
	@RequestMapping(value = "/la/ncs/updateNcsLicence.do")
	public String updateNcsLicence(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		int iResult = ncsService.updateNcsLicence(ncsLicenceVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (수정)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("ncsLicenceVO", ncsLicenceVO);
		
		
		return "redirect:/la/ncs/listNcsLicence.do";
	}
	
	@RequestMapping(value = "/la/ncs/deleteNcsLicence.do")
	public String deleteNcsLicence(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		int iResult = ncsService.deleteNcsLicence(ncsLicenceVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (삭제)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("ncsLicenceVO", ncsLicenceVO);
		
		
		return "redirect:/la/ncs/listNcsLicence.do";
	}
	
	
	@RequestMapping(value = "/la/ncs/insertNcsLicenceUnit.do")
	public String insertNcsLicenceUnit(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		int iResult = ncsService.insertNcsLicenceUnit(ncsLicenceVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("ncsLicenceVO", ncsLicenceVO);
		
		
		return "redirect:/la/ncs/listNcsLicence.do";
	}
	
	@RequestMapping(value = "/la/ncs/updateNcsLicenceUnit.do")
	public String updateNcsLicenceUnit(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		int iResult = ncsService.updateNcsLicenceUnit(ncsLicenceVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (수정)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("ncsLicenceVO", ncsLicenceVO);
		
		
		return "redirect:/la/ncs/listNcsLicence.do";
	}
	
	@RequestMapping(value = "/la/ncs/deleteNcsLicenceUnit.do")
	public String deleteNcsLicenceUnit(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		int iResult = ncsService.deleteNcsLicenceUnit(ncsLicenceVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (삭제)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("ncsLicenceVO", ncsLicenceVO);
		
		
		return "redirect:/la/ncs/listNcsLicence.do";
	}
	
	
	@RequestMapping(value = "/la/ncs/listNcsLicenceExcelDownload.do")
	public String listNcsLicenceExcelDownload(@ModelAttribute("frmNcs") NcsLicenceVO ncsLicenceVO, ModelMap model,HttpServletRequest request)  throws Exception {
			
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(ncsLicenceVO);
		
		List<NcsLicenceVO> resultList = ncsService.listNcsLicence(ncsLicenceVO);
		
		model.addAttribute("resultList", resultList);
  
        request.setAttribute("ExcelName", URLEncoder.encode( "NCS기반자격".replaceAll(" ", "_") ,"UTF-8") );
        
		// View호출
		return "oklms_excel/la/ncs/excelNcsLicence";
	}
	

}
