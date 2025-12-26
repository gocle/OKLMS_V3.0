/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 11. 21.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.comm.interceptor;

import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.gocle.oklms.comm.util.UrlConnectUtil;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.menu.vo.CommbizMenuVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.UrlPathHelper;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;

import javax.annotation.Resource;

import kr.co.gocle.oklms.commbiz.config.service.LmsConfigService;
import kr.co.gocle.oklms.commbiz.config.vo.LmsConfigVO;
import kr.co.gocle.oklms.comm.util.CommonUtil;

 /**
 * 사용자 권한 그룹 첵크
 * @author 이진근
 * @since 2016. 11. 21.
 */
public class AuthenticCheckInterceptor extends HandlerInterceptorAdapter {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticCheckInterceptor.class);

	@Resource(name = "lmsConfigService")
	private LmsConfigService lmsConfigService;
	
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다. 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle( HttpServletRequest request, HttpServletResponse response, Object handler ) throws Exception {

		String requestURI = request.getRequestURI(); // 요청 URI

		String strCurrentUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

		UrlPathHelper urlPathHelper = new UrlPathHelper();
		String originalURL = urlPathHelper.getOriginatingRequestUri(request);

		String addParams = "";
		if( StringUtils.isNoneBlank( request.getQueryString() ) ){
			addParams = "?" + request.getQueryString();
		}
//		String addParams = "";
//		// 패턴 첵크 대상 Parameter
//		String bbsId = (String)request.getParameter("bbsId");
//
//		if( StringUtils.isNoneBlank( bbsId ) ){
//			if( 0 == addParams.length() ){
//				addParams = addParams + "?";
//			}else{
//				addParams = addParams + "&";
//			}
//			addParams = addParams + "bbsId=" + bbsId;
//		}

		originalURL = originalURL + addParams;


		LOGGER.debug("");
		LOGGER.debug("#####################################################################################################");
		LOGGER.debug("#### AuthenticInterceptor #### strCurrentUrl : " + strCurrentUrl + " ####");
		LOGGER.info("#### AuthenticInterceptor #### CHECK URI : " + originalURL + " ####");
//		LOGGER.debug("#### AuthenticInterceptor #### requestURI : " + requestURI + " ####");
		LOGGER.debug("#####################################################################################################");
		LOGGER.debug("");

		if( StringUtils.isNoneBlank(originalURL) && ( 0 < originalURL.indexOf(".json") ||  0 < originalURL.indexOf(".jsp") ) ){
			// json 방식은 첵크하지 않는 경우인데 들어오는 경우 호출 메서드에 @ResponseBody 반환 하는지 첵크. ( com-servlet.xml )
			LOGGER.warn("#### *.json is exclude-mapping URL : return Value setting Check!! ( @ResponseBody )");
		}

		StackTraceElement[] stacks = new Throwable().getStackTrace();
		LOGGER.debug( "#### use class/method : " + this.getClass().getName() + " / " + stacks[0].getMethodName() );

		boolean isPermittedURL = false;

		HttpSession session = request.getSession();

//		ArrayList<CommbizMenuVO> menuStructureList = (ArrayList<CommbizMenuVO>) session.getAttribute( Globals.SESSION_MENU_LIST );
		String rootMenuId = StringUtils.defaultIfBlank(request.getParameter("rootMenuId"), (String)request.getAttribute("rootMenuId") );
		String menuId = StringUtils.defaultIfBlank(request.getParameter("menuId"), (String)request.getAttribute("menuId") );
		rootMenuId = StringUtils.defaultIfBlank( rootMenuId , (String)session.getAttribute("rootMenuId") );
		menuId = StringUtils.defaultIfBlank( menuId , (String)session.getAttribute("menuId") );


    	LoginInfo loginInfo = new LoginInfo();
		ArrayList<CommbizMenuVO> menuStructureList = loginInfo.getAuthenticMenuInfo();

		if( 1 == StringUtils.countMatches( originalURL , "/mm/") && loginInfo.getLoginInfo() != null ){
			menuStructureList = loginInfo.getAuthenticMobileMenuInfo();
			//모바일 권한추가
			request.setAttribute("loginAuthGroupId", loginInfo.getLoginInfo().getAuthGroupId()); // 권한 추가
		}

		LOGGER.debug("#### menuStructureList Size : " + menuStructureList.size() );
//		LOGGER.warn("#### must have menuId!! : menuId = " + menuId );


		// menuId 와 호출된 URL 을 이용하여 접근 가능한 URL 인지 식별해준다.
		LOGGER.debug("#### Call!! : UrlConnectUtil.isRequestUrlAble()" );
		CommbizMenuVO menuObj = UrlConnectUtil.isRequestUrlAble( menuStructureList , originalURL );

		if( null != menuObj ){

			LOGGER.debug( "" );
			isPermittedURL = true;

			session.setAttribute("rootMenuId" , menuObj.getRootMenuId() );
			session.setAttribute("menuId" , menuObj.getMenuId() );

			request.setAttribute("rootMenuId" , menuObj.getRootMenuId());

		}

		if(originalURL.indexOf("BBSMSTR_000000000000") == 0 || originalURL.indexOf("BBSMSTR_000000000004") == 0){
			request.setAttribute("loginAuthGroupId", loginInfo.getLoginInfo().getAuthGroupId()); // 권한 추가
		}

		LOGGER.debug( "#### Pattern.matches " + isPermittedURL );
		
		// 관리자 페이지 접근 IP 체크
		if( 1 == StringUtils.countMatches( originalURL , "/la/") ){
			
			LmsConfigVO lmsConfigVO = new LmsConfigVO();
			lmsConfigVO.setConfId("global");
			lmsConfigVO.setOptKey("admin_access_whitelist");
			lmsConfigVO.setSitePrefix("OKLMS");
			lmsConfigVO = lmsConfigService.getUseConfig(lmsConfigVO);
			
			String targetUrl = request.getRequestURI().replace ( request.getServletPath(), "" );
			
			LOGGER.info("*********************** targetUrl=" +targetUrl);
			
			
			String remoteIp = CommonUtil.getRempoteIp(request);
			
			LOGGER.info("*********************** remoteIp=" +remoteIp);
			
			if( lmsConfigVO != null ){
				String retMsg = "접속 불가 IP 입니다.";
				String adminAccessIp = lmsConfigVO.getOptValue();
				
				// 등록 IP가 여러개일 경우
				if( !adminAccessIp.equals("") ){
					boolean isAdminAccess = false;
					String [] adminAccessIpArray = adminAccessIp.split(",");
					targetUrl = "/lu/login/goLmsUserLogin.do";
					
					
					for( int i=0; i < adminAccessIpArray.length; i++ ){
						
						// 패턴으로 체크
						if(adminAccessIpArray[i].indexOf("*") != -1){
							String cutAdminAccessIpArray = adminAccessIpArray[i].substring(0,(adminAccessIpArray[i].indexOf("*")-1));
							if(remoteIp.matches(".*"+cutAdminAccessIpArray+".*")){
								isAdminAccess = true;
								LOGGER.info("#### remoteIp=" + remoteIp );
								LOGGER.info("#### cutAdminAccessIpArray[i] =" + cutAdminAccessIpArray );
								return true;
							}
						} else {
							
							// 패텅이 아닐경우
							if(remoteIp.equals(adminAccessIpArray[i])){
								isAdminAccess = true;
								
								LOGGER.info("#### remoteIp=" + remoteIp );
								LOGGER.info("#### cutAdminAccessIpArray[i] =" + adminAccessIpArray[i] );
								
								return true;
							}
						}
							
					}
					if(!isAdminAccess){
						session.invalidate();
						targetUrl = "/lu/login/goLmsUserLogin.do";
						retMsg = URLEncoder.encode( retMsg ,"UTF-8");
						targetUrl = targetUrl + "?retMsgEncode=" + retMsg;
						response.sendRedirect( targetUrl );
						LOGGER.info("#### targetUrl=" + targetUrl );
						return false;
					}
				}
			}
			
		}
		
		

		if(originalURL.indexOf("BBSMSTR_000000000000") == 0 || originalURL.indexOf("BBSMSTR_000000000004") == 0){
			if (!isPermittedURL && !"2016AUTH0000001".equals( loginInfo.getLoginInfo().getAuthGroupId() ) ) {

				String targetUrl = request.getRequestURI().replace ( request.getServletPath(), "" );
				String retMsg = "권한이 없는 사용자 그룹입니다.(Not Authentic)";

				LoginVO loginVO = loginInfo.getLoginInfo();
				if( null == loginVO ){
					targetUrl = targetUrl + Globals.MAIN_PAGE;
				}else{

					LOGGER.debug("#### loginInfo.getServiceArea('') : " + loginInfo.getServiceArea("") );
					LOGGER.debug("#### loginInfo.getLoginInfo() : " + loginInfo.getLoginInfo() );
					LOGGER.debug("#### loginInfo.getAuthGroupId().getAuthGroupId() : " + loginInfo.getLoginInfo().getAuthGroupId() );

					String serviceArea = loginInfo.getServiceArea("");
					if("la".equals( serviceArea ) ){

						targetUrl = targetUrl + "/la/main/lmsAdminMainPage.do";
					}else if("mm".equals( serviceArea ) ){

						targetUrl = targetUrl + "/mm/main/lmsMainPage.do";
					}else if("lu".equals( serviceArea ) ){

						targetUrl = targetUrl + Globals.MAIN_PAGE;
					}else{
						retMsg = "권한 그룹을 확인하세요.(AccessDenied!!)";
						targetUrl = targetUrl + "/accessDenied.do";
					}


					/*2016AUTH0000001	관리자
					2016AUTH0000002	학습근로자
					2016AUTH0000003	담당교수
					2016AUTH0000004	기업전담자
					2016AUTH0000005	센터전담자
					2016AUTH0000006	학과전담자
					2016AUTH0000007	지도교수
					2016AUTH0000008	기업현장교사*/


//					if("2016AUTH0000001".equals( loginInfo.getLoginInfo().getAuthGroupId() ) ){
//						if( "/la/main/lmsAdminMainPage.do".equals( originalURL ) ){
//							targetUrl = targetUrl + "/accessDenied.do";
//						}else{
//							targetUrl = targetUrl + "/la/main/lmsAdminMainPage.do";
//						}
//					}else if("2016AUTH0000002".equals( loginInfo.getLoginInfo().getAuthGroupId() ) ){
	//
//						if( "/la/main/lmsAdminMainPage.do".equals( originalURL ) ){
//							targetUrl = targetUrl + "/accessDenied.do";
//						}else{
//							targetUrl = targetUrl + "/la/main/lmsAdminMainPage.do";
//						}
//					}else if("2016AUTH0000003".equals( loginInfo.getLoginInfo().getAuthGroupId() ) ){
	//
//						targetUrl = targetUrl + Globals.MAIN_PAGE;
//					}else if("2016AUTH0000004".equals( loginInfo.getLoginInfo().getAuthGroupId() ) ){
	//
//						targetUrl = targetUrl + Globals.MAIN_PAGE;
//					}else{
//						retMsg = "권한 그룹을 확인하세요.(AccessDenied!!)";
//						targetUrl = targetUrl + "/accessDenied.do";
//					}
				}

				retMsg = URLEncoder.encode( retMsg ,"UTF-8");
				targetUrl = targetUrl + "?retMsgEncode=" + retMsg;
				response.sendRedirect( targetUrl );
				LOGGER.info("#### targetUrl=" + targetUrl );
//				//response.encodeRedirectURL(targetUrl);
				return false;
			}
		}

		return true;
	}

}
