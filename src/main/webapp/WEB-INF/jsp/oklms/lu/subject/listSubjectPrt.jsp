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
		}
	}

	/* 리스트 조회 */
	function fn_search(){
		
		
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSubjectPrt.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}
	
	
	
</script>

			
<div id="content-area">
			<h2>담당 개설교과 조회</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
<form id="frmSubject" name="frmSubject" action="<c:url value='/lu/subject/listSubjectPrt.do'/>" method="post">
		
			<div class="group-area mt-020">
							
<%@ include file="/lu/subject/getSubjectSearch.do"%>							
							
							
							<div class="table-responsive">
							<table class="type-2">
								<colgroup>
									<col style="width:40px" />
									<col style="width:50px" />
									<col style="width:50px" />
									<col style="width:60px" />
									<col style="width:*" />
									<col style="width:50px" />
									<col style="width:120px" />
									<col style="width:90px" />
									<col style="width:60px" />
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>학년도</th>
										<th>학기</th>
										<th>대상학년</th>
										<th>개설교과명</th>
										<th>분반</th>
										<th>기업명</th>
										<th>기업현장교사</th>
										<th>과정구분</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>10</td>
										<td>2016</td>
										<td>1</td>
										<td>1</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>01</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>9</td>
										<td>2016</td>
										<td>1</td>
										<td>2</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>01</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>8</td>
										<td>2016</td>
										<td>1</td>
										<td>2</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>01</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>7</td>
										<td>2016</td>
										<td>1</td>
										<td>2</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>02</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>6</td>
										<td>2016</td>
										<td>1</td>
										<td>3</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>01</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>5</td>
										<td>2016</td>
										<td>2</td>
										<td>1</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>03</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>4</td>
										<td>2016</td>
										<td>2</td>
										<td>1</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>02</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>3</td>
										<td>2016</td>
										<td>2</td>
										<td>2</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>03</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>2</td>
										<td>2016</td>
										<td>2</td>
										<td>2</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>03</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
									<tr>
										<td>1</td>
										<td>2016</td>
										<td>2</td>
										<td>1</td>
										<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
										<td>03</td>
										<td>기업명_A</td>
										<td>현장교사_A1</td>
										<td>학부</td>
									</tr>
								</tbody>
							</table>
							</div>
							<!-- E : type-2 -->

							<div class="btn-area mt-010">
								<div class="float-right">
								<c:choose>
									<c:when test="${fn:length(gradeList) == 0}">
										<a href="#!" onclick="javascript:alert('저장 할 데이터가 없습니다.');" class="orange">엑셀파일 저장</a>
									</c:when>
									<c:otherwise>
										<a href="#!" onclick="javascript:fn_excel('${confirmVO.submitId}','${confirmVO.confirmYn}');" class="orange">엑셀파일 저장</a>
									</c:otherwise>
								</c:choose>
								</div>
							</div><!-- E : btn-area -->
						</div>


						<h2>성적 수신 내역</h2>
						<div class="table-responsive">
						<table class="type-2 mt-040">
							<colgroup>
								<col style="width:5%" />
								<col style="width:15%" />
								<col style="width:15%" />
								<col style="width:15%" />
								<col style="width:15%" />
								<col style="width:5%" />
								<col style="width:*" />
								<col style="width:15%" />
							</colgroup>
							<tr>
								<th>번호</th>
								<th>수신일</th>
								<th>학과명</th>
								<th>발송인</th>
								<th>저장일자</th>
								<th>본인확인</th>
								<th>전송사유</th>
								<th>IP</th>
							</tr>
							<c:forEach var="result" items="${confirmList}" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${result.insertDate}</td>
									<td>${result.deptNm}</td>
									<td>${result.insertUserName}</td>
									<td id="${result.submitId}_confirmDate">${result.confirmDate}</td>
									<td id="${result.submitId}_confirmYn">${result.confirmYn}</td>
									<td>규정에 의한 정기 전송</td>
									<td>${result.ip}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty confirmList}" >
								<tr>
									<td colspan="8">성적 수신 내역이 없습니다.</td>
								</tr>
							</c:if>
						</table>
						</div>
</form>
					</div><!-- E : content-area -->
	
	
	
	
					

	