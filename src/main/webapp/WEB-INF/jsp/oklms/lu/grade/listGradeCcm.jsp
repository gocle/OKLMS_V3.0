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
<c:set var="targetUrl" value="/lu/grade/"/>
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
		
		if($("#yyyy").val() == ""){
			alert("학년도 선택은 필수항목입니다.");
			$("#yyyy").focus();
			return;
		}
		
		if($("#term").val() == ""){
			alert("학기 선택은 필수항목입니다.");
			$("#term").focus();
			return;
		} else {
			$("#termNm").val($("#term option:selected").text());
		}
		
		if($("#deptNo").val() == ""){
			alert("학과 선택은 필수항목입니다.");
			$("#deptNo").focus();
			return;
		} else {
			$("#deptNm").val($("#deptNo option:selected").text());
		}
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listGradeCcm.do";
		$("#frmGrade").attr("action", reqUrl);
		$("#frmGrade").submit();
	}
	
	function fn_excel( submitId, confirmYn  ){ 
		var reqUrl = "";
		if(confirmYn == "N" && $("#confirmYn").val() == "" ){
			if(confirm("전송 된 성적자료에는 학습근로자의 개인정보가 포함되어 있습니다.\n\n담당자 본인이 아닌 경우 자료의 저장 및 반출시\n\n정보통신망법에 의해 처벌됨을 유념하시기 바랍니다.")){
				$("#submitId").val(submitId);
				$("#confirmYn").val(confirmYn);
				reqUrl = CONTEXT_ROOT + targetUrl + "updateGradeCcmConfirmY.json";
			 	var param = $("#frmGrade").serializeArray();
				com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
				if (200 == jqXHR.status ) {
					retData 	= jqXHR.responseJSON.retData;
					var submitConfirmDateId = retData.submitId+"_confirmDate";
					var submitConfirmYnId = retData.submitId+"_confirmYn";
					$("#"+submitConfirmDateId).html(retData.confirmDate);
					$("#"+submitConfirmYnId).html(retData.confirmYn);
					
					/* 
					<td id="${result.submitId}_confirmDate">${result.confirmDate}</td>
					<td id="${result.submitId}_confirmYn">${result.confirmYn}</td> 
					*/
				}
				}, {
					async : false,
					type : "POST",
					errorCallback : null
				});
			} else {
				$("#submitId").val("");
				$("#confirmYn").val("");
			}
		} else {
			confirm("전송 된 성적자료에는 학습근로자의 개인정보가 포함되어 있습니다.\n\n담당자 본인이 아닌 경우 자료의 저장 및 반출시\n\n정보통신망법에 의해 처벌됨을 유념하시기 바랍니다.");
		}
		reqUrl = CONTEXT_ROOT + targetUrl + "excelGradeCcm.do";
		$("#frmGrade").attr("action", reqUrl);
		$("#frmGrade").attr("target","_self");
		$("#frmGrade").submit();	 
	}
	
	
</script>

			
<div id="content-area">
			<h2>성적조회</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
<form id="frmGrade" name="frmGrade" action="<c:url value='/lu/grade/listGradeCcm.do'/>" method="post">
		<input type="hidden" name="deptNm" id="deptNm" value="${param.deptNm}"/>
		<input type="hidden" name="termNm" id="termNm" value="${param.termNm}"/>
		<input type="hidden" name="confirmYn" id="confirmYn"/>	
		<input type="hidden" name="submitId" id="submitId"/>
			<div class="group-area mt-020">
							<div class="search-box-1">
								<label for="yyyy" class="hidden">학년도 선택</label>
								<select name="yyyy" id="yyyy"> 
									<option value="" >학년도</option>
									<c:forEach var="i" begin="0" end="4" step="1">
								      	<option value="${nowYear-i}" <c:if test="${param.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
								    </c:forEach>								
								</select>
								
								<label for="term" class="hidden">학기 선택</label>
								<select name="term" id="term">
									<option value="" >학기</option>
									<option value="1" <c:if test="${param.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
									<option value="2" <c:if test="${param.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
									<option value="3" <c:if test="${param.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
									<option value="4" <c:if test="${param.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
								</select>
								
								<label for="deptNo" class="hidden">학과명 선택</label>
								<select name="deptNo" id="deptNo">
									<option value="">학과명</option>
									<c:forEach var="result" items="${deptCodeList}" varStatus="status">
										<option value="${result.codeId}" <c:if test="${param.deptNo eq result.codeId }" > selected="selected"  </c:if>>${result.codeName}</option>
									</c:forEach>		
								</select>
								<a href="#!" onclick="javascript:fn_search();">검색</a>
							</div><!-- E : search-box-1 -->
							
							<table class="type-1 mb-010">
								<caption>학년도 학기 학과명에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:10%" />
									<col style="width:17%" />
									<col style="width:10%" />
									<col style="width:17%" />
									<col style="width:10%" />
									<col style="width:17%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">학년도</th>
										<td style="text-align: center">${param.yyyy } ${empty param.yyyy ? '' : '학년도' }</td>
										<th scope="row">학기</th>
										<td style="text-align: center">${param.termNm }</td>
										<th scope="row">학과명</th>
										<td style="text-align: center">${param.deptNm }</td>
									</tr>
								</tbody>
							</table>
							
							

							<table class="type-2 mt-010">
								<caption>학년 학번 성명 과목명평정 평점평균에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:5%" />
									<col style="width:5%" />
									<col style="width:6%" />
									<col style="width:12%" />
									<col style="width:12%" />
									<col style="width:12%" />
									<col style="width:12%" />
									<col style="width:12%" />
								<%-- 	<col style="width:4%" />
									<col style="width:4%" />
									<col style="width:4%" /> --%>
									<col style="width:6%" />
									<col style="width:6%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">학년</th>
										<th scope="col">학번</th>
										<th scope="col">성명</th>
										<th scope="col">과목명 평점</th>
										<th scope="col">과목명 평점</th>
										<th scope="col">과목명 평점</th>
										<th scope="col">과목명 평점</th>
										<th scope="col">과목명 평점</th>
