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

	
	
	function fn_list(){
		var reqUrl = "/lu/traning/listTraningPrt.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
</script>



	
	
			
<form id="frmTraning" name="frmTraning" method="post">
<input type="hidden" name="searchName" id="searchName" value="${param.searchName}">
<input type="hidden" name="searchWord" id="searchWord" value="${param.searchWord}">



			
				<h2>훈련과정 운영현황</h2>
				<!--  검색 -->
				
				<div class="table-responsive mt-010">
					<table class="type-2">
						<colgroup>
							<col style="width:13%">
							<col style="width:20%">
							<col style="width:13%">
							<col style="width:20%">
							<col style="width:13%">
							<col style="width:20%">
						</colgroup>
							
						<tbody>
						<tr>
							<th>훈련과정명</th>
							<td>
								${traningProcessVO.traningProcessName}
							</td>      
							<th>훈련과정번호</th>
					  		<td>
					  			${traningProcessVO.traningProcessNo}
					  		</td>
					  		<th>훈련과정회차</th>
					  		<td>
					  			${traningProcessVO.traningProcessPeriod}
					  		</td>
						</tr>
						
						<tr>
							<th>실시년도</th>
							<td>
								${traningProcessVO.year}
							</td>
							<th>훈련시작일</th>
							<td>
								${traningProcessVO.startDate}
							</td>      
							<th>훈련종료일</th>
							<td colspan="3">
								${traningProcessVO.endDate}
							</td>    
						</tr>
						<tr>
							<th>훈련상태</th>
							<td>
								<c:choose>
									<c:when test="${traningProcessVO.traningStatusCd eq '1'}">진행중</c:when>
									<c:when test="${traningProcessVO.traningStatusCd eq '2'}">전체중탈</c:when>
									<c:when test="${traningProcessVO.traningStatusCd eq '3'}">훈련중지</c:when>
									<c:when test="${traningProcessVO.traningStatusCd eq '4'}">종료</c:when>
								</c:choose>
							</td>
							<th>과정구분</th>
							<td colspan="3">
								<c:choose>
									<c:when test="${traningProcessVO.traningTypeCd eq '1'}">일반</c:when>
									<c:when test="${traningProcessVO.traningTypeCd eq '2'}">변경인정</c:when>
									<c:when test="${traningProcessVO.traningTypeCd eq '3'}">과정연계</c:when>
								</c:choose>
							</td>      
						</tr>
						
						<tr>
							<th>NCS 자격명</th>
							<td>
								${traningProcessVO.ncsLicenceName}
							</td>
							<th>NCS 자격수준</th>
							<td>
								${traningProcessVO.ncsLicenceLevel}
							</td>      
							<th>NCS 자격버전</th>
							<td>
								${traningProcessVO.ncsLicenceVersion}
							</td>    
						</tr>
						
						<tr>
							<th>NCS 코드</th>
							<td>
								${traningProcessVO.ncsCode}
							</td>
							<th>NCS 명</th>
							<td>
								${traningProcessVO.ncsName}
							</td>  
							<th>등급</th>
							<td>
								${traningProcessVO.centerGrade}
							</td>      
						</tr>
						
						<tr>
							<th>OJT 훈련시간</th>
							<td>
								${traningProcessVO.ojtTimeHour}
							</td>
							<th>Off-JT 훈련시간</th>
							<td>
								${traningProcessVO.offTimeHour}
							</td>  
							<th>특이사항</th>
							<td>
								${traningProcessVO.centerBigo}
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-area align-right mt-010">
					<a href="#!" onclick="fn_list();" class="black ">목록</a>
				</div>
</form>


<script>




</script>
	
	
					

	