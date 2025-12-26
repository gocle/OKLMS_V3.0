<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<style type="text/css">
</style>

<c:set var="targetUrl" value="/la/config/"/>
<script type="text/javascript">

	var targetUrl = "${targetUrl}";
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

	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}


	/* 상세조회 페이지로 이동 */
	function fn_read( param1 , param2 ){
		
		$("#confId").val( param1 );
		$("#optKey").val( param2 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goUpdateConfig.do";
		$("#frmConfig").attr("action", reqUrl);
		$("#frmConfig").submit();
	}
	
	/* 삭제 */
	function fn_delt(){
		if (confirm("삭제 하시겠습니까?")) {
			var checkedVals = com.getCheckedVal('check0','check1');
			
			$("#companyId").val( checkedVals );
			
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteConfig.do";
			
			$("#frmConfig").attr("action", reqUrl);
			$("#frmConfig").submit();
		}
	}
	
	/* 신규 페이지로 이동 */
	function fn_cret(){
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goInsertConfig.do";
		
		$("#frmConfig").attr("action", reqUrl);
		$("#frmConfig").submit();
	}
	
	
</script>

<!-- 회원정보 팝업용 끝 -->
<form id="frmConfig" name="frmConfig" action="<c:url value='/la/company/listConfig.do'/>" method="post">
	<input type="hidden" id="confId" name="confId" />
	<input type="hidden" id="optKey" name="optKey" />
</form>


<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="15%">설정 아이디</th>
			<th width="30%">설정 키</th>
			<th width="20%">설정 이름</th>
			<th width="20%">설정 값</th>
			<th width="15%">사용여부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><c:out value="${result.confId}" /></td>
			<td><c:out value="${result.optKey}" /></td>
			<td>
			<a href="javascript:fn_read('${result.confId}','${result.optKey}')" ><span color="blue"><c:out value="${result.optName}" /></span></a>
			</td>
			<td><c:out value="${result.optValue}" /></td>
			
			<td><c:out value="${result.optHidden eq '0' ? '사용' : '미사용'}" /></td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td colspan="5"><spring:message code="common.nodata.msg" /></td>
		</tr>
		</c:if>
	</tbody>
</table><!-- E : list -->



	