<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="targetUrl" value="/la/statistics/ccncompany/" />
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
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCcnCompanyStat.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}

	function fn_LoginLogManage() { 
		fn_search(pageIndex);
	}
	
	function fn_calendarClear(Obj) {
		document.getElementById(Obj).value="";
	}
	
	//엑셀 다운로드 ddd
	function fn_exclDownload(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCcnCompanyStatExcelDownload.do";
		$("#pageIndex").val("1");
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	
</script>
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
	기능을 사용하실 수 없습니다.</noscript>
<form name="frmMember" id="frmMember" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />  
	<!-- E : search-list-1 (검색조건 영역) -->
	<ul class="search-list-1">
		<li><span>검색조건</span> 
			<select name="searchCondition" id="searchCondition">				
				<option value="comp" >기업명</option>
				<option value="name" >이름</option>
			</select>
			<input type="text" id="searchKeyword" name="searchKeyword" style="width: 300px;" value="${memberVO.searchKeyword }" />
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
			<th rowspan="3">성명</th>
			<th rowspan="3">기업명</th>
			<th rowspan="3">직위</th>
			<th rowspan="2" colspan="2">구분</th>
			
			<th rowspan="3">입사일자</th>
			<th rowspan="3">재직여부</th>
			
			<th colspan="5">전담인력양성교육 수료 여부 명칭 변경</th>
			
			<th rowspan="2" colspan="3">기업현장 교사 조건</th>
			
			<th rowspan="2" colspan="3">연락처</th>
			
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
			
			<th>사무실</th>
			<th>핸드폰</th>
			<th>이메일</th>	
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
			<td><c:out value="${totalCount-((pageIndex-1) * pageSize + status.count)+1}"/></td>
			<td><c:out value="${resultList.memName}" /></td>
			<td><c:out value="${resultList.companyName}" /></td>
			<td><c:out value="${resultList.title}" /></td>
			<td><c:if test="${resultList.memType eq 'CCM' }">O</c:if></td>
			<td><c:if test="${resultList.memType eq 'COT' }">O</c:if></td>
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
</div> 

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div>
<!-- E : page-num -->
 