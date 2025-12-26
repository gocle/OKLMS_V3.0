<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<style type="text/css">
</style>

<c:set var="targetUrl" value="/la/company/"/>
<script type="text/javascript">

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

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search( param1 ){
		
		$("#pageIndex").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCcnCompany.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").attr("target","_self");
		$("#frmCompany").submit();
	}
	
	function fn_opener_search(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCcnCompany.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	

	/* 상세조회 페이지로 이동 */
	function fn_read( param1 ){
		
		$("#companyId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "getCompany.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 삭제 */
	function fn_delt(){
		if (confirm("삭제 하시겠습니까?")) {
			var checkedVals = com.getCheckedVal('check0','check1');
			
			$("#companyId").val( checkedVals );
			
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteCompany.do";
			
			$("#frmCompany").attr("action", reqUrl);
			$("#frmCompany").submit();
		}
	}
	
	/* 신규 페이지로 이동 */
	function fn_cret(){
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goInsertCompany.do";
		
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	function fn_mapping_pop(memSeq,ccnName) { 
		popOpenWindow("", "popSearch", 500, 550);
		var reqUrl = "/la/popup/popup/popupCcnCompany.do";
		$("#memSeq").val( memSeq );
		$("#ccnName").val( ccnName );
		//$("#rowId").val(rowId);
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").attr("target", "popSearch");
		$("#frmCompany").submit();
	} 
	
	
</script>

<!-- 회원정보 팝업용 끝 -->
<form id="frmCompany" name="frmCompany" action="<c:url value='/la/company/listCcnCompany.do'/>" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="companyId" name="companyId" />
	<input type="hidden" id="memSeq" name="memSeq" />
	<input type="hidden" id="ccnName" name="ccnName" />
<ul class="search-list-1">
	<li>
		<span>담당자명</span>
		&nbsp;
		<input type="text" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword}" onkeypress="press(event);"  style="width:410px;" />
	</li>
</ul><!-- E : search-list-1 -->
</form>
<div class="search-btn-area">
	<a href="#fn_search" onclick="javascript:fn_search(1); return false">조회</a>
</div>

<ul class="board-info">
	<span>검색결과 : 총 </span><span id="totalRow">0</span><span> 건</span>
</ul><!-- E : board-info -->

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="15%">담당자명</th>
			<th width="30%">담당회사</th>
			<th width="20%">매핑</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><c:out value="${result.ccnName}" /></td>
			<td>
			${fn:replace(result.companyNames, ',' , '<br/>' )}
			</td>
			<td><a href="javascript:fn_mapping_pop('${result.memSeq}','${result.ccnName}');" class="btn-1">매핑</a> </td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td colspan="3"><spring:message code="common.nodata.msg" /></td>
		</tr>
		</c:if>
	</tbody>
</table><!-- E : list -->


<div class="page-btn">
</div><!-- E : page-btn -->
					

	