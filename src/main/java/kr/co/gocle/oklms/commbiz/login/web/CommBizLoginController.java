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
package kr.co.gocle.oklms.commbiz.login.web;

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

import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.log.service.ComLoginLogService;
import kr.co.gocle.oklms.commbiz.log.vo.ComLoginLogVO;
import kr.co.gocle.oklms.commbiz.login.service.CommBizLoginService;
import kr.co.gocle.oklms.commbiz.menu.service.CommbizMenuService;
import kr.co.gocle.oklms.commbiz.menu.vo.CommbizMenuVO;
import kr.co.gocle.oklms.commbiz.util.SecurityUtil;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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
public class CommBizLoginController extends BaseController{

	@Resource(name = "commBizLoginService")
	private CommBizLoginService commBizLoginService;

	@Resource(name = "comLoginLogService")
	private ComLoginLogService comLoginLogService;

	@Resource(name = "commbizMenuService")
	private CommbizMenuService commbizMenuService;

	@Resource(name = "securityUtil")
	private SecurityUtil securityUtil;

	@Resource(name = "beanValidatorJSR303")
	Validator validator;

	@InitBinder
	public void initBinder(WebDataBinder dataBinder){
		try {
			dataBinder.setValidator(this.validator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	/**
	 * 로그인 페이지 이동.
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 * String
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = { "/commbiz/login/goLogin.do" })
	public String loginForm(HttpServletRequest request, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		// View호출
		String returnPage = "";

		String reqUri = StringUtils.defaultIfBlank( (String)commandMap.get("reqUri") , "" );
		String retMsg = StringUtils.defaultIfBlank( (String)commandMap.get("retMsg") , "" );
		String memId = StringUtils.defaultIfBlank( (String)commandMap.get("memId") , "" );


		request.setAttribute("reqUri" , reqUri );
		request.setAttribute("retMsg" , retMsg );
		request.setAttribute("memId" , memId );


		returnPage = "oklms_body/commbiz/login/login";
		return returnPage;
	}


	/**
	 * 로그인 수행.
	 * @param request
	 * @param pResponse
	 * @param commandMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/login/loginProc.do")
	public String loginProc(HttpServletRequest request, HttpServletResponse pResponse, @RequestParam Map<String, Object> commandMap, ModelMap model, SessionStatus sessionStatus){
		try {
			String retMsg = ""; 

			String loginYn = "N";

//			String loginType = StringUtils.defaultIfBlank( (String)commandMap.get("loginType") , "" );
			String reqUri = StringUtils.defaultIfBlank( (String) commandMap.get("reqUri"), "");
			String memId = StringUtils.defaultIfBlank( (String) commandMap.get("memId"), "");
			String memPasswordEncript = StringUtils.defaultIfBlank( (String) commandMap.get("memPasswordEncript"), "");
			
			
			//String memId = "sitglobaladmin";
			//String memPasswordEncript = "1";
			
			String nextUri = StringUtils.defaultIfBlank( (String) commandMap.get("nextUri"), "");
			
			HttpSession reqSession = request.getSession(true);
			reqSession.invalidate();
  
			//로그인 성공시 session 정보 삭제
			//sessionStatus.setComplete();

			String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getHeader("REMOTE_ADDR");
			}else{
				logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
			}

			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getRemoteAddr();
			}else{
				logger.info("#### is REMOTE_ADDR : " + usrIP );
			}

			logger.info("#### reqUri : " + reqUri);
			logger.debug("#### commandMap : " + commandMap.toString());

			LoginVO searchLoginVO = new LoginVO();
			searchLoginVO.setMemId(memId);	
			searchLoginVO.setMemPasswordEncript(memPasswordEncript);
			searchLoginVO.setDeleteYn("N");
			searchLoginVO.setScsnYn("N");
			List<LoginVO> commBizLoginList = commBizLoginService.listLoginVO(searchLoginVO);

			HttpSession session = request.getSession(true);

			LoginVO loginVO = null;

			if ( StringUtils.isNoneBlank( memId ) && commBizLoginList.size() > 0) {
				// ---------------------------------
				// 등록된 사용자인 경우
				// ---------------------------------
				loginVO = commBizLoginList.get(0);
				
				// 로그인실패횟수 5회이며, 로그인제한 시간이 5분보다 작으면 로그인 금지
				if(loginVO.getPwErrNumberTimes() == 5 && loginVO.getLoginLimitMinute() < 5){
					loginYn = "N";
					retMsg = " ( 비밀번호가 오류 횟수 제한으로 5분간 로그인이 금지됩니다. )" ;
				} else {					
					if ( !( loginVO.getMemPassword() ).equals( loginVO.getEncryptShaPw() ) ) {
						// ---------------------------------
						// 비밀번호가 일치하지 않는 경우
						// ---------------------------------

						retMsg = messageSource.getMessage("fail.login.idAndPassword", null, Locale.getDefault()); // 아이디 또는 비밀번호를 다시 확인하세요.
						loginYn = "N";

						String pwFailMaxCnt = EgovProperties.getProperty("Globals.loginPWFailMaxCnt");
						int ablePwFailCnt = 10; // 비밀번호 오류 횟수 저장 컬럼의 길이가 1자리임.

						if( null == loginVO.getPwErrNumberTimes() ){
							retMsg = retMsg + " ( 비밀번호 오류 횟수 초기값이 셋팅되지 않은 사용자입니다!! : 초기값을 셋팅해주세요. )" ;
						}else{
							if( Integer.parseInt(pwFailMaxCnt) > loginVO.getPwErrNumberTimes() ){

								logger.info("#### if pwFailMaxCnt > getPwErrNumberTimes" );

								ablePwFailCnt = commBizLoginService.updateLoginVOPwFailCnt(loginVO); // 비밀번호 오류 횟수 증가 및 잔여 오류 허용 횟수 반환.
								commBizLoginService.updateLoginVOLoginLimit(loginVO);
								retMsg = retMsg + " (" + ablePwFailCnt + "회 남았습니다.)" ;
							}else{
								// 반복적 로그인 통제	( 일정횟수 패스워드 입력 오류 시 해당 사용자 ID에 대한 Lock 기능 )
								logger.info("#### else pwFailMaxCnt > getPwErrNumberTimes");
									
									
								//commBizLoginService.updateLoginVOPwInit(loginVO);
								//retMsg = retMsg + " ( 비밀번호가 초기화되었습니다. 비밀번호 찾기를 이용해주세요. )" ;
								commBizLoginService.updateLoginVOLoginLimit(loginVO);
								retMsg = " ( 비밀번호가 오류 횟수 제한으로 5분간 로그인이 금지됩니다. )" ;
								
							}
						}

						logger.info("#### pwFailMaxCnt=" + Integer.parseInt(pwFailMaxCnt) + ", getPwErrNumberTimes=" + loginVO.getPwErrNumberTimes() );

						// 관리자,HRD담당자,센터전담자,기업현장교사만 일반로그인 처리 나머지는 통합로그인
					} else if(loginVO.getAuthGroupId().equals("2016AUTH0000001")||loginVO.getAuthGroupId().equals("2016AUTH0000004")||loginVO.getAuthGroupId().equals("2016AUTH0000005")||loginVO.getAuthGroupId().equals("2016AUTH0000008")) {
						
						//테스트용
			//		}else if(true){
					
						// ---------------------------------
						// 비밀번호가 일치하는 경우 
						// ---------------------------------

						Calendar cal = new GregorianCalendar();
						Date today = cal.getTime();
//						Date today = new Date();
						String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); // 비밀번호 변경없이 최대 사용 일수
//						Date useExpireYmd = loginVO.getUseExpireYmd(); // 서비스 사용 만료일자
						String authGroupId = loginVO.getAuthGroupId();
						
						logger.debug("#### loginPWMaxUsedDays : " + loginPWMaxUsedDays );
						logger.debug("#### today : " + DateFormatUtils.format( today , "yyyy-MM-dd") );
						logger.debug("#### authGroupId : " + authGroupId );
/*
						logger.info("#### if today > useExpireYmd");

						if( null == loginVO.getLastPwUpdtYmd() ){
							logger.info("#### if getLasPwUpdtYmd is null");

							retMsg = "최종 비밀번호 변경일 값이 없습니다. 관리자에게 문의하세요.";
							loginYn = "N";
							logger.warn("#### loginVO.getLasPwUpdtYmd() 은 항상 존재하여야함!! : " + loginVO.getLastPwUpdtYmd() );

						}
						if( null == loginVO.getUseExpireYmd() ){
							logger.info("#### if getUseExpireYmd is null");

							retMsg = "서비스 사용 만료일 값이 없습니다. 관리자에게 문의하세요.";
							loginYn = "N";
						}
*/						
						
						if ( StringUtils.isBlank( authGroupId ) ){
							logger.info("#### if authGroupId is null");

							retMsg = "사용자 그룹이 지정되지 않았습니다. 관리자에게 문의하세요.";
							loginYn = "N";
						}else{


							logger.info("#### login Success !!");

							//Date pwExpireDay = DateUtils.addDays(loginVO.getLastPwUpdtYmd(), Integer.parseInt(loginPWMaxUsedDays) ); // 비밀번호를 변경하지않고 사용할 수 있는 기한(날짜).
							//logger.debug("#### pwExpireDay : " + DateFormatUtils.format( pwExpireDay , "yyyy-MM-dd") );
							retMsg = null;
							loginYn = "Y";
							//로그인 정보에서 관리자/사용자에 따라 분기 처리.
						/*	2016AUTH0000001	관리자
							2016AUTH0000002	학습근로자
							2016AUTH0000003	담당교수
							
							2016AUTH0000004	기업전담자
							2016AUTH0000005	센터전담자
							
							2016AUTH0000006	학과전담자
							2016AUTH0000007	지도교수
							2016AUTH0000008	기업현장교사  */


							if( StringUtils.isBlank(nextUri) || "/".equals( nextUri ) ){

								if("2016AUTH0000001".equals(loginVO.getAuthGroupId()) ){
									nextUri = "/la/main/lmsAdminMainPage.do";
									session.setAttribute(Globals.SESSION_ADMIN_ID, memId);
								}else{
									nextUri = "/lu/main/lmsUserMainPage.do";
								}
							}

							logger.info("#### login Success nextUri : " + nextUri );

							//로그인 시 사용만료일 업데이트
							Map<String,Object> paramMap2 = new HashMap<String,Object>();
							paramMap2.put("memSeq", loginVO.getMemSeq());
							logger.info("#### loginPWMaxUsedDays : " + loginPWMaxUsedDays );
							paramMap2.put("loginPWMaxUsedDays", loginPWMaxUsedDays);

							logger.info("#### updateLoginVOExpireYmd 11 : ");
							
							//commBizLoginService.updateLoginVOExpireYmd(paramMap2);
							
							logger.info("#### updateLoginVOExpireYmd 22 : ");

							// 최종사용시각 표시	( 응용시스템 접속 시 이전 응용시스템에 대한 최종사용시각을 표시 )
							commBizLoginService.updateLoginVOLastLoginDt(loginVO); // 최종 로그인 일시 업데이트.

							// 로그인,  로그아웃 기록 ( 시스템에 로그인 및 로그아웃한 내용을 로깅하는 기능 )
							ComLoginLogVO comLoginLogVO = new ComLoginLogVO();
							comLoginLogVO.setSessionMemSeq(loginVO.getMemSeq());
							comLoginLogVO.setSessionMemId(loginVO.getMemId());
							comLoginLogVO.setSessionMemName(loginVO.getMemName());
							comLoginLogVO.setMemSeq(loginVO.getMemSeq());
							comLoginLogVO.setMemId(loginVO.getMemId());
							comLoginLogVO.setMemType(loginVO.getMemType());
							comLoginLogVO.setClientIp(usrIP);
							logger.info("#### insertComLoginLog 11 : ");
							logger.info("#### insertComLoginLog VO : "+comLoginLogVO.toString());
							comLoginLogService.insertComLoginLog(comLoginLogVO );
							logger.info("#### insertComLoginLog 22 : ");

							session.setAttribute(Globals.SSO_LOGIN_YN, "N");	
							session.setAttribute(Globals.CONNECTION_USER_ID, memId);
							session.setAttribute(Globals.SESSION_USER_SEQ, loginVO.getMemSeq()); // PK
							session.setAttribute(Globals.SESSION_USER_ID, loginVO.getMemId());
							session.setAttribute(Globals.SESSION_USER_NAME, loginVO.getMemName());
							session.setAttribute(Globals.SESSION_LAST_LOGIN_DT, loginVO.getLastLoginYmd());


						    session.setAttribute(Globals.SESSION_INFO     , "" );           // "LOGIN_SESSION_KEY";
						    session.setAttribute(Globals.MEM_SEQ          , loginVO.getMemSeq() );        // 회원 고유번호
						    session.setAttribute(Globals.MEM_ID           , loginVO.getMemId() );         // 사용자 아이디
						    session.setAttribute(Globals.MEM_ASP_ID       , "");     // 회원 ASP ID
						    session.setAttribute(Globals.MEM_NAME         , loginVO.getMemName() );       // 사용자 성명
						    session.setAttribute(Globals.MEM_NAME_ENG     , loginVO.getMemNameEng() );   // 사용자 성명
						    session.setAttribute(Globals.MEM_TYPE         , loginVO.getMemType() );       // 사융자유형
						    session.setAttribute(Globals.AUTH_GROUP_ID    , loginVO.getAuthGroupId() );  // 권한그룹ID
						    session.setAttribute(Globals.AUTH_GROUP_NAME  , loginVO.getAuthGroupName() );  // 권한그룹NAME
						    session.setAttribute(Globals.EMAIL            , loginVO.getEmail() );          // E-MAIL ADDRESS
						    session.setAttribute(Globals.LEC_ID           , loginVO.getLecId() );         // 강의 ID
						    session.setAttribute(Globals.PERIOD_ID        , loginVO.getPeriodId() );      // 기수 ID
						    session.setAttribute(Globals.CLASS_ID         , loginVO.getClassId() );       // 반 ID
						    session.setAttribute(Globals.PAGE_DIV         , loginVO.getPageDiv() );       // 페이지 모드(일반, 강사, 관리자)
						    session.setAttribute(Globals.LESSON_ID  , loginVO.getLessonId() );     // 레슨 ID
						    session.setAttribute(Globals.LEC_STEP         , loginVO.getLecStep() );       // 차시
						    session.setAttribute(Globals.MENU_AREA        , loginVO.getMenuArea() );      // 메뉴영역(LMS/LCMS구분)
						    session.setAttribute(Globals.COMM_ID          , "" );        // 커뮤니티 ID
						    session.setAttribute(Globals.BG_COLOR_CODE    , "" );  // 커뮤니티 배경색 코드
						    session.setAttribute(Globals.COMPANY_ID     , loginVO.getCompanyId() );   // 회사코드
						    session.setAttribute(Globals.COMPANY_NAME     , loginVO.getCompanyName() );   // 회사명



						    session.setAttribute(Globals.COMPANY_DOMAIN   , "" );        // 회원 고유번호
						    session.setAttribute(Globals.COMPANY_LOGO    , "" );        // 회원 고유번호
						    session.setAttribute(Globals.ASP_ID           , "" );         //ASP ID (현재 접속한URL의 ASP ID)
						    session.setAttribute(Globals.SITE_TYPE        , "" );     //SITE_TYPE 교원(A) 일반(B)
						    session.setAttribute(Globals.ASP_STYLE        , "" );         //ASP_STYLE(A,B,C)
						    session.setAttribute(Globals.SESSION_ID        , session.getId() );         //세션 아이디(로그인 중복을 막기 위함)
						    session.setAttribute(Globals.OVERLAPLOGIN_YN        , loginVO.getOverlaploginYn() );         //중복로그인 사용여부
						    session.setAttribute(Globals.LEC_TARGET           , loginVO.getLecTarget() );         //교육대상
						    session.setAttribute(Globals.LEC_TARGET_YEAR        , loginVO.getLecTargetYear() );         //교육대상연차
						    session.setAttribute(Globals.FACILITY_NO        , loginVO.getFacilityNo() );         //소속코드
						    session.setAttribute(Globals.FACILITY_NAME        , loginVO.getFacilityName() );         //소속명​

						    session.setAttribute(Globals.DEPT_NM        , loginVO.getDeptNm());         //
						    session.setAttribute(Globals.DEPT_NO        , loginVO.getDeptNo());         //소속명​
						    
						    session.setAttribute(Globals.IP        , usrIP);         //IP

							session.setAttribute(Globals.LOCALE, Locale.getDefault());
							session.setAttribute(Globals.SESSION_MAX_INACTIVE_INTERVAL, Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME);

							session.setMaxInactiveInterval(Integer.parseInt( Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME ) );

							/*
							 * Role 따른 조회기준 위해 세션 등록
							 *  2016AUTH0000004	기업전담자
							 */
							if("2016AUTH0000004".equals(loginVO.getAuthGroupId()) ){
								 session.setAttribute(Globals.BIZCOMPANY_ID     , loginVO.getCompanyId() );   // 회사코드
								 session.setAttribute(Globals.BIZCOMPANY_NAME   , loginVO.getCompNm() );   // 회사명
							}
					    	setSessionSyncInfo( session , pResponse , loginVO.getMemSeq() );

					    	// 세션 관리 Table 에 너무 많은값이 들어가는경우 오류 발생으로 VO 객체는 setSessionSyncInfo 처리 후에 셋팅하도록함.
							loginVO.setSessionMemSeq(loginVO.getMemSeq());
							loginVO.setSessionMemId(loginVO.getMemId());
							loginVO.setSessionMemName(loginVO.getMemName());
							loginVO.setSessionSsoLoginYn("N");
							loginVO.setSessionIp(usrIP);
							session.setAttribute(Globals.SESSION_USER_VO, loginVO);

							commandMap.put("memType", loginVO.getMemType()); // 회원유형 셋팅( 메뉴조회에 사용됨. )
							commandMap.put("authGroupId", loginVO.getAuthGroupId()); // 사용자 그룹 셋팅( 메뉴조회에 사용됨. )
							commandMap.put("menuArea", loginVO.getMenuArea()); // 사용자메뉴영역
							ArrayList<CommbizMenuVO> menuList = commbizMenuService.listMenu(commandMap);
							ArrayList<CommbizMenuVO> mobileMenuList = commbizMenuService.mobilelistMenu(commandMap);
							if( !"2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){ // 관리자는 메뉴정보를 필요할 때마다 매번 가져오도록 한다.(LCMS 전환)
								session.setAttribute(Globals.SESSION_MENU_LIST, menuList);
								session.setAttribute(Globals.SESSION_MM_MENU_LIST, mobileMenuList);
							}else{
								logger.debug("#### 슈퍼 운영자(2016AUTH0000001)는 메뉴정보를 필요할 때마다 매번 가져오도록 한다.(LCMS 전환)");
							}

						}
					}else{
						logger.info("#### user not found");
						// ---------------------------------
						// 통합로그인 사용자가 아닌 경우
						// ---------------------------------
						// retMsg = "부적합한 사용자입니다.(등록된 사용자가 아닙니다.)";
						retMsg = "통합로그인으로 선택하세요.";
						loginYn = "N";						
					}
				}
				
			}else{

				logger.info("#### user not found");
				// ---------------------------------
				// 등록된 사용자가 아닌 경우
				// ---------------------------------
				// retMsg = "부적합한 사용자입니다.(등록된 사용자가 아닙니다.)";
				retMsg = "아이디 또는 비밀번호를 다시 확인하세요";
				loginYn = "N";
			}

