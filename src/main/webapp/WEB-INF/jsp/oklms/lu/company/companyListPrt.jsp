<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<style type="text/css"></style>

<c:set var="targetUrl" value="/lu/company/"/>
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
	
		var reqUrl = "/lu/company/listCompany.do";
		//alert($("#pageIndex").val());
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
	
	/* 수정 페이지로 이동 */
	function fn_updt(  ){
		
		var checkedVal = $(":input:radio[name=companyIdSelect]:checked").val();
		
		if(undefined == checkedVal){
			alert("수정할 기업명에 라디오버튼을 선택하여주십시오.");
			return false
		}
		
		$("#companyId").val( checkedVal );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goUpdateCompany.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 삭제 */
	function fn_delt(){
		if (confirm("삭제 하시겠습니까?")) {
			var checkedVal = $(":input:radio[name=companyIdSelect]:checked").val();
			
			if(undefined == checkedVal){
				alert("삭제할 기업명에 라디오버튼을 선택하여주십시오.");
				return false
			}
			
			$("#companyId").val( checkedVal );
			
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
	
</script>
	
	
<div id="">
	<h2><c:out value="${curMenu.menuTitle }" /></h2>
	
<form id="frmCompany" name="frmCompany" action="<c:url value='/lu/Company/Company/listCompany.do'/>" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="companyId" name="companyId" />
	
	<div class="search-box-1">
		<input type="text" id="searchCompanyName" name="searchCompanyName" placeholder="(ex)기업명" value=""/>
		<input type="text" id="searchEmployInsManageNo" name="searchEmployInsManageNo" placeholder="(ex)고용보험관리번호" value=""/>
		<a href="#fn_search" onclick="javascript:fn_search(1); return false" >검색</a>
		
	
	</div><!-- E : search-box-1 -->
	
	
	<div class="table-responsive mt-020">
	<table class="type-2">
		<colgroup>
			<col style="width:*" />
			<col style="width:350px" />
			<col style="width:*" />
			<col style="width:200px" />
		</colgroup>
		<thead>
			<tr>
				<th>기업명</th>
				<th>고용보험관리번호 (사업자등록번호)</th>
				<th>소재지</th>
				<th>선정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<%-- <td><a href="#fn_read" onclick="javascript:fn_read('${result.companyId}')" class="text">${result.companyName}</a></td> --%>
				<td><a href="#fn_read" onclick="javascript:fn_read('${result.companyId}')" class="text">${result.companyName}</a></td>
				<td>${result.employInsManageNo} (${result.companyNo})</td>
				<td class="left">${result.address}</td>
				<td>${result.choiceDay}</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="5"><spring:message code="common.nodata.msg" /></td>
			</tr>
			</c:if>
		</tbody>
	</table>
	</div>
	
</form>

</div><!-- E : content-area -->
	
