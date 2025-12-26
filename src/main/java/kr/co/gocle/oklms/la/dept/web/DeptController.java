package kr.co.gocle.oklms.la.dept.web;

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
import kr.co.gocle.oklms.la.dept.service.DeptService;
import kr.co.gocle.oklms.la.dept.vo.DeptVO;
import kr.co.gocle.oklms.la.member.service.MemberService;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

@Controller
public class DeptController  extends BaseController{


	@Resource(name = "deptService")
	private DeptService deptService;
	
	@RequestMapping(value = "/la/dept/listDept.do")
	public String listDept(@ModelAttribute("frmDept") DeptVO deptVO, ModelMap model) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(deptVO);
		
		List<DeptVO> resultList = deptService.listDept(deptVO);
		
		model.addAttribute("resultList", resultList);
		// View호출
		return "oklms/la/ncs/listNcsLicence";
	}
	
	@RequestMapping(value = "/la/ncs/insertDept.do")
	public String insertDept(@ModelAttribute("frmDept") DeptVO deptVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(deptVO);
		
		int iResult = deptService.insertDept(deptVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("deptVO", deptVO);
		
		
		return "redirect:/la/dept/listDept.do";
	}
	
	@RequestMapping(value = "/la/dept/updateDept.do")
	public String updateDept(@ModelAttribute("frmDept") DeptVO deptVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(deptVO);
		
		int iResult = deptService.updateDept(deptVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (수정)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("deptVO", deptVO);
		
		
		return "redirect:/la/dept/listDept.do";
	}
	
	@RequestMapping(value = "/la/dept/deleteDept.do")
	public String deleteDept(@ModelAttribute("frmDept") DeptVO deptVO, ModelMap model,RedirectAttributes redirectAttributes) throws Exception {
	
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(deptVO);
		
		int iResult = deptService.deleteDept(deptVO);
		
		String retMsg = "";
		
		if(iResult > 0){
			retMsg = "정상적으로 (삭제)처리되었습니다.!";
		}else{
			retMsg = "처리에 실패하였습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		redirectAttributes.addFlashAttribute("deptVO", deptVO);
		
		
		return "redirect:/la/dept/listDept.do";
	}
	
	

}
