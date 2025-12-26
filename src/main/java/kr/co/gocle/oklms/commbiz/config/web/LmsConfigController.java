package kr.co.gocle.oklms.commbiz.config.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.config.service.LmsConfigService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.lu.currproc.service.CurrProcService;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.bbs.service.EgovBBSSatisfactionService;
import egovframework.com.cop.bbs.service.EgovBBSScrapService;
import egovframework.com.utl.sim.service.EgovFileScrty;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.gocle.oklms.commbiz.config.vo.LmsConfigVO;

/**
 * LMS 관리를 위한 컨트롤러 클래스
 *
 * @author 최선호
 * @since 2020.01.29
 * @version 1.0
 * @see
 *
 */

@Controller
public class LmsConfigController extends BaseController {

	@Resource(name = "lmsConfigService")
	private LmsConfigService lmsConfigService;

	

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	
	@RequestMapping(value = "/{userType}/config/listConfig.do")
	public String listConfig(@PathVariable("userType") String userType,@ModelAttribute("frmConfig") LmsConfigVO lmsConfigVO, ModelMap model) throws Exception {
		
		String sitePrefix = "OKLMS";
		
		List<LmsConfigVO> resultList = lmsConfigService.listConfig(sitePrefix);

		model.addAttribute("resultList", resultList);

		// View호출
		return "oklms/"+userType+"/config/configList";
	}
	
	
	@RequestMapping(value = "/{userType}/config/goUpdateConfig.do")
	public String goUpdateConfig(@PathVariable("userType") String userType,@ModelAttribute("frmConfig") LmsConfigVO lmsConfigVO,  ModelMap model) throws Exception {
		
		lmsConfigVO.setSitePrefix("OKLMS");
		
		logger.debug("get lmsConfigVO : "+lmsConfigVO.toString());
		
		lmsConfigVO = lmsConfigService.getConfig(lmsConfigVO);
        model.addAttribute("lmsConfigVO", lmsConfigVO);


		return "oklms/"+userType+"/config/configUpdate";
	}
	
	
	@RequestMapping(value = "/{userType}/config/updateConfig.do")
	public String updateConfig(@PathVariable("userType") String userType,@ModelAttribute("frmConfig") LmsConfigVO lmsConfigVO, BindingResult bindingResult, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception {
		
		lmsConfigVO.setSitePrefix("OKLMS");
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(lmsConfigVO);
		
		String retMsg = "입력값을 확인해주세요";

		if (bindingResult.hasErrors()) {

			List<FieldError> fieldErrorList = bindingResult.getFieldErrors();
			for( FieldError fieldError : fieldErrorList ){

				retMsg = retMsg + "\\n" + fieldError.getDefaultMessage();
			}

			model.addAttribute("retMsg", retMsg);

			return "oklms/"+userType+"/config/configUpdate";
		}

		if( StringUtils.isBlank( lmsConfigVO.getSitePrefix()) || StringUtils.isBlank( lmsConfigVO.getConfId()) || StringUtils.isBlank( lmsConfigVO.getOptKey()) ){
			retMsg = "존재하지 않는 정보입니다.";
		}else{
			logger.debug("update companyVO : "+lmsConfigVO.toString());
	    	int updateCnt = lmsConfigService.updateConfig(lmsConfigVO);
	    	int insertHist = lmsConfigService.insertConfigHist(lmsConfigVO);
	    	retMsg = "정상적으로 (수정)처리되었습니다.!";
		}

		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		return "redirect:/"+userType+"/config/listConfig.do";
	}



	
}
