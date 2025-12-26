<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>

td {mso-number-format:"@";}

</style> 
<table   width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
<thead>
		<tr>
			<th>성명</th>
			<td>${memberVO.memName}</td>
		</tr>
		<tr>
			<th>학과</th>
			<td>${memberVO.deptNm}</td>
		</tr>
		<tr>
			<th>학번</th>
			<td>${memberVO.memId}</td>
		</tr>
		<tr>
			<th>기업명</th>
			<td>${memberVO.companyName}</td>
		</tr>
</table>
<table   width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
	<thead>
		<tr>
			<th rowspan="4">학년</th>
			<th rowspan="4">해당학기</th>
			<th rowspan="4">교과목명</th>
			<th rowspan="3" colspan="2">능력단위<br />(NCS, 비NCS)</th>
			<th rowspan="2" colspan="4">Off-JT 출석시간(대학)</th>
			<th colspan="6">이수여부</th>
			<th rowspan="4">재수강 여부</th>
		</tr>
		<tr>
			<th colspan="4">Off-JT</th>
			<th rowspan="2" colspan="2">OJT</th>
		</tr>
		<tr>
			<th colspan="2">집체(아우누리)</th>
			<th colspan="2">원격(OK-LMS)</th>
			<th colspan="2">학사</th>
			<th colspan="2">훈련</th>
		</tr>
		<tr>
			<th>능력단위명</th>
			<th>필수여부</th>
			<th>목표</th>
			<th>이수</th>
			<th>목표</th>
			<th>이수</th>
			<th>능력단위</th>
			<th>교과목(학점)</th>
			<th>능력단위</th>
			<th>교과목</th>
			<th>능력단위</th>
			<th>교과목</th>
		</tr>
	</thead>
	<tbody>
			
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td>${result.subjectGrade}학년</td>
									<td>
									${fn:replace(fn:replace(result.yySemstrNm, '-01' , '-1학기' ),'-02','-2학기')}
									</td>
									<td>${result.subjectName}</td>
									<td>${result.ncsUnitName}</td>
									<td>${result.ncsCnt ne '0' ? '필수' : ''}</td>
									<td>${result.offAttGoal}</td>
									<td>${result.offAttCompl}</td>
									<td>${result.onAttGoal}</td>
									<td>${result.onAttCompl}</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OFF'}">
									${result.ncsUnitName}
									 </c:if>
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OFF'}">
									${result.grd}
									</c:if>
									</td>
									<td>${result.passYn}</td>
									<td>${result.grade}</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OJT'}">
									${result.ncsUnitName}
									</c:if>
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OJT'}">
									${result.grd}
									</c:if>
									</td>
									<td>${result.reCorsYn}</td>
								</tr>	
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
								 	<td colspan="16"><spring:message code="common.nodata.msg" /></td>
								</tr>		
							</c:if>	
	</tbody>

</table>