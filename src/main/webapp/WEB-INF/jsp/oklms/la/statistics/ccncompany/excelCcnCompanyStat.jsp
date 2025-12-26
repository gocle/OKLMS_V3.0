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
			<th rowspan="3">연번</th>
			<th rowspan="3">성명</th>
			<th rowspan="3">기업명</th>
			
			<th rowspan="2" colspan="2">구분</th>
			
			<th rowspan="3">직위</th>
			<th rowspan="3">입사일자</th>
			<th rowspan="3">재직여부</th>
			
			<th colspan="5">전담자연수<br />수료 여부</th>
			
			<th rowspan="2" colspan="3">기업현장<br />교사 조건</th>
			
			<th rowspan="3">사무실<br />번호</th>
			<th rowspan="3">핸드폰번호</th>
			<th rowspan="3">이메일</th>
			
		</tr>
		<tr>
			<th rowspan="2">HRD담당자</th>
			<th colspan="3">기업현장교사</th>
			<th rowspan="2">증빙제출</th>			
		</tr>		
		
		<tr>
			<th>HRD담당자</th>
			<th>기업현장교사</th>
			<th>단기(온라인)</th>
			<th>기본</th>
			<th>심화</th>
			<th>경력</th>
			<th>학력</th>
			<th>자격</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="19"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		<%-- 데이터를 화면에 출력해준다 --%>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">		
		<tr>
			<td><c:out value="${status.count}"/></td>
			<td><c:out value="${resultList.memName}" /></td>
			<td><c:out value="${resultList.companyName}" /></td>
			<td><c:if test="${resultList.memType eq 'CCM' }">O</c:if></td>
			<td><c:if test="${resultList.memType eq 'COT' }">O</c:if></td>
			<td><c:out value="${resultList.title}" /></td>
			<td><c:out value="${resultList.compJoinDay}" /></td>
			<td>
				<c:if test="${resultList.compStatusCd eq '1' }">재직</c:if>
				<c:if test="${resultList.compStatusCd eq '2' }">휴직</c:if>
				<c:if test="${resultList.compStatusCd eq '3' }">퇴직</c:if>
			</td>
			<td><c:out value="${resultList.hrdNames}" /></td>
			<td><c:if test="${resultList.compLicenceCd eq '1' }">O</c:if></td>
			<td><c:if test="${resultList.compLicenceCd eq '2' }">O</c:if></td>
			<td><c:if test="${resultList.compLicenceCd eq '3' }">O</c:if></td>
			<td><c:if test="${not empty resultList.atchFileId }">O</c:if></td>
			<td><c:out value="${resultList.compCareerYear}" /></td>
			<td>
				<c:if test="${resultList.compEduLevelCd eq '1' }">고등학교졸업</c:if>
				<c:if test="${resultList.compEduLevelCd eq '2' }">대학교졸업(2,3년)</c:if>
				<c:if test="${resultList.compEduLevelCd eq '3' }">대학교졸업(4년)</c:if>
				<c:if test="${resultList.compEduLevelCd eq '4' }">석사졸업</c:if>
				<c:if test="${resultList.compEduLevelCd eq '5' }">박사졸업</c:if>
			</td>
			<td><c:out value="${resultList.compLicenceNm}" /></td>
			
			<td><c:out value="${resultList.compTelNo}" /></td>
			<td><c:out value="${resultList.hpNo}" /></td>
			<td><c:out value="${resultList.email}" /></td>
		</tr>		
		</c:forEach>
		
	</tbody>
</table>