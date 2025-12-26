/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/
package kr.co.gocle.oklms.la.traningprocess.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import kr.co.gocle.ifx.service.CmsIfxService;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.ncs.service.NcsService;
import kr.co.gocle.oklms.la.ncs.vo.NcsLicenceVO;
import kr.co.gocle.oklms.la.traningprocess.service.TraningProcessService;
import kr.co.gocle.oklms.la.traningprocess.vo.TraningProcessVO;
import kr.co.gocle.oklms.lu.currproc.service.CurrProcService;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.traning.service.TraningService;
import kr.co.gocle.oklms.lu.traning.vo.TraningProcessMappingVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningScheduleVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
//import egovframework.com.cmm.util.EgovDoubleSubmitHelper;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class TraningProcessController extends BaseController{

	@Resource(name = "traningProcessService")
	private TraningProcessService traningProcessService;

	@Resource(name = "ncsService")
	private NcsService ncsService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;


	/**
	 * 훈련시간표등록 목록 첫화면 기업체검색 List Data.
	 * @param searchKeyword
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/la/traningprocess/listTraningProcess.do")
	public String listTraningProcess(@ModelAttribute("frmProcess") TraningProcessVO traningProcessVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /la/traningprocess/listTraningProcess.do" );
		
		List <TraningProcessVO> resultList = traningProcessService.listTraningProcess(traningProcessVO);
		
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("traningProcessVO", traningProcessVO);
		
		Integer pageSize = traningProcessVO.getPageSize();
		Integer page = traningProcessVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(traningProcessVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(traningProcessVO.getPageSize());
        paginationInfo.setPageSize(traningProcessVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		// View호출
		return "oklms/la/traningprocess/listTraningProcess";
	}
	
	/**
	 * 훈련시간표등록 목록 첫화면 기업체검색 List Data.
	 * @param searchKeyword
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/la/traningprocess/getTraningProcess.do")
	public String getTraningProcess(@ModelAttribute("frmProcess") TraningProcessVO traningProcessVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		logger.debug("#### URL = /la/traningprocess/getTraningProcess.do" );
		
		traningProcessVO = traningProcessService.getTraningProcess(traningProcessVO);
		int useCnt = traningProcessService.getTraningProcessUseCnt(traningProcessVO);
		
		NcsLicenceVO ncsLicenceVO = new NcsLicenceVO();
		List<NcsLicenceVO> resultList = ncsService.listLicence(ncsLicenceVO);
		model.addAttribute("resultList", resultList);
		
		model.addAttribute("traningProcessVO", traningProcessVO);
		model.addAttribute("useCnt", useCnt);
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		// View호출
		return "oklms/la/traningprocess/getTraningProcess";
	}
	
	/**
	 * 훈련시간표등록 목록 첫화면 기업체검색 List Data.
	 * @param searchKeyword
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/la/traningprocess/insertTraningProcessPage.do")
	public String insertTraningProcessPage(@ModelAttribute("frmProcess") TraningProcessVO traningProcessVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		logger.debug("#### URL = /la/traningprocess/insertTraningProcessPage.do" );
		
		NcsLicenceVO ncsLicenceVO = new NcsLicenceVO();
		
		List<NcsLicenceVO> resultList = ncsService.listLicence(ncsLicenceVO);
		model.addAttribute("resultList", resultList);
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		model.addAttribute("traningProcessVO", traningProcessVO);
		// View호출
		return "oklms/la/traningprocess/insertTraningProcessPage";
	}
	
	
	/**
	 * 훈련시간표등록 목록 첫화면 기업체검색 List Data.
	 * @param searchKeyword
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/la/traningprocess/insertTraningProcess.do")
	public String insertTraningProcess(@ModelAttribute("frmProcess") TraningProcessVO traningProcessVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		
		logger.debug("#### URL = /la/traningprocess/insertTraningProcess.do" );
		int iResult = 0;
		String retMsg = "";
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningProcessVO); // session의 정보를 VO에 추가.
		
		iResult = traningProcessService.insertTraningProcess(traningProcessVO);
		
		if( iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		} else {
			retMsg = "처리된건이 없습니다.";
		}
		
		redirectAttributes.addFlashAttribute("frmProcess", traningProcessVO);
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		// View호출
		return "redirect:/la/traningprocess/listTraningProcess.do";
	}
	
	
	
	/**
	 * 훈련시간표등록 목록 첫화면 기업체검색 List Data.
	 * @param searchKeyword
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/la/traningprocess/updateTraningProcess.do")
	public String updateTraningProcess(@ModelAttribute("frmProcess") TraningProcessVO traningProcessVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		
		logger.debug("#### URL = /la/traningprocess/updateTraningProcess.do" );
		int iResult = 0;
		String retMsg = "";
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningProcessVO); // session의 정보를 VO에 추가.
		
		iResult = traningProcessService.updateTraningProcess(traningProcessVO);
		
		if( iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		} else {
			retMsg = "처리된건이 없습니다.";
		}
		
		redirectAttributes.addFlashAttribute("frmProcess", traningProcessVO);
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		// View호출
		return "redirect:/la/traningprocess/listTraningProcess.do";
	}
	
	/**
	 * 훈련시간표등록 목록 첫화면 기업체검색 List Data.
	 * @param searchKeyword
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/la/traningprocess/deleteTraningProcess.do")
	public String deleteTraningProcess(@ModelAttribute("frmProcess") TraningProcessVO traningProcessVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		
		logger.debug("#### URL = /la/traningprocess/deleteTraningProcess.do" );
		
		int iResult = 0;
		String retMsg = "";
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningProcessVO); // session의 정보를 VO에 추가.
		
		iResult = traningProcessService.deleteTraningProcess(traningProcessVO);
		
		if( iResult > 0){
			retMsg = "정상적으로 (저장)처리되었습니다.";
		} else {
			retMsg = "처리된건이 없습니다.";
		}
		
		redirectAttributes.addFlashAttribute("frmProcess", traningProcessVO);
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		// View호출
		return "redirect:/la/traningprocess/listTraningProcess.do";
	}

}
