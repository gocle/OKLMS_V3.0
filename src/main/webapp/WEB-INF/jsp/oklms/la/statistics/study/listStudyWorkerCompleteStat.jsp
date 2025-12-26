<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="targetUrl" value="/la/statistics/study/" />
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
	function fn_search( ) {
 
		var reqUrl = CONTEXT_ROOT + targetUrl + "listStudyWorkerCompleteStat.do";
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
		var reqUrl = CONTEXT_ROOT + targetUrl + "listStudyWorkerCompleteStatExcelDownload.do";
		
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
 	<input type="hidden" id="memSeq" name="memSeq" value="${memberVO.memSeq  }"  /> 
</form>
 
 <ul class="board-info">
	 
	<li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>
 
 

<div class="table-responsive">
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
<thead>
		<tr>
			<th>성명</th>
			<td>${memberVO.memName}</td>
		</tr>
		<tr>
			<th>학과</th>
			<td>${memberVO.deptNm}</td>
		</tr>
		<tr>
			<th>학번</th>
			<td>${memberVO.memId}</td>
		</tr>
		<tr>
			<th>기업명</th>
			<td>${memberVO.companyName}</td>
		</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th rowspan="4">학년</th>
			<th rowspan="4">해당학기</th>
			<th rowspan="4">교과목명</th>
			<th rowspan="3" colspan="2">능력단위<br />(NCS, 비NCS)</th>
			<th rowspan="2" colspan="4">Off-JT 출석시간(대학)</th>
			<th colspan="6">이수여부</th>
			<th rowspan="4">재수강<br />여부</th>
		</tr>
		<tr>
			<th colspan="4">Off-JT</th>
			<th rowspan="2" colspan="2">OJT</th>
		</tr>
		<tr>
			<th colspan="2">집체(아우누리)</th>
			<th colspan="2">원격(OK-LMS)</th>
			<th colspan="2">학사</th>
			<th colspan="2">훈련</th>
		</tr>
		<tr>
			<th>능력단위명</th>
			<th>필수여부</th>
			<th>목표</th>
			<th>이수</th>
			<th>목표</th>
			<th>이수</th>
			<th>능력단위</th>
			<th>교과목(학점)</th>
			<th>능력단위</th>
			<th>교과목</th>
			<th>능력단위</th>
			<th>교과목</th>
		</tr>
	</thead>
	<tbody>
			
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td>${result.subjectGrade}학년</td>
									<td>
									${fn:replace(fn:replace(result.yySemstrNm, '-01' , '-1학기' ),'-02','-2학기')}
									</td>
									<td>${result.subjectName}</td>
									<td>${result.ncsUnitName}</td>
									<td>${result.ncsCnt ne '0' ? '필수' : ''}</td>
									<td>${result.offAttGoal}</td>
									<td>${result.offAttCompl}</td>
									<td>${result.onAttGoal}</td>
									<td>${result.onAttCompl}</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OFF'}">
									${result.ncsUnitName}
									 </c:if>
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OFF'}">
									${result.grd}
									</c:if>
									</td>
									<td>${result.passYn}</td>
									<td>${result.grade}</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OJT'}">
									${result.ncsUnitName}
									</c:if>
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OJT'}">
									${result.grd}
									</c:if>
									</td>
									<td>${result.reCorsYn}</td>
								</tr>	
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
								 	<td colspan="16"><spring:message code="common.nodata.msg" /></td>
								</tr>		
							</c:if>	
	</tbody>
</table>
</div> 



 