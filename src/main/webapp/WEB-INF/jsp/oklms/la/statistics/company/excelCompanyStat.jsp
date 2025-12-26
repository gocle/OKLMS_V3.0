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
			<th rowspan="3">기업명</th>
			<th rowspan="3">기업코드</th>
			<th rowspan="3">센터담당자</th>
			<th rowspan="3">홈페이지</th>
			<th rowspan="3">훈련참여상태</th>
			<th rowspan="3">기업상태</th>
			<th rowspan="3">관할 지부지사</th>
			
			<th colspan="${fn:length(deptCodeList)}" rowspan="2" >참여학과</th>
			<th colspan="7">타기관참여현황</th>
						
			<th rowspan="3">사업자등록번호</th>
			<th rowspan="3">고용보험관리번호</th>
			<th rowspan="3">대표자명</th>
			<th rowspan="3">업종</th>
			
			<th rowspan="3">상시근로자 수</th>
			<th rowspan="3">설립일자</th>
			<th colspan="2" rowspan="2" >주소</th>
			<th colspan="5" rowspan="2" >담당자</th>
			
			<th rowspan="3">신용등급</th>		
			<th rowspan="3">자산총계</th>
			<th rowspan="3">부채총계</th>
			<th rowspan="3">자본총계</th>
			<th rowspan="3">매출액</th>
			<th rowspan="3">영업이익</th>
			<th rowspan="3">당기순이익</th>
			<th rowspan="3">평가일자</th>
			<th rowspan="3">조회기관</th>
			
		</tr>
		<tr>
			<th colspan="3" >재학생단계</th>
			<th colspan="4" >재직자단계</th>
		</tr>
		<tr>
		
		 
		<c:forEach items="${deptCodeList}" var="deptCodeList" varStatus="status">
			<th>${deptCodeList.codeName}</th>
		</c:forEach>
			 
			<th>도제(참여기관명)</th>
			<th>Uni-Tech(참여기관명)</th>
			<th>IPP(참여기관명)</th>
			<th>단독기업형</th>
			<th>대학연계형(참여기관명)</th>
			<th>P-Tech(참여기관명)</th>
			<th>고숙련마이스터(참여기관명)</th>
			
			
			<th>시,군,구</th>
			<th>세부주소</th>
			
			<th>성명</th>
			<th>이메일</th>
			<th>사무실전화</th>
			<th>핸드폰</th>
			<th>팩스</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<tr>
				<td><c:out value="${status.count}"/></td>
				<td><c:out value="${resultList.companyName}" /></td>
				<td><c:out value="${resultList.companyId}" /></td>
				<td><c:out value="${resultList.ccnNames}" /></td>
				<td><c:out value="${resultList.homepageUrl}" /></td>
				<td>
				<c:choose>
					<c:when test="${resultList.traningStatusCd eq '1'}">진행중</c:when>
					<c:when test="${resultList.traningStatusCd eq '2'}">참여대기</c:when>
					<c:when test="${resultList.traningStatusCd eq '3'}">참여포기</c:when>
				</c:choose>
				</td>
				<td>
				<c:choose>
					<c:when test="${resultList.companyStatusCd eq '1'}">정상</c:when>
					<c:when test="${resultList.companyStatusCd eq '2'}">폐업</c:when>
					<c:when test="${resultList.companyStatusCd eq '3'}">합병</c:when>
				</c:choose>
				</td>
				<td><c:out value="${resultList.controlPlaceName}" /></td>
				
				<td><c:if test="${resultList.departmentA eq '1'}">O</c:if></td>
				<td><c:if test="${resultList.departmentB eq '1'}">O</c:if></td>				
				<td><c:if test="${resultList.departmentC eq '1'}">O</c:if></td>
				<td><c:if test="${resultList.departmentD eq '1'}">O</c:if></td>
				<td><c:if test="${resultList.departmentE eq '1'}">O</c:if></td>
				
				<td><c:out value="${resultList.stuLevelName1}" /></td>
				<td><c:out value="${resultList.stuLevelName2}" /></td>
				<td><c:out value="${resultList.stuLevelName3}" /></td>
				<td><c:out value="${resultList.compLevelName1}" /></td>
				<td><c:out value="${resultList.compLevelName2}" /></td>
				<td><c:out value="${resultList.compLevelName3}" /></td>
				<td><c:out value="${resultList.compLevelName4}" /></td>
				
				
				<td><c:out value="${resultList.companyNo}" /></td>
				<td><c:out value="${resultList.employInsManageNo}" /></td>
				<td><c:out value="${resultList.ceo}" /></td>
				<td><c:out value="${resultList.smailBusinessType}" /></td>
				<td><c:out value="${resultList.regularEmploymentCnt}" /></td>
				<td><c:out value="${resultList.makeDay}" /></td>
				
				<td><c:out value="${resultList.address}" /></td>
				<td><c:out value="${resultList.addressDtl}" /></td>
				<td><c:out value="${resultList.name}" /></td>
				
				
				
				<td><c:out value="${resultList.email}" /></td>
				<td><c:if test="${not empty resultList.telNo1 }"><c:out value="${resultList.telNo1}" />-<c:out value="${resultList.telNo2}" />-<c:out value="${resultList.telNo3}" /></c:if></td>
				<td><c:if test="${not empty resultList.hpNo1 }"><c:out value="${resultList.hpNo1}" />-<c:out value="${resultList.hpNo2}" />-<c:out value="${resultList.hpNo3}" /></c:if></td>
				<td><c:if test="${not empty resultList.faxNo1 }"><c:out value="${resultList.faxNo1}" />-<c:out value="${resultList.faxNo2}" />-<c:out value="${resultList.faxNo3}" /></c:if></td>
				<td><c:out value="${resultList.creditLevel}" /></td>
				<td><c:out value="${resultList.assets}" /></td>
				<td><c:out value="${resultList.liabilities}" /></td>
				<td><c:out value="${resultList.equities}" /></td>
				<td><c:out value="${resultList.revenue}" /></td>
				<td><c:out value="${resultList.operatingIncome}" /></td>
				
				
				
				<td><c:out value="${resultList.netIncome}" /></td>
				<td><c:out value="${resultList.evalDay}" /></td>
				<td><c:out value="${resultList.searchPlaceName}" /></td>
		 
			</tr>
		</c:forEach>
	</tbody>
</table>