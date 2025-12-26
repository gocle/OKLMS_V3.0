<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2016. 12. 01 오전 11:20         First Draft.
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

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

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
		
		var reqUrl = "/lu/traning/listTraningPrt.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	function fn_save(){
		
		var checkedVals = com.getCheckedVal('check0','traningProcessManageIds');
		
		if(checkedVals == ''){
			alert("처리 대상을 선택하세요.");
			return;
		}
		
		var reqUrl = "/lu/traning/updateTraningPrt.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
	function fn_allSave(){
		var reqUrl = "/lu/traning/saveTraningPrt.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
	function fn_read(traningProcessId){
		$("#traningProcessId").val( traningProcessId );
		var reqUrl = "/lu/traning/getTraningPrt.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
</script>



	
	
			
<form id="frmTraning" name="frmTraning" method="post">
<input type="hidden" name="traningProcessId" id="traningProcessId">
<input type="hidden" name="companyId" id="companyId">
			
				<h2>훈련과정 조회</h2>
				<!--  검색 -->
				<div class="search-box-1 mb-020">
					<label for="searchName" class="hidden">검색</label>
					<select id="searchName" name="searchName" onchange="">
						<option value="">훈련과정+기업명</option>
						<option value="TRANING_PROCESS_NAME" ${param.searchName eq 'TRANING_PROCESS_NAME' ? 'selected' : ''}>훈련과정</option>
						<option value="COMPANY_NAME" ${param.searchName eq 'COMPANY_NAME' ? 'selected' : ''}>기업명</option>
					</select>
					<label for="searchWord" class="hidden">검색어 입력</label>
					<input type="text" id="searchWord" name="searchWord" value="${param.searchWord}" maxlength="35" placeholder="검색어 입력" onkeypress="javascript:fn_search(1);">
					<a href="#fn_search" onclick="javascript:fn_search(1); return false" onkeypress="this.onclick;">검색</a>
				</div>	
				<!--  //검색 -->
				
				
				<ul class="mb-007">
					<li class="float-left">
						<div class="page-sum">
							총 <b>${fn:length(resultList)}</b>건
						</div>
					</li>
					<li class="float-right">
						<div class="btn-area">
							<!-- <a href="#!" onclick="fn_save();" class="yellow float-left">선택 저장하기</a> -->
							<c:if test="${ojtPrtCnt ne '0'}">
								<a href="#!" onclick="fn_allSave();" class="black">전체 저장하기</a>
							</c:if>
						</div>
					</li> 
				</ul>
			
				<div class="clearfix"></div>	
				
				<div class="table-responsive mt-010">
					<table class="type-2">
						<colgroup>
							<col style="width:5%">
							<col style="width:25%">
							<col style="width:10%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" rowspan="2"><label for="check0" class="hidden">선택</label><input type="checkbox" id="check0" name="check0" onclick="javascript:com.checkAll('check0','traningProcessManageIds');" class="choice" /></th>
								<th scope="col" rowspan="2">훈련과정명</th>
								<th scope="col" rowspan="2">기업명</th>
								<th scope="col" rowspan="2">시작일</th>
								<th scope="col" rowspan="2">종료일</th>
								<th scope="col" colspan="2">OJT 지도교수 의견</th>
							 	<th scope="col" colspan="2">센터전담자 의견</th>
							</tr>
							<tr>
							 	<th scope="col">등급</th>
								<th scope="col">특이사항</th>
								<th scope="col">등급</th>
								<th scope="col">특이사항</th>
							 </tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
							 	<td>
							 	<label for="traningProcessManageId${status.count}" class="hidden">선택</label>
							 	<input type="checkbox" id="traningProcessManageId${status.count}" name="traningProcessManageIds" value='<c:out value="${result.traningProcessManageId}"/>' class="choice" />
							 	<input type="hidden" id="traningProcessManageIds${status.count}" name="traningProcessManageIdss" value="${result.traningProcessManageId}">
							 	</td>
							 	<td><a href="javascript:fn_read('${result.traningProcessId}')">${result.traningProcessName}</a></td>
								<td>${result.companyName}</td>
								<td>${result.startDate}</td>			
								<td>${result.endDate}</td>
								<td>
									<label for="prtGrade${status.count}" class="hidden">등급 선택</label>
									<select id="prtGrade${status.count}" name="prtGrades">
										<option value="">선택</option>
										<option value="A" ${result.prtGrade eq 'A' ? 'selected' : ''}>A</option>
										<option value="B" ${result.prtGrade eq 'B' ? 'selected' : ''}>B</option>
										<option value="C" ${result.prtGrade eq 'C' ? 'selected' : ''}>C</option>
										<option value="D" ${result.prtGrade eq 'D' ? 'selected' : ''}>D</option>
										<option value="F" ${result.prtGrade eq 'F' ? 'selected' : ''}>F</option>
									</select>
								</td>
								<td> 
									<label for="prtBigo${status.count}" class="hidden">특이사항 입력</label>
									<textarea id="prtBigo${status.count}" name="prtBigos"  style="width: 100%; border:1px solid #ddd" rows="3" maxlength="150" placeholder="(ex)내용 입력">${result.prtBigo}</textarea>
								</td>
								<td>
									${result.ccnGrade}
								</td>
								<td>
									<label for="ccnBigo${status.count}" class="hidden">특이사항 입력</label>
									<textarea id="ccnBigo${status.count}" name="ccnBigos"  style="width: 100%; border:1px solid #ddd" rows="3" maxlength="150" readonly="readonly" placeholder="(ex)내용 입력">${result.ccnBigo}</textarea>
								</td>
							</tr>
						</c:forEach>
							
							
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="7"><spring:message code="common.nodata.msg" /></td>
							</tr>
						</c:if>
									
						</tbody>
					</table>
				</div>
				<div class="btn-area mt-010">
					<div class="float-right">
						<c:if test="${ojtPrtCnt ne '0'}">
							<a href="#!" onclick="fn_save();" class="black">선택 저장하기</a>
							<a href="#!" onclick="fn_allSave();" class="black ">전체 저장하기</a>
						</c:if>
					</div>
				</div>
</form>


<script>




</script>
	
	
					

	