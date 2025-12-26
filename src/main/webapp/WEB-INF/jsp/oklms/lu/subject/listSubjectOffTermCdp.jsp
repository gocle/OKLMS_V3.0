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
<c:set var="targetUrl" value="/lu/subject/"/>
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
		$("#pageIndex").val( pageIndex );
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectCdp.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}
	
	/* 탭이동 */
	function fn_searchTraningType( pageIndex ){
		$("#pageIndex").val( pageIndex );
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectCdp.do";
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
	
</script>

			
<div id="content-area">
			<h2>담당 개설교과 조회</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
			
<form id="frmSubject" name="frmSubject" action="<c:url value='/lu/subject/listSubjectCdp.do'/>" method="post">
    <input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
		
			<div class="group-area">
			
							
							<div class="search-box-1 mt-020 mb-020">
								<label for="yyyy" class="hidden">학년도 선택</label>
								<select name="yyyy" id="yyyy" > 
									<option value="" >학년도</option>
									<c:forEach var="i" begin="0" end="6" step="1">
										<option value="${nowYear-i}" <c:if test="${subjectVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
									</c:forEach>								
								</select> 
								
								<label for="term" class="hidden">학기 선택</label>
								<select name="term" id="term">
									<option value="" >학기</option>
									<option value="1" <c:if test="${subjectVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
									<option value="2" <c:if test="${subjectVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
									<option value="3" <c:if test="${subjectVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
									<option value="4" <c:if test="${subjectVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
								</select>
								
								<label for="deptCode" class="hidden">학과명 선택</label>
								<select name="deptCode" id="deptCode">
									<option value="">학과명</option>
									<c:forEach var="result" items="${deptCodeList}" varStatus="status">
										<option value="${result.codeId}" <c:if test="${subjectVO.deptCode eq result.codeId }" > selected="selected"  </c:if>>${result.codeName}</option>
									</c:forEach>		
								</select>
								
								<label for="subjectGrade" class="hidden">대상학년 선택</label>
								<select name="subjectGrade" id="subjectGrade">
									<option value="">대상학년</option>
									<option value="1" <c:if test="${subjectVO.subjectGrade eq '1' }" > selected="selected"  </c:if>>1학년</option>
									<option value="2" <c:if test="${subjectVO.subjectGrade eq '2' }" > selected="selected"  </c:if>>2학년</option>
									<option value="3" <c:if test="${subjectVO.subjectGrade eq '3' }" > selected="selected"  </c:if>>3학년</option>
									<option value="4" <c:if test="${subjectVO.subjectGrade eq '4' }" > selected="selected"  </c:if>>4학년</option>
									<option value="5" <c:if test="${subjectVO.subjectGrade eq '5' }" > selected="selected"  </c:if>>5학년</option>
								</select>
								
								<label for="subjectType" class="hidden">과정구분 선택</label>
								<select name="subjectType" id="subjectType">
									<option value="">과정구분</option>
									<option value="NORMAL" <c:if test="${subjectVO.subjectType eq 'NORMAL' }" > selected="selected"  </c:if>>학부</option>
									<option value="HSKILL" <c:if test="${subjectVO.subjectType eq 'HSKILL' }" > selected="selected"  </c:if>>고숙련</option>
								</select>
								
								<label for="subjectName" class="hidden">교과명 검색</label>
								<input type="text" name="subjectName" id="subjectName" value="${subjectVO.subjectName}" placeholder="교과명 검색" /><a href="#!" onclick="javascript:fn_search(1);">검색</a>
							</div><!-- E : search-box-1 -->
					
							<ul class="page-sum bg-none mb-007">
								<li class="float-right">
									PAGE VIEW : <input type="radio" name="pageSizeCnt" id="pageSizeCnt1" value="10" <c:if test="${pageSize eq '10' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('10');"> <label for="pageSizeCnt1" >10</label>
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt2" value="20" <c:if test="${pageSize eq '20' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('20');"> <label for="pageSizeCnt2" >20</label>
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt3" value="50" <c:if test="${pageSize eq '50' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('50');"> <label for="pageSizeCnt3" >50</label>
									Lines
								</li>
							</ul>
							
							
							<div class="table-responsive">
							<table class="type-2">
								<caption>학년도 학기 학과 대상학년 개설교과명 과정구분 온라인교육형태에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:6%" />
									<col style="width:8%" />
									<col style="width:6%" />
									<col style="width:15%" />
									<col style="width:6%" />
									<col style="width:*" />
									<col style="width:6%" />
									<col style="width:10%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">학년도</th>
										<th scope="col">학기</th>
										<th scope="col">학과</th>
										<th scope="col">대상학년</th>
										<th scope="col">개설교과명</th>
										<th scope="col">과정구분</th>
										<th scope="col">온라인교육형태</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td><c:out value="${(subjectVO.pageIndex-1) * subjectVO.pageSize + status.count}"/></td>
											<td>${result.yyyy}</td>
											<td>${result.termName}</td>
											<td>${result.deptName}</td>
											<td>${result.subjectGrade}학년</td>
											<td class="left"><a href="#fn_move_subject" onclick="fn_move_subject('${result.subjectTraningType}','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','${result.subjectType}','${result.onlineType}','${result.preSubjectCode}');" class="text">${result.subjectName }</a></td>
											<td>${result.subjectTypeName}</td>
											<td>${result.onlineTypeName}</td>
											<!-- javascript:fn_lec_menu_display('OFF','2017','1','MAE700','01','기계제도및CAD','NORMAL','ONLINE'); -->
										</tr>
									</c:forEach>
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="8"><spring:message code="common.nodata.msg" /></td>
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
	
	
	
	
					

	