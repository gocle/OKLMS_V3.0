<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="false"

%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ include file="../common/sso_common.jsp" %>
<%@ include file="../common/sp_const.jsp" %>


<%

HttpSession session = request.getSession();
String eXSignOnUserId = (String) session.getAttribute(SSO_SESSION_NAME);
String ssoUseYn =  EgovProperties.getProperty("Globals.ssoYn");
String sesssionSsoLoginYn = (String) session.getAttribute("SESSION_SSO_LOGIN_YN");

System.out.println("---------------------  eXSignOnUserId : "+eXSignOnUserId);

if("Y".equals(ssoUseYn)){
	if(eXSignOnUserId == null || "".equals(eXSignOnUserId) || SSO_SESSION_ANONYMOUSE.equals(eXSignOnUserId)) {
	   
		if("Y".equals(sesssionSsoLoginYn)){
			
			//		System.out.println("sesssionSsoLoginYn : "+sesssionSsoLoginYn);
			//	 	response.sendRedirect("/commbiz/login/logout.do");
			//		return;
%>
<script>
	window.location.href="/commbiz/login/mobilelogout.do";
</script>
<%

		} else {
			if(SSO_SESSION_ANONYMOUSE.equals(eXSignOnUserId)) {
		        session.removeAttribute(SSO_SESSION_NAME);
		    }
		    java.util.Map paramMap = new java.util.HashMap();
		    paramMap.put(ID_NAME, SP_ID);
		    paramMap.put(AC_NAME, "N");
		    paramMap.put(IFA_NAME, "N");
		        
		    StringBuffer requestUrl = new StringBuffer(request.getRequestURI());
		    String queryStr = request.getQueryString();
		    
		    if(queryStr != null && !"".equals(queryStr.trim())) {
		        requestUrl.append("?");
		        requestUrl.append(queryStr);
		    }
		    //paramMap.put(RELAY_STATE_NAME, requestUrl.toString());
		    paramMap.put(RELAY_STATE_NAME, "/mm/main/lmsMainPage.do");
		    //paramMap.put(RELAY_STATE_NAME, "/commbiz/login/logout.do");
		    
		    String redirectUrl = this.generateUrlWithParam(IDP_URL, AUTH_URL, paramMap);
		    response.sendRedirect(redirectUrl);
		    
		    //return;
		}
		
	} else if(SSO_SESSION_ANONYMOUSE_IDENTIFY.equals(eXSignOnUserId)) {
	    session.setAttribute(SSO_SESSION_NAME, SSO_SESSION_ANONYMOUSE);
	    eXSignOnUserId = (String) session.getAttribute(SSO_SESSION_NAME);
	} else {
		
		String memId = "";
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(eXSignOnUserId);
			memId = jsonObj.get("empno").toString();
		} catch (Exception e) {
			memId = "";
		}
		
		System.out.println("memId : "+memId);
		System.out.println("ssoUseYn : "+ssoUseYn);
		
		if( !"".equals(memId) && "Y".equals(ssoUseYn) ){
			response.sendRedirect("/commbiz/login/ssoLoginProc.do?menuArea=MOBILE");
		} else {
			response.sendRedirect("/mm/login/goLmsMobileLogin.do");
		}
	}
	
}
%>