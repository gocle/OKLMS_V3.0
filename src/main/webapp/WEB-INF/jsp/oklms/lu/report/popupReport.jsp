<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script type="text/javascript">

var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
var totalCount = '${totalCount}'; //전체 데이터 갯수
var pageIndex = '${pageIndex}'; //현재 페이지 정보

<!--


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


function loadPage() {
	initEvent();
	initHtml();
}



/* 화면이 로드된후 처리 초기화 */
function initHtml() {

//     com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

	$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
	$("#pageIndex").val(pageIndex); //현재 페이지 정보
	$("#totalRow").text(totalCount);
}
			function pop_closeWin() {
				self.close();
			}
			/* 엑셀 다운로드 */
			function fn_exclDownload(){
				var reqUrl = "/lu/report/getReportExcel.do";
				$("#frmReport").attr("action", reqUrl);
				$("#frmReport").attr("target","_self");
				$("#frmReport").submit();
			}
			function fn_search(param1){
				$("#pageIndex").val( param1 ); 
				var reqUrl = "/lu/report/popupReport.do";
				$("#frmReport").attr("action", reqUrl);
				$("#frmReport").attr("target","_self");
				$("#frmReport").submit();				
			}
			function printReport(){
				if(confirm("출력하시겠습니까?")){
					window.print();				
				}
			}
//-->
</script>

	<body>
<form name="frmReport" id="frmReport" action=""  method="post" >
	<input type="hidden" name="reportId" value="${reportVO.reportId}"/>
	<input type="hidden" name="pageIndex"  id="pageIndex" value="${pageIndex}" /> 
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
</form>
		<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">

			<h1>과제 제출현황</h1>
			<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>



			<table class="type-1 mb-020">
				<caption>제목 주차 과제제출기간 내용에 대한 정보를 제공합니다</caption>
				<colgroup>
					<col style="width:110px" />
					<col style="width:200px" />
					<col style="width:110px" />
					<col style="width:*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">${reportVO.reportName}</td>
					</tr>
					<tr>
						<th scope="row">주차</th>
						<td>${reportVO.weekCnt} 주차</td>
						<th scope="row">과제제출 기간</th>
						<td>${reportVO.submitStartDate} ${reportVO.submitStartHour}:${reportVO.submitStartMin}<br/>~<br/>${reportVO.submitEndDate} ${reportVO.submitEndHour}:${reportVO.submitEndMin}</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td colspan="3">${reportVO.reportDesc}</td>
					</tr>
				</tbody>
			</table>



			<table class="type-2">
				<caption>학번 이름 제출일 제출현황에 대한 정보를 제공합니다</caption>
				<colgroup>
					<col style="width:60px" />
					<col style="width:120px" />
					<col style="width:*" />
					<col style="width:80px" />
					<col style="width:80px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">학번</th>
						<th scope="col">이름</th>
						<th scope="col">제출일</th>
						<th scope="col">제출현황</th>
					</tr>
				</thead>
				<tbody>
							<c:forEach var="result" items="${result}" varStatus="status">
							<input type="hidden" name="arrReportSubmitId" value="${result.reportSubmitId }"/>
								<tr>
									<td><c:out value="${totalCount - ((pageIndex-1) * pageSize + status.index)}"/></td>
									<td>${result.memId }</td>
									<td>${result.memName }</td>
									<td>${result.insertDate }</td>
									<td>
										<c:if test="${!empty result.atchFileId }">
											<a href="#" class="btn-line-gray" onclick="javascript:com.downFile('${result.atchFileId}','1');" >제출</a>
										</c:if>
										<c:if test="${empty result.atchFileId }">
											<span class="btn-line-orange">미제출</span>
										</c:if>										
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result}">
						          <tr>
						            <td colspan="5">자료가 없습니다.</td>
						          </tr>
						    </c:if>
		 
				</tbody>
			</table>

		<!-- S : page-num (페이징 영역) -->
		<div class="page-num mt-015">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
		</div>
		<!-- E : page-num (페이징 영역) -->

			<div class="btn-area align-center mt-010" style="border-top:1px solid #CCC; padding-top:20px;">
				<a href="#!" onclick="javascript:printReport();" class="black">프린트</a>
				<a href="#!" onclick="javascript:fn_exclDownload();" class="orange">엑셀 다운로드</a>
				<a href="javascript:pop_closeWin();" class="black">닫기</a>
			</div>


		</div><!-- E : wrapper -->
	</body>