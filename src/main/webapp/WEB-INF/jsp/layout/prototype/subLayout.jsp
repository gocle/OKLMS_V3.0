<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">
<% String contextRoot = request.getContextPath(); %>
	<script type="text/javascript">
		//var CONTEXT_ROOT = "<c:url value='/' />"; // Client 에서 ContextRoot 활용
		//var CONTEXT_ROOT = "${pageContext.request.contextPath}";
		var CONTEXT_ROOT = "<%= contextRoot %>";
	</script>


<link href="${contextRoot }/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/oklms/base.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/egovframework/com/main.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/egovframework/com/com.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/egovframework/com/button.css" rel="stylesheet" type="text/css" />

<%-- <%@include file="/includeCss.jsp"%> --%>
<%@include file="/includeJs.jsp"%>

	<script type="text/javascript">

		//Controller에서  전달된 메시지를 출력한다. ( gridUtil.setretMsg 값 )
		$(document).ready(function(){
			if(""!="${retMsg}"){
				
				alert("Layout retMsg [A] : " + "${retMsg}");
			}
		});
	</script>
</head>
<body>
	<!-- Prototype Sub Layout -->
	
<div id="container"><!--블로그 전체 몸통을 감싸는 레이어입니다.-->
  <div id="header">
   1. Header영역
   <tiles:insertAttribute name="header" />
  </div>
  <div id="lnb">
    2-1. MENU
    <tiles:insertAttribute name="left" />
  </div>
  <div id="content">
   2-2.  본문영역
   <tiles:insertAttribute name="body" />
  </div>
  <div id="footer">
    3. Footer영역
   <tiles:insertAttribute name="footer" />
 </div>
</div>	
</body>
</html>