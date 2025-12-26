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
			<th rowspan="3">구분</th>
			<th rowspan="3">학과명</th>
			<th rowspan="3">훈련실시연도</th>
			<th rowspan="3">실시구분</th>			
			<th colspan="15">운영결과</th>			
		</tr>
		 <tr>
		 	<th rowspan="2">편제정원</th>
		 	<th rowspan="2">훈련총인원</th>
		 	<th rowspan="2">훈련실시인원</th>
		 	
		 	<th colspan="2">참여철회</th>
		 	<th rowspan="2">훈련중인원</th>
		 	<th colspan="2">중탈</th>
		 	<th colspan="2">미이수</th>
		 	<th colspan="2">이수</th>
		 	<th colspan="2">수료</th>
		 	<th rowspan="2">재학인원</th>
		 </tr>
		 
		<tr>
			<th>인원</th>
			<th>철회율</th>
			<th>인원</th>
			<th>중탈율</th>
			<th>인원</th>
			<th>미이수율</th>
			<th>인원</th>
			<th>이수율</th>
			<th>인원</th>
			<th>수료율</th>
		</tr>
	</thead>
	<tbody>
 
		<c:forEach items="${resultList}" var="resultList" varStatus="status">		
			<tr>
				<td><c:if test="${resultList.mstYn eq 'Y'}">고숙련마이스터과정</c:if><c:if test="${resultList.mstYn eq 'N'}">대학연계형</c:if></td>
				<td><c:out value="${resultList.deptName}" /></td>
				<td><c:out value="${resultList.yyyy}" /></td>
				<td><c:out value="${resultList.deptTransferNm}" /></td>
				<td><c:out value="${resultList.formationTotal}" /></td>
				<td><c:out value="${resultList.trainingTotal}" /></td>
				<td><c:out value="${resultList.trainingActionTotal}" /></td>
				<td><c:out value="${resultList.recantTotal}" /></td>
				<td><c:out value="${resultList.recantRatio}" /></td>
				<td><c:out value="${resultList.trainingRealTotal}" /></td>
				<td><c:out value="${resultList.failTotal}" /></td>
				<td><c:out value="${resultList.failRatio}" /></td>
				<td><c:out value="${resultList.notFinishTotal}" /></td>
				<td><c:out value="${resultList.notFinishRatio}" />%</td>
				<td><c:out value="${resultList.finishTotal}" /></td>
				<td><c:out value="${resultList.finishRatio}" /></td>
				<td><c:out value="${resultList.completeTotal}" /></td>
				<td><c:out value="${resultList.completeRatio}" />%</td>
				<td><c:out value="${resultList.skTotal}" /></td>
			</tr>

		</c:forEach>
		
	</tbody>

</table>