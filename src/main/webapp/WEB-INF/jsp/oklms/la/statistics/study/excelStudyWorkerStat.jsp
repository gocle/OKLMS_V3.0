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
			<th rowspan="3">학습<br />근로자명</th>
			<th rowspan="3">학과명</th>
			<th rowspan="3">학번</th>
			
			<th rowspan="2" colspan="5">개인정보</th>
			
			<th rowspan="2" colspan="2">상태</th>
			
			<th colspan="4">평가점수</th>
			
			<th rowspan="3">실시구분</th>
			<th rowspan="3">기업명</th>
			<th rowspan="3">OJT분반</th>
			<th rowspan="3">과정명</th>
			<th rowspan="3">과정코드</th>
			<th rowspan="3">회차</th>
			<th rowspan="3">실시연도</th>
			
			
			<th colspan="6" >이수현황(학기별 누적 기준)</th>
			
			<th rowspan="3">훈련시작일</th>
			<th rowspan="3">훈련종료<br />예정일</th>
			
			<th rowspan="3">퇴사일자</th>
			<th rowspan="3">중탈일자</th>			
			<th rowspan="3">자퇴(제적)일자</th>
			
			<th rowspan="2" colspan="4">외부평가</th>
			
			<th rowspan="3">졸업일자</th>
			<th rowspan="3">센터담당자</th>
		</tr>
		<tr>
			<th colspan="2">OJT지도교수</th>
			<th colspan="2">센터전담자</th>
			
			<th colspan="4">교과목 기준</th>
			<th colspan="2" rowspan="2">능력단위 기준</th>
		</tr>
		<tr>
			<th>생년월일</th>
			<th>사무실번호</th>
			<th>핸드폰번호</th>
			<th>이메일</th>
			<th>고용보험<br />가입일자</th>
			
			<th>훈련기준</th>
			<th>학사기준</th>
			
			<th>등급</th>
			<th>특이사항</th>
			<th>등급</th>
			<th>특이사항</th>
			
			<th colspan="2">Off-JT</th>
			<th colspan="2">OJT</th>
			
			<th>필수능력단위(70%)</th>
			<th>훈련이수시간(80%)</th>
			<th>합격여부</th>
			<th>합격일자</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="38"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		<%-- 데이터를 화면에 출력해준다 --%>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">		
		<tr>
			<td><c:out value="${status.count}"/></td>
			<td><c:out value="${resultList.memName}" /></td>
			<td><c:out value="${resultList.deptNm}" /></td>
			<td><c:out value="${resultList.memId}" /></td>
			<td><c:out value="${resultList.memBirth}" /></td>
			<td><c:out value="${resultList.stdCompTelNo}" /></td>
			<td><c:out value="${resultList.hpNo1}" />-<c:out value="${resultList.hpNo2}" />-<c:out value="${resultList.hpNo3}" /></td>
			<td><c:out value="${resultList.email}" /></td>
			<td><c:out value="${resultList.stdGoyongDate }" /></td>
			
			<td><c:choose>
				<c:when test="${resultList.stdStatus eq '1'}">진행중</c:when>
				<c:when test="${resultList.stdStatus eq '2'}">이수</c:when>
				<c:when test="${resultList.stdStatus eq '3'}">수료</c:when>
				<c:when test="${resultList.stdStatus eq '4'}">중탈</c:when>
				<c:when test="${resultList.stdStatus eq '5'}">참여철회</c:when>
				<c:when test="${resultList.stdStatus eq '7'}">훈련중지</c:when>
				<c:when test="${resultList.stdStatus eq '6'}">미이수</c:when>
				<c:otherwise></c:otherwise>
			</c:choose></td>
			
			<td>
			<c:out value="${resultList.sknrgsSttusNm }" />
			<%-- <c:choose>
				<c:when test="${resultList.stdHakStatus eq '1'}">재학</c:when>
				<c:when test="${resultList.stdHakStatus eq '2'}">졸업</c:when>
				<c:when test="${resultList.stdHakStatus eq '3'}">자퇴</c:when>
				<c:when test="${resultList.stdHakStatus eq '4'}">휴학</c:when>
				<c:otherwise></c:otherwise>
			</c:choose> --%>
			</td>
			
			
			<td><c:out value="${resultList.prtGrade }" /></td>
			<td><c:out value="${resultList.prtBigo }" /></td>
			<td><c:out value="${resultList.ccnGrade }" /></td>
			<td><c:out value="${resultList.ccnBigo }" /></td>
			
			<td>
			
			<c:choose>
				<c:when test="${resultList.stdTransferYn eq 'N'}">신입</c:when>
				<c:when test="${resultList.stdTransferYn eq 'Y'}">편입</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
			
			</td>
			<td><c:out value="${resultList.companyName }" /></td>
			
			<td><c:out value="${resultList.ojtClass }" /></td>
			<td><c:out value="${resultList.traningProcessName }" /></td> 
			<td><c:out value="${resultList.traningProcessId }" /></td> 
			<td><c:out value="${resultList.traningProcessPeriod }" /></td> 
			<td><c:out value="${resultList.year }" /></td>
			
			<td style="text-align: center;">${resultList.offGoal}</td>
			<td style="text-align: center;">${resultList.offCompl}</td>
			<td style="text-align: center;">${resultList.ojtGoal}</td>
			<td style="text-align: center;">${resultList.ojtCompl}</td>
			<td style="text-align: center;">${resultList.ncsGoal}</td>
			<td style="text-align: center;">${resultList.ncsCompl}</td>
			
			<td><c:out value="${resultList.startDate }"/></td>
			<td><c:out value="${resultList.endDate }"/></td>
			<td><c:out value="${resultList.stdCompOutDate }"/></td>
			<td><c:out value="${resultList.stdLeaveDate }"/></td>
			
			<td><c:out value="${resultList.extDt }"/></td>
			<td><c:out value="${resultList.outEvalNcsYn }"/></td>
			<td><c:out value="${resultList.outEvalProgressYn }"/></td>
			<td><c:out value="${resultList.outEvalPassYn eq 'Y' ? '합격' : '미합격' }"/></td>
			<td><c:out value="${resultList.outEvalPassDate }"/></td>
			<td><c:out value="${resultList.gradDt }"/></td>
			<td><c:out value="${resultList.ccnNames }"/></td> 
		</tr>
		</c:forEach>
	</tbody>
</table>