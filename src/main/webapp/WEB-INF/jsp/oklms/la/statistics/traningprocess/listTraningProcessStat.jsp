<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

<c:set var="targetUrl" value="/la/statistics/traningprocess/" />
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
		var reqUrl = CONTEXT_ROOT + targetUrl + "listTraningProcessStat.do";
		$("#frmTraningProcess").attr("action", reqUrl);
		$("#frmTraningProcess").submit();
	}

	function fn_LoginLogManage() { 
		fn_search(pageIndex);
	}
	
	function fn_calendarClear(Obj) {
		document.getElementById(Obj).value="";
	}
	
	//엑셀 다운로드 ddd
	function fn_exclDownload(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "listTraningProcessStatExcelDownload.do";
		$("#pageIndex").val("1");
		$("#frmTraningProcess").attr("action", reqUrl);
		$("#frmTraningProcess").attr("target","_self");
		$("#frmTraningProcess").submit();
	}
	
</script>
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
	기능을 사용하실 수 없습니다.</noscript>
<form name="frmTraningProcess" id="frmTraningProcess" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />  
	<!-- E : search-list-1 (검색조건 영역) -->
	<ul class="search-list-1">
		<li><span>실시연도</span>  
			
<select name="searchKeyword" id="searchKeyword" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_LoginLogManage();"> 
	<option value="" <c:if test="${traningProcessVO.searchKeyword eq '' }" > selected="selected"  </c:if>>전체</option>
	<c:forEach var="i" begin="0" end="8" step="1">
		<option value="${nowYear-i+1}" <c:if test="${traningProcessVO.searchKeyword eq nowYear-i+1 }" > selected="selected"  </c:if>>${nowYear-i+1}</option>
	</c:forEach>								
</select> 
			
		</li>
		<li><span>과정구분</span> 
			<input type="text" id="searchTraningTypeCd" name="searchTraningTypeCd" style="width: 300px;" value="${traningProcessVO.searchTraningTypeCd }" />
		</li>
		<li><span>기업명</span> 
			<input type="text" id="searchCompanyName" name="searchCompanyName" style="width: 300px;" value="${traningProcessVO.searchCompanyName }" />
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

  

