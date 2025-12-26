<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Prototype</title>
	
<% String contextRoot = request.getContextPath(); %>
	<script type="text/javascript">
		//var CONTEXT_ROOT = "<c:url value='/' />"; // Client 에서 ContextRoot 활용
		//var CONTEXT_ROOT = "${pageContext.request.contextPath}";
		var CONTEXT_ROOT = "<%= contextRoot %>";
	</script>
<%@include file="/includeCss.jsp"%>
<%@include file="/includeJs.jsp"%>

<link href="${contextRoot }/css/oklms/base.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/egovframework/com/main.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/egovframework/com/com.css" rel="stylesheet" type="text/css" />
<link href="${contextRoot }/css/egovframework/com/button.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<!-- Prototype Popup Layout -->
	<tiles:insertAttribute name="body" />
</body>
</html>
