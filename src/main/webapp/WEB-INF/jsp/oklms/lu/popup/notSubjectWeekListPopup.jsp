<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of gocle LEARN.
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근C    2016. 10. 27 오후 1:20         Modify Draft.
  ~  *
  ~  *******************************************************************************
 --%>

<script type="text/javascript">
	
	$(document).ready(function() {
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
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	
	
	function fn_closeWin(){
		window.close();
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		
		var reqUrl = "/lu/popup/goPopupSearchCcnCompany.do";
		$("#frmCompany").attr("target", "_self");
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}

</script>

<form id="frmCompany" name="frmCompany" method="post">

<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
<div id="pop-wrapper" class="min-w650">

			<h1>시간표 미등록 교과</h1>



	<div class="search-box-1 mb-010">
	</div><!-- E : search-box-1 -->


<table class="type-2">
	
	<colgroup>
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
	</colgroup>

	<thead>
		<tr>
			<th width="15%">학년도</th>
			<th width="15%">학기</th>
			<th width="15%">교과목코드</th>
			<th width="15%">분반</th>
			<th width="15%">훈련방식</th>
			<th width="15%">학과</th>
			<th width="15%">교과구분</th>
			<th width="15%">학점여부</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${result.yyyy}</td>
			<td>${result.termName}</td>
			<td>${result.subjectCode}</td>
			<td>${result.subClass}</td>
			<td>${result.subjectTraningType}</td>
			<td>${result.departmentName}</td>
			<td>${result.subjectTypeName}</td>
			<td>${result.pointUseYnName}</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="8">시간표 미등록 상태인 개설교과가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table><!-- E : view-1 -->

<!-- 팝업 내용  영역 끝 -->

<ul class="page-num-btn mt-015">
	<li class="page-btn-area">
		<a href="#fn_closeWin" class="yellow close" onclick="javascript:fn_closeWin(); return false" onkeypress="this.onclick();">닫기</a>
	</li>
</ul><!-- E : page-num-btn -->
	
		</div><!-- E : wrapper -->
</form>		
		
		