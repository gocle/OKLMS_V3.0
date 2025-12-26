<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

<style type="text/css">
</style>
<c:set var="targetUrl" value="/la/subject/"/>
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
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectAdm.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
	
	
	function fn_opener_search(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCcnCompany.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}
	
	

	/* 상세조회 페이지로 이동 */
	function fn_read( param1 ){
		
		$("#companyId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "getCompany.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}
	
	
	//엑셀 다운로드 ddd
	function fn_exclDownload(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectAdmExcelDownload.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
	
	// 학기연계팝업
	function fn_link_pop(memSeq,ccnName) { 
		popOpenWindow("", "linkPop", 500, 400);
		var reqUrl = "/la/popup/popup/popupSubjectAdmLink.do";
		//$("#rowId").val(rowId);
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target", "linkPop");
		$("#frmSubject").submit();
	} 
	
	// 학기연계팝업
	function fn_reinfc_pop() { 
		popOpenWindow("", "reinfcPop", 800, 650);
		var reqUrl = "/la/popup/popup/popupSubjectAdmReinfcPop.do";
		//$("#rowId").val(rowId);
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target", "reinfcPop");
		$("#frmSubject").submit();
	} 
	
	function fn_online_traing(yyyy, term, subjectCode, subjectClass){
		var reqUrl = "/lu/online/listOnlineTraning.do";
		
		$("#yyyy").val( yyyy );
		$("#term").val( term );
		$("#subjectCode").val( subjectCode );
		$("#subjectClass").val( subjectClass );
		$("#subClass").val( subjectClass );
		
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").attr("target", "_blank");
		$("#frmTraning").submit();
	}
	
	
</script>

<form id="frmTraning" name="frmTraning" method="post">
	<input type="hidden" id="yyyy" name="yyyy" value="" />
	<input type="hidden" id="term" name="term" value="" />
	<input type="hidden" id="subjectClass" name="subjectClass" value="" />
	<input type="hidden" id="subjectCode" name="subjectCode" value="" />
	<input type="hidden" id="subClass" name="subClass" value="" />
</form>

<!-- 회원정보 팝업용 끝 -->
<form id="frmSubject" name="frmSubject" action="<c:url value='/la/admin/listSubjectAdm.do'/>" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
<ul class="search-list-1">
	<li>
		<span>학년도 / 학기 /  훈련방식</span>&nbsp;&nbsp;&nbsp;
		
<select name="yyyy" id="yyyy" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_search(1);"> 
	<option value="" >학년도-전체</option>
	<c:forEach var="i" begin="0" end="3" step="1">
		<option value="${nowYear-i+1}" <c:if test="${subjectVO.yyyy eq nowYear-i+1 }" > selected="selected"  </c:if>>${nowYear-i+1}</option>
	</c:forEach>								
</select> 

 
		&nbsp;&nbsp;&nbsp;
		<select name="term" id="term" style="width: 100px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">학기-전체</option>
			<option value="1" <c:if test="${subjectVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
			<option value="2" <c:if test="${subjectVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
			<option value="3" <c:if test="${subjectVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
			<option value="4" <c:if test="${subjectVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
		</select>
		&nbsp;&nbsp;&nbsp;
		<select name="subjectTraningType" id="subjectTraningType" style="width: 110px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">교과형태-전체</option>
			<option value="OFF" <c:if test="${subjectVO.subjectTraningType eq 'OFF' }" > selected="selected"  </c:if>>Off-JT</option>
			<option value="OJT" <c:if test="${subjectVO.subjectTraningType eq 'OJT' }" > selected="selected"  </c:if>>OJT</option>
		</select>
	</li>
	<li>
		<span>교과구분 / 학과 /  학점여부</span>&nbsp;&nbsp;&nbsp;
		<select name="subjectType" id="subjectType" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">교과구분-전체</option>
			<option value="NORMAL" <c:if test="${subjectVO.subjectType eq 'NORMAL' }" > selected="selected"  </c:if>>학부</option>
			<option value="HSKILL" <c:if test="${subjectVO.subjectType eq 'HSKILL' }" > selected="selected"  </c:if>>고숙련</option>
		</select>
		&nbsp;&nbsp;&nbsp;
		<select name="departmentNo" id="departmentNo" style="width: 100px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">학과-전체</option>
			<c:forEach var="result" items="${deptCodeList}" varStatus="status">
				<option value="${result.codeId}" <c:if test="${subjectVO.departmentNo eq result.codeId }" > selected="selected"  </c:if>>${result.codeName}</option>
			</c:forEach>
		</select>
		&nbsp;&nbsp;&nbsp;
		<select name="pointUseYn" id="pointUseYn" style="width: 110px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">학점여부-전체</option>
			<option value="Y" <c:if test="${subjectVO.pointUseYn eq 'Y' }" > selected="selected"  </c:if>>학점형</option>
			<option value="N" <c:if test="${subjectVO.pointUseYn eq 'N' }" > selected="selected"  </c:if>>비학점</option>
		</select>
	</li>
	<li>
		<span>훈련과정 매핑여부</span>&nbsp;&nbsp;&nbsp;
		<select name="traningProcessYn" id="traningProcessYn" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">메핑여부-전체</option>
			<option value="Y" <c:if test="${subjectVO.traningProcessYn eq 'Y' }" > selected="selected"  </c:if>>Y</option>
			<option value="N" <c:if test="${subjectVO.traningProcessYn eq 'N' }" > selected="selected"  </c:if>>N</option>
		</select>
	</li>
	<li>
		<span>검색조건</span>&nbsp;&nbsp;&nbsp;
		<select name="searchCondition" id="searchCondition" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">전체</option>
			<option value="subjectName" <c:if test="${subjectVO.searchCondition eq 'subjectName' }" > selected="selected"  </c:if>>교과명</option>
			<option value="traningProcessName" <c:if test="${subjectVO.searchCondition eq 'traningProcessName' }" > selected="selected"  </c:if>>훈련과정명</option>
			<option value="insNames" <c:if test="${subjectVO.searchCondition eq 'insNames' }" > selected="selected"  </c:if>>교수명</option>
			<option value="cdpName" <c:if test="${subjectVO.searchCondition eq 'cdpName' }" > selected="selected"  </c:if>>학과전담자명</option>
			<option value="tutNames" <c:if test="${subjectVO.searchCondition eq 'tutNames' }" > selected="selected"  </c:if>>기업현장교사</option>
		</select>
		<input type="text" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword}" onkeypress="press(event);"  style="width:410px;" />
	</li>
</ul><!-- E : search-list-1 -->
</form>
<div class="search-btn-area">
	<a href="#fn_search" onclick="javascript:fn_search(1); return false">조회</a>
</div>

<ul class="board-info">
	<span>검색결과 : 총 </span><span id="totalRow">0</span><span> 건</span>
	<li class="btn-area">
		<a href="#fn_link_pop" onclick="javascript:fn_link_pop( ); return false" onkeypress="this.onclick;" class="btn">교과목 연계</a>
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul><!-- E : board-info -->

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="4%">학년도</th>
			<th width="4%">학기</th>
			<th>교과명</th>
			<th width="7%">교과코드</th>
			<th width="3%">분반</th>
			<th width="5%">교과<br/>형태</th>
			<th width="5%">교과<br/>구분</th>
			<th width="10%">학과</th>
			<th width="5%">학점<br/>여부</th>
			<th width="5%">온라인<br/>형태</th>
			<th width="10%">훈련<br/>과정</th>
			<th width="5%">교수</th>
			<th width="10%">학과전담자</th>
			<th width="10%">기업현장교사</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${result.yyyy}</td>
			<td>${result.termName}</td>
			<td>${result.subjectName}</td>
			<td>${result.subjectCode}</td>
			<td>${result.subjectClass}</td>
			<td>${result.subjectTraningTypeName}</td>
			<td>${result.subjectTypeName}</td>
			<td>${result.departmentName}</td>
			<td>${result.pointUseYn eq 'Y' ? '학점형' : '비학점'}</td>
			<td>
			<c:choose>
				<c:when test="${result.onlineTypeName eq '없음'}">
					${result.onlineTypeName}
				</c:when>
				<c:otherwise>
					<a href="#fn_online_traing" onclick="javascript:fn_online_traing('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}');" class="btn-1">${result.onlineTypeName}</a>
				</c:otherwise>
			</c:choose>
			</td>
			<td>
			<c:if test="${result.subjectTraningType eq 'OJT'}">
			${result.traningProcessName}
			</c:if>
			</td>
			<td>${result.insNames}</td>
			<td>${result.cdpName}</td>
			<td>${result.tutNames}</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td colspan="14"><spring:message code="common.nodata.msg" /></td>
		</tr>
		</c:if>
	</tbody>
</table><!-- E : list -->

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div><!-- E : page-num -->

<div class="page-btn">
</div><!-- E : page-btn -->
					

	