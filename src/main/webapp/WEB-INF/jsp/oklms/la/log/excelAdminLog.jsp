<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
    String excelName = (String)request.getAttribute("ExcelName");
    if(excelName == null){
        excelName = "관리자로그";
    }
    response.setHeader(
        "Content-Disposition",
        "attachment; filename=\"" + excelName + ".xls\""
    );
%>

<html>
<head>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8" />
<style>
    td, th {
        border: 1px solid #000000;
        mso-number-format:"\@"; /* 문자열로 처리 */
    }
    th {
        background-color: #f0f0f0;
        font-weight: bold;
        text-align: center;
    }
</style>
</head>

<body>
<table>
    <thead>
        <tr>
            <th>번호</th>
            <th>회원아이디</th>
            <th>접속시간</th>
            <th>아이피</th>
            <th>OS</th>
            <th>브라우저</th>
            <th>메뉴ID</th>
            <th>작업종류</th>
            <th>작업URL</th>
            <th>접속헤더정보</th>
        </tr>
    </thead>

    <tbody>
        <c:if test="${fn:length(resultList) == 0}">
            <tr>
                <td colspan="9">데이터가 없습니다.</td>
            </tr>
        </c:if>

        <c:forEach items="${resultList}" var="resultInfo">
            <tr>
                <td><c:out value="${resultInfo.logSeq}" /></td>
                <td><c:out value="${resultInfo.memId}" /></td>
                <td><c:out value="${resultInfo.loginDate}" /></td>
                <td><c:out value="${resultInfo.clientIp}" /></td>
                <td><c:out value="${resultInfo.clientOs}" /></td>
                <td><c:out value="${resultInfo.clientBrowser}" /></td>
                <td><c:out value="${resultInfo.menuId}" /></td>
                <td><c:out value="${resultInfo.workType}" /></td>
                <td><c:out value="${resultInfo.workUrl}" /></td>
                <td>
                    <c:out value="${resultInfo.workText}" />
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>