<!-- 디자인추가 -->
<div class="table-responsive">
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th rowspan="3">연번</th>
			<th rowspan="3">과정명</th>
			<th rowspan="3">훈련과정코드</th>
			<!-- <th rowspan="3">과정코드</th>  -->
			<th rowspan="3">과정구분</th>
			<th rowspan="3">회차</th>
			<th rowspan="3">실시<br />연도</th>
			<th rowspan="3">OJT<br />분반</th>
			
			<th rowspan="3" >OJT<br />지도교수</th>
			<th rowspan="3">센터<br />담당자</th>
						
			<th rowspan="3">훈련상태</th>
			<th rowspan="3">HRD-Net<br />진행상태</th>
			<!-- <th colspan="3">비용신청</th> -->
			<th colspan="4">평가점수</th>
			
			<th rowspan="3">훈련<br />시작일</th>
			<th rowspan="3">훈련<br />종료일</th>
			<th rowspan="3" >훈련<br />총인원</th>
			<th rowspan="3" >훈련실시<br />인원</th>
			
			<th colspan="2">참여철회</th>		
			<th rowspan="3">훈련중<br />인원</th>
			<th colspan="2">중탈</th>
			<th colspan="2">이수</th>
			<th colspan="2">수료</th>
			<th colspan="2">미이수</th>
			<th rowspan="3">전체<br />중탈일</th>
			<th rowspan="3">학과</th>
			<th rowspan="3">신/편입</th>
			<th rowspan="3">기업명</th>

			<th rowspan="2" colspan="3">NCS기반자격</th>
			<th rowspan="2" colspan="2">대표직무</th>
			<th rowspan="2" colspan="3">훈련시간</th>
		</tr>
		<tr>
			<!-- <th rowspan="2">학습일지</th>
			<th rowspan="2">학습활동서</th>
			<th rowspan="2">훈련과정</th> -->
			<!-- <th colspan="2">훈련비</th>
			<th rowspan="2">전담자</th> -->
			<th colspan="2">OJT지도교수</th>
			<th colspan="2">센터전담자</th>
			<th rowspan="2">인원</th>
			<th rowspan="2">철회율</th>
			<th rowspan="2">인원</th>
			<th rowspan="2">중탈율</th>
			<th rowspan="2">인원</th>
			<th rowspan="2">이수율</th>
			<th rowspan="2">인원</th>
			<th rowspan="2">수료율</th>
			<th rowspan="2">인원</th>
			<th rowspan="2">미이수율</th>
		</tr>
		<tr>
			<!-- <th>Off-JT</th>
			<th>OJT</th> -->
			<th>등급</th>
			<th>특이사항</th>
			<th>등급</th>
			<th>특이사항</th>
			<th>자격명</th>
			<th>수준</th>
			<th>버전</th>
			<th>NCS코드</th>
			<th class="min-w100">NCS명</th>
			<th>합계</th>
			<th>OJT</th>
			<th>Off-JT</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="46"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		<%-- 데이터를 화면에 출력해준다 --%>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">		
 
		<tr>
			<td><c:out value="${totalCount-((pageIndex-1) * pageSize + status.count)+1}"/></td>
			<td class="space-nowrap"><c:out value="${resultList.traningProcessName}" /></td>
			<td><c:out value="${resultList.traningProcessNo}" /></td>
			<!-- <td><c:out value="${resultList.traningProcessId}" /></td> -->
			<td>
			<c:choose>
				<c:when test="${resultList.traningTypeCd eq '1'}">일반</c:when>
				<c:when test="${resultList.traningTypeCd eq '2'}">변경인정</c:when>
				<c:when test="${resultList.traningTypeCd eq '3'}">과정연계</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
			
			</td>
			<td><c:out value="${resultList.traningProcessPeriod}" /></td>
			<td><c:out value="${resultList.year}" /></td>
			
			<td><c:out value="${resultList.ojtclass}" /></td>
			<td><c:out value="${resultList.insNames}" /></td>
			<td><c:out value="${resultList.ccnNames}" /></td>
			
			<td>
			<c:choose>
				<c:when test="${resultList.traningStatusCd eq '1'}">진행중</c:when>
				<c:when test="${resultList.traningStatusCd eq '2'}">전체중탈</c:when>
				<c:when test="${resultList.traningStatusCd eq '3'}">훈련중지</c:when>
				<c:when test="${resultList.traningStatusCd eq '4'}">종료</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
			</td>
			
			<%-- 
			<td><c:out value="${resultList.noteMonth}" /> </td>
			<td><c:out value="${resultList.actMonth}" /> </td>
			 --%>
			<td><c:choose>
				<c:when test="${resultList.processStatus eq '1'}">진행중</c:when>
				<c:when test="${resultList.processStatus eq '2'}">전체중탈</c:when>
				<c:when test="${resultList.processStatus eq '3'}">훈련중지</c:when>
				<c:when test="${resultList.processStatus eq '4'}">종료</c:when>
				<c:when test="${resultList.processStatus eq '5'}">수료보고</c:when>
				<c:when test="${resultList.processStatus eq '6'}">최종정산</c:when>
				<c:otherwise></c:otherwise>
			</c:choose></td>
			<%-- 
			<td><c:out value="${resultList.ojtMonthBiyong}" /> </td>
			<td><c:out value="${resultList.offMonthBiyong}" /> </td>
			<td><c:out value="${resultList.ccnMonth}" /> </td>
			 --%>
			
			<td><c:out value="${resultList.prtGrade }" /></td>
			<td><div class="min-wauto"><c:out value="${resultList.prtBigo }" /></div></td>
			<td><c:out value="${resultList.ccnGrade }" /></td>
			<td><div class="min-wauto"><c:out value="${resultList.ccnBigo }" /></div></td>
			
			<td><c:out value="${resultList.startDate }" /></td>
			<td><c:out value="${resultList.endDate }" /></td>
 
			
			<td><c:out value="${resultList.totalTraning }" /></td>
			<td>
			<%-- <c:choose>
				<c:when test="${resultList.traningStatusCd eq '1'}"><c:out value="${resultList.runTraning +resultList.failTraning}" /></c:when>
				<c:when test="${resultList.traningStatusCd eq '2'}"><c:out value="${resultList.failTraning}" /></c:when>
				<c:when test="${resultList.traningStatusCd eq '3'}"><c:out value="${resultList.runTraning +resultList.failTraning}" /></c:when>
				<c:when test="${resultList.traningStatusCd eq '4'}"><c:out value="${resultList.finishTraning +resultList.failTraning}" /></c:when>
				<c:otherwise><c:out value="${resultList.runTraning +resultList.failTraning}" /></c:otherwise>
			</c:choose>	 --%>		
			<c:out value="${resultList.runTraning + resultList.failTraning + resultList.finishTraning + resultList.completeTraning + resultList.notFinishTraning}" />
			</td>
			<td><c:out value="${resultList.recantTraning }" /></td><!-- 참여철회 -->
			<td><c:out value="${resultList.recantRatio}" />%</td>
			<td><c:out value="${resultList.runTraning}" /></td><!-- 훈련중인원 -->
			<td><c:out value="${resultList.failTraning}" /></td><!-- 중탈인원 -->
			<td><c:out value="${resultList.failRatio}" />%</td>
			<td><c:out value="${resultList.finishTraning}" /></td><!-- 이수인원 -->
			<td><c:out value="${resultList.finishRatio}" /> %</td>
			<td><c:out value="${resultList.completeTraning}" /></td><!-- 수료인원 -->
			<td><c:out value="${resultList.completeRatio}" /> %</td>
			<td><c:out value="${resultList.notFinishTraning}" /></td><!-- 미이수인원 -->
			<td><c:out value="${resultList.notFinishRatio}" /> %</td>
			
			<td><c:choose>
				<c:when test="${resultList.traningStatusCd eq '2'}"> <c:out value="${resultList.allFailDate}" /></c:when>
				<c:otherwise></c:otherwise>
			</c:choose></td>
			<td class="space-nowrap"><c:out value="${resultList.deptName}" /></td>
			<td><c:choose>
				<c:when test="${resultList.transferYn eq 'Y'}">편입</c:when>
				<c:otherwise>신입</c:otherwise>
			</c:choose></td>
			<td class="space-nowrap"><c:out value="${resultList.companyName }" /></td>
			
			<td class="space-nowrap"><c:out value="${resultList.ncsLicenceName }" /></td>
			<td><c:out value="${resultList.ncsLicenceLevel }" /></td>
			<td><c:out value="${resultList.ncsLicenceVersion }" /></td>
			
			<td><c:out value="${resultList.ncsCode }" /></td>
			<td><c:out value="${resultList.ncsName }" /></td>
 
			<td><c:out value="${resultList.offTimeHour+resultList.ojtTimeHour }" /></td>
			<td><c:out value="${resultList.ojtTimeHour }" /></td>
			<td><c:out value="${resultList.offTimeHour }" /></td>
		</tr>		
		
		</c:forEach>
		
		
	</tbody>
</table>
</div>



<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div>
<!-- E : page-num -->
 