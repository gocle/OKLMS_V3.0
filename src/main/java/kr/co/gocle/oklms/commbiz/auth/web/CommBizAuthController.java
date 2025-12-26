/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/
package kr.co.gocle.oklms.commbiz.auth.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.auth.service.CommBizAuthService;
import kr.co.gocle.oklms.commbiz.auth.vo.ComAuthVO;
import kr.co.gocle.oklms.commbiz.log.service.ComLoginLogService;
import kr.co.gocle.oklms.commbiz.log.vo.ComLoginLogVO;
import kr.co.gocle.oklms.commbiz.login.service.CommBizLoginService;
import kr.co.gocle.oklms.commbiz.menu.service.CommbizMenuService;
import kr.co.gocle.oklms.commbiz.menu.vo.CommbizMenuVO;
import kr.co.gocle.oklms.commbiz.menu.web.CommbizMenuController;
import kr.co.gocle.oklms.commbiz.util.SecurityUtil;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
 /**
 *
 * @author
 * @since 2016. 07. 01.
 */
@Controller
public class CommBizAuthController extends BaseController{
	
	private static final Logger LOG = LoggerFactory.getLogger(CommBizAuthController.class);
	
	@Resource(name = "commBizAuthService")
	private CommBizAuthService commBizAuthService;
	
	@Resource(name = "commbizMenuService")
	private CommbizMenuService commbizMenuService;
	
	/**
	 * 권한변경 수행
	 * @param request
	 * @param pResponse
	 * @param commandMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/auth/authProc.do")
	public String authProc(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap, ModelMap model, SessionStatus sessionStatus){
		String authGroupSet = StringUtils.defaultIfBlank( (String) commandMap.get("authGroupSet"), "");
		String retMsg = ""; 
		String nextUri = StringUtils.defaultIfBlank( (String) commandMap.get("nextUri"), "");
		boolean isAdmin = false;
		boolean isLogin = false;
		
		LoginInfo loginInfo = new LoginInfo(request, response);
		HttpSession session = request.getSession(true);
			
		if( "".equals(authGroupSet) ){
			retMsg = "권한그룹이 없습니다.";
		} else {
				
			loginInfo.getLoginInfo();
			ComAuthVO comAuthVO = new ComAuthVO();
			loginInfo.putSessionToVo(comAuthVO); // session의 정보를 VO에 추가.
			comAuthVO.setAuthGroupId(authGroupSet);
			
			try {
				comAuthVO = commBizAuthService.getAuth(comAuthVO);
				System.out.println("========== comAuthVO.getAuthGroupId() : "+comAuthVO.getAuthGroupId());
				System.out.println("========== comAuthVO.getMemType() : "+comAuthVO.getMemType());
				if(comAuthVO != null){
					session.setAttribute(Globals.AUTH_GROUP_ID         , comAuthVO.getAuthGroupId() );  
					session.setAttribute(Globals.MEM_TYPE         , comAuthVO.getMemType() );  
					
					

					commandMap.put( "memType", comAuthVO.getMemType());
					commandMap.put( "menuArea", comAuthVO.getMemType().equals("ADM") ? "la" : "lu");
					commandMap.put( "authGroupId", comAuthVO.getAuthGroupId()); // 사용자 그룹 셋팅( 메뉴조회에 사용됨. )

			    	ArrayList<CommbizMenuVO> menuList = commbizMenuService.listMenu(commandMap);


			    	session.setAttribute(Globals.SESSION_MENU_LIST, menuList);
					
					isLogin = true;
					
					// 관리자
					if( "2016AUTH0000001".equals(authGroupSet) ){
						isAdmin = true;
						nextUri = "/la/main/lmsAdminMainPage.do";
					}else{
						nextUri = "/lu/main/lmsUserMainPage.do";
					}
					
					
				} else {
					retMsg = "권한그룹이 없습니다.";
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				retMsg = "권한그룹이 없습니다.";
			}
				
		}
		
		session.setAttribute("isAdmin", isAdmin);
		session.setAttribute("isLogin", isLogin);
		model.addAttribute("retMsg", retMsg);
		model.addAttribute("nextUri", nextUri);

			
		return "oklms_blank/commbiz/login/loginProc";
	}
	


}
