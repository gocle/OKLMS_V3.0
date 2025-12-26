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
<c:set var="targetUrl" value="/lu/send/"/>
<script type="text/javascript">
<!--
	
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
		
		$("#checkbox").click(function(){
			if($("#checkbox").is(":checked")==true){
				$("input:checkbox[name='memIdArr']").prop("checked",true);
			}else{
				$("input:checkbox[name='memIdArr']").prop("checked",false);
			} 
		});	

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
//      com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_search(1);
		}
	}
	
	function fn_searchPageView(val) {
		$("#pageSize").val(val);
		 fn_search(pageIndex);
	}
	

	/* 리스트 조회 */
	function fn_search( pageIndex ){
		$("#pageIndex").val( pageIndex );
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSendCcn.do";
		$("#frmSend").attr("action", reqUrl);
		$("#frmSend").submit();
	}

	function sms(){		
		var obj = document.getElementsByName("memIdArr");
		var temp = 0;
	    var arr_value = "";
	    for(var i = 0; i < obj.length; i++){
	         if(obj[i].checked){
	              arr_value += obj[i].value+",";
	              temp++;
	         }
	    }	
		if(temp==0){
			alert("선택된 대상이 없습니다.");
			return;
		}	  
		fn_send_sms(0,arr_value,'','','');
		
	}

	function email(){	
		
		var obj = document.getElementsByName("memIdArr");
	    var temp = 0;
	    var arr_value = "";
	    for(var i = 0; i < obj.length; i++){
	         if(obj[i].checked){
	              arr_value += obj[i].value+",";
	              temp++;
	         }
	    }
		if(temp==0){
			alert("선택된 대상이 없습니다.");
			return;
		}	  
		fn_send_mail(0,arr_value,'','','');	
	}
	
//-->	
</script>

			
			<h2>${curMenu.menuTitle }</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
			

