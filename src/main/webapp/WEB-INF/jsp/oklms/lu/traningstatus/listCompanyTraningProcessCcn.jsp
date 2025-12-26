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

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2017. 01. 09 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<c:set var="targetUrl" value="/lu/traningstatus/"/>
<script type="text/javascript">


	

	function press(event) {
		if (event.keyCode==13) {
			fn_search(1);
		}
	}
	
function fn_searchYear( pageIndex ){
		
		$("#pageIndex").val( pageIndex );
		var reqUrl = "/lu/traningstatus/listCompanyTraningProcessCcn.do";
		$("#frmTraningstatus").attr("action", reqUrl);
		$("#frmTraningstatus").submit();
	}

	/* 리스트 조회 */
	function fn_search( pageIndex ){
		
		if($("#searchTraningProcess").val() == ""){
			alert("기업별 훈련과정을 선택하세요.");
			$("#searchTraningProcess").focus();
			return;
		}
		
		if($("#searchTraningProcess").val() != ""){
			var traningProcessId = $("#searchTraningProcess").val().split("|")[0];
			var companyId = $("#searchTraningProcess").val().split("|")[1];
			var traningProcessManageId = $("#searchTraningProcess").val().split("|")[2];
			 $("#traningProcessId").val(traningProcessId);
			 $("#companyId").val(companyId);
			 $("#traningProcessManageId").val(traningProcessManageId);
		}
		
		/* if($("#searchSubject").val() != ""){
			var yyyy = $("#searchSubject").val().split("|")[0];
			var term = $("#searchSubject").val().split("|")[1];
			var subjectCode = $("#searchSubject").val().split("|")[2];
			var subjectClass = $("#searchSubject").val().split("|")[3];
			
			$("#yyyy").val(yyyy);
			$("#term").val(term);
			$("#subjectCode").val(subjectCode);
			$("#subjectClass").val(subjectClass);
		} */
		
		$("#pageIndex").val( pageIndex );
		var reqUrl = "/lu/traningstatus/listCompanyTraningProcessCcn.do";
		$("#frmTraningstatus").attr("action", reqUrl);
		$("#frmTraningstatus").submit();
	}
	
	function fn_tab(tab){
		
		if($("#searchTraningProcess").val() != ""){
			var traningProcessId = $("#searchTraningProcess").val().split("|")[0];
			var companyId = $("#searchTraningProcess").val().split("|")[1];
			var traningProcessManageId = $("#searchTraningProcess").val().split("|")[2];
			 $("#traningProcessId").val(traningProcessId);
			 $("#companyId").val(companyId);
			 $("#traningProcessManageId").val(traningProcessManageId);
		}
		
		$("#searchTab").val( tab );
		var reqUrl = "/lu/traningstatus/listCompanyTraningProcessCcn.do";
		$("#frmTraningstatus").attr("action", reqUrl);
		$("#frmTraningstatus").submit();
	}
	
	function fn_get( yyyy,term,subjectCode,subjectClass ){
		
		if($("#searchTraningProcess").val() == ""){
			alert("기업별 훈련과정을 선택하세요.");
			$("#searchTraningProcess").focus();
			return;
		}
		
		if($("#searchTraningProcess").val() != ""){
			var traningProcessId = $("#searchTraningProcess").val().split("|")[0];
			var companyId = $("#searchTraningProcess").val().split("|")[1];
			var traningProcessManageId = $("#searchTraningProcess").val().split("|")[2];
			 $("#traningProcessId").val(traningProcessId);
			 $("#companyId").val(companyId);
			 $("#traningProcessManageId").val(traningProcessManageId);
		}
		
		/* if($("#searchSubject").val() != ""){
			var yyyy = $("#searchSubject").val().split("|")[0];
			var term = $("#searchSubject").val().split("|")[1];
			var subjectCode = $("#searchSubject").val().split("|")[2];
			var subjectClass = $("#searchSubject").val().split("|")[3];
			
			$("#yyyy").val(yyyy);
			$("#term").val(term);
			$("#subjectCode").val(subjectCode);
			$("#subjectClass").val(subjectClass);
		} */
		
		$("#yyyy").val(yyyy);
		$("#term").val(term);
		$("#subjectCode").val(subjectCode);
		$("#subjectClass").val(subjectClass);
		
		var reqUrl = "/lu/traningstatus/getCompanyTraningProcessCcn.do";
		$("#frmTraningstatus").attr("action", reqUrl);
		$("#frmTraningstatus").submit();
	}
	

