<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of gocle LEARN.
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근C    2016. 10. 27 오후 1:20         Modify Draft.
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
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	
	//선택 버튼을 클릭시 부모창에 필요항목 셋팅
	function fn_selectInfo(){
		if( opener ){
			var selectInfo = "";
			
			selectInfo = com.getCheckedVal('check0','baseCheckCompanyIds');
			
			if('' == selectInfo){
				alert("추가할 기업을 선택하여주십시오.");
				return false;
			}
			
			opener.fn_company_add(selectInfo);
			window.close();
		}
	}
	
	function fn_closeWin(){
		window.close();
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		
		var reqUrl = "/lu/popup/goPopupSearchCcnCompany.do";
		$("#frmCompany").attr("target", "_self");
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}

</script>

<form id="frmCompany" name="frmCompany" method="post">

<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
<div id="pop-wrapper">

	<h1>기업체 검색</h1>
	<div class="search-box-1 mb-010">
		<input type="text" id="companyName" name="companyName" value="${param.companyName}" placeholder="기업명 입력" />
		<a href="#fn_search" onclick="javascript:fn_search('1'); return false" onkeypress="this.onclick();">조회</a>
	</div><!-- E : search-box-1 -->


<table class="type-2 wp100">
	<colgroup>
		<col width="5%" />
		<col width="15%" />
	</colgroup>

	<thead>
		<tr>
			<th width="5%"><input type="checkbox" name="checkbox" id="check0" name="check0" class="choice" onclick="javascript:com.checkAll('check0','baseCheckCompanyIds');" /></th>
			<th width="15%">기업명</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="baseCheckCompanyIds" value="${result.companyId}" <c:if test="${result.mappingCnt ne '0'}">checked="checked"</c:if>   class="choice" /></td>
			<td>${result.companyName}</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="2"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
	</tbody>
</table><!-- E : view-1 -->

<!-- 팝업 내용  영역 끝 -->

<ul class="page-num-btn mt-015">
	<li class="page-btn-area">
		<a href="#fn_closeWin" class="yellow close" onclick="javascript:fn_closeWin(); return false" onkeypress="this.onclick();">닫기</a>
		<a href="#fn_selectInfo" class="orange close" onclick="javascript:fn_selectInfo(); return false" onkeypress="this.onclick();">확인</a>
	</li>
</ul><!-- E : page-num-btn -->
	
		</div><!-- E : wrapper -->
</form>		
		
		