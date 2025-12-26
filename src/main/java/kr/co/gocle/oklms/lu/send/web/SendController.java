package kr.co.gocle.oklms.lu.send.web;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO; 
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.grade.service.GradeService;
import kr.co.gocle.oklms.lu.member.vo.ExcelMemberStdVO;
import kr.co.gocle.oklms.lu.report.vo.ReportVO;
import kr.co.gocle.oklms.lu.send.service.SendService;
import kr.co.gocle.oklms.lu.send.vo.SendVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class SendController  extends BaseController{

	
	@Resource(name = "sendService")
	private SendService sendService;
	
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	@RequestMapping(value = "/lu/send/listSendCdp.do")
	public String listSendCdp(@ModelAttribute("frmSend") SendVO sendVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendCdp.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(sendVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		String returnView = "oklms/lu/send/listSendCdp";
		
		List <SendVO> resultList = null;
	
		if(loginInfo.getMemType().equals("CCN")){
			
			if(sendVO.getSearchMemType() != null){
				if(sendVO.getSearchMemType().equals("STD")){
					resultList = sendService.listSend(sendVO);
					returnView = "oklms/lu/send/listSendCcn";
				} else {
					resultList = sendService.listSendCcn(sendVO);
					returnView = "oklms/lu/send/listSendCompanyCcn";
				}
			} else {
				resultList = sendService.listSend(sendVO);
				returnView = "oklms/lu/send/listSendCcn";
			}
		} else {
			resultList = sendService.listSend(sendVO);
		}
		
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = sendVO.getPageSize();
		Integer page = sendVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(sendVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sendVO.getPageSize());
        paginationInfo.setPageSize(sendVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("sendVO", sendVO);
		
  		// View호출
		return returnView;
	}

	
  	@RequestMapping(value = "/lu/send/listSend.do")
	public String listSend(@ModelAttribute("frmSend") SendVO sendVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSend.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(sendVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		String returnView = "oklms/lu/send/listSend";
		
		List <SendVO> resultList = null;
	
		if(loginInfo.getMemType().equals("CCN")){
			
			if(sendVO.getSearchMemType() != null){
				if(sendVO.getSearchMemType().equals("STD")){
					resultList = sendService.listSend(sendVO);
					returnView = "oklms/lu/send/listSendCcn";
				} else {
					resultList = sendService.listSendCcn(sendVO);
					returnView = "oklms/lu/send/listSendCompanyCcn";
				}
			} else {
				resultList = sendService.listSend(sendVO);
				returnView = "oklms/lu/send/listSendCcn";
			}
		} else {
			resultList = sendService.listSend(sendVO);
		}
		
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = sendVO.getPageSize();
		Integer page = sendVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(sendVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sendVO.getPageSize());
        paginationInfo.setPageSize(sendVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("sendVO", sendVO);
		
  		// View호출
		return returnView;
	}
  	
  	@RequestMapping(value = "/lu/send/listSendCcn.do")
	public String listSendCcn(@ModelAttribute("frmSend") SendVO sendVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(sendVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		String returnView = "oklms/lu/send/listSend";
		
		List <SendVO> resultList = null;
	
		if(loginInfo.getMemType().equals("CCN")){
			
			if(sendVO.getSearchMemType() != null){
				if(sendVO.getSearchMemType().equals("STD")){
					resultList = sendService.listSend(sendVO);
					returnView = "oklms/lu/send/listSendCcn";
				} else {
					resultList = sendService.listSendCcn(sendVO);
					returnView = "oklms/lu/send/listSendCompanyCcn";
				}
			} else {
				resultList = sendService.listSend(sendVO);
				returnView = "oklms/lu/send/listSendCcn";
			}
		} else {
			resultList = sendService.listSend(sendVO);
		}
		
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = sendVO.getPageSize();
		Integer page = sendVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(sendVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sendVO.getPageSize());
        paginationInfo.setPageSize(sendVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("sendVO", sendVO);
		
  		// View호출
		return returnView;
	}
  	
  	@RequestMapping(value = "/lu/send/listSendPrt.do")
	public String listSendPrt(@ModelAttribute("frmSend") SendVO sendVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendPrt.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(sendVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		String returnView = "oklms/lu/send/listSend";
		
		List <SendVO> resultList = null;
	
		if(loginInfo.getMemType().equals("CCN")){
			
			if(sendVO.getSearchMemType() != null){
				if(sendVO.getSearchMemType().equals("STD")){
					resultList = sendService.listSend(sendVO);
					returnView = "oklms/lu/send/listSendCcn";
				} else {
					resultList = sendService.listSendCcn(sendVO);
					returnView = "oklms/lu/send/listSendCompanyCcn";
				}
			} else {
				resultList = sendService.listSend(sendVO);
				returnView = "oklms/lu/send/listSendCcn";
			}
		} else {
			resultList = sendService.listSend(sendVO);
		}
		
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = sendVO.getPageSize();
		Integer page = sendVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(sendVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sendVO.getPageSize());
        paginationInfo.setPageSize(sendVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("sendVO", sendVO);
		
  		// View호출
		return returnView;
	}
  	
  	@RequestMapping(value = "/lu/send/listSendEmailResult.do")
	public String listSendEmailResult(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendEmailResult.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendEmailResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendEmailResult";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendSmsResult.do")
	public String listSendSmsResult(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendSmsResult.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendSmsResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendSmsResult";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendEmailResultPrt.do")
	public String listSendEmailResultPrt(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendEmailResultPrt.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendEmailResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendEmailResultPrt";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendSmsResultPrt.do")
	public String listSendSmsResultPrt(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendSmsResultPrt.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendSmsResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendSmsResultPrt";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendEmailResultCdp.do")
	public String listSendEmailResultCdp(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendEmailResultCdp.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendEmailResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendEmailResultCdp";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendSmsResultCdp.do")
	public String listSendSmsResultCdp(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendSmsResultCdp.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendSmsResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendSmsResultCdp";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendEmailResultCcn.do")
	public String listSendEmailResultCcn(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendEmailResultCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendEmailResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendEmailResultCcn";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendSmsResultCcn.do")
	public String listSendSmsResultCcn(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendSmsResultCcn.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendSmsResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendSmsResultCcn";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendCot.do")
	public String listSendCot(@ModelAttribute("frmSend") SendVO sendVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendCot.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(sendVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		String returnView = "oklms/lu/send/listSend";
		
		List <SendVO> resultList = null;
	
		if(loginInfo.getMemType().equals("CCN")){
			
			if(sendVO.getSearchMemType() != null){
				if(sendVO.getSearchMemType().equals("STD")){
					resultList = sendService.listSend(sendVO);
					returnView = "oklms/lu/send/listSendCcn";
				} else {
					resultList = sendService.listSendCcn(sendVO);
					returnView = "oklms/lu/send/listSendCompanyCcn";
				}
			} else {
				resultList = sendService.listSend(sendVO);
				returnView = "oklms/lu/send/listSendCcn";
			}
		} else {
			resultList = sendService.listSend(sendVO);
		}
		
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = sendVO.getPageSize();
		Integer page = sendVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(sendVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sendVO.getPageSize());
        paginationInfo.setPageSize(sendVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("sendVO", sendVO);
		
  		// View호출
		return returnView;
	}
  	
  	@RequestMapping(value = "/lu/send/listSendEmailResultCot.do")
	public String listSendEmailResultCot(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendEmailResultCot.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendEmailResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendEmailResult";
	}
  	
  	@RequestMapping(value = "/lu/send/listSendSmsResultCot.do")
	public String listSendSmsResultCot(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model, HttpServletRequest request) throws Exception {
  		
  		logger.debug("#### URL = /lu/send/listSendSmsResultCot.do" );
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO); // session의 정보를 VO에 추가.
		
		// 학과코드,학과명 코드 리스트
		CommonCodeVO codeVO = new  CommonCodeVO();
		codeVO.setCodeGroup("DEPT_CD");
		List<CommonCodeVO> deptCodeList = commonCodeService.selectCmmCodeList(codeVO); // 학과
		model.addAttribute("deptCodeList", deptCodeList);
		
		List <MailVO> resultList = sendService.listSendSmsResult(mailVO);
		model.addAttribute("resultList", resultList);
		
		
		Integer pageSize = mailVO.getPageSize();
		Integer page = mailVO.getPageIndex();
		
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(mailVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(mailVO.getPageSize());
        paginationInfo.setPageSize(mailVO.getPageUnit());
        paginationInfo.setTotalRecordCount(totalCnt);

        model.addAttribute("resultCnt", totalCnt );
        model.addAttribute("paginationInfo", paginationInfo);
		
        model.addAttribute("mailVO", mailVO);
		
  		// View호출
		return "oklms/lu/send/listSendSmsResult";
	}
  	
  	@RequestMapping(value = "/lu/send/popupSendResult.do")
	public String goPopupReportFeed(@ModelAttribute("frmSend") MailVO mailVO, ModelMap model , HttpServletRequest request) throws Exception {
		
  		logger.debug("#### URL = /lu/send/popupSendResult.do" );
  		
  		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
  		
		MailVO mstVO = sendService.getSendMaster(mailVO);
		List <MailVO> resultList = sendService.listSendDetail(mailVO);
		
		model.addAttribute("mstVO", mstVO);
		model.addAttribute("resultList", resultList);
		
		// View호출
  		return "oklms_popup/lu/send/popupSend";
	} 
  	
  	@RequestMapping(value = "/lu/send/deleteSendMaster.do")
	public String deleteSendMaster(@RequestParam Map<String, Object> paramMap, @ModelAttribute("frmSend") MailVO mailVO, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {

		String retMsg = "";
		int iResult = 0;
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(mailVO);
			
		iResult = sendService.deleteSendMaster(mailVO);

		if(iResult > 0 ){
			retMsg = "정상적으로 삭제처리 되었습니다.";
		} else {
			retMsg = "삭제처리시 에러가 발생하였습니다.";
		}
		
		redirectAttributes.addFlashAttribute("retMsg", retMsg);
		
		if(mailVO.getSendType().equals("EMAIL")){
			if(loginInfo.getMemType().equals("CCN")){
				return "redirect:/lu/send/listSendEmailResultCcn.do";
			} else if (loginInfo.getMemType().equals("PRT")){
				return "redirect:/lu/send/listSendEmailResultPrt.do";
			} else { // 학과전담자
				return "redirect:/lu/send/listSendEmailResultCdp.do";
			}
		} else {
			if(loginInfo.getMemType().equals("CCN")){
				return "redirect:/lu/send/listSendSmsResultCcn.do";
			} else if (loginInfo.getMemType().equals("PRT")){
				return "redirect:/lu/send/listSendSmsResultPrt.do";
			} else { // 학과전담자
				return "redirect:/lu/send/listSendSmsResultCdp.do";
			}
		}
		
	}
}
