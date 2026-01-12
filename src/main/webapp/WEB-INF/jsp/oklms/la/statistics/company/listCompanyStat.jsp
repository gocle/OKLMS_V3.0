<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="targetUrl" value="/la/statistics/company/" />
<script type="text/javaScript" language="javascript">
	/* ********************************************************
	 * 페이징 처리 함수
	 ******************************************************* */
	var targetUrl = "${targetUrl}";
	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보
	$(document).ready(function() {

		if ('' == pageSize) {
			pageSize = 10;
		}
		if ('' == totalCount) {
			totalCount = 0;
		}
		if ('' == pageIndex) {
			pageIndex = 1;
		} 
		loadPage();
	});

	/*====================================================================
	화면 초기화 
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {

		//     com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
 
	}

	/*====================================================================
	 사용자 정의 함수 
	 ====================================================================*/
	function press(event) {
		if (event.keyCode == 13) {
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search(param1) {

		$("#pageIndex").val(param1);
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyStat.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}

	function fn_LoginLogManage() { 
		fn_search(pageIndex);
	}
	
	function fn_calendarClear(Obj) {
		document.getElementById(Obj).value="";
	}
	
	//엑셀 다운로드 ddd
	function fn_exclDownload(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyStatExcelDownload.do";
		$("#pageIndex").val("1");
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").attr("target","_self");
		$("#frmCompany").submit();
	}
	
</script>
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
	기능을 사용하실 수 없습니다.</noscript>
<form name="frmCompany" id="frmCompany" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />  
	<!-- E : search-list-1 (검색조건 영역) -->
	<ul class="search-list-1">
		<li><span>센터담당자</span> 
			<input type="text" id="searchKeyword" name="searchKeyword" style="width: 300px;" value="${companyVO.searchKeyword }" />
		</li>
		<li><span>훈련참여상태</span> 
			<select name="traningStatusCd" id ="traningStatusCd">			
				<option value="">전체</option>
				<option value="1" <c:if test="${companyVO.traningStatusCd eq '1' }" >selected</c:if> >진행중</option>
				<option value="2" <c:if test="${companyVO.traningStatusCd eq '2' }" >selected</c:if> >참여대기</option>
				<option value="3" <c:if test="${companyVO.traningStatusCd eq '3' }" >selected</c:if> >참여포기</option>
			</select>
		</li> 		
		<li><span>기업상태</span> 
			<select name="companyStatusCd" id ="companyStatusCd">			
				<option value="">전체</option>
				<option value="1" <c:if test="${companyVO.companyStatusCd eq '1' }" >selected</c:if>>정상</option>
				<option value="2" <c:if test="${companyVO.companyStatusCd eq '2' }" >selected</c:if>>폐업</option>
				<option value="3" <c:if test="${companyVO.companyStatusCd eq '3' }" >selected</c:if>>합병</option>
			</select>
		</li> 
	</ul>
</form>
<!-- E : search-list-1 (검색조건 영역) -->
<div class="search-btn-area">
	<a href="#@" onclick="fn_LoginLogManage(); return false;">조회</a>
</div>
<ul class="board-info">
	<li class="info-area"><span>전체</span> : <c:out value="${paginationInfo.totalRecordCount }" /> 건</li>
	<li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>

 

<div class="table-responsive">
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th rowspan="3">연번</th>
			<th rowspan="3"">기업명</th>
			<th rowspan="3">센터<br/>담당자</th>
			<th rowspan="3">홈페이지</th>
			<th rowspan="3">훈련참여<Br/>상태</th>
			<th rowspan="3">기업<br/>상태</th>
			<th rowspan="3">관할<br/>지부지사</th>
			
			<th colspan="${fn:length(deptCodeList)}" rowspan="2" >참여학과</th>
			<th colspan="7">일학습병행 참여 현황</th>
						
			<th rowspan="3">사업자등록번호</th>
			<th rowspan="3">고용보험관리번호</th>
			<th rowspan="3">대표자명</th>
			<th rowspan="3">업종</th>
			
			<th rowspan="3">상시<br/>근로자 수</th>
			<!-- <th rowspan="3">설립일자</th> -->
			<th colspan="3" rowspan="2" >주소</th>
			<th colspan="4" rowspan="2" >담당자</th>
			
			<th rowspan="3">신용<br/>등급</th>		
			<!-- <th rowspan="3">자산총계</th>
			<th rowspan="3">부채총계</th>
			<th rowspan="3">자본총계</th>
			<th rowspan="3">매출액</th>
			<th rowspan="3">영업이익</th>
			<th rowspan="3">당기순이익</th>
			<th rowspan="3">평가일자</th>
			<th rowspan="3">조회기관</th> -->
			
		</tr>
		<tr>
			<th rowspan="2">단독기업형</th>
			<th colspan="3" >재학생단계</th>
			<th colspan="3" >재직자단계</th>
		</tr>
		<tr>
		
		 
		<c:forEach items="${deptCodeList}" var="deptCodeList" varStatus="status">
			<th>${deptCodeList.codeName}</th>
		</c:forEach>
			
			<th>도제</th>
			<th>Uni-Tech</th>
			<th>IPP</th>
			<th>대학연계형</th>
			<th>P-Tech</th>
			<th>고숙련마이스터</th>
			

			<th>도</th>
			<th>시,군,구</th>
			<th>세부주소</th>
			
			<th>성명</th>
			<th>이메일</th>
			<th>사무실전화</th>
			<th>핸드폰</th>
			<!-- <th>팩스</th> -->
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="43"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		<%-- 데이터를 화면에 출력해준다 --%>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<tr>
				<td><c:out value="${totalCount-((pageIndex-1) * pageSize + status.count)+1}"/></td>
				<td class="space-nowrap"><c:out value="${resultList.companyName}" /></td>
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
				<td><c:if test="${resultList.departmentF eq '1'}">O</c:if></td>
				<td><c:if test="${resultList.departmentG eq '1'}">O</c:if></td>
				<td><c:if test="${resultList.departmentH eq '1'}">O</c:if></td>
				<td><c:if test="${resultList.departmentI eq '1'}">O</c:if></td>
				
				<td><c:out value="${resultList.compLevelName1}" /></td>
				<td><c:out value="${resultList.stuLevelName1}" /></td>
				<td><c:out value="${resultList.stuLevelName2}" /></td>
				<td><c:out value="${resultList.stuLevelName3}" /></td>
				<td><c:out value="${resultList.compLevelName2}" /></td>
				<td><c:out value="${resultList.compLevelName3}" /></td>
				<td><c:out value="${resultList.compLevelName4}" /></td>
				
				
				<td><c:out value="${resultList.companyNo}" /></td>
				<td><c:out value="${resultList.employInsManageNo}" /></td>
				<td><c:out value="${resultList.ceo}" /></td>
				<td><c:out value="${resultList.smailBusinessType}" /></td>
				<td><c:out value="${resultList.regularEmploymentCnt}" /></td>
				<%-- <td><c:out value="${resultList.makeDay}" /></td> --%>
				
				<td>경기도</td>
				<td><c:out value="${resultList.address}" /></td>
				<td class="space-nowrap"><c:out value="${resultList.addressDtl}" /></td>
				<td><c:out value="${resultList.name}" /></td>
				
				
				
				<td class="space-nowrap"><c:out value="${resultList.email}" /></td>
				<td class="space-nowrap"><c:if test="${not empty resultList.telNo1 }"><c:out value="${resultList.telNo1}" />-<c:out value="${resultList.telNo2}" />-<c:out value="${resultList.telNo3}" /></c:if></td>
				<td class="space-nowrap"><c:if test="${not empty resultList.hpNo1 }"><c:out value="${resultList.hpNo1}" />-<c:out value="${resultList.hpNo2}" />-<c:out value="${resultList.hpNo3}" /></c:if></td>
				<%-- <td class="space-nowrap"><c:if test="${not empty resultList.faxNo1 }"><c:out value="${resultList.faxNo1}" />-<c:out value="${resultList.faxNo2}" />-<c:out value="${resultList.faxNo3}" /></c:if></td> --%>
				<td><c:out value="${resultList.creditLevel}" /></td>
<%-- 				<td><c:out value="${resultList.assets}" /></td>
				<td><c:out value="${resultList.liabilities}" /></td>
				<td><c:out value="${resultList.equities}" /></td>
				<td><c:out value="${resultList.revenue}" /></td>
				<td><c:out value="${resultList.operatingIncome}" /></td>
				
				
				
				<td><c:out value="${resultList.netIncome}" /></td>
				<td><c:out value="${resultList.evalDay}" /></td>
				<td><c:out value="${resultList.searchPlaceName}" /></td> --%>
		 
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<!-- E : list (게시판 목록 영역) -->

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div>
<!-- E : page-num -->
 