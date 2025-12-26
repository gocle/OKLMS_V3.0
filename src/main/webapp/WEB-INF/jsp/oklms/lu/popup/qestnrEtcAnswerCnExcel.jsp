<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- 팝업 사이즈 : 가로 최소 500px 이상 설정 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    
		<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<tr>
			<td colspan="5">설문의견보기</td>
		</tr>
		<tr>
			<td>학번</td>
			<td>이름</td>
			<td>보기문항</td>
			<td>의견</td>
			<td>등록일</td>
		</tr>
		</table>
		
		<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${result.memId}</td>
			<td>${result.memName}</td>
			<td>${result.qestnCn}</td>
			<td>${result.etcAnswerCn}</td>
			<td>${result.insertDate}</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td>의견이 없습니다.</td></tr>
		</c:if>
		</table>
	
	</td>
  </tr>
</table>