<!-- 										<th scope="col">학</th>
										<th scope="col">강</th>
										<th scope="col">실</th>
 -->										<th scope="col">취/신</th>
										<th scope="col">평점평균</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="result" items="${gradeList}" varStatus="status">
									<tr>
										<td>${result.subjectGrade }학년</td>
										<td>${result.memId}</td>
										<td>${result.memName }</td>
										<td>${result.subject1 }</td>
										<td>${result.subject2 }</td>
										<td>${result.subject3 }</td>
										<td>${result.subject4 }</td>
										<td>${result.subject5 }</td>
									<%-- 	<td>${result.totPnt }</td>
										<td>${result.totLctrePnt }</td>
										<td>${result.totReqstPnt }</td> --%>
										<td>${result.totGetPnt}/${result.totPnt}</td>
										<td>
										<c:choose>
										<c:when test="${fn:substring(result.totMarkAvrg,0,1) == '.'}">0${result.totMarkAvrg }</c:when>
										<c:otherwise>${result.totMarkAvrg }</c:otherwise>
										</c:choose>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${empty gradeList}" >
									<tr>
										<td colspan="13"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								</tbody>
							</table>

							<div class="btn-area align-right mt-010">
								<c:choose>
									<c:when test="${fn:length(gradeList) == 0}">
										<a href="#!" onclick="javascript:alert('저장 할 데이터가 없습니다.');" class="orange">엑셀파일 저장</a>
									</c:when>
									<c:otherwise>
										<a href="#!" onclick="javascript:fn_excel('${confirmVO.submitId}','${confirmVO.confirmYn}');" class="orange">엑셀파일 저장</a>
									</c:otherwise>
								</c:choose>
								
							</div><!-- E : btn-area -->
						</div>


						<h2>성적 수신 내역</h2>
						<table class="type-2 mt-040">
							<caption>수신일 학과명 발송인 저장일자 본인확인 전송사유 ip에 대한 정보 제공</caption>
							<colgroup>
								<col style="width:5%" />
								<col style="width:8%" />
								<col style="width:15%" />
								<col style="width:8%" />
								<col style="width:8%" />
								<col style="width:5%" />
								<col style="width:*" />
								<col style="width:15%" />
							</colgroup>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">수신일</th>
								<th scope="col">학과명</th>
								<th scope="col">발송인</th>
								<th scope="col">저장일자</th>
								<th scope="col">본인확인</th>
								<th scope="col">전송사유</th>
								<th scope="col">IP</th>
							</tr>
							<c:forEach var="result" items="${confirmList}" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${result.insertDate}</td>
									<td>${result.deptNm}</td>
									<td>${result.insertUserName}</td>
									<td id="${result.submitId}_confirmDate">${result.confirmDate}</td>
									<td id="${result.submitId}_confirmYn">${result.confirmYn}</td>
									<td>${result.submitComment}</td>
									<td>${result.ip}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty confirmList}" >
								<tr>
									<td colspan="8">성적 수신 내역이 없습니다.</td>
								</tr>
							</c:if>
						</table>
</form>
					</div><!-- E : content-area -->
	
	
	
	
					

	