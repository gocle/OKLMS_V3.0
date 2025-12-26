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
				$("input:checkbox[name='sendSeqs']").prop("checked",true);
			}else{
				$("input:checkbox[name='sendSeqs']").prop("checked",false);
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
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSendEmailResultCdp.do";
		$("#frmSend").attr("action", reqUrl);
		$("#frmSend").submit();
	}

	function sms(){		
		var obj = document.getElementsByName("sendSeqs");
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
		var obj = document.getElementsByName("sendSeqs");
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
	
	function fn_delete(){
		var obj = document.getElementsByName("sendSeqs");
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
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "deleteSendMaster.do";
		$("#frmSend").attr("action", reqUrl);
		$("#frmSend").submit();
	}
	
	function fn_popupSendResult(sendSeq){
		var url = CONTEXT_ROOT + targetUrl + "popupSendResult.do?sendSeq="+sendSeq;
		var wndName = "send";
		var wWidth = "858";
		var wHeight = "700";

		popOpenWindow( url, wndName, wWidth, wHeight, 250, 400, 'scrollbars=yes' );
	}
	
//-->	
</script>

			
<div id="content-area">
			<h2>E-MAIL 발송결과 관리</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
			

<form id="frmSend" name="frmSend" action="<c:url value='/lu/send/listSendCdp.do'/>" method="post">
    <input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="sendType" name="sendType" value="EMAIL" /> 	
			<div class="search-box-1 mb-020">
					<select name="realTypeYn" id="realTypeYn">
						<option value="">-발송형식-</option>
						<option value="Y" <c:if test="${mailVO.realTypeYn eq 'Y' }" > selected="selected"  </c:if>>즉시</option>
						<option value="N" <c:if test="${mailVO.realTypeYn eq 'N' }" > selected="selected"  </c:if>>예약</option>
					</select>
					<select name="sendYn" id="sendYn">
						<option value="">-발송상태-</option>
						<option value="N" <c:if test="${mailVO.sendYn eq 'N' }" > selected="selected"  </c:if>>발송준비</option>
						<option value="Y" <c:if test="${mailVO.sendYn eq 'Y' }" > selected="selected"  </c:if>>발송완료</option>
					</select>
					<select name="templetType" id="templetType">
						<option value="" <c:if test="${empty mailVO.mailTempType}">selected</c:if> >- 템플릿 없음-</option>
						<option value="RC" <c:if test="${mailVO.mailTempType eq 'RC'}">selected</c:if> >과제 제출</option>
						<option value="TC" <c:if test="${mailVO.mailTempType eq 'TC'}">selected</c:if>>팀프로젝트 제출</option>
						<option value="DC" <c:if test="${mailVO.mailTempType eq 'DC'}">selected</c:if>>토론참여</option>
						<option value="WC" <c:if test="${mailVO.mailTempType eq 'WC'}">selected</c:if>>재직증빙서류 제출</option>
						<option value="OC" <c:if test="${mailVO.mailTempType eq 'OC'}">selected</c:if>>온라인교과수강</option>
						<option value="AC" <c:if test="${mailVO.mailTempType eq 'AC'}">selected</c:if>>학습활동서 작성</option>		
					</select>
					
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
						<col style="width:160px" />
						<col style="width:160px" />
						<col style="width:160px" />
						<col style="width:160px" />
						<col style="width:160px" />
						<col style="width:160px" />
						<col style="width:160px" />
					</colgroup>

					<thead>
						<tr>
							<th><input type="checkbox" name="checkbox" id="checkbox" class="choice" /></th>
							<th>전송구분</th>
							<th>템플릿</th>
							<th>발송일</th>
							<th>예약일</th>
							<th>진행상태</th>
							<th>전체건수</th>
							<th>성공건수</th>
							<th>실패건수</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="sendSeqs" value="${result.sendSeq}"  class="choice" /></td>
							<td>${result.realTypeYn eq 'Y' ? '즉시' : '예약'}</td>
							<td>
							<c:choose>
								<c:when test="${result.templetType eq 'RC'}">과제 제출</c:when>
								<c:when test="${result.templetType eq 'TC'}">팀프로젝트 제출</c:when>
								<c:when test="${result.templetType eq 'DC'}">토론참여</c:when>
								<c:when test="${result.templetType eq 'WC'}">재직증빙서류 제출</c:when>
								<c:when test="${result.templetType eq 'OC'}">온라인교과수강</c:when>
								<c:when test="${result.templetType eq 'AC'}">학습활동서 작성출</c:when>
								<c:otherwise>템플릿 없음</c:otherwise>
							</c:choose>
							</td>
							<td>${result.insertDate}</td>
							<td>${result.sendDate}</td>
							<td>${result.sendYn eq 'Y' ? '발송완료' : '발송준비'}</td>
							<td>
							<a href="#email-detail-wrap" rel="modal:open" onclick="fn_popupSendResult('${result.sendSeq}');" class="btn btn-primary">${result.totCnt}</a>
							</td>
							<td>${result.successCnt}</td>
							<td>
							${result.sendYn eq 'Y' ? result.failCnt : 0}
							</td>
						</tr>
					</c:forEach>

					<c:if test="${fn:length(resultList) == 0}"> 
						<tr>
							<td colspan="9"><spring:message code="common.nodata.msg" /></td>
						</tr>
					</c:if>	
					</tbody>
				</table>
				
				<ul class="page-num-btn mt-015">
					<li class="page-num-area">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
					</li>
				</ul><!-- E : page-num-btn -->
								
				<div class="btn-area  mt-010">
					<a href="javascript:fn_delete();" class="black ">삭제</a>
				</div>
			</div>
</form>

					</div><!-- E : content-area -->