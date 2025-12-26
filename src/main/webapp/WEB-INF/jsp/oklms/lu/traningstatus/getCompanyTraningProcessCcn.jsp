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
	
function fn_get( pageIndex ){
		
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
                  
                  <c:forEach var="result" items="${resultList}" varStatus="status">
					<c:if test="${status.count eq '1'}">
	                  	<div class="training-info">
							 <div class="txt-box">
								<dl>
									<dt>진행학기</dt>
									<dd id="subject_term">${result.yyyy} 학년도 ${result.termName}</dd>
								</dl>
								<dl>
									<dt>교과목명</dt>
									<dd id="subject_name"> ${result.subjectName}</dd>
								</dl>
								<dl>
									<dt>분반</dt>
									<dd id="subject_name"> ${result.subjectClass}</dd>
								</dl>
							</div>
						</div>
					</c:if>
				</c:forEach>
				<div class="btn-area mt-010">
								<div class="float-right">
								<a href="javascript:history.back(-1);" class="black">뒤로</a>
								</div>
							</div>
								
							</div><!-- E : search-box-1 -->
							
							<br/>
							<div class="table-responsive">
							<table class="type-2">
								<caption>교과목명 진행학기 담당교수명 기업현장교사명 훈련일지작성현황에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:10%" />
									<col style="width:15%"/>
									<col style="width:15%" />
									<col style="width:15%" />
									<col style="width:15%" />
									<col style="width:30%" />
								</colgroup>
								<thead>
									<tr>
											<th scope="col">주차</th>
											<th scope="col">학번</th>
											<th scope="col">성명</th>
											<th scope="col">훈련시간</th>
											<th scope="col">성취도</th>
											<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<c:set var="rowspan" value="1"/>
										<tr>
											<%-- <td rowspan="${rowspan}">${result.weekCnt}</td>
											<td rowspan="${rowspan}">${result.subjectClass}</td>
											<td rowspan="${rowspan}">${result.memNm}</td>									 
											<td rowspan="${rowspan}">${result.weekCnt}</td> --%>
											<td>${result.weekCnt}</td>
											<td>${result.memId}</td>	
											<td>${result.memNm}</td>	
											<td>${result.studyTime}</td>	
											<td>${result.achievement}</td>	
											<td>${result.bigo}</td>
										</tr>
										<c:if test="${result.rn eq result.rowspan}">
										<tr>
											<th>총평</th>
											<td colspan="5" style="text-align: left;">${result.review}</td>
										</tr>
											<c:if test="${result.subjectTraningType eq 'OJT'}">
											<tr>
												<th>상태</th>
												<td colspan="5" style="text-align: center;">
													<c:choose>
														<c:when test="${result.status eq '1'}"><span class="label gray">승인대기</span></c:when>
														<c:when test="${result.status eq '2'}"><span class="label blue">승인</span></c:when>
														<c:when test="${result.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnNoteComment" data-comment="${result.returnComment}" rel="modal:open">반려</a></span></c:when>
													</c:choose>
												</td>
											</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
							</div>
							<!-- E : type-2 -->
							
							
							</dd>
							</dl> 
							
						</div>
	
	
	
		
</form>

