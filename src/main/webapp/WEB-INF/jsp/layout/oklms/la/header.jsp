<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="org.apache.commons.lang3.time.DateUtils" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="kr.co.gocle.oklms.commbiz.util.BizUtil" %>
<%@ page import="kr.co.gocle.oklms.comm.vo.LoginInfo" %>
<%@ page import="egovframework.com.cmm.service.Globals" %>
<%@ page import="egovframework.com.cmm.LoginVO" %>
<%-- <%@ page import="kr.co.gocle.oklms.sys.menu.vo.MenuMngmVO" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- oklms Header -->
<%
LoginInfo loginInfo = new LoginInfo();
String authGroupSet = loginInfo.getAuthGroupId();
%>


<c:set var="SESSION_AUTH_GROUP_SET" value="<%=authGroupSet %>"/>

<script>
	function fn_authChange(selectObject){
		var value = selectObject.value;
		location.href = "/commbiz/auth/authProc.do?authGroupSet="+value;
	}
</script>

<!-- ############### LA Header ############### -->
	<%
	if(loginInfo.isLogin()){
		//String sessionLastLoginDt = loginInfo.getAttribute("SESSION_LAST_LOGIN_DT") + "";
		String sessionLastLoginDt = session.getAttribute(Globals.SESSION_LAST_LOGIN_DT) + ""; // 최종 로그인 시간
		//String sessionLastLoginDt = loginInfo.getLoginInfo().getLasLgnYmd() + "";
		
	%>
	<c:if test="${ empty menuList}">
 					<dl id="top-area"> 
 						<dt class="logo-area"><h1><a href="/la/main/lmsAdminMainPage.do">한국기술교육대학교</a></h1></dt> 
						<dd class="info">
						
						<span>
						
						<select name="authGroupSet" id="authGroupSet" onchange="fn_authChange(this);">
							<c:forEach var="result" items="${authList}" varStatus="status">
								<option value="${result.authGroupSet}" ${result.authGroupSet eq SESSION_AUTH_GROUP_SET ? 'selected' : ''}>${result.authGroupName}</option>
							</c:forEach>
						</select>
						</span>
						<span><%=loginInfo.getUserName() %></span>님 안녕하세요.<span id="session_timer"></span> <a href="/commbiz/login/logout.do" class="logout">로그아웃</a>
					 </dd>
 						
 						<!-- <dd class="bg-1"></dd> -->
<!--  						<dd class="bg-2"></dd>  -->
 					</dl>	 
	</c:if> 					
	<c:if test="${not empty menuList}"> 					
 			<div id="header">
				<h1><a href="/lu/main/lmsUserMainPage.do" title="학습관리통합시스템 온라인교육시스템">학습관리통합시스템</a></h1>
			</div>
 					
 					
			<div id="gnb-pc" class="newgnb-menu-area newgnb-two-depth-area">
				<h2 class="hidden">전체메뉴</h2>
				<div class="newgnb-menu">
					<ul class="gnb-one-depth">
					
						<c:set var="upperMenuNo" value="TOP"/>
						<c:set var="menuLevel" value="1"/>
						<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
						<c:if test="${not empty menuList[key1]}">
							<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
								<!-- S : depth-1 -->
								<li class="sel0${status.count }">
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${0 eq menu1.isLeafMenu}"><a id="hm_a_${menu1.menuId }" href="#" >${menu1.menuTitle }<img src="/images/oklms/std/inc/blank.png" alt="" /></a></c:when> --%>
<%-- 											<c:otherwise><a id="hm_a_${menu1.menuId }" href="#" onclick="javascript:com.subPageMove('${menu1.menuArea }', '${menu1.rootMenuId }', '${menu1.menuId }' , false);">${menu1.menuTitle }<img src="/images/oklms/std/inc/blank.png" alt="" /></a></c:otherwise> --%>
<%-- 										</c:choose> --%>
										<a id="hm_a_${menu1.menuId }" href="#" class="btn-slide" onclick="javascript:com.subPageMove('${menu1.menuArea }', '${menu1.rootMenuId }', '${menu1.menuId }' , false);">${menu1.menuTitle }<img src="/images/oklms/std/inc/blank.png" alt="" /></a>
										<c:set var="key2" value="${ menu1.menuId}_${menu1.menuLevel+1}"/>
										<c:choose>
											<c:when test="${not empty menuList[key2]}">
											<div class="list0${status.count } sell">
												<ul>
												<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
													<!-- S : depth-2 -->
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${0 eq menu2.isLeafMenu}"><li><a id="hm_a_${menu2.menuId }" href="#" >${menu2.menuTitle }</a></li></c:when> --%>
<%-- 														<c:otherwise><li><a id="hm_a_${menu2.menuId }" href="#" onclick="javascript:com.subPageMove('${menu2.menuArea }', '${menu2.rootMenuId }', '${menu2.menuId }' , false);">${menu2.menuTitle }</a></li></c:otherwise> --%>
<%-- 													</c:choose> --%>
														<li><a id="hm_a_${menu2.menuId }" href="#" onclick="javascript:com.subPageMove('${menu2.menuArea }', '${menu2.rootMenuId }', '${menu2.menuId }' , false);">${menu2.menuTitle }</a></li>
												</c:forEach>
												</ul>
											</div>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
								</li>
								
							</c:forEach>
						</c:if>
					
					</ul>
				</div>
			</div><!-- gnb -->
	</c:if>
	<%}else{ %>
					<dl id="top-area">
						<dt><span>ADMIN</span> mode</dt>
						<dd class="info"><a href="/lu/login/goLmsUserLogin.do"></a></dd>
<!-- 						<dd class="bg-1"></dd> -->
<!-- 						<dd class="bg-2"></dd> -->
					</dl>			  
	<%} %>
