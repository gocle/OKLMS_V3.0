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
			<th rowspan="4">연번</th>
			<th rowspan="4">과목명</th>
			<th rowspan="4">교과목코드</th>
			<th rowspan="4">과목구분</th>
			<th rowspan="4">과목유형</th>
			<th rowspan="2" colspan="3">OJT 교과목 관리</th>
			<th rowspan="4">담당교수</th>
			<th rowspan="2" colspan="3">강의시간</th>
			<th rowspan="4">학점</th>
			
			<th rowspan="4">수강인원</th>
			<th rowspan="4">학과</th>
			<th rowspan="4">학년</th>
			<th rowspan="4">개설학기</th>
			
			<th colspan="3">능력단위</th>
		</tr>
		
		<tr>
			<th colspan="2" rowspan="2">NCS</th>
			<th rowspan="3">비NCS</th>
		</tr>
		
		<tr>
			<th rowspan="2" >분반</th>
			<th rowspan="2" >과정명</th>
			<th rowspan="2" >기업명</th>
			
			<th rowspan="2" >합계</th>
			<th rowspan="2" >집체</th>
			<th rowspan="2" >온라인</th>
			
			<!-- th colspan="2">1</th>
			<th colspan="2">2</th>
			<th colspan="2">3</th-->
		</tr>
		<tr>
			<th>능력단위명</th>
			<th>필수여부</th>
			<!--th>능력단위명</th>
			<th>필수여부</th>
			<th>능력단위명</th>
			<th>필수여부</th--> 
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="17"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		<%-- 데이터를 화면에 출력해준다 --%>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">	
		
		<tr>
			<td><c:out value="${totalCount-((pageIndex-1) * pageSize + status.count)+1}"/></td>
			<td><c:out value="${resultList.subjectName}" /></td>
			<td><c:out value="${resultList.subjectCode}" /></td>
			<td><c:out value="${resultList.subjectTraningTypeName}" /></td>
			<td><c:out value="${resultList.onlineTypeName}" /></td>
			<td><c:out value="${resultList.subjectClass}" /></td>
			<td>
			<c:if test="${resultList.subjectTraningTypeName eq 'OJT'}">
			<c:out value="${resultList.traningProcessName}" />
			</c:if>
			</td>
			<td><c:out value="${resultList.companyName}" /></td>
			<td><c:out value="${resultList.insNames}" /></td>
			<td><c:out value="${resultList.traningHour}" /></td>
			<td></td>
			<td></td>
			<td><c:out value="${resultList.point}" /></td>
			<td><c:out value="${resultList.studyCnt}" /></td>
			<td><c:out value="${resultList.departmentName}" /></td>
			<td><c:out value="${resultList.grade}" /></td>
			<td><c:out value="${resultList.yyyy}" />-<c:out value="${resultList.term}" /></td>
			<td><c:out value="${resultList.ncsUnit}" /></td>
			<td>    </td>
			
			<!--td></td>
			<td></td>
			<td></td>
			<td></td-->
			<td><c:out value="${resultList.subjectNcsName }" /></td>
		</tr>
		
		</c:forEach>
		
	</tbody>

</table>