			boolean isAdmin = false;
			boolean isLogin = false;

			if( !"Y".equals(loginYn) ){
				String tempLoginPage = "";
				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){

					tempLoginPage = "/la/login/goLmsAdminLogin.do";
				}else if(reqUri!= null && reqUri.indexOf("/mm/")>-1){
					tempLoginPage = "/mm/login/goLmsMobileLogin.do";
				}else{
					tempLoginPage = Globals.LOGIN_PAGE;
				}

				nextUri = request.getRequestURI().replace( request.getServletPath(), "") + tempLoginPage + "?reqUri=" + reqUri + "&memId=" + memId;
			}else{
				isLogin = true;

				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){
					isAdmin = true;
				}
			}

			session.setAttribute("isAdmin", isAdmin);
			session.setAttribute("isLogin", isLogin);

			logger.debug("#### getRequestURI : "+ request.getRequestURI().replace(request.getServletPath(), ""));

			model.addAttribute("retMsg", retMsg);
			model.addAttribute("nextUri", nextUri);


			logger.debug("#### getRequestURI model : "+ model.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "oklms_blank/commbiz/login/loginProc";
	}
	
	/**
	 *  SSO 인증여부 확인 및 로그인 수행.
	 * @param request
	 * @param pResponse
	 * @param commandMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/login/ssoLoginProc.do")
	public String ssoLoginProc(HttpServletRequest request, HttpServletResponse pResponse, @RequestParam Map<String, Object> commandMap, ModelMap model, SessionStatus sessionStatus){
		try {
			String retMsg = "";
			String nextUri = "";

			String loginYn = "N";

			String reqUri = StringUtils.defaultIfBlank( (String) commandMap.get("reqUri"), "");
			String menuArea = StringUtils.defaultIfBlank( (String) commandMap.get("menuArea"), "");
			//String memId = StringUtils.defaultIfBlank( (String) commandMap.get("user_id"), "");
			
			logger.debug("===================  #### menuArea : " +menuArea);
			
			//HttpSession reqSession = request.getSession(true);
			//reqSession.invalidate();
			
			HttpSession session = request.getSession(true);
			
			String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getHeader("REMOTE_ADDR");
			}else{
				logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
			}

			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getRemoteAddr();
			}else{
				logger.info("#### is REMOTE_ADDR : " + usrIP );
			}

			logger.info("#### reqUri : " + reqUri);
			logger.debug("#### commandMap : " + commandMap.toString());

			
			
			String eXSignOnUserId = (String) session.getAttribute("eXSignOn.session.userid");
			
			logger.debug("#### eXSignOnUserId : " + eXSignOnUserId);
			
			System.out.println("#### eXSignOnUserId : " + eXSignOnUserId);
			
			String memId = "";
			try {
				JSONParser parser = new JSONParser();
				JSONObject jsonObj = (JSONObject)parser.parse(eXSignOnUserId);
				memId = jsonObj.get("empno").toString();
			} catch (Exception e) {
				memId = "";
			}
			

			// 라웅재 학생 학번이 2개이며, SSO 에서 넘어오는 학번은 하나므로 변경처리
			if(memId.equals("2015191014")){
				memId = "2051022008";
			}
			// 염지서 학생 학번이 2개이며, SSO 에서 넘어오는 학번은 하나므로 변경처리
			if(memId.equals("2016192019")){
				memId = "2051022011";
			}
			// 백강현 학생 학번이 2개이며, SSO 에서 넘어오는 학번은 하나므로 변경처리
			if(memId.equals("2019192018")){
				memId = "2020191011";
			}
			// 현정욱 학생 학번이 2개이며, SSO 에서 넘어오는 학번은 하나므로 변경처리
			if(memId.equals("2018191047")){
				memId = "2251021018";
			}
			// 강민우 학생 학번이 2개이며, SSO 에서 넘어오는 학번은 하나므로 변경처리
			if(memId.equals("2018192001")){
				memId = "2251022002";
			}
			// 황승호 학생 학번이 2개이며, SSO 에서 넘어오는 학번은 하나므로 변경처리
			if(memId.equals("2021191030")){
				memId = "2551022016";
			}
			 
			System.out.println("============ sso memId : " + memId);
			
			
			LoginVO loginVO = null;
			
			// 인증정보가 있을경우
			if( !"".equals(memId)  ){
				
				logger.debug("============  sso memId : " + memId);
				
				LoginVO searchLoginVO = new LoginVO();
				searchLoginVO.setMemId(memId);
				searchLoginVO.setDeleteYn("N");
				searchLoginVO.setScsnYn("N");
				List<LoginVO> commBizLoginList = commBizLoginService.listLoginVO(searchLoginVO);
				
				/*
				 * 
 
	
				2016AUTH0000001	관리자
				2016AUTH0000002	학습근로자
				2016AUTH0000003	담당교수
				2016AUTH0000004	기업전담자
				2016AUTH0000005	센터전담자
				2016AUTH0000006	학과전담자
				2016AUTH0000007	지도교수
				2016AUTH0000008	기업현장교사*/

				if ( StringUtils.isNoneBlank( memId ) && commBizLoginList.size() > 0) {
					// ---------------------------------
					// 등록된 사용자인 경우
					// ---------------------------------
					loginVO = commBizLoginList.get(0);


					Calendar cal = new GregorianCalendar();
					Date today = cal.getTime();
//						Date today = new Date();
					String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); // 비밀번호 변경없이 최대 사용 일수
