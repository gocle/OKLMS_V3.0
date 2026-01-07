<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
						<h2>과제</h2>
						
						<div class="group-area-title">
						
							<c:choose>
								<c:when test="${currProcVO.subjectTraningType eq 'OJT'}">
									<h4><span>${currProcVO.subjectName} / ${currProcVO.subjectCode}</span> (${currProcVO.subjectClass}분반_${empty param.companyName ? companyName : param.companyName}) ㅣ ${currProcVO.yyyy}학년도 ${currProcVO.termName}</h4>
								</c:when>
								<c:otherwise>
									<h4><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
								</c:otherwise>
							</c:choose>
						
						
							<c:if test="${currProcVO.subjectTraningType eq 'OJT'}">
							
							<!--  분반 검색 -->
								<p><a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">개설교과 분반 검색 <i class="xi-search"></i></a></p>
	
								<!--  분반 모달창 -->
								<div id="learner-wrap_area" class="modal">
									<div class="modal-title">개설교과 분반 검색 </div>
									<div class="modal-body">
										<!--  분반 검색 -->
										<div class="search_box"> 
											<fieldset>
											<legend>게시물 검색</legend>
												<label for="class_searchKeyword" class="">검색어 입력</label>
												<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
												<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch();">검색</button> 
											</fieldset>
										 </div>
										
										<!--  분반 검색 결과 및 리스트 -->
										<div id="learner-wrap_box">
											<ul id="learner-wrap">
												<li>
													<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
													<div id="scroller" <%-- style="width:${fn:length(listOjtClassName)*128}px;" --%>>
														<ul id="thelist" class="name-tab-btn">
															<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
																<li <c:if test="${result.subjectClass eq subjectVO.subjectClass }">  class="current" </c:if> >
																<a href="#!" onclick="javascript:fn_search('${result.subjectClass}','${result.companyId }','${status.count }','${result.companyName}')" title="${result.companyName}">${result.subjectClass}분반_${result.companyName }</a></li>
															</c:forEach>
														</ul>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<!--  //분반 모달창 -->
								<!--  //분반 검색 -->
							
							</c:if>
						</div>
						
						<div class="group-area mt-010">
							<table class="type-1 responsive-tr">
								<caption>교과형태 과정구분 학점 교수 온라인 교육형태 선수여부에 대한 정보를 제공합니다</caption>
								<colgroup>
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">교과형태</th>
										<td>${currProcVO.subjectTraningTypeName}</td>
										<th scope="row">과정구분</th>
										<td>${currProcVO.subjectTypeName}</td>
										<th scope="row">학점</th>
										<td>${currProcVO.point }학점</td>
									</tr>
									<tr>
										<th scope="row">교수</th>
										<td>${currProcVO.insNames}</td>
										<th scope="row">온라인 교육형태</th>
										<td>${currProcVO.onlineTypeName} (성적비율 ${currProcVO.gradeRatio}%)</td>
										<th scope="row">선수여부</th>
										<td>${currProcVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td>
									</tr>
								</tbody>
							</table>

							<div class="btn-area mt-010">
								<div class="float-right">
									<a href="/lu/report/goInsertReport.do" onclick="javascript:" class="orange">과제출제</a>
								</div>
							</div><!-- E : btn-area -->
						</div>
<script type="text/javascript">
<!--

$(document).ready(function() {

	
});
/*  수정,삭제 */
function fn_formSave(type){ 
	 
 	if(!$(":input:radio[name=reportId]:checked").val()){
 		alert("과제를 선택하세요!");
 		return;
 	} 
 	
 	
 	var reportId = $(":input:radio[name=reportId]:checked").attr('id');
 	var scoreCnt =  $("#score_"+reportId).val();	// 제출자 수
 	
 	// 상세페이지에서 제출자 수가 있을 시 주차 수정을 못하게 넘기는 파러매터
 	$("#scoreCnt").val(scoreCnt);
 	
	//수정
	if(type=="U"){
		var reqUrl =  "/lu/report/goUpdateReport.do";
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();
	//삭제	
	}else if(type=="D"){
		if( scoreCnt != "0" ){ // 제출자가 있을 시 삭제 못하게 변경
			alert("제출자가 있는 과제는 삭제 불가능합니다.");
	 		return;
		}
		if (  confirm("삭제 하시겠습니까?")) {
			var reqUrl =  "/lu/report/deleteReport.do";
			$("#frmReport").attr("target", "_self");
			$("#frmReport").attr("action", reqUrl);
			$("#frmReport").submit();	
		}
	} 
}
function fn_popupReport(reportId){
	var url = "/lu/report/popupReport.do?reportId="+reportId;
	var wndName = "report";
	var wWidth = "650";
	var wHeight = "840";

	popOpenWindow( url, wndName, wWidth, wHeight, 0, 0, 'scrollbars=yes' );
}


function fn_search(subjectClass,companyId,scrollNum,companyName){
	
	$("#subjectClass").val(subjectClass);
	$("#subClass").val(subjectClass);
	$("#companyId").val(companyId);
	$("#companyName").val(companyName);
	$("#scrollNum").val(scrollNum);
	
	var reqUrl = "/lu/report/listReport.do";
 	
	$("#frmReport").attr("target", "_self");
	$("#frmReport").attr("action", reqUrl);
	$("#frmReport").submit();
	

}

//--> 
</script>

<form:form modelAttribute="frmReport" name="frmReport" method="post"   >
	<input type="hidden" name="scoreCnt" id="scoreCnt"  value="" />
    <input type="hidden" id="subClass" name="subClass" value="" />
    <input type="hidden" id="subjectClass" name="subjectClass" value="" />
    <input type="hidden" id="classId" name="classId" value="" />
	<input type="hidden" id="companyId" name="companyId" value="" />
	<input type="hidden" id="companyName" name="companyName" value="" />
	<input type="hidden" id="scrollNum" name="scrollNum" value="" />

						<h2>과제 목록</h2>
						
						<div class="group-area">
							<div class="table-responsive mt-010">
							<table class="type-2">
								<caption>주차 제목 제출기간 제출현황 채점현황에 대한 정보를 제공합니다</caption>
								<colgroup>
									<col style="width:7%" />
									<col style="width:7%" />
									<col style="width:*" />
									<col style="width:25%" />
									<col style="width:10%" />
									<col style="width:10%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">선택</th>
										<th scope="col">주차</th>
										<th scope="col">제목</th>
										<th scope="col">제출기간</th>
										<th scope="col">제출현황</th>
										<th scope="col">채점현황</th>
									</tr>
									<c:forEach var="result" items="${result}" varStatus="status">
									<tr>
										<td>
											<%-- <c:if test="${result.scoreCnt=='0'}"> --%>
												<label for="report_${status.count}" class="hidden">선택</label>
												<input type="radio" name="reportId" id="report_${status.count}"  value="${result.reportId}" class="choice"  <c:if test="${status.index==0 }">checked</c:if> />
												<input type="hidden" name="score_report" id="score_report_${status.count}"  value="${result.scoreCnt}" />
											<%-- </c:if> --%>
										</td>
										<td>${result.weekCnt}</td>
										<!-- <td class="left"><a href="/lu/report/getReport.do?reportId=${result.reportId}" class="text">${result.reportName}</a></td> -->
										<td class="left"><a href="/lu/report/goScoreReport.do?reportId=${result.reportId}" class="text">${result.reportName}</a></td>
										<td>${result.submitStartDate} ${result.submitStartHour}:${result.submitStartMin} ~ ${result.submitEndDate} ${result.submitEndHour}:${result.submitEndMin}</td>
										
										<td>${result.scoreCnt}/${result.totCnt}&nbsp;&nbsp;&nbsp;<a href="#!" onclick="javascript:fn_popupReport('${result.reportId}');" class="btn-full-blue">보기</a></td>
										<td>
											<c:choose>
										       <c:when test="${result.scoreOn ne result.totCnt }">
													${result.scoreOn}/${result.scoreCnt}&nbsp;&nbsp;
													<a href="/lu/report/goScoreReport.do?reportId=${result.reportId}" class="btn-line-gray">
														<c:if test="${result.scoreOn==0}" >미채점</c:if>
														<c:if test="${result.scoreOn>0}" >
															<c:if test="${result.scoreOn < result.scoreCnt}" >미채점</c:if>
															<c:if test="${result.scoreOn == result.scoreCnt}" >채점중</c:if>
															<c:if test="${result.scoreOn == result.totCnt}" >완료</c:if>
														</c:if>
													</a>
										       </c:when>
										       <c:when test="${result.reportId eq result.totCnt }">
													<a href="/lu/report/goScoreReport.do?reportId=${result.reportId}" class="btn-line-blue">열기</a>
										       </c:when>
 											   <c:otherwise>
													<a href="/lu/report/goScoreReport.do?reportId=${result.reportId}" class="btn-line-gray">채점완료</a>
										       </c:otherwise>										       
										    </c:choose>
										</td>
									</tr>
									</c:forEach>
								<c:if test="${empty result}">
						          <tr>
						            <td colspan="6">자료가 없습니다.</td>
						          </tr>
						        </c:if>
								</tbody>
							</table><!-- E : 과제관리 -->
							</div>
							<c:if test="${!empty result}">
							<div class="btn-area mt-010">
								<div class="float-right">
								<a href="#" onclick="javascript:fn_formSave('D');" class="gray-1">삭제</a><a href="#"  onclick="javascript:fn_formSave('U');" class="yellow">수정</a>
								</div>
							</div><!-- E : btn-area -->
							</c:if>
						</div>
</form:form>