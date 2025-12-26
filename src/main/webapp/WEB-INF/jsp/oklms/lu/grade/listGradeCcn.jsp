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
  ~  * 이진근    2017. 01. 09 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<c:set var="targetUrl" value="/lu/grade/"/>
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
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search( param1 ){
		
		$("#pageIndex").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listGrade.do";
		$("#frmGrade").attr("action", reqUrl);
		$("#frmGrade").submit();
	}
	
	/* 상세조회 페이지로 이동 */
	function fn_read( param1 ){
		
		//컨테츠 미리보기 테스트때문에 주석처리함.
		$("#id").val( param1 );
		//$("#id").val( '2' );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "getGrade.do";
		$("#frmGrade").attr("action", reqUrl);
		$("#frmGrade").submit();
	}
	
	/* 컨텐츠 미리보기 레이어팝업 open */
	function fn_showLearningpop(){
		$(".learning-area,.popup-bg").addClass("open"); 
		window.location.hash = "#open";
	}
	
	/* 컨텐츠 미리보기 레이어팝업 open */
	function fn_hideLearningpop(){
		$(".learning-area,.popup-bg").removeClass("open");
	}
	
</script>

<!-- 회원정보 팝업용 시작 -->
<form id="frmPop" name="frmPop" method="post">
	<input type="hidden" name="memSeqPop" id="memSeqPop"/>
	<input type="hidden" name="lectureStat" id="lectureStat" value="01"/>
</form>
<!-- 회원정보 팝업용 끝 -->
			
<div id="content-area">
			<h2>성적조회</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
			<form id="frmGrade" name="frmGrade" action="<c:url value='/lu/grade/listGrade.do'/>" method="post">
			<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />
			<input type="hidden" id="id" name="id" />
			
			<%-- <div class="search">
			<select name="category_code" id="category_code" style="width:120px">
	  			<option selected value=''>--전체--</option>
	  			<c:forEach var="categoryCd" items="${categoryCode}" varStatus="status">
					<option value="${categoryCd.category_code}" ${categoryCd.category_code == GradeVO.category_code ? 'selected="selected"' : '' }>${categoryCd.category_name}</option>
				</c:forEach>
		 	</select>
			<input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
			<input type="button" class="grey_search" value="검색" onclick="fn_search('1'); return false;" />
			</div> --%>
			
			<div class="group-area mt-020">
							<div class="search-box-1">
								<select id="" onchange="">
									<option value="">2016학년도</option>
									<option value="">2017학년도</option>
								</select>
								<select id="" onchange="">
									<option value="">학기</option>
									<option value="">1학기</option>
									<option value="">2학기</option>
								</select>
								<select id="" onchange="">
									<option value="">개설 교과명</option>
								</select>
								<a href="#!">조회</a>
							</div><!-- E : search-box-1 -->



							<table class="type-2 mt-020">
								<colgroup>
									<col style="width:90px" />
									<col style="width:70px" />
									<col style="width:80px" />
									<col style="width:100px" />
									<col style="width:*" />
									<col style="width:110px" />
									<col style="width:70px" />
								</colgroup>
								<thead>
									<tr>
										<th>학년도</th>
										<th>학기</th>
										<th>구분</th>
										<th>형태</th>
										<th>교과목명</th>
										<th>교과목코드</th>
										<th>분반</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>2016</td>
										<td>2</td>
										<td>OJT</td>
										<td>현장교육</td>
										<td class="left">교과목명_01</td>
										<td>ABC001</td>
										<td>01</td>
									</tr>
								</tbody>
							</table>



							<table class="type-2 mt-010">
								<colgroup>
									<col style="width:50px" />
									<col style="width:110px" />
									<col style="width:*" />
									<col style="width:70px" />
									<col style="width:70px" />
									<col style="width:70px" />
									<col style="width:70px" />
									<col style="width:70px" />
									<col style="width:80px" />
									<col style="width:80px" />
									<col style="width:50px" />
									<col style="width:70px" />
								</colgroup>
								<thead>
									<tr>
										<th rowspan="2">번호</th>
										<th rowspan="2">학번</th>
										<th rowspan="2">성명</th>
										<th>출석</th>
										<th>훈련태도</th>
										<th>질의응답</th>
										<th>1차평가</th>
										<th>2차평가</th>
										<th rowspan="2">재평가<br />가점</th>
										<th rowspan="2">점수<br />환산합계</th>
										<th rowspan="2">석차</th>
										<th rowspan="2">성적등급</th>
									</tr>
									<tr>
										<th class="border-left">10%</th>
										<th>10%</th>
										<th>10%</th>
										<th>35%</th>
										<th>35%</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>2016000001</td>
										<td>학습근로자_01</td>
										<td>90</td>
										<td>90</td>
										<td>100</td>
										<td>80</td>
										<td>75</td>
										<td>0</td>
										<td>91.0</td>
										<td>5</td>
										<td>A+</td>
									</tr>
									<tr>
										<td>2</td>
										<td>2016000001</td>
										<td>학습근로자_01</td>
										<td>90</td>
										<td>90</td>
										<td>100</td>
										<td>80</td>
										<td>75</td>
										<td>0</td>
										<td>91.0</td>
										<td>5</td>
										<td>B+</td>
									</tr>
									<tr>
										<td>3</td>
										<td>2016000001</td>
										<td>학습근로자_01</td>
										<td>90</td>
										<td>90</td>
										<td>100</td>
										<td>80</td>
										<td>75</td>
										<td>0</td>
										<td>91.0</td>
										<td>5</td>
										<td>C+</td>
									</tr>
								</tbody>
							</table>

							<div class="btn-area align-right mt-010">
								<a href="" class="orange">전송</a>
							</div><!-- E : btn-area -->
						</div>



						<table class="type-2 mt-040">
							<colgroup>
								<col style="width:50px" />
								<col style="width:90px" />
								<col style="width:160px" />
								<col style="width:160px" />
								<col style="width:160px" />
								<col style="width:*" />
							</colgroup>
							<tr>
								<th>번호</th>
								<th>전송일</th>
								<th>기업명</th>
								<th>사업자등록번호</th>
								<th>수신인 E-MAIL</th>
								<th>전송사유</th>
							</tr>
							<tr>
								<td>1</td>
								<td>2016.12.23</td>
								<td>기업명_01</td>
								<td>000-00-00000</td>
								<td>ABC@TEST.COM</td>
								<td class="left">규정에 의한 정기 전송</td>
							</tr>
						</table>

					</div><!-- E : content-area -->
	
	
	
	
					

	