</script>

			
			<h2>기업별 훈련현황 조회</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
			

<form id="frmTraningstatus" name="frmTraningstatus" method="post">
	<input type="hidden" name="searchTab" id="searchTab" value="${searchTab}"/>
	<input type="hidden" name="traningProcessId" id="traningProcessId" />
	<input type="hidden" name="traningProcessManageId" id="traningProcessManageId" />
	<input type="hidden" name="companyId" id="companyId" />
	<input type="hidden" name="yyyy" id="yyyy" value=""/>
	<input type="hidden" name="term" id="term" value=""/>
	<input type="hidden" name="subjectCode" id="subjectCode" value=""/>
	<input type="hidden" name="subjectClass" id="subjectClass" value=""/>
	<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
	
	<div class="group-area mt-020">
							
					 <dl id="tab-type">

					 <dt class="tab-name-12"><a href="javascript:fn_tab('act');">학습활동서</a></dt>
                  <dd id="tab-content-12">
                  
                  <dt class="tab-name-13"><a href="javascript:fn_tab('eval');">평가결과</a></dt>
                  <dd id="tab-content-13">	
						
				 <dt class="tab-name-11 on"><a href="#!">훈련일지</a></dt>
                  <dd id="tab-content-11" style="display:block">
                  
							<div class="search-box-1 mb-020">
								<label for="year" class="hidden">실시년도</label>
								<select name="year" id="year" onchange="fn_searchYear(1);">
									<option value="">실시년도</option>
									<c:forEach var="result" items="${listTraningYear}" varStatus="status">
										<option value="${result.year}" ${result.year eq searchYear ? 'selected' : ''}>${result.year}</option>
									</c:forEach>
								</select>
								
								<label for="searchTraningProcess" class="hidden">훈련과정</label>
								<select name="searchTraningProcess" id="searchTraningProcess" onchange="fn_search(1);">
									<option value="">훈련과정</option>
									<c:forEach var="result" items="${listTraningStatusCcn}" varStatus="status">
										<c:set var="searchTraningProcess" value="${result.traningProcessId}|${result.companyId}|${result.traningProcessManageId}"/>
										<option value="${result.traningProcessId}|${result.companyId}|${result.traningProcessManageId}" <c:if test="${searchTraningProcess eq param.searchTraningProcess }" > selected="selected"  </c:if>>${result.traningProcessName}-${result.traningProcessPeriod}회차</option>
									</c:forEach>
								</select>
								<%-- <select name="searchSubject" id="searchSubject">
									<option value="">교과목</option>
									<c:forEach var="result" items="${listTraningSubjectStatusCcn}" varStatus="status">
										<option value="${result.yyyy}|${result.term}|${result.subjectCode}${result.subjectClass}">${result.subjectName}</option>
									</c:forEach>
								</select> --%>
								<a href="#!" onclick="javascript:fn_search(1);">검색</a>
							</div><!-- E : search-box-1 -->
							
							
							<div class="table-responsive">
							<table class="type-2">
								<caption>교과목명 진행학기 담당교수명 기업현장교사명 훈련일지작성현황에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:*" />
									<col style="width:15%"/>
									<col style="width:15%" />
									<col style="width:15%" />
									<col style="width:15%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">교과목명</th>
										<th scope="col">진행학기</th>
										<th scope="col">담당교수명</th>
										<th scope="col">기업현장교사명</th>
										<th scope="col">훈련일지작성현황</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td>${result.subjectName}</td>
											<td>${result.yyyy}년도 ${result.termName}</td>
											<td>${result.insNames}</td>
											<td>${result.tutNames}</td>
											<td>
											<c:if test="${!empty result.noteCnt}">
											<a href="javascript:fn_get('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}')"><font color="blue">${result.noteCnt}주차</font></a>
											</c:if>
											</td>
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
							<!-- E : type-2 -->
							
							
							</dd>
							</dl> 
							
						</div>
	
	
	
		
</form>

