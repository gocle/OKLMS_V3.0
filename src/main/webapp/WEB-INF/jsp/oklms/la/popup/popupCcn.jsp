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
	var pageIndex = '${pageIndex}'; //현재 페이지 정보
	var searchKeyword = '${searchKeyword}'; //현재 페이지 정보
	
	searchKeyword = encodeURIComponent(searchKeyword);
	
	if ('' == pageIndex) {
		pageIndex = 1;
	}
	<c:if test="${!empty iResult and iResult ne '0'}">
		opener.window.location.replace("/la/company/listCcnCompany.do?pageIndex="+pageIndex+"&searchKeyword="+searchKeyword+"");
		window.self.close();	
	</c:if>

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
	
	/* 아이디 중복체크 */
	function fn_mapping_ccn(){
		
		var checkedVals = com.getCheckedVal('check0','companyIds');
		//alert(checkedVals);
		//if(checkedVals == ''){
		//	alert("추가 할 담당자를 선택주세요.");
		//	return;
		//}
		
		var reqUrl = "/la/company/saveCcnCompany.do";
		//var reqUrl = "/la/company/listCcnCompany.do";
		$("#frmCompany").attr("target","_self");
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	} 

</script>

<form id="frmCompany" name="frmCompany" method="post">
<input type="hidden" name="memSeq" id ="memSeq" value ="${param.memSeq}"/>
<input type="hidden" name="companyId" id ="companyId" value ="${companyVO.companyId}"/>
<input type="hidden" name="pageIndex" id ="pageIndex" value ="${param.pageIndex}"/>
<input type="hidden" name="searchKeyword" id ="searchKeyword" value ="${companyVO.searchKeyword}"/>
<div id="popup-wrarpr">
<div id="popup-header">
	<h1><img src="/images/oklms/adm/inc/pop_border_02.png" alt="" />${param.ccnName} 기업 매핑</h1>
	<p><a href="#" onclick="parent.close();">닫기</a></p>
</div><!-- E : p-header -->

<div id="popup-content-area">
	<div id="popup-container">

<!-- 팝업 내용 영역 시작 : 가로 650px , 세로 560px -->

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="5%"><input type="checkbox" name="checkbox" id="check0" name="check0" class="choice" onclick="javascript:com.checkAll('check0','companyIds');" /></th>
			<th width="15%">기업명</th>
			<th width="15%">담당자</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="companyIds" value="${result.companyId}" <c:if test="${result.mappingCnt ne '0'}">checked="checked"</c:if>   class="choice" /></td>
			<td>${result.companyName}</td>
			<td>${result.ccnNames}</td>
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

<div class="page-btn">
	<a href="#fn_send_mail" onclick="javascript:fn_mapping_ccn();" onkeypress="this.onclick;">확인</a>
</div><!-- E : page-btn -->

	</div><!-- E : p-contentiner -->
</div><!-- E : p-content-area -->
	<div id="popup-footer"></div><!-- E : p-footer -->
</div><!-- E : p-wrapper -->
</form>		
		
		