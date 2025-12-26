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

<c:set var="targetUrl" value="/la/statistics/subject/" />
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
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectStat.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}

	function fn_LoginLogManage() { 
		fn_search(pageIndex);
	}
	
	function fn_calendarClear(Obj) {
		document.getElementById(Obj).value="";
	}
	
	//엑셀 다운로드 ddd
	function fn_exclDownload(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectStatExcelDownload.do";
		$("#pageIndex").val("1");
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
	
</script>
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
	기능을 사용하실 수 없습니다.</noscript>
<form name="frmSubject" id="frmSubject" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />  
	<!-- E : search-list-1 (검색조건 영역) -->
	<ul class="search-list-1">
		<li><span>년도</span> 
			
<select name="searchyyyy" id="searchyyyy" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_LoginLogManage();"> 
	<c:forEach var="i" begin="0" end="8" step="1">
		<option value="${nowYear-i+1}" <c:if test="${subjectVO.searchyyyy eq nowYear-i+1 }" > selected="selected"  </c:if>>${nowYear-i+1}</option>
	</c:forEach>								
</select> 
			
		</li>	
		<li><span>과목명</span> 
			<input type="text" id="searchKeyword" name="searchKeyword" style="width: 300px;" value="${subjectVO.searchKeyword }" />
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
			
			<th colspan="7">능력단위</th>
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
</div>
<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div>