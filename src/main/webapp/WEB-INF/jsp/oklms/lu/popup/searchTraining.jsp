<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript">

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
		
		/* var nowDate = '${nowDate}';
		var nowDate1 = '${currProcVO.nowDate}';
		
		alert("nowDate="+nowDate);
		alert("nowDate1="+nowDate1);
		
		$("#searchYyyyCd").val(nowDate); */
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
		
		var reqUrl = "/lu/popup/goPopupSearchTraning.do";
		$("#frmProcess").attr("action", reqUrl);
		$("#frmProcess").submit();
	}
	
	//선택 버튼을 클릭시 부모창에 필요항목 셋팅
	function fn_selectInfo(){
		if( opener ){
			var selectInfo = "";
			selectInfo = com.getCheckedVal('check0','check1');
		   // var memSeq = '${currProcVO.memSeq }';
		    var memSeq = $("#memSeq").val();
		    var cnt = '${resultTrainSubjectSeachListCnt}';
		    //var companyId = '${currProcVO.companyId }';

			if('' == selectInfo){
				alert("추가할 개설강좌명을 선택하여주십시오.");
				return false;
			}
			
			//sselectInfo = selectInfo + "," + memSeq;
									
 			//opener.fn_setSubjectNmInfo(selectInfo, memSeq, companyId);
			opener.fn_setSubjectNmInfo(selectInfo, memSeq, cnt);
			window.close();
		}
	}
	
	//선택 버튼을 클릭시 부모창에 필요항목 셋팅
	function fn_traning(traningProcessId,year,traningProcessName){
		if( opener ){
			$(opener.document).find("#traningProcessId").val(traningProcessId);
			$(opener.document).find("#stdTraningYear").val(year);
			$(opener.document).find("#traningProcessName_text").text(traningProcessName);
			window.close();
		}
	}
	
	function fn_closeWin(){
		window.close();
	}
	
</script>

<!-- 회원정보 팝업용 끝 -->
<form id="frmProcess" name="frmProcess" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 

	
<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">

			<h1>훈련과정검색</h1>

			<div class="search-box-1 mb-010">
				<input type="text" id="searchKeyword" name="searchKeyword" value="${param.searchKeyword}" placeholder="훈련과정명/훈련과정번호" style="width:150px;" /> 
				<a href="#fn_search" onclick="javascript:fn_search('1'); return false" onkeypress="this.onclick();">조회</a>
			</div><!-- E : search-box-1 -->

			<table class="type-2">
				<colgroup>
					<col width="40px" />
					<col width="140px" />
					<col width="*" />
					<col width="60px" />
					<col width="60px" />
					<col width="60px" />
				</colgroup>
				<thead>
					<tr>
						<th></th>
						<th>훈련과정번호</th>
						<th>훈련과정명</th>
						<th>회차</th>
						<th>훈련시작일</th>
						<th>훈련종료일</th>
					</tr>
				</thead>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><input type="radio" id="check1" name="check1" value="${result.traningProcessName}_${result.year}" onclick="fn_traning('${result.traningProcessId}','${result.year}','${result.traningProcessName}');"></td>
						<td><c:out value="${result.traningProcessNo}" /></td>
						<td class="left">${result.traningProcessName}</td>
						<td><c:out value="${result.traningProcessPeriod}" /></td>
						<td><c:out value="${result.startDate}" /></td>
						<td><c:out value="${result.endDate}" /></td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="6"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
				</tbody>
			</table><!-- E : 기업체검색 -->
			
			<ul class="page-num-btn mt-015">
				<li class="page-num-area">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
				</li>
				<li class="page-btn-area">
					<a href="#fn_closeWin" class="yellow close" onclick="javascript:fn_closeWin(); return false" onkeypress="this.onclick();">닫기</a>
				</li>
			</ul><!-- E : page-num-btn -->

		</div><!-- E : wrapper -->
</form>
					

	