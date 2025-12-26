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
		}
	}
	
	 function fn_searchPageView(val) {
		$("#pageSize").val(val);
		 fn_search(pageIndex);
	}

	/* 리스트 조회 */
	function fn_search( pageIndex ){
		
		if($("#yyyy").val() == "" ){
			alert("[학년도] 선택은 필수입니다.");
			$("#yyyy").focus();
			return;
		}
		
		if($("#term").val() == "" ){
			alert("[학기] 선택은 필수입니다.");
			$("#yyyy").focus();
		}
		
		$("#pageIndex").val( pageIndex );
		var reqUrl = CONTEXT_ROOT + targetUrl + "listOjtTraningstatusCdp.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}
	
	/* 탭이동 */
	function fn_searchTraningType( pageIndex ){
		$("#pageIndex").val( pageIndex );
		var reqUrl = CONTEXT_ROOT + targetUrl + "listOjtTraningstatusCdp.do";
		$("#frmMove").attr("action", reqUrl);
		$("#frmMove").submit();
	}
	
	
	/* 교과로 이동 */
	function fn_move_subject(subjectTraningType, year, term, subjectCode, subClass, subjectName, subjectType, onlineType,preSubjectCode){
		subjectName = encodeURIComponent(subjectName);
		if(preSubjectCode != ""){
			location.href = "/lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType+"&preSubjectCode="+preSubjectCode;
		} else {
			location.href = "/lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType;
		}
	}
	
	function fn_excel(){ 
		var reqUrl = "";
		reqUrl = CONTEXT_ROOT + targetUrl + "excelOjtTraningstatus.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();	 
	}
	
</script>

			
<div id="content-area">
			<h2><c:out value="${curMenu.menuTitle }" /></h2>
			<!-- E : search-list-1 (검색조건 영역) -->
			
<form id="frmSubject" name="frmSubject" action="<c:url value='/lu/traningstatus/listOjtTraningstatusCdp.do'/>" method="post">
    <input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
		
			<div class="group-area">
							
							<div class="search-box-1 mt-020 mb-020">
								<label for="yyyy" class="hidden">학년도</label>
								<select name="yyyy" id="yyyy" > 
									<option value="" >학년도</option>
									<c:forEach var="i" begin="0" end="2" step="1">
										<option value="${nowYear-i}" <c:if test="${traningStatusVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
									</c:forEach>								
								</select> 
								
								<label for="term" class="hidden">학기</label>
								<select name="term" id="term">
									<option value="" >학기</option>
									<option value="1" <c:if test="${traningStatusVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
									<option value="2" <c:if test="${traningStatusVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
									<option value="3" <c:if test="${traningStatusVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
									<option value="4" <c:if test="${traningStatusVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
								</select>
								
								<label for="subjectType" class="hidden">과정구분</label>
								<select name="subjectType" id="subjectType">
									<option value="">과정구분</option>
									<option value="NORMAL" <c:if test="${traningStatusVO.subjectType eq 'NORMAL' }" > selected="selected"  </c:if>>학부</option>
									<option value="HSKILL" <c:if test="${traningStatusVO.subjectType eq 'HSKILL' }" > selected="selected"  </c:if>>고숙련</option>
								</select>
								<input type="text" name="subjectName" id="subjectName" value="${traningStatusVO.subjectName}" placeholder="교과명 검색" /><a href="#!" onclick="javascript:fn_search(1);">검색</a>
								<a href="#!" onclick="javascript:fn_excel();" class="orange">엑셀파일 저장</a>
							</div><!-- E : search-box-1 -->
					
							<ul class="page-sum bg-none mb-007">
								<li class="float-right">
									PAGE VIEW : 
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt1" value="10" <c:if test="${pageSize eq '10' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('10');"> <label for="pageSizeCnt1">10</label>
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt2" value="20" <c:if test="${pageSize eq '20' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('20');"> <label for="pageSizeCnt2">20</label>
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt3" value="50" <c:if test="${pageSize eq '50' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('50');"> <label for="pageSizeCnt3">50</label>
									Lines
								</li>
							</ul>
							
							
							<div class="table-responsive">
							<table class="type-2">
								<caption>학년도 학기 개설교과명 분반 담당교수 훈련일지 학습활동서에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:8%" />
									<col style="width:6%" />
									<col style="width:*" />
									<col style="width:6%" />
									<col style="width:8%" />
									<col style="width:7%" />
									<col style="width:7%" />
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:6%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" rowspan="2">학년도</th>
										<th scope="col" rowspan="2">학기</th>
										<th scope="col" rowspan="2">개설교과명</th>
										<th scope="col" rowspan="2">분반</th>
										<th scope="col" rowspan="2">담당교수</th>
										<th scope="col" rowspan="2">기업현장교사</th>
										<th scope="col" rowspan="2">학습근로자 수</th>
										<th scope="col" colspan="4">훈련일지</th>
										<th scope="col" colspan="4">학습활동서</th>
									</tr>
									<tr>
										<th scope="col">승인대기</th>
										<th scope="col">승인</th>
										<th scope="col">반려</th>
										<th scope="col">작성주차</th>
										<th scope="col">승인대기</th>
										<th scope="col">승인</th>
										<th scope="col">반려</th>
										<th scope="col">작성주차</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td>${result.yyyy}년도</td>
											<td>${result.termName}</td>
											<td class="left">${result.subjectName }</td>
											<td>${result.subjectClass}</td>
											<td>${result.insNames}</td>
											<td>${result.tutNames}</td>
											<td>${result.lessonCnt}</td>
											<td>${result.noteCnt1}</td>
											<td>${result.noteCnt2}</td>
											<td>${result.noteCnt3}</td>
											<td>${result.noteMaxCnt}</td>
											<td>${result.actCnt1}</td>
											<td>${result.actCnt2}</td>
											<td>${result.actCnt3}</td>
											<td>${result.actMaxCnt}</td>
										</tr>
									</c:forEach>
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="15"><spring:message code="common.nodata.msg" /></td>
										</tr>
									</c:if>	
								</tbody>
							</table>
							</div>
							<!-- E : type-2 -->
							
							
							<div class="page-num mt-015">
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
							</div><!-- E : page-num -->
						</div>


</form>
					</div><!-- E : content-area -->
	
	
	
	
					

	