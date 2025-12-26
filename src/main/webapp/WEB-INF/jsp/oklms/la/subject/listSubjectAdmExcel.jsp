<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style type="text/css">
</style>


<table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
	<thead>
		<tr>
			<th width="4%">학년도</th>
			<th width="4%">학기</th>
			<th>교과명</th>
			<th width="10%">교과코드</th>
			<th width="3%">분반</th>
			<th width="5%">교과형태</th>
			<th width="5%">교과구분</th>
			<th width="10%">학과</th>
			<th width="5%">학점여부</th>
			<th width="5%">온라인형태</th>
			<th width="10%">훈련과정</th>
			<th width="5%">교수</th>
			<th width="10%">학과전담자</th>
			<th width="10%">기업현장교사</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${result.yyyy}</td>
			<td>${result.termName}</td>
			<td>${result.subjectName}</td>
			<td>${result.subjectCode}</td>
			<td>${result.subjectClass}</td>
			<td>${result.subjectTraningTypeName}</td>
			<td>${result.subjectTypeName}</td>
			<td>${result.departmentName}</td>
			<td>${result.pointUseYn eq 'Y' ? '학점형' : '비학점'}</td>
			<td>${result.onlineTypeName}</td>
			<td>
			<c:if test="${result.subjectTraningType eq 'OJT'}">
			${result.traningProcessName}
			</c:if>
			</td>
			<td>${result.insNames}</td>
			<td>${result.cdpName}</td>
			<td>${result.tutNames}</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td colspan="14"><spring:message code="common.nodata.msg" /></td>
		</tr>
		</c:if>
	</tbody>
</table><!-- E : list -->

					

	