//					Date useExpireYmd = loginVO.getUseExpireYmd(); // 서비스 사용 만료일자
					String authGroupId = loginVO.getAuthGroupId();
					logger.debug("#### loginPWMaxUsedDays : " + loginPWMaxUsedDays );
					logger.debug("#### today : " + DateFormatUtils.format( today , "yyyy-MM-dd") );
					logger.debug("#### authGroupId : " + authGroupId );



					logger.info("============  sso login Success !!");

					retMsg = null;
					loginYn = "Y";

					if( StringUtils.isBlank(nextUri) || "/".equals( nextUri ) ){

						if("2016AUTH0000001".equals(loginVO.getAuthGroupId()) ){
							nextUri = "/la/main/lmsAdminMainPage.do";
							session.setAttribute(Globals.SESSION_ADMIN_ID, memId);
						}else{
							if(menuArea.equals("MOBILE")){
								nextUri = "/mm/main/lmsMainPage.do";
							} else {
								nextUri = "/lu/main/lmsUserMainPage.do";
							}
							
						}
					}

					logger.info("#### login Success nextUri : " + nextUri );

					//로그인 시 사용만료일 업데이트
					Map<String,Object> paramMap2 = new HashMap<String,Object>();
					paramMap2.put("memSeq", loginVO.getMemSeq());
					paramMap2.put("loginPWMaxUsedDays", loginPWMaxUsedDays);

					logger.info("#### updateLoginVOExpireYmd 11 : ");
					//commBizLoginService.updateLoginVOExpireYmd(paramMap2);
					logger.info("#### updateLoginVOExpireYmd 22 : ");

					// 최종사용시각 표시	( 응용시스템 접속 시 이전 응용시스템에 대한 최종사용시각을 표시 )
					commBizLoginService.updateLoginVOLastLoginDt(loginVO); // 최종 로그인 일시 업데이트.

					// 로그인,  로그아웃 기록 ( 시스템에 로그인 및 로그아웃한 내용을 로깅하는 기능 )
					ComLoginLogVO comLoginLogVO = new ComLoginLogVO();
					comLoginLogVO.setSessionMemSeq(loginVO.getMemSeq());
					comLoginLogVO.setSessionMemId(loginVO.getMemId());
					comLoginLogVO.setSessionMemName(loginVO.getMemName());
					comLoginLogVO.setMemSeq(loginVO.getMemSeq());
					comLoginLogVO.setMemId(loginVO.getMemId());
					comLoginLogVO.setMemType(loginVO.getMemType());
					comLoginLogVO.setClientIp(usrIP);
					logger.info("#### insertComLoginLog 11 : ");
					logger.info("#### insertComLoginLog VO : "+comLoginLogVO.toString());
					comLoginLogService.insertComLoginLog(comLoginLogVO );
					logger.info("#### insertComLoginLog 22 : ");
					
					session.setAttribute(Globals.SSO_LOGIN_YN, "Y");
					session.setAttribute(Globals.CONNECTION_USER_ID, memId);
					session.setAttribute(Globals.SESSION_USER_SEQ, loginVO.getMemSeq()); // PK
					session.setAttribute(Globals.SESSION_USER_ID, loginVO.getMemId());
					session.setAttribute(Globals.SESSION_USER_NAME, loginVO.getMemName());
					session.setAttribute(Globals.SESSION_LAST_LOGIN_DT, loginVO.getLastLoginYmd());


				    session.setAttribute(Globals.SESSION_INFO     , "" );           // "LOGIN_SESSION_KEY";
				    session.setAttribute(Globals.MEM_SEQ          , loginVO.getMemSeq() );        // 회원 고유번호
				    session.setAttribute(Globals.MEM_ID           , loginVO.getMemId() );         // 사용자 아이디
				    session.setAttribute(Globals.MEM_ASP_ID       , "");     // 회원 ASP ID
				    session.setAttribute(Globals.MEM_NAME         , loginVO.getMemName() );       // 사용자 성명
				    session.setAttribute(Globals.MEM_NAME_ENG     , loginVO.getMemNameEng() );   // 사용자 성명
				    session.setAttribute(Globals.MEM_TYPE         , loginVO.getMemType() );       // 사융자유형
				    session.setAttribute(Globals.AUTH_GROUP_ID    , loginVO.getAuthGroupId() );  // 권한그룹ID
				    session.setAttribute(Globals.AUTH_GROUP_NAME  , loginVO.getAuthGroupName() );  // 권한그룹NAME
				    session.setAttribute(Globals.EMAIL            , loginVO.getEmail() );          // E-MAIL ADDRESS
				    session.setAttribute(Globals.LEC_ID           , loginVO.getLecId() );         // 강의 ID
				    session.setAttribute(Globals.PERIOD_ID        , loginVO.getPeriodId() );      // 기수 ID
				    session.setAttribute(Globals.CLASS_ID         , loginVO.getClassId() );       // 반 ID
				    session.setAttribute(Globals.PAGE_DIV         , loginVO.getPageDiv() );       // 페이지 모드(일반, 강사, 관리자)
				    session.setAttribute(Globals.LESSON_ID  , loginVO.getLessonId() );     // 레슨 ID
				    session.setAttribute(Globals.LEC_STEP         , loginVO.getLecStep() );       // 차시
				    session.setAttribute(Globals.MENU_AREA        , loginVO.getMenuArea() );      // 메뉴영역(LMS/LCMS구분)
				    session.setAttribute(Globals.COMM_ID          , "" );        // 커뮤니티 ID
				    session.setAttribute(Globals.BG_COLOR_CODE    , "" );  // 커뮤니티 배경색 코드
				    session.setAttribute(Globals.COMPANY_ID     , loginVO.getCompanyId() );   // 회사코드
				    session.setAttribute(Globals.COMPANY_NAME     , loginVO.getCompanyName() );   // 회사명



				    session.setAttribute(Globals.COMPANY_DOMAIN   , "" );        // 회원 고유번호
				    session.setAttribute(Globals.COMPANY_LOGO    , "" );        // 회원 고유번호
				    session.setAttribute(Globals.ASP_ID           , "" );         //ASP ID (현재 접속한URL의 ASP ID)
				    session.setAttribute(Globals.SITE_TYPE        , "" );     //SITE_TYPE 교원(A) 일반(B)
				    session.setAttribute(Globals.ASP_STYLE        , "" );         //ASP_STYLE(A,B,C)
				    session.setAttribute(Globals.SESSION_ID        , session.getId() );         //세션 아이디(로그인 중복을 막기 위함)
				    session.setAttribute(Globals.OVERLAPLOGIN_YN        , loginVO.getOverlaploginYn() );         //중복로그인 사용여부
				    session.setAttribute(Globals.LEC_TARGET           , loginVO.getLecTarget() );         //교육대상
				    session.setAttribute(Globals.LEC_TARGET_YEAR        , loginVO.getLecTargetYear() );         //교육대상연차
				    session.setAttribute(Globals.FACILITY_NO        , loginVO.getFacilityNo() );         //소속코드
				    session.setAttribute(Globals.FACILITY_NAME        , loginVO.getFacilityName() );         //소속명​

				    session.setAttribute(Globals.DEPT_NM        , loginVO.getDeptNm());         //
				    session.setAttribute(Globals.DEPT_NO        , loginVO.getDeptNo());         //소속명
				    
				    session.setAttribute(Globals.IP        , usrIP);         //IP​


					session.setAttribute(Globals.LOCALE, Locale.getDefault());
					session.setAttribute(Globals.SESSION_MAX_INACTIVE_INTERVAL, Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME);

					session.setMaxInactiveInterval(Integer.parseInt( Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME ) );

					/*
					 * Role 따른 조회기준 위해 세션 등록
					 *  2016AUTH0000004	기업전담자
					 */
					if("2016AUTH0000004".equals(loginVO.getAuthGroupId()) ){
						 session.setAttribute(Globals.BIZCOMPANY_ID     , loginVO.getCompanyId() );   // 회사코드
						 session.setAttribute(Globals.BIZCOMPANY_NAME   , loginVO.getCompNm() );   // 회사명
					}

			    	setSessionSyncInfo( session , pResponse , loginVO.getMemSeq() );

			    	// 세션 관리 Table 에 너무 많은값이 들어가는경우 오류 발생으로 VO 객체는 setSessionSyncInfo 처리 후에 셋팅하도록함.
					loginVO.setSessionMemSeq(loginVO.getMemSeq());
					loginVO.setSessionMemId(loginVO.getMemId());
					loginVO.setSessionSsoLoginYn("Y");
					loginVO.setSessionMemName(loginVO.getMemName());
					loginVO.setSessionIp(usrIP);
					session.setAttribute(Globals.SESSION_USER_VO, loginVO);

					commandMap.put("memType", loginVO.getMemType()); // 회원유형 셋팅( 메뉴조회에 사용됨. )
					commandMap.put("authGroupId", loginVO.getAuthGroupId()); // 사용자 그룹 셋팅( 메뉴조회에 사용됨. )
					commandMap.put("menuArea", loginVO.getMenuArea()); // 사용자메뉴영역
					ArrayList<CommbizMenuVO> menuList = commbizMenuService.listMenu(commandMap);
					ArrayList<CommbizMenuVO> mobileMenuList = commbizMenuService.mobilelistMenu(commandMap);
					if( !"2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){ // 관리자는 메뉴정보를 필요할 때마다 매번 가져오도록 한다.(LCMS 전환)
						session.setAttribute(Globals.SESSION_MENU_LIST, menuList);
						session.setAttribute(Globals.SESSION_MM_MENU_LIST, mobileMenuList);
					}else{
						logger.debug("#### 슈퍼 운영자(2016AUTH0000001)는 메뉴정보를 필요할 때마다 매번 가져오도록 한다.(LCMS 전환)");
					}
				}else{

					logger.info("#### user not found");
					// ---------------------------------
					// 등록된 사용자가 아닌 경우
					// ---------------------------------
					// retMsg = "부적합한 사용자입니다.(등록된 사용자가 아닙니다.)";
					// 로그인대상자가 아님
					retMsg = "등록 된 사용자가 아닙니다.";
					session.setAttribute("NOT_USER_YN"     , "Y");
					loginYn = "N";
				}
			} else {
				// 인증정보 없을때
				retMsg = "통합 로그인 인증에 실패했습니다.";
				loginYn = "N";
			}
			
			

			boolean isAdmin = false;
			boolean isLogin = false;

			if( !"Y".equals(loginYn) ){
				String tempLoginPage = "";
				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){

					tempLoginPage = "/la/login/goLmsAdminLogin.do";
				}else{
					tempLoginPage = Globals.LOGIN_PAGE;
				}

				nextUri = request.getRequestURI().replace( request.getServletPath(), "") + tempLoginPage + "?reqUri=" + reqUri + "&memId=" + memId;
			}else{
				isLogin = true;

				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){
					isAdmin = true;
				}
			}

			session.setAttribute("isAdmin", isAdmin);
			session.setAttribute("isLogin", isLogin);

			logger.debug("#### getRequestURI : "+ request.getRequestURI().replace(request.getServletPath(), ""));


			model.addAttribute("retMsg", retMsg);
			model.addAttribute("nextUri", nextUri);
			
			logger.debug("#### getRequestURI model : "+ model.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "oklms_blank/commbiz/login/loginProc";
	}
	
	
	/**
	 * 로그인 수행.
	 * @param request
	 * @param pResponse
	 * @param commandMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/login/adminLoginProc.do")
	public String adminLoginProc(HttpServletRequest request, HttpServletResponse pResponse, @RequestParam Map<String, Object> commandMap, ModelMap model, SessionStatus sessionStatus){
		try {
			String retMsg = ""; 

			String loginYn = "N";

//			String loginType = StringUtils.defaultIfBlank( (String)commandMap.get("loginType") , "" );
//			String reqUri = StringUtils.defaultIfBlank( (String) commandMap.get("reqUri"), Globals.MAIN_PAGE );
			String reqUri = StringUtils.defaultIfBlank( (String) commandMap.get("reqUri"), "");
			String memId = StringUtils.defaultIfBlank( (String) commandMap.get("memId"), "");
//			String memPasswordEncript = StringUtils.defaultIfBlank( (String) commandMap.get("memPasswordEncript"), "");
			String nextUri = StringUtils.defaultIfBlank( (String) commandMap.get("nextUri"), "");
			
//			HttpSession reqSession = request.getSession(true);

			//로그인 성공시 session 정보 삭제
			//sessionStatus.setComplete();

			String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getHeader("REMOTE_ADDR");
			}else{
				logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
			}

			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getRemoteAddr();
			}else{
				logger.info("#### is REMOTE_ADDR : " + usrIP );
			}

			logger.info("#### reqUri : " + reqUri);
			logger.debug("#### commandMap : " + commandMap.toString());

			LoginVO searchLoginVO = new LoginVO();
			searchLoginVO.setMemId(memId);
			searchLoginVO.setDeleteYn("N");
			searchLoginVO.setScsnYn("N");
			List<LoginVO> commBizLoginList = commBizLoginService.listAdminLoginVO(searchLoginVO);

			HttpSession session = request.getSession(true);

			LoginVO loginVO = null;

			if ( StringUtils.isNoneBlank( memId ) && commBizLoginList.size() > 0) {
				// ---------------------------------
				// 등록된 사용자인 경우
				// ---------------------------------
				loginVO = commBizLoginList.get(0);
				

				Calendar cal = new GregorianCalendar();
				Date today = cal.getTime();
//						Date today = new Date();
				String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); // 비밀번호 변경없이 최대 사용 일수
//				Date useExpireYmd = loginVO.getUseExpireYmd(); // 서비스 사용 만료일자
				String authGroupId = loginVO.getAuthGroupId();
				logger.debug("#### loginPWMaxUsedDays : " + loginPWMaxUsedDays );
				logger.debug("#### today : " + DateFormatUtils.format( today , "yyyy-MM-dd") );
				logger.debug("#### authGroupId : " + authGroupId );

				if( null == loginVO.getLastPwUpdtYmd() ){
					logger.info("#### if getLasPwUpdtYmd is null");

					retMsg = "최종 비밀번호 변경일 값이 없습니다. 관리자에게 문의하세요.";
					loginYn = "N";
					logger.warn("#### loginVO.getLasPwUpdtYmd() 은 항상 존재하여야함!! : " + loginVO.getLastPwUpdtYmd() );

				}
				if( null == loginVO.getUseExpireYmd() ){
					logger.info("#### if getUseExpireYmd is null");

					retMsg = "서비스 사용 만료일 값이 없습니다. 관리자에게 문의하세요.";
					loginYn = "N";
				}
				if ( StringUtils.isBlank( authGroupId ) ){
					logger.info("#### if authGroupId is null");

					retMsg = "사용자 그룹이 지정되지 않았습니다. 관리자에게 문의하세요.";
					loginYn = "N";
				}else{


					logger.info("#### admin login Success !!");

					retMsg = null;
					loginYn = "Y";


					if( StringUtils.isBlank(nextUri) || "/".equals( nextUri ) ){

						if("2016AUTH0000001".equals(loginVO.getAuthGroupId()) ){
							nextUri = "/la/main/lmsAdminMainPage.do";
							session.setAttribute(Globals.SESSION_ADMIN_ID, memId);
						}else{
							nextUri = "/lu/main/lmsUserMainPage.do";
						}
					}

					logger.info("#### login Success nextUri : " + nextUri );

					//로그인 시 사용만료일 업데이트
					Map<String,Object> paramMap2 = new HashMap<String,Object>();
					paramMap2.put("memSeq", loginVO.getMemSeq());
					paramMap2.put("loginPWMaxUsedDays", loginPWMaxUsedDays);

					logger.info("#### updateLoginVOExpireYmd 11 : ");
					//commBizLoginService.updateLoginVOExpireYmd(paramMap2);
					logger.info("#### updateLoginVOExpireYmd 22 : ");

					// 최종사용시각 표시	( 응용시스템 접속 시 이전 응용시스템에 대한 최종사용시각을 표시 )
					commBizLoginService.updateLoginVOLastLoginDt(loginVO); // 최종 로그인 일시 업데이트.

					// 로그인,  로그아웃 기록 ( 시스템에 로그인 및 로그아웃한 내용을 로깅하는 기능 )
					ComLoginLogVO comLoginLogVO = new ComLoginLogVO();
					comLoginLogVO.setSessionMemSeq(loginVO.getMemSeq());
					comLoginLogVO.setSessionMemId(loginVO.getMemId());
					comLoginLogVO.setSessionMemName(loginVO.getMemName());
					comLoginLogVO.setMemSeq(loginVO.getMemSeq());
					comLoginLogVO.setMemId(loginVO.getMemId());
					comLoginLogVO.setMemType(loginVO.getMemType());
					comLoginLogVO.setClientIp(usrIP);
					logger.info("#### insertComLoginLog 11 : ");
					logger.info("#### insertComLoginLog VO : "+comLoginLogVO.toString());
					//comLoginLogService.insertComLoginLog(comLoginLogVO );
					logger.info("#### insertComLoginLog 22 : ");

					session.setAttribute(Globals.SSO_LOGIN_YN, "N");	
					session.setAttribute(Globals.CONNECTION_USER_ID, memId);
					session.setAttribute(Globals.SESSION_USER_SEQ, loginVO.getMemSeq()); // PK
					session.setAttribute(Globals.SESSION_USER_ID, loginVO.getMemId());
					session.setAttribute(Globals.SESSION_USER_NAME, loginVO.getMemName());
					session.setAttribute(Globals.SESSION_LAST_LOGIN_DT, loginVO.getLastLoginYmd());


				    session.setAttribute(Globals.SESSION_INFO     , "" );           // "LOGIN_SESSION_KEY";
				    session.setAttribute(Globals.MEM_SEQ          , loginVO.getMemSeq() );        // 회원 고유번호
				    session.setAttribute(Globals.MEM_ID           , loginVO.getMemId() );         // 사용자 아이디
				    session.setAttribute(Globals.MEM_ASP_ID       , "");     // 회원 ASP ID
				    session.setAttribute(Globals.MEM_NAME         , loginVO.getMemName() );       // 사용자 성명
				    session.setAttribute(Globals.MEM_NAME_ENG     , loginVO.getMemNameEng() );   // 사용자 성명
				    session.setAttribute(Globals.MEM_TYPE         , loginVO.getMemType() );       // 사융자유형
				    session.setAttribute(Globals.AUTH_GROUP_ID    , loginVO.getAuthGroupId() );  // 권한그룹ID
				    session.setAttribute(Globals.AUTH_GROUP_NAME  , loginVO.getAuthGroupName() );  // 권한그룹NAME
				    session.setAttribute(Globals.EMAIL            , loginVO.getEmail() );          // E-MAIL ADDRESS
				    session.setAttribute(Globals.LEC_ID           , loginVO.getLecId() );         // 강의 ID
				    session.setAttribute(Globals.PERIOD_ID        , loginVO.getPeriodId() );      // 기수 ID
				    session.setAttribute(Globals.CLASS_ID         , loginVO.getClassId() );       // 반 ID
				    session.setAttribute(Globals.PAGE_DIV         , loginVO.getPageDiv() );       // 페이지 모드(일반, 강사, 관리자)
				    session.setAttribute(Globals.LESSON_ID  , loginVO.getLessonId() );     // 레슨 ID
				    session.setAttribute(Globals.LEC_STEP         , loginVO.getLecStep() );       // 차시
				    session.setAttribute(Globals.MENU_AREA        , loginVO.getMenuArea() );      // 메뉴영역(LMS/LCMS구분)
				    session.setAttribute(Globals.COMM_ID          , "" );        // 커뮤니티 ID
				    session.setAttribute(Globals.BG_COLOR_CODE    , "" );  // 커뮤니티 배경색 코드
				    session.setAttribute(Globals.COMPANY_ID     , loginVO.getCompanyId() );   // 회사코드
				    session.setAttribute(Globals.COMPANY_NAME     , loginVO.getCompanyName() );   // 회사명



				    session.setAttribute(Globals.COMPANY_DOMAIN   , "" );        // 회원 고유번호
				    session.setAttribute(Globals.COMPANY_LOGO    , "" );        // 회원 고유번호
				    session.setAttribute(Globals.ASP_ID           , "" );         //ASP ID (현재 접속한URL의 ASP ID)
				    session.setAttribute(Globals.SITE_TYPE        , "" );     //SITE_TYPE 교원(A) 일반(B)
				    session.setAttribute(Globals.ASP_STYLE        , "" );         //ASP_STYLE(A,B,C)
				    session.setAttribute(Globals.SESSION_ID        , session.getId() );         //세션 아이디(로그인 중복을 막기 위함)
				    session.setAttribute(Globals.OVERLAPLOGIN_YN        , loginVO.getOverlaploginYn() );         //중복로그인 사용여부
				    session.setAttribute(Globals.LEC_TARGET           , loginVO.getLecTarget() );         //교육대상
				    session.setAttribute(Globals.LEC_TARGET_YEAR        , loginVO.getLecTargetYear() );         //교육대상연차
				    session.setAttribute(Globals.FACILITY_NO        , loginVO.getFacilityNo() );         //소속코드
				    session.setAttribute(Globals.FACILITY_NAME        , loginVO.getFacilityName() );         //소속명​

				    session.setAttribute(Globals.DEPT_NM        , loginVO.getDeptNm());         //
				    session.setAttribute(Globals.DEPT_NO        , loginVO.getDeptNo());         //소속명​
				    
				    session.setAttribute(Globals.IP        , usrIP);         //IP

					session.setAttribute(Globals.LOCALE, Locale.getDefault());
					session.setAttribute(Globals.SESSION_MAX_INACTIVE_INTERVAL, Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME);

					session.setMaxInactiveInterval(Integer.parseInt( Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME ) );

					/*
					 * Role 따른 조회기준 위해 세션 등록
					 *  2016AUTH0000004	기업전담자
					 */
					if("2016AUTH0000004".equals(loginVO.getAuthGroupId()) ){
						 session.setAttribute(Globals.BIZCOMPANY_ID     , loginVO.getCompanyId() );   // 회사코드
						 session.setAttribute(Globals.BIZCOMPANY_NAME   , loginVO.getCompNm() );   // 회사명
					}

			    	setSessionSyncInfo( session , pResponse , loginVO.getMemSeq() );

			    	// 세션 관리 Table 에 너무 많은값이 들어가는경우 오류 발생으로 VO 객체는 setSessionSyncInfo 처리 후에 셋팅하도록함.
					loginVO.setSessionMemSeq(loginVO.getMemSeq());
					loginVO.setSessionMemId(loginVO.getMemId());
					loginVO.setSessionMemName(loginVO.getMemName());
					loginVO.setSessionSsoLoginYn("N");
					loginVO.setSessionIp(usrIP);
					session.setAttribute(Globals.SESSION_USER_VO, loginVO);

					commandMap.put("memType", loginVO.getMemType()); // 회원유형 셋팅( 메뉴조회에 사용됨. )
					commandMap.put("authGroupId", loginVO.getAuthGroupId()); // 사용자 그룹 셋팅( 메뉴조회에 사용됨. )
					commandMap.put("menuArea", loginVO.getMenuArea()); // 사용자메뉴영역
					ArrayList<CommbizMenuVO> menuList = commbizMenuService.listMenu(commandMap);
					ArrayList<CommbizMenuVO> mobileMenuList = commbizMenuService.mobilelistMenu(commandMap);
					if( !"2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){ // 관리자는 메뉴정보를 필요할 때마다 매번 가져오도록 한다.(LCMS 전환)
						/*2016AUTH0000001	관리자
						2016AUTH0000002	학습근로자
						2016AUTH0000003	담당교수
						2016AUTH0000004	기업전담자
						2016AUTH0000005	센터전담자
						2016AUTH0000006	학과전담자
						2016AUTH0000007	지도교수
						2016AUTH0000008	기업현장교사*/
						session.setAttribute(Globals.SESSION_MENU_LIST, menuList);
						session.setAttribute(Globals.SESSION_MM_MENU_LIST, mobileMenuList);
					}else{
						logger.debug("#### 슈퍼 운영자(2016AUTH0000001)는 메뉴정보를 필요할 때마다 매번 가져오도록 한다.(LCMS 전환)");
					}
				}
			}
				

			boolean isAdmin = false;
			boolean isLogin = false;

			if( !"Y".equals(loginYn) ){
				String tempLoginPage = "";
				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){

					tempLoginPage = "/la/login/goLmsAdminLogin.do";
				}/*else if(reqUri!= null && reqUri.indexOf("/mm/")>-1){
					tempLoginPage = "/mm/login/goLmsMobileLogin.do";
				}*/else{
					tempLoginPage = Globals.LOGIN_PAGE;
				}

				nextUri = request.getRequestURI().replace( request.getServletPath(), "") + tempLoginPage + "?reqUri=" + reqUri + "&memId=" + memId;
			}else{
				isLogin = true;

				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){
					isAdmin = true;
				}
			}

			session.setAttribute("isAdmin", isAdmin);
			session.setAttribute("isLogin", isLogin);

			logger.debug("#### getRequestURI : "+ request.getRequestURI().replace(request.getServletPath(), ""));


			model.addAttribute("retMsg", retMsg);
			model.addAttribute("nextUri", nextUri);


			logger.debug("#### getRequestURI model : "+ model.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "oklms_blank/commbiz/login/loginProc";
	}



	/**
	 * 로그인 수행.
	 * @param request
	 * @param pResponse
	 * @param commandMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/login/autoAdminLoginProc.do")
	public String autoAdminLoginProc(HttpServletRequest request, HttpServletResponse pResponse, @RequestParam Map<String, Object> commandMap, ModelMap model, SessionStatus sessionStatus){
		try {

			HttpSession session = request.getSession(true);

			LoginVO loginVO = null;
			
			String retMsg = ""; 

			String loginYn = "N";
			String reqUri = StringUtils.defaultIfBlank( (String) commandMap.get("reqUri"), "");
			String memId = StringUtils.defaultIfBlank( (String) session.getAttribute(Globals.SESSION_ADMIN_ID), "");
			String nextUri = StringUtils.defaultIfBlank( (String) commandMap.get("nextUri"), "");

			String usrIP = request.getHeader("HTTP_X_FORWARDED_FOR");
			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getHeader("REMOTE_ADDR");
			}else{
				logger.info("#### is HTTP_X_FORWARDED_FOR : " + usrIP );
			}

			if( StringUtils.isBlank( usrIP ) || usrIP.toLowerCase().equals("unknown") ){
				usrIP = request.getRemoteAddr();
			}else{
				logger.info("#### is REMOTE_ADDR : " + usrIP );
			}


			LoginVO searchLoginVO = new LoginVO();
			searchLoginVO.setMemId(memId);
			searchLoginVO.setDeleteYn("N");
			searchLoginVO.setScsnYn("N");
			List<LoginVO> commBizLoginList = commBizLoginService.listAdminLoginVO(searchLoginVO);


			if ( StringUtils.isNoneBlank( memId ) && commBizLoginList.size() > 0) {
				// ---------------------------------
				// 등록된 사용자인 경우
				// ---------------------------------
				loginVO = commBizLoginList.get(0);
				
				String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); // 비밀번호 변경없이 최대 사용 일수				
					retMsg = null;
					loginYn = "Y";


					if( StringUtils.isBlank(nextUri) || "/".equals( nextUri ) ){

						if("2016AUTH0000001".equals(loginVO.getAuthGroupId()) ){
							nextUri = "/la/main/lmsAdminMainPage.do";
							session.setAttribute(Globals.SESSION_ADMIN_ID, memId);
						}else{
							nextUri = "/lu/main/lmsUserMainPage.do";
						}
					}
					//로그인 시 사용만료일 업데이트
					Map<String,Object> paramMap2 = new HashMap<String,Object>();
					paramMap2.put("memSeq", loginVO.getMemSeq());
					paramMap2.put("loginPWMaxUsedDays", loginPWMaxUsedDays);

					//commBizLoginService.updateLoginVOExpireYmd(paramMap2);

					// 최종사용시각 표시	( 응용시스템 접속 시 이전 응용시스템에 대한 최종사용시각을 표시 )
					commBizLoginService.updateLoginVOLastLoginDt(loginVO); // 최종 로그인 일시 업데이트.

					// 로그인,  로그아웃 기록 ( 시스템에 로그인 및 로그아웃한 내용을 로깅하는 기능 )
					ComLoginLogVO comLoginLogVO = new ComLoginLogVO();
					comLoginLogVO.setSessionMemSeq(loginVO.getMemSeq());
					comLoginLogVO.setSessionMemId(loginVO.getMemId());
					comLoginLogVO.setSessionMemName(loginVO.getMemName());
					comLoginLogVO.setMemSeq(loginVO.getMemSeq());
					comLoginLogVO.setMemId(loginVO.getMemId());
					comLoginLogVO.setMemType(loginVO.getMemType());
					comLoginLogVO.setClientIp(usrIP);
					comLoginLogService.insertComLoginLog(comLoginLogVO );

					
					session.setAttribute(Globals.SSO_LOGIN_YN, "N");	
					session.setAttribute(Globals.CONNECTION_USER_ID, memId);
					session.setAttribute(Globals.SESSION_USER_SEQ, loginVO.getMemSeq()); // PK
					session.setAttribute(Globals.SESSION_USER_ID, loginVO.getMemId());
					session.setAttribute(Globals.SESSION_USER_NAME, loginVO.getMemName());
					session.setAttribute(Globals.SESSION_LAST_LOGIN_DT, loginVO.getLastLoginYmd());


				    session.setAttribute(Globals.SESSION_INFO     , "" );           // "LOGIN_SESSION_KEY";
				    session.setAttribute(Globals.MEM_SEQ          , loginVO.getMemSeq() );        // 회원 고유번호
				    session.setAttribute(Globals.MEM_ID           , loginVO.getMemId() );         // 사용자 아이디
				    session.setAttribute(Globals.MEM_ASP_ID       , "");     // 회원 ASP ID
				    session.setAttribute(Globals.MEM_NAME         , loginVO.getMemName() );       // 사용자 성명
				    session.setAttribute(Globals.MEM_NAME_ENG     , loginVO.getMemNameEng() );   // 사용자 성명
				    session.setAttribute(Globals.MEM_TYPE         , loginVO.getMemType() );       // 사융자유형
				    session.setAttribute(Globals.AUTH_GROUP_ID    , loginVO.getAuthGroupId() );  // 권한그룹ID
				    session.setAttribute(Globals.AUTH_GROUP_NAME  , loginVO.getAuthGroupName() );  // 권한그룹NAME
				    session.setAttribute(Globals.EMAIL            , loginVO.getEmail() );          // E-MAIL ADDRESS
				    session.setAttribute(Globals.LEC_ID           , loginVO.getLecId() );         // 강의 ID
				    session.setAttribute(Globals.PERIOD_ID        , loginVO.getPeriodId() );      // 기수 ID
				    session.setAttribute(Globals.CLASS_ID         , loginVO.getClassId() );       // 반 ID
				    session.setAttribute(Globals.PAGE_DIV         , loginVO.getPageDiv() );       // 페이지 모드(일반, 강사, 관리자)
				    session.setAttribute(Globals.LESSON_ID  , loginVO.getLessonId() );     // 레슨 ID
				    session.setAttribute(Globals.LEC_STEP         , loginVO.getLecStep() );       // 차시
				    session.setAttribute(Globals.MENU_AREA        , loginVO.getMenuArea() );      // 메뉴영역(LMS/LCMS구분)
				    session.setAttribute(Globals.COMM_ID          , "" );        // 커뮤니티 ID
				    session.setAttribute(Globals.BG_COLOR_CODE    , "" );  // 커뮤니티 배경색 코드
				    session.setAttribute(Globals.COMPANY_ID     , loginVO.getCompanyId() );   // 회사코드



				    session.setAttribute(Globals.COMPANY_DOMAIN   , "" );        // 회원 고유번호
				    session.setAttribute(Globals.COMPANY_LOGO    , "" );        // 회원 고유번호
				    session.setAttribute(Globals.ASP_ID           , "" );         //ASP ID (현재 접속한URL의 ASP ID)
				    session.setAttribute(Globals.SITE_TYPE        , "" );     //SITE_TYPE 교원(A) 일반(B)
				    session.setAttribute(Globals.ASP_STYLE        , "" );         //ASP_STYLE(A,B,C)
				    session.setAttribute(Globals.SESSION_ID        , session.getId() );         //세션 아이디(로그인 중복을 막기 위함)
				    session.setAttribute(Globals.OVERLAPLOGIN_YN        , loginVO.getOverlaploginYn() );         //중복로그인 사용여부
				    session.setAttribute(Globals.LEC_TARGET           , loginVO.getLecTarget() );         //교육대상
				    session.setAttribute(Globals.LEC_TARGET_YEAR        , loginVO.getLecTargetYear() );         //교육대상연차
				    session.setAttribute(Globals.FACILITY_NO        , loginVO.getFacilityNo() );         //소속코드
				    session.setAttribute(Globals.FACILITY_NAME        , loginVO.getFacilityName() );         //소속명​

				    session.setAttribute(Globals.DEPT_NM        , loginVO.getDeptNm());         //
				    session.setAttribute(Globals.DEPT_NO        , loginVO.getDeptNo());         //소속명​
				    
				    session.setAttribute(Globals.IP        , usrIP);         //IP

					session.setAttribute(Globals.LOCALE, Locale.getDefault());
					session.setAttribute(Globals.SESSION_MAX_INACTIVE_INTERVAL, Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME);

					session.setMaxInactiveInterval(Integer.parseInt( Globals.SESSION_MAX_INACTIVE_INTERVAL_TIME ) );

				
			    	setSessionSyncInfo( session , pResponse , loginVO.getMemSeq() );

			    	// 세션 관리 Table 에 너무 많은값이 들어가는경우 오류 발생으로 VO 객체는 setSessionSyncInfo 처리 후에 셋팅하도록함.
					loginVO.setSessionMemSeq(loginVO.getMemSeq());
					loginVO.setSessionMemId(loginVO.getMemId());
					loginVO.setSessionMemName(loginVO.getMemName());
					loginVO.setSessionSsoLoginYn("N");
					loginVO.setSessionIp(usrIP);
					session.setAttribute(Globals.SESSION_USER_VO, loginVO);

					commandMap.put("memType", loginVO.getMemType()); // 회원유형 셋팅( 메뉴조회에 사용됨. )
					commandMap.put("authGroupId", loginVO.getAuthGroupId()); // 사용자 그룹 셋팅( 메뉴조회에 사용됨. )
					commandMap.put("menuArea", loginVO.getMenuArea()); // 사용자메뉴영역
					ArrayList<CommbizMenuVO> menuList = commbizMenuService.listMenu(commandMap);
					ArrayList<CommbizMenuVO> mobileMenuList = commbizMenuService.mobilelistMenu(commandMap);
					session.setAttribute(Globals.SESSION_MENU_LIST, menuList);
					session.setAttribute(Globals.SESSION_MM_MENU_LIST, mobileMenuList);
			}
				

			boolean isAdmin = false;
			boolean isLogin = false;

			if( !"Y".equals(loginYn) ){
				String tempLoginPage = "";
				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){

					tempLoginPage = "/la/login/goLmsAdminLogin.do";
				}/*else if(reqUri!= null && reqUri.indexOf("/mm/")>-1){
					tempLoginPage = "/mm/login/goLmsMobileLogin.do";
				}*/else{
					tempLoginPage = Globals.LOGIN_PAGE;
				}

				nextUri = request.getRequestURI().replace( request.getServletPath(), "") + tempLoginPage + "?reqUri=" + reqUri + "&memId=" + memId;
			}else{
				isLogin = true;

				if( null != loginVO && "2016AUTH0000001".equals( loginVO.getAuthGroupId() ) ){
					isAdmin = true;
				}
			}

			session.setAttribute("isAdmin", isAdmin);
			session.setAttribute("isLogin", isLogin);

			logger.debug("#### getRequestURI : "+ request.getRequestURI().replace(request.getServletPath(), ""));


			model.addAttribute("retMsg", retMsg);
			model.addAttribute("nextUri", nextUri);


			logger.debug("#### getRequestURI model : "+ model.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "oklms_blank/commbiz/login/loginProc";
	}

	/**
	 * 세션에 저장된 정보를 모두 암호화 하여 Globals.SESSION_SYNC_ID 이름으로 쿠키에 저장한다.
	 * @param session
	 * @param response
	 * @param dbUsrId
	 * void
	 */
	private void setSessionSyncInfo( HttpSession session, HttpServletResponse response, String dbUsrId ) {
		// TODO Auto-generated method stub

		String loginCheckUserId = "";
		String sessionId = session.getId();

		StringBuffer sessionValue = new StringBuffer();
		for (Enumeration<String> e = session.getAttributeNames(); e.hasMoreElements();) {
			String key = (String) e.nextElement();
			Object value = session.getAttribute(key);

			if( !Globals.SESSION_MENU_LIST.equals(key)
					&& !"org.springframework.web.servlet.support.SessionFlashMapManager.FLASH_MAPS".equals(key) ){

				if (0 < sessionValue.length()) {
					sessionValue.append("||");
				}
				sessionValue.append(key);
				sessionValue.append("##");
				sessionValue.append(value);

				if ("CONNECTION_USER_ID".equals(key)) {
					loginCheckUserId = (String) value;
					sessionId = sessionId + "@|@" + loginCheckUserId;
				}
			}
		}

		String sessionSyncString = "";
		int sessionSnycCookieMaxAge = 0;
		try {
			sessionSnycCookieMaxAge = Integer.parseInt( EgovProperties.getProperty("Globals.sessionSnycCookieMaxAge") ); // (단위 : 초)
//			int maxSessionTime = sessionObj.getMaxInactiveInterval() / 60;
			Map<String, Object> pParamMap = new HashMap<String, Object>();
			pParamMap.put("sessionId", sessionId);
			pParamMap.put("sessionExpirySec", sessionSnycCookieMaxAge ); // (단위 : 초) : DB SYSDATE 시간 기준.
			pParamMap.put("sessionVl", sessionValue.toString());
			pParamMap.put("memId", dbUsrId);

			commBizLoginService.regSessionSync(pParamMap);


//			String key = "new2016@oklms^stat";
			String key = EgovProperties.getProperty("Globals.sessionSnycCookiePw");
			sessionSyncString = SecurityUtil.encryptAes128( key , sessionId );

//			logger.debug("#### key : " + key );
			logger.debug("#### sessionId : " + sessionId );
			logger.debug("#### sessionSyncString : " + sessionSyncString );


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 쿠키를 이용하는 방법 (가장 대중적, 메인 도메인이 같을 때) 로그인하면, 고유의 키를 만들어 쿠키에 저장합니다.
		// 각각의 사이트에서는 쿠키에 담긴 이 키값의 여부로,
		// 로그인 여부를 판단하고 세션을 생성하며 키값에 따른 고유한 사용자 정보를 뽑아와 세션에 저장합니다.
		// 로그아웃시에는 쿠키를 지워줍니다.

		logger.debug("#### Globals.SESSION_SYNC_ID : " + sessionSyncString );


		String sessionSnycCookieDomain = EgovProperties.getProperty("Globals.sessionSnycCookieDomain");
		Cookie cookie = new Cookie(Globals.SESSION_SYNC_ID, sessionSyncString);
		cookie.setDomain(sessionSnycCookieDomain);
		cookie.setPath("/");
//		cookie.setMaxAge(1 * 60 * sessionSnycCookieMaxAge); // (단위 : 초)
		cookie.setMaxAge( session.getMaxInactiveInterval() ); // (단위 : 초)

		response.addCookie(cookie);
	}

	/**
	 * 로그아웃 처리.
	 * @param request
	 * @param pResponse
	 * @param requestParamMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/login/logout.do")
	public String logout(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> requestParamMap, Model model,
			RedirectAttributes redirectAttributes) {

		HttpSession  session = request.getSession(false);
		// SSO 사용여부를 가져옴
		String ssoYn =  EgovProperties.getProperty("Globals.ssoYn");
		
		String adminYn = (String) session.getAttribute(Globals.SESSION_ADMIN_ID);
		
		String nextUrl = "";
		// 관리자였을경우  
		if(adminYn!=null && !adminYn.equals("") && !adminYn.equals((String)session.getAttribute(Globals.MEM_ID)) ){			
			nextUrl = "/commbiz/login/autoAdminLoginProc.do";
		}else
		// SSO 사용일 경우 세션 및 쿠키 삭제는 /sso/logout.jsp 에서 실행
		if("Y".equals(ssoYn)){
			nextUrl = "/sso/logout.jsp";
		} else {

	    	if(session != null){

	    		String memId = (String) session.getAttribute(Globals.CONNECTION_USER_ID);

	    		logger.debug("#### memId : " + memId );

	    		// 세션 동기화처리용 DB Table update
		        HashMap<String, Object> paramMap = new HashMap<String, Object>();
		        paramMap.put("memId", memId );
				try {

					commBizLoginService.delSessionSync(paramMap);

					// 로그인,  로그아웃 기록 ( 시스템에 로그인 및 로그아웃한 내용을 로깅하는 기능 )
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}


				cookieRemove( Globals.SESSION_SYNC_ID , request , response );

				// session 값 초기화
			     String key;
			     Object value;
			     for (Enumeration<String> e = session.getAttributeNames() ; e.hasMoreElements() ;) {
			         key = (String) e.nextElement();
			         value = session.getAttribute(key);
			         session.setAttribute(key, "");
			     }

			     session.invalidate();
	 	    }


			String retCd = "";
			String retMsg = messageSource.getMessage("msg.logout", null,Locale.getDefault());

			redirectAttributes.addFlashAttribute("retCd", retCd );
			redirectAttributes.addFlashAttribute("retMsg", retMsg );

			//String nextUrl = StringUtils.defaultIfBlank( EgovProperties.getProperty("Globals.MainPage") , "/index.jsp");
			nextUrl = "/index.jsp";
		}
    	 
 
		return "redirect:" + nextUrl;
	}
	/**
	 * 로그아웃 처리.
	 * @param request
	 * @param pResponse
	 * @param requestParamMap
	 * @param model
	 * @return
	 * String
	 */
	@RequestMapping(value = "/commbiz/login/mobilelogout.do")
	public String mobilelogout(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> requestParamMap, Model model,
			RedirectAttributes redirectAttributes) {

		// SSO 사용여부를 가져옴
		String ssoYn =  EgovProperties.getProperty("Globals.ssoYn");
		String nextUrl = "";
		// SSO 사용일 경우 세션 및 쿠키 삭제는 /sso/logout.jsp 에서 실행
		if("Y".equals(ssoYn)){
			nextUrl = "/sso/logout.jsp?menuArea=MOBILE";
			//nextUrl = "/mm/main/lmsMainPage.do";
		} else { 
			HttpSession  session = request.getSession(false);
	    	if(session != null){

	    		String memId = (String) session.getAttribute(Globals.CONNECTION_USER_ID);

	    		logger.debug("#### memId : " + memId );

	    		// 세션 동기화처리용 DB Table update
		        HashMap<String, Object> paramMap = new HashMap<String, Object>();
		        paramMap.put("memId", memId );
				try {

					commBizLoginService.delSessionSync(paramMap);

					// 로그인,  로그아웃 기록 ( 시스템에 로그인 및 로그아웃한 내용을 로깅하는 기능 )
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}


				cookieRemove( Globals.SESSION_SYNC_ID , request , response );

				// session 값 초기화
			     String key;
			     Object value;
			     for (Enumeration e = session.getAttributeNames() ; e.hasMoreElements() ;) {
			         key = (String) e.nextElement();
			         value = session.getAttribute(key);
			         session.setAttribute(key, "");
			     }

			     session.invalidate();
	 	    }


			String retCd = "";
			String retMsg = messageSource.getMessage("msg.logout", null,Locale.getDefault());

			redirectAttributes.addFlashAttribute("retCd", retCd );
			redirectAttributes.addFlashAttribute("retMsg", retMsg );
 
			nextUrl = "/mm/main/lmsMainPage.do";
		}
    	 
		return "redirect:" + nextUrl;
	}


	/**
	 * Cooki 정보를 제거한다.
	 * @param syncIdStr
	 * @param request
	 * @param response
	 * void
	 */
	public void cookieRemove( String syncIdStr, HttpServletRequest request, HttpServletResponse response ) {

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(syncIdStr)) {
					cookie.setValue(null);
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}
	}
}