<script type="text/javascript">
var iSecond; //초단위로 환산

var timerchecker = null;

window.onload = function() {
    fncClearTime();
    initTimer();
}

function fncClearTime() {
    //iSecond = 14400;
    iSecond = 7200;
}

Lpad = function(str, len) {
    str = str + "";
    while (str.length < len) {
        str = "0" + str;
    }
    return str;

}

initTimer = function() {
    var timer = document.getElementById("session_timer");

    rHour = parseInt(iSecond / 3600);
    rHour = rHour % 60;
    rMinute = parseInt(iSecond / 60);
    rMinute = rMinute % 60;
    rSecond = iSecond % 60;

    if (iSecond > 0) {
        timer.innerHTML = "&nbsp;" + Lpad(rHour, 2) + " : " + Lpad(rMinute, 2)

                + " : " + Lpad(rSecond, 2);
        iSecond--;
        timerchecker = setTimeout("initTimer()", 1000); // 1초 간격으로 체크
    } else {
    	logoutUser();
    }
}

/* function refreshTimer() {
    var xhr = initAjax();
    xhr.open("POST", "/jsp_std/kor/util/window_reload2.jsp", false);
    xhr.send();
    fncClearTime();
}
 */
function logoutUser() {
    location.href="/commbiz/login/logout.do";
}
 
 var doubleSubmitFlag = false;
 function doubleSubmitCheck(){
     if(doubleSubmitFlag){
         return doubleSubmitFlag;
     }else{
         doubleSubmitFlag = true;
         return false;
     }
 }




/* function initAjax() { // 브라우저에 따른 AjaxObject 인스턴스 분기 처리
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
}

function fileValidation(name){
	var fileName = name.substring(name.lastIndexOf('.')+1).toUpperCase();
	//alert(fileName);
	var isValid;
	if ( (/DOC/i).test(fileName ) 
        || (/DOCX/i).test(fileName ) 
        || (/GIF/i).test(fileName ) 
        || (/HWP/i).test(fileName ) 
        || (/JPEG/i).test(fileName ) 
        || (/JPG/i).test(fileName ) 
        || (/PNG/i).test(fileName ) 
        || (/PDF/i).test(fileName ) 
        || (/PPT/i).test(fileName ) 
        || (/PPTX/i).test(fileName ) 
        || (/TXT/i).test(fileName ) 
	    || (/XLS/i).test(fileName ) 
	    || (/ZIP/i).test(fileName ) 
	    || (/XLSX/i).test(fileName ) 
	    || (/MP3/i).test(fileName ) 
	    || (/MP4/i).test(fileName ) 
	    || (/M4A/i).test(fileName ) 
	    || (/WAV/i).test(fileName ) 
	    || (/WMA/i).test(fileName ) 
	    || (/FLAC/i).test(fileName ) 
	    || (/OGG/i).test(fileName ) 
	    || (/AAC/i).test(fileName ) 
            ) {
                isValid = true;
            } else {
            	// Message.FILE_CHECK  : message.js
				var message = "파일 업로드는\n\nDOC,DOCX,GIF,HWP,JPEG,\nJPG,PNG,PDF,PPT,PPTX,\nTXT,XLS,ZIP,XLSX,MP3,\nMP4,M4A,WAV,WMA,\nFLAC,OGG,AAC\n\n확장자만 가능합니다.";
                alert(message);
                isValid = false;
            }
	//alert(isValid);
	return isValid;
	
}

 */
</script>
<!-- ############### // LA Header ############### -->