<form id="frmSend" name="frmSend" action="<c:url value='/lu/send/listSend.do'/>" method="post">
    <input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="searchMemType" name="searchMemType" value="COT" /> 
	
	
	<div class="group-area mt-020">
							
					 <dl id="tab-type">

						<dt class="tab-name-11"><a href="/lu/send/listSendCcn.do">학습근로자</a></dt>
						<dd id="tab-content-11"></dd>
				
						<dt class="tab-name-12 on"><a href="#">기업전담자</a></dt>
						<dd id="tab-content-12" style="display:block;">
						

							<div class="search-box-1 mt-020 mb-020"">
								<select name="searchGroup" id="searchGroup">
									<option value="">권한그룹</option>
									<option value="COT" <c:if test="${sendVO.memType eq 'COT' }" > selected="selected"  </c:if>>기업현장교사</option>
									<option value="CCM" <c:if test="${sendVO.memType eq 'CCM' }" > selected="selected"  </c:if>>HRD전담자</option>
								</select>
								<input type="text" name="companyName" id="companyName" value="${sendVO.companyName}" placeholder="기업명" onkeypress="press(event);"  style="width:150px;" />
								<input type="text" name="searchKeyword" id="searchKeyword" value="${sendVO.searchKeyword}" placeholder="학생명, 학번 검색" onkeypress="press(event);"  style="width:150px;" />
								<a href="#!" onclick="javascript:fn_search(1);">검색</a>
							</div><!-- E : search-box-1 -->
			
							<ul class="page-sum bg-none mb-007">
								<li class="float-right">
									PAGE VIEW : <input type="radio" name="pageSizeCnt" id="pageSizeCnt1" value="10" <c:if test="${pageSize eq '10' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('10');"> 10
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt2" value="20" <c:if test="${pageSize eq '20' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('20');"> 20
									<input type="radio" name="pageSizeCnt"  id="pageSizeCnt3" value="50" <c:if test="${pageSize eq '50' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('50');"> 50
									Lines
								</li>
							</ul>
							
							
							<div class="table-responsive">
							<table class="type-2">
								<colgroup>
									<col style="width:50px" />
									<col style="width:200px" />
									<col style="width:200px" />
									<col style="width:200px" />
									<col style="*" />
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" name="checkbox" id="checkbox" class="choice" /></th>
										<th>성명</th>
										<th>아이디</th>
										<th>권한그룹</th>
										<th>기업명</th>
										
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td><input type="checkbox" name="memIdArr" value="${result.memId}"  class="choice" /></td>
											<td>${result.memName}</td>
											<td>${result.memId}</td>
											<td>
											<c:choose>
												<c:when test="${result.memType eq 'COT'}">
													기업현장교사
												</c:when>
												<c:otherwise>
													HRD 전담자
												</c:otherwise>
											</c:choose>
											</td>
											<td>${result.companyName}</td>
											
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
							
							<ul class="page-num-btn mt-015">
								<li class="page-num-area">
									<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
								</li>
								<li class="page-btn-area">
									 <a href="#" onclick="javascript:sms();"  class="yellow">SMS 발송</a>
									 <a href="#" onclick="javascript:email();" class="orange">E-MAIL 발송</a> 
								</li>
							</ul>
							
						</div>
	
	
	
		
			<%-- <div class="search-box-1 mt-020 mb-020"">
					<select name="deptCode" id="deptCode">
						<option value="">학과명</option>
						<c:forEach var="result" items="${deptCodeList}" varStatus="status">
							<option value="${result.codeId}" <c:if test="${sendVO.deptCode eq result.codeId }" > selected="selected"  </c:if>>${result.codeName}</option>
						</c:forEach>		
					</select>
					<select name="subjectGrade" id="subjectGrade">
						<option value="">권한그룹</option>
						<option value="STD" <c:if test="${sendVO.subjectGrade eq 'STD' }" > selected="selected"  </c:if>>학습근로자</option>
						<option value="COT" <c:if test="${sendVO.subjectGrade eq 'COT' }" > selected="selected"  </c:if>>기업현장교사</option>
						<option value="CCM" <c:if test="${sendVO.subjectGrade eq 'CCM' }" > selected="selected"  </c:if>>HRD전담자</option>
					</select>
					<input type="text" name="companyName" id="companyName" value="${sendVO.companyName}" placeholder="기업명" onkeypress="press(event);"  style="width:150px;" />
					<input type="text" name="searchKeyword" id="searchKeyword" value="${sendVO.searchKeyword}" placeholder="학생명, 학번 검색" onkeypress="press(event);"  style="width:150px;" />
					<a href="#!" onclick="javascript:fn_search(1);">검색</a>
				</div><!-- E : search-box-1 -->

				<ul class="page-sum bg-none mb-007">
					<li class="float-right">
						PAGE VIEW : <input type="radio" name="pageSizeCnt" id="pageSizeCnt1" value="10" <c:if test="${pageSize eq '10' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('10');"> 10
						<input type="radio" name="pageSizeCnt"  id="pageSizeCnt2" value="20" <c:if test="${pageSize eq '20' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('20');"> 20
						<input type="radio" name="pageSizeCnt"  id="pageSizeCnt3" value="50" <c:if test="${pageSize eq '50' }" > checked="checked"  </c:if> onclick="javascript:fn_searchPageView('50');"> 50
						Lines
					</li>
				</ul>

				<div class="group-area mb-040">
					<table class="type-2">

					<colgroup>
						<col style="width:40px" />
						<col style="width:140px" />
						<col style="width:50px" />
						<col style="width:*" />
						<col style="width:170px" />
						<col style="width:110px" />
						<col style="width:90px" />
						<col style="width:110px" />
					</colgroup>

					<thead>
						<tr>
							<th><input type="checkbox" name="checkbox" id="checkbox" class="choice" /></th>
							<th></th>
							<th>학과</th>
							<th>학년</th>
							<th>교과목명</th>
							<th>기업명</th>
							<th>학번</th>
							<th>입학년도</th>
							<th>이름</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="memIdArr" value="${result.memId}"  class="choice" /></td>
							<td>${result.deptName}</td>
							<td>${result.subjectGrade}</td>
							<td class="left">${result.subjectName}</td>
							<td>${result.companyName}</td>
							<td>${result.memId}</td>
							<td>${result.adYear}</td>
							<td>${result.memName}</td>
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
							
							
							 </dd>
							</dl> 

				<!-- E : page-num-btn -->
			</div> --%